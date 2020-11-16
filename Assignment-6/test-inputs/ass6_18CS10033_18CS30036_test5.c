// Test code for Bubble sort

void swap(int *xp, int *yp) {
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

void bubbleSort(int arr[], int n) {
    int i, j;
    for (i = 0; i < n - 1; i++)
        for (j = 0; j < n - i - 1; j++)
            if (arr[j] > arr[j + 1])
                swap(&arr[j], &arr[j + 1]);
}

void printArray(int arr[], int size) {
    int i;
    for (i = 0; i < size; i++) {
        printInt(arr[i]);
        printStr(" ");
    }
    printStr("\n");
}

int main() {
    int arr[100], i, n;
    int err = 1;
    printStr("Number of numbers: \n");
    n = readInt(&err);
    printStr("Enter the numbers (separated by newlines): \n");
    for (i = 0; i < n; i++)
        arr[i] = readInt(&err);
    bubbleSort(arr, n);
    printStr("The sorted elements are:\n");
    printArray(arr, n);
    return 0;
}
