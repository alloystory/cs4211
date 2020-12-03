proctype a() {
    printf("%d\n", false & false);
    printf("%d\n", false & true);
    printf("%d\n", true & false);
    printf("%d\n", true & true);
}

init {
    run a();
}