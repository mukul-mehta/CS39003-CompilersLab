int main() {
    int a;
    int fizzCount = 0;
    int buzzCount = 0;
    int fizzBuzzCount = 0;

    for (a = 1; a <= 100; a++) {
        if (a % 3 == 0) {
            fizzCount++;
            printf("Fizz\n");
        }
        if (a % 5 == 0) {
            buzzCount++;
            printf("Buzz\n");
        }
        if (a % 3 && a % 5) {
            fizzBuzzCount++;
            printf("FizzBuzz\n");
        }
    }
}
