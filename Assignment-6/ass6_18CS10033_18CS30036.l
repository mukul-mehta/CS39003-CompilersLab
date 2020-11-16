/*
####################################
#### Mukul Mehta | 18CS10033    ####
#### Rashil Gandhi | 18CS30036  ####
#### CS39003 -> Compilers Lab   ####
#### Assignment 6               ####
####################################
*/

/* These regexes will be used to build other regexes */
%{
	#include<stdio.h>

	#include "ass6_18CS10033_18CS30036_translator.h"
	#include "y.tab.h"

	extern void yyerror(const char *);
	static void comment(void);
%}

%option noyywrap

/* These regexes will be used to build other regexes */
ZERO                    "0"
DOT                     "."
DIGIT                   [0-9]
NON_DIGIT               [a-zA-Z_]
NON_ZERO_DIGIT          [1-9]
SIGN                    [+-]
WHITESPACE              [ \t]
NEWLINE                 [\n]

IDENTIFIER              ({NON_DIGIT}({NON_DIGIT}|{DIGIT})*)
INTEGER_CONSTANT        (({NON_ZERO_DIGIT}{DIGIT}*)|{ZERO}+)
DIGIT_SEQUENCE          {DIGIT}+
EXPONENT_PART           ([eE]{SIGN}?{DIGIT_SEQUENCE})
FRACTION_CONSTANT       (({DIGIT_SEQUENCE}?{DOT}{DIGIT_SEQUENCE})|({DIGIT_SEQUENCE}{DOT}))
FLOAT_CONSTANT          (({FRACTION_CONSTANT}{EXPONENT_PART}?)|({DIGIT_SEQUENCE}{EXPONENT_PART}))
ESCAPE_SEQUENCE         ([\\][\'\"\?\\abfnrtv])
CHARACTER               ([^\'\\\n']|{ESCAPE_SEQUENCE})
CHARACTER_SEQUENCE      ({CHARACTER}+)
CHARACTER_CONSTANT      ([\']{CHARACTER_SEQUENCE}[\'])
STRING_CHARARCTER       {CHARACTER}
STRING_CHAR_SEQUENCE    ({STRING_CHARARCTER}+)
STRING_LITERAL          ([\"]{STRING_CHAR_SEQUENCE}?[\"])

/* Regex for comment matching */
SINGLELINE_COMMENT      [/][/].*
MULTILINE_START         [/][\*]+
MULTILINE_END           [\*]+[/]
MULTILINE_COMMENT       ({MULTILINE_START}([^\*]|([\*]+[^/\*]))*{MULTILINE_END})
COMMENT                 {MULTILINE_COMMENT}|{SINGLELINE_COMMENT}

%%

"break"             	{ return BREAK;    }
"case"              	{ return CASE;     }
"char"              	{ return CHAR;     }
"const"             	{ return CONST;    }
"continue"          	{ return CONTINUE; }
"default"           	{ return DEFAULT;  }
"do"                	{ return DO;       }
"double"            	{ return DOUBLE;   }
"else"              	{ return ELSE;     }
"extern"            	{ return EXTERN;   }
"float"             	{ return FLOAT;    }
"for"               	{ return FOR;      }
"goto"              	{ return GOTO;     }
"if"                	{ return IF;       }
"inline"            	{ return INLINE;   }
"int"               	{ return INT;      }
"long"              	{ return LONG;     }
"restrict"          	{ return RESTRICT; }
"return"            	{ return RETURN;   }
"short"             	{ return SHORT;    }
"sizeof"            	{ return SIZEOF;   }
"static"            	{ return STATIC;   }
"struct"            	{ return STRUCT;   }
"switch"            	{ return SWITCH;   }
"typedef"           	{ return TYPEDEF;  }
"union"             	{ return UNION;    }
"void"              	{ return VOID;     }
"volatile"          	{ return VOLATILE; }
"while"             	{ return WHILE;    }

"["                 {return '[';  }
"]"                 { return ']'; }
"("                 { return '('; }
")"                 { return ')'; }
"{"                 { return '{'; }
"}"                 { return '}'; }
"."                 { return '.'; }
"&"                 { return '&'; }
"*"                 { return '*'; }
"+"                 { return '+'; }
"-"                 { return '-'; }
"~"                 { return '~'; }
"!"                 { return '!'; }
"/"                 { return '/'; }
"%"                 { return '%'; }
"<"                 { return '<'; }
">"                 { return '>'; }
"^"                 { return '^'; }
"|"                 { return '|'; }
"?"                 { return '?'; }
":"                 { return ':'; }
";"                 { return ';'; }
"="                 { return '='; }
","                 { return ','; }
"#"                 { return '#'; }

"->"					{ return ARROW;			      }
"--"					{ return DECREMENT;		      }
"++"					{ return INCREMENT;		      }
">>"					{ return RIGHT_SHIFT;         }
"<<"					{ return LEFT_SHIFT;          }
">="					{ return GREATER_THAN_EQUAL;  }
"<="					{ return LESS_THAN_EQUAL;     }
"!="					{ return NOT_EQUAL;           }
"=="					{ return EQUALITY;            }
"||"					{ return OR;                  }
"&&"					{ return AND;                 }
"..."					{ return ELLIPSIS;            }
"+="					{ return PLUS_EQUAL;          }
"-="					{ return MINUS_EQUAL;         }
"*="					{ return MULTIPLY_EQUAL;      }
"%="					{ return MOD_EQUAL;           }
"/="					{ return DIVIDE_EQUAL;        }
"&="					{ return AND_EQUAL;           }
"|="     				{ return OR_EQUAL;            }
"^="					{ return XOR_EQUAL;           }
">>="                   { return RIGHT_SHIFT_EQUAL;   }
"<<="					{ return LEFT_SHIFT_EQUAL;    }

{NEWLINE}               { ;                                                                      }
{WHITESPACE}        	{ ;                 		                                             }
{COMMENT}				{ ;                  		                                             }
{INTEGER_CONSTANT}      { yylval._int_value=atoi(yytext); 			   return INTEGER_CONSTANT;  }
{FLOAT_CONSTANT}		{ yylval._float_value=atof(yytext); 		   return FLOATING_CONSTANT; }
{CHARACTER_CONSTANT}	{ yylval._char_value=yytext[1]; 			   return CHAR_CONST;		 }
{STRING_LITERAL}    	{ yylval._string_literal = new string(yytext); return STRING_LITERAL;	 }
{IDENTIFIER}            { yylval._identifier.name=new string(yytext);  return IDENTIFIER;		 }
%%
