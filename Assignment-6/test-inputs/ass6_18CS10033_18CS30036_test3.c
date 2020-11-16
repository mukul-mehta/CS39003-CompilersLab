//Test code for Binary Search

int binarySearch(int a[], int n, int m, int l, int u) {
    int mid, c = 0;
    if (l > u)
        return -1;
    mid = (l + u) / 2;
    int t = a[mid];
    if (m < t)
        return binarySearch(a, n, m, l, mid - 1);
    else if (m > t)
        return binarySearch(a, n, m, mid + 1, u);
    else
        return mid;
}

int main() {
    int a[10], i, n, m, c, l, u;
    int err = 1;
    printStr("Size of array: \n");
    n = readInt(&err);
    printStr("Enter the elements of the array in sorted order (separated by newlines): \n");
    for (i = 0; i < n; i++)
        a[i] = readInt(&err);

    printStr("Search target: \n");
    m = readInt(&err);
    l = 0, u = n - 1;
    c = 0;
    c = binarySearch(a, n, m, l, u);
    if (c == -1)
        printStr("Not found.\n");
    else {
        printStr("Found at position: \n");
        c = c + 1;
        printInt(c);
        printStr("\n");
    }
    return 0;
}
