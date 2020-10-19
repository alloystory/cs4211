int x = 100;
active proctype A() {
  do
  :: x %2 -> x = 3*x+1
  od
}

active proctype B() {
  do
  :: !(x%2) -> x = x/2
  od
}

#define q (x == 1)
ltl p1 {[](<>q)}
