// Yo Yo Yo this is to test the amaze lexer


/* 18CS10033
Compilers Assignment 3
Using lex/flex to generate a lexer
****/

#include <stdio.h>
#include <math.h>

break
case
char
const
continue
default
do
double
else
enum
extern
float
for
goto
if
inline
int
long
register
restrict
return
short
signed
sizeof
static
struct
switch
typedef
union
void
while

int integer = 123456;
float f = -69.23;
double d = 38291.28390201100; 

f = .0123456;
f = 16e24;
d = 0.182829203039383;

char c = 'm' ;
printf("%c", c);

int x = 8;
int y = 4;

x = x + y;
y = x - y;
x = x - y;

if ( a == b )
{
	printf("x is equal to y\n");
}
else
{
    printf("x is not equal to y\n")
}

for(int i = 0; i <= 16; i++)
{
	printf("%d\n", i);
}

char str[46] = "Yo yo yo if it reaches here, it prolly works!";

(
)
{
}
[
]

+ - * / = ~ ! ^ % & |
== != < > <= >= <<= >>=
<< >>
? , . : ; # ->
&& ||

++
--
+=
-=
*=
/=
%=
^=
&=

int fact(int n)
{
    if (n == 1)
        return 1;

    return n * fact(n - 1);
}
printf("THE END!!!");
