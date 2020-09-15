bit flags[2];
byte sem, turn;
proctype myprocess(bit id){
  flags[id] = 1;
  turn = 1 - id;
  flags[1-id] == 0 || turn == id;
  sem++;
  sem--;
  flags[id]=0
}

proctype observer(){
  assert( sem != 2 );
}

init{
  atomic{
    run myprocess(0);
    run myprocess(1);
    run observer()
  }
}
