int randomNumber = 8;

int fibonacci(int n);

void main() {
    int n = 42;
    int res = fibonacci(n) + randomNumber;
    return;
}

int fibonacci(int n) {
    if (n == 0)
        return 0;

    else if (n == 1)
        return 1;

    int r = fibonacci(n - 1) + fibonacci(n - 2);
    return r;
}
