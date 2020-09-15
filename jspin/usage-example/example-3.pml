bit flag;
byte sem;
proctype myprocess(bit i) {
  (flag != 1)-> flag = 1;
  sem = sem + 1;
  sem = sem - 1;
  flag = 0;
}

proctype observer() {
  assert( sem != 2 );
}

init {
  atomic{
    run myprocess(0);
    run myprocess(1);
    run observer()
  }
}
