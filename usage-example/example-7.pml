chan datachan = [2] of { bit };
chan ackchan = [2] of { bit };

active proctype Sender() {
  bit out, in;
  do :: datachan!out ->
    ackchan?in;
    if
    :: in == out -> out = 1- out;
    :: else fi
  od
}

active proctype Receiver() {
  bit in ;
  do
  :: datachan?in -> ackchan!in
  :: timeout -> ackchan!in
  od
}
