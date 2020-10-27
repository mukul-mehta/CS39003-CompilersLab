/* C includes and definitions and regex definitions */
%{
    #include "ass3_18CS10033.h"
%}

/* Define bases using which other regexes will be built */ 
ZERO                    "0"
DOT                     "."
DIGIT                   [0-9]
NON_DIGIT               [a-zA-Z_]
NON_ZERO_DIGIT          [1-9]
SIGN                    [+-]
WHITESPACE              [ \n\t]

IDENTIFIER              ({NON_DIGIT}({NON_DIGIT}|{DIGIT})*)
INTEGER_CONSTANT        (({NON_ZERO_DIGIT}{DIGIT}*)|{ZERO}+)
DIGIT_SEQUENCE          {DIGIT}+
EXPONENT_PART           ([eE]{SIGN}?{DIGIT_SEQUENCE})
FRACTION_CONST          (({DIGIT_SEQUENCE}?{DOT}{DIGIT_SEQUENCE})|({DIGIT_SEQUENCE}{DOT}))
FLOAT_CONST             (({FRACTION_CONST}{EXPONENT_PART}?)|({DIGIT_SEQUENCE}{EXPONENT_PART}))
ESCAPE_SEQUENCE         ([\\][\'\"\?\\abfnrtv])
C_CHAR                  ([^\'\\\n']|{ESCAPE_SEQUENCE})
C_CHAR_SEQ              ({C_CHAR}+)
CHAR_CONSTANT           ([\']{C_CHAR_SEQ}[\'])
CONSTANT                ({INTEGER_CONSTANT}|{FLOAT_CONST}|{CHAR_CONSTANT})

S_CHAR                  {C_CHAR}
S_CHAR_SEQ              ({S_CHAR}+)
STRING_LITERAL          ([\"]{S_CHAR_SEQ}?[\"])


/* Regex for comment matching */
SINGLE_COMMENT          [/][/].*
MULTI_START             [/][\*]+
INSIDE_MULTI            ([^\*]|([\*]+[^/\*]))
MULTI_END               [\*]+[/]
MULTI_COMMENT           ({MULTI_START}{INSIDE_MULTI}*{MULTI_END})
COMMENT                 {MULTI_COMMENT}|{SINGLE_COMMENT}

%%

"break"                 { return KEYWORD; }
"float"                 { return KEYWORD; }
"static"                { return KEYWORD; }
"case"                  { return KEYWORD; }
"for"                   { return KEYWORD; }
"struct"                { return KEYWORD; }
"char"                  { return KEYWORD; }
"goto"                  { return KEYWORD; }
"switch"                { return KEYWORD; }
"continue"              { return KEYWORD; }
"if"                    { return KEYWORD; }
"typedef"               { return KEYWORD; }
"default"               { return KEYWORD; }
"int"                   { return KEYWORD; }
"union"                 { return KEYWORD; }
"do"                    { return KEYWORD; }
"long"                  { return KEYWORD; }
"void"                  { return KEYWORD; }
"double"                { return KEYWORD; }
"return"                { return KEYWORD; }
"while"                 { return KEYWORD; }
"else"                  { return KEYWORD; }
"short"                 { return KEYWORD; }
"extern"                { return KEYWORD; }
"sizeof"                { return KEYWORD; }

"["                     { return PUNCTUATOR; }
"]"                     { return PUNCTUATOR; }
"("                     { return PUNCTUATOR; }
")"                     { return PUNCTUATOR; }
"{"                     { return PUNCTUATOR; }
"}"                     { return PUNCTUATOR; }
"..."                   { return PUNCTUATOR; }
"="                     { return PUNCTUATOR; }
"%="                    { return PUNCTUATOR; }
"+="                    { return PUNCTUATOR; }
"*="                    { return PUNCTUATOR; }
"/="                    { return PUNCTUATOR; }
"-="                    { return PUNCTUATOR; }
"<<="                   { return PUNCTUATOR; }
">>="                   { return PUNCTUATOR; }
"."                     { return PUNCTUATOR; }
"->"                    { return PUNCTUATOR; }
"++"                    { return PUNCTUATOR; }
"--"                    { return PUNCTUATOR; }
"&"                     { return PUNCTUATOR; }
"*"                     { return PUNCTUATOR; }
"+"                     { return PUNCTUATOR; }
"-"                     { return PUNCTUATOR; }
"~"                     { return PUNCTUATOR; }
"!"                     { return PUNCTUATOR; }
"/"                     { return PUNCTUATOR; }
"%"                     { return PUNCTUATOR; }
"<<"                    { return PUNCTUATOR; }
">>"                    { return PUNCTUATOR; }
"<"                     { return PUNCTUATOR; }
">"                     { return PUNCTUATOR; }
"<="                    { return PUNCTUATOR; }
">="                    { return PUNCTUATOR; }
"=="                    { return PUNCTUATOR; }
"!="                    { return PUNCTUATOR; }
"^"                     { return PUNCTUATOR; }
"|"                     { return PUNCTUATOR; }
"&&"                    { return PUNCTUATOR; }
"||"                    { return PUNCTUATOR; }
"?"                     { return PUNCTUATOR; }
":"                     { return PUNCTUATOR; }
";"                     { return PUNCTUATOR; }
"&="                    { return PUNCTUATOR; }
"^="                    { return PUNCTUATOR; }
"|="                    { return PUNCTUATOR; }
","                     { return PUNCTUATOR; }
"#"                     { return PUNCTUATOR; }

{COMMENT}               {printf("<COMMENT: %s >\n", yytext);}
{IDENTIFIER}            { return IDENTIFIER;                 }
{CONSTANT}              { return CONSTANT;                   }
{STRING_LITERAL}        { return STRING_LITERAL;             }
{WHITESPACE}            { ;                                  }

%%
