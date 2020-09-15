chan name = [1] of {byte};
proctype A() {
  name!124;
  name!121;
}

proctype B() {
  byte state;
  name?state;
  printf("state=%d\n",state)
}

init{
  atomic{
    run A();
    run B()
  }
}
