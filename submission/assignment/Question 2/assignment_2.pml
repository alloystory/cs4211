mtype = {red, green, blue, start, ack, stop};
chan red_chan = [1] of {mtype};
chan green_chan = [1] of {mtype};
chan blue_chan = [1] of {mtype};
chan buf_chan = [8] of {mtype};
chan out_chan = [1] of {mtype, mtype, mtype};

int num_red_in = 0;
int num_green_in = 0;
int num_blue_in = 0;
int limit = 99999;

proctype red_sender(chan red_ch) {
    do
        :: int rem_limit = limit;
        red_ch!start;
        red_ch?ack;
        do
            :: (rem_limit > 0) -> atomic { red_ch!red; num_red_in++; rem_limit--; };
            :: (rem_limit == 0) -> atomic { red_ch!stop; break; };
        od
    od
}

proctype green_sender(chan green_ch) {
    do
        :: int rem_limit = limit;
        green_ch!start;
        green_ch?ack;
        do
            :: (rem_limit > 0) -> atomic { green_ch!green; num_green_in++; rem_limit--; };
            :: (rem_limit == 0) -> atomic { green_ch!stop; break; };
        od
    od
}

proctype blue_sender(chan blue_ch) {
    do
        :: int rem_limit = limit;
        blue_ch!start;
        blue_ch?ack;
        do
            :: (rem_limit > 0) -> atomic { blue_ch!blue; num_blue_in++; rem_limit--; };
            :: (rem_limit == 0) -> atomic { blue_ch!stop; break; };
        od
    od
}

proctype node(chan red_ch, green_ch, blue_ch, buf_ch, out_ch) {
    bool is_sending[3];
    do
        :: atomic  { (buf_ch??[red] && buf_ch??[green] && buf_ch??[blue]) -> 
            buf_ch??red; buf_ch??green; buf_ch??blue;
            out_ch!red, green, blue;
            num_red_in--; num_green_in--; num_blue_in--;
        };
        :: else ->
            if 
                :: atomic { red_ch?start -> is_sending[0] = true; red_ch!ack };
                :: atomic { red_ch?stop -> is_sending[0] = false; };
                :: atomic { red_ch?red -> is_sending[0] -> buf_ch!red; };

                :: atomic { green_ch?start -> is_sending[1] = true; green_ch!ack };
                :: atomic { green_ch?stop -> is_sending[1] = false; };
                :: atomic { green_ch?green -> is_sending[1] -> buf_ch!green; };
                
                :: atomic { blue_ch?start -> is_sending[2] = true; blue_ch!ack };
                :: atomic { blue_ch?stop -> is_sending[2] = false; };
                :: atomic { blue_ch?blue -> is_sending[2] -> buf_ch!blue; };
            fi
    od
}

#define p (num_red_in > 0)
#define q (num_green_in > 0)
#define r (num_blue_in > 0)
#define s (out_chan?[red, green, blue])
ltl prop { ([](p && q && r -> <> s)) }

init{
    atomic {
        run red_sender(red_chan);
        run green_sender(green_chan);
        run blue_sender(blue_chan);
        run node(red_chan, green_chan, blue_chan, buf_chan, out_chan);
    };
    do
        :: out_chan?red, green, blue;
    od
}
