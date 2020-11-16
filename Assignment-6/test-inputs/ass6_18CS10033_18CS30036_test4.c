int main() {
    int i;
    for (i = 1; i <= 100; i++) {
        if (i % 15 == 0)
            printStr("FizzBuzz\t");
        else if ((i % 3) == 0)
            printStr("Fizz\t");
        else if ((i % 5) == 0)
            printStr("Buzz\t");
        else {
            printInt(i);
            printStr("\t");
        }
    }
    return 0;
}
