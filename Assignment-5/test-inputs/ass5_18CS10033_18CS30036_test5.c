int potato() {
    int i;
    for (i = 25; i > 0; i -= 2) {
        if (i >= 'B' && i <= 101)
            i = 2 * i;
        else {
            if (i > 55 && i <= 'x')
                i = 77;
        }
    }
}

void main()
{
  int p = 0;
  p = potato();
}
