/*
####################################
#### Mukul Mehta                ####   
#### 18CS10033                  ####
#### CS39003 -> Assignment 4    ####
####################################
*/

int main ()
{
	int i, j;
	i = 0;
	j = -1;

	float p = 123.4567;
	double d = 123.456789091928392;

	const float x  = 1234.123E-123;
	char c = 'm';
	char s[] = "YO YO YO";

	for (i = 1;i < 420; i++)
	{
		if (i)
			printf("YOYOYO this is %d", i);
	}

	i = 0;
	while (i < 10)
	{
		double temp = 4 / 3;
		i++;
	}

	int v[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	int n = sizeof(v) / sizeof(int);

	i = 4;

	switch(i){
		case 2 : i++; break;
		case 10 : i++; break;
		case 10000 : i++; break;
		case 100000 : i++; break;
		default : break;
	}
}