#define true 1
#define false 0

bool busy [2];

mtype = {start,stop,data,ack};

chan up[2] = [1] of {mtype};
chan down[2] = [1] of {mtype};

proctype station(byte id; chan in, out){
  do
     ::atomic{in?start->
             !busy[id]->busy[id]=true;
             out!ack;
        };
        do
            ::in?data->out!data
            ::in?stop->break
        od;
        out!stop;
        busy[id]=false
     ::atomic{(!busy[id] && !busy[1-id]) -> 
               busy[id]=true;
               out!start;
          };
          in?ack;
          int remdata = 999999;
          do
              ::(remdata > 0) -> atomic{out!data; in?data; remdata--;}
              ::atomic{out!stop; break}
          od;
          in?stop;
          busy[id]=false
 od
}

#define p (busy[0] == 1)
#define q (busy[1] == 1)
ltl prop {([](p -> <> !p)) && ([](q -> <>!q))}

init{
    atomic{
        run station(0,up[1],down[1]);
        run station(1,up[0],down[0]);
        run station(0,down[0],up[0]);
        run station(1,down[1],up[1]);
    }
}
