proctype fact(int n; chan p) {
  chan child = [1] of {int};
  int result;
  if
  :: (n <= 1) -> p!1
  :: (n > 1) ->
    run fact(n-1, child);
    child?result;
    p!n*result
  fi
}

init {
  int result;
  chan child = [1] of {int};
  run fact(10, child);
  child?result;
  printf("result is %d\n", result);
  assert(result > 1024);
}
