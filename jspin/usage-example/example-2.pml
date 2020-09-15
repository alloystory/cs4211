byte state = 0;
proctype A() {
  byte tmp;
  (state==0) -> tmp = state;
  tmp = tmp+1;
  state = tmp;
  printf("state=%d\n", state)
}

init {
  run A();
  run A();
}
