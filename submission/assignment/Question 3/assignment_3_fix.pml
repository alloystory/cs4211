mtype = {idle, pre_init, in_init, post_init, pre_up, in_up, post_up, post_rev,
    connecting, get_init_wthr, use_init_wthr, get_new_wthr, use_new_wthr, 
    use_old_wthr, update, ack, nak, refuse};

chan wcp_cm = [1] of { mtype };
chan cm_client[2] = [1] of { mtype };
chan client_cm[2] = [1] of { mtype };
bool wcp_status = true;
mtype cm_status = idle;
mtype client_status[2] = idle;
bool client_connected[2] = false;
bool client_used_new_wthr[2] = false;

proctype cm() {
    do
        :: atomic { client_cm[0]?connecting -> {
            if
                :: (cm_status == idle) -> 
                    cm_status = pre_init;
                    client_status[0] = pre_init;
                    wcp_status = false;
                :: (cm_status != idle) -> client_cm[0]!refuse;
            fi
        }};

        :: atomic { client_cm[1]?connecting -> {
            if
                :: (cm_status == idle) -> 
                    cm_status = pre_init;
                    client_status[1] = pre_init;
                    wcp_status = false;
                :: (cm_status != idle) -> client_cm[1]!refuse;
            fi
        }};

        :: atomic { (cm_status == pre_init) -> {
            int id;
            for (id : 0..1) {
                if
                    :: (client_status[id] == pre_init) -> 
                        client_cm[id]!get_init_wthr;
                        cm_status = in_init;
                        client_status[id] = in_init;
                    :: else -> skip;
                fi
            }
        }};

        :: (cm_status == in_init) -> {
            int id;
            for (id : 0..1) {
                if
                    :: (client_status[id] == in_init) -> 
                        if
                            :: atomic { client_cm[id]?ack ->
                                client_cm[id]!use_init_wthr;
                                cm_status = post_init;
                                client_status[id] = post_init;
                            };
                            :: atomic { client_cm[id]?nak -> 
                                client_connected[id] = false;
                                client_status[id] = idle;
                                cm_status = idle;
                                wcp_status = true;
                            };
                        fi
                    :: else -> skip;
                fi
            }
        };

        :: (cm_status == post_init) -> {
            int id;
            for (id : 0..1) {
                if
                    :: (client_status[id] == post_init) -> 
                        if
                            :: atomic { client_cm[id]?ack ->
                                cm_status = idle;
                                client_status[id] = idle;
                                client_connected[id] = true;
                                wcp_status = true;
                            };
                            :: atomic { client_cm[id]?nak -> 
                                cm_status = idle;
                                client_status[id] = idle
                                client_connected[id] = false;
                                wcp_status = true;
                            };
                        fi
                    :: else -> skip;
                fi
            }
        };
    
        :: atomic { wcp_cm?update -> {
            if
                :: (cm_status == idle) -> 
                    int id;
                    for (id : 0..1) {
                        if
                            :: (client_connected[id]) -> client_status[id] = pre_up;
                            :: else -> skip;
                        fi
                    }
                    cm_status = pre_up;
                    wcp_status = false;
                :: (cm_status != idle) -> skip;
            fi
        }};
        
        :: atomic { (cm_status == pre_up) -> {
            int id;
            for (id : 0..1) {
                if
                    :: (client_connected[id]) -> client_cm[id]!get_new_wthr; client_status[id] = in_up;
                    :: else -> skip;
                fi
            }
            cm_status = in_up;
        }};

        :: (cm_status == in_up) -> {
            int id;
            bool all_success = true;
            for (id : 0..1) {
                if
                    :: (client_connected[id]) -> 
                        if
                            :: client_cm[id]?ack -> all_success = all_success & true;
                            :: client_cm[id]?nak -> all_success = all_success & false;
                        fi
                    :: else -> skip;
                fi
            }
            atomic {
                for (id : 0..1) {
                    if
                        :: (client_connected[id]) ->
                            if
                                :: all_success -> client_cm[id]!use_new_wthr; client_status[id] = post_up;
                                :: !all_success -> client_cm[id]!use_old_wthr; client_status[id] = post_rev;
                            fi
                        :: else -> skip;
                    fi
                }

                if
                    :: all_success -> cm_status = post_up;
                    :: !all_success -> cm_status = post_rev
                fi
            };
        };
        
        :: (cm_status == post_up) -> {
            int id;
            bool all_success = true;
            for (id : 0..1) {
                if
                    :: (client_connected[id]) -> 
                        if
                            :: client_cm[id]?ack -> all_success = all_success & true;
                            :: client_cm[id]?nak -> all_success = all_success & false;
                        fi
                    :: else -> skip;
                fi
            }
            
            atomic {
                for (id : 0..1) {
                    if
                        :: (client_connected[id]) ->
                            if
                                :: all_success -> client_status[id] = idle;
                                :: !all_success -> client_status[id] = idle; client_connected[id] = false;
                            fi
                        :: else -> skip;
                    fi
                }

                cm_status = idle;
                wcp_status = true;
            };
        };
        
        :: (cm_status == post_rev) -> {
            int id;
            bool all_success = true;
            for (id : 0..1) {
                if
                    :: (client_connected[id]) -> 
                        if
                            :: client_cm[id]?ack -> all_success = all_success & true;
                            :: client_cm[id]?nak -> all_success = all_success & false;
                        fi
                    :: else -> skip;
                fi
            }

            atomic {
                for (id : 0..1) {
                    if
                        :: (client_connected[id]) ->
                            if
                                :: all_success -> client_status[id] = idle;
                                :: !all_success -> client_status[id] = idle; client_connected[id] = false;
                            fi
                        :: else -> skip;
                    fi
                }

                cm_status = idle;
                wcp_status = true;
            };
        };
    od
}

proctype wcp() {
    int limit = 5;
    do
        :: atomic { wcp_status -> {
            if
                :: wcp_cm!update -> limit = 5;
                :: (limit > 0) -> skip; limit--;
            fi
        }}
    od
}

proctype client(byte id) {
    do
        :: atomic { (!client_connected[id] && client_status[id] == idle && cm_status == idle) -> client_cm[id]!connecting; };
            if
                :: atomic { client_cm[id]?refuse -> client_connected[id] = false; };
                :: (client_status[id] != idle) -> skip;
            fi
        :: atomic { client_cm[id]?get_init_wthr -> {
            if
                :: client_cm[id]!ack;
                :: client_cm[id]!nak;
            fi
        }};
        :: atomic { client_cm[id]?use_init_wthr -> {
            if
                :: client_cm[id]!ack;
                :: client_cm[id]!nak;
            fi
        }};
        :: atomic { client_cm[id]?get_new_wthr -> {
            if
                :: client_cm[id]!ack;
                :: client_cm[id]!nak;
            fi
        }};
        :: atomic { client_cm[id]?use_new_wthr -> {
            if
                :: client_cm[id]!ack; client_used_new_wthr[id] = true;
                :: client_cm[id]!nak;
            fi
        }};
        :: atomic { client_cm[id]?use_old_wthr -> {
            if
                :: client_cm[id]!ack;
                :: client_cm[id]!nak;
            fi
        }};
    od
}

#define p (wcp_status == true)
#define q (wcp_cm?[update])
#define r1 (client_connected[0])
#define r2 (client_connected[1])
#define s1 (client_used_new_wthr[0])
#define s2 (client_used_new_wthr[1])

ltl prop { ([](!p -> <>p) && [](q -> <>((r1 -> s1) && (r2 -> s2)))) }

init {
    atomic {
        run client(0);
        run client(1);
        run cm();
        run wcp();
    };
}
