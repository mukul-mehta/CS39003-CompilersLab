/*
####################################
#### Mukul Mehta                ####   
#### 18CS10033                  ####
#### CS39003 -> Assignment 4    ####
####################################
*/

/* C includes and definitions */
%{
  #include <stdio.h>
  extern int yylex();
  void yyerror(const char*);
  extern char* yytext;
  extern int yylineno;
%}

%union {
	float floatval;
  	char *charval;
	int intval;
}
/* 
	Tokens as defined in my flex specification
	These tokens will be given numeric constants by
	yacc, in the file y.tab.h
*/
%token BREAK
%token CASE
%token CHAR
%token CONST
%token CONTINUE
%token DEFAULT
%token DO
%token DOUBLE
%token ELSE
%token EXTERN
%token FLOAT
%token FOR
%token GOTO
%token IF
%token INLINE
%token INT
%token LONG
%token RESTRICT
%token RETURN
%token SHORT
%token SIZEOF
%token STATIC
%token STRUCT
%token SWITCH
%token TYPEDEF
%token UNION
%token VOID
%token VOLATILE
%token WHILE

%token PARENTHESISOPEN
%token PARENTHESISCLOSE
%token CURLYBRACEOPEN
%token CURLYBRACECLOSE
%token SQUAREBRACEOPEN
%token SQUAREBRACECLOSE
%token BITWISE_AND
%token BITWISE_OR
%token BITWISE_XOR
%token BITWISE_NOR
%token DOT
%token MULTIPLY
%token ADD
%token SUBTRACT
%token NOT
%token MODULO
%token LESS_THAN
%token GREATER_THAN
%token COLON
%token SEMICOLON
%token ASSIGNMENT
%token TERNARY_OP
%token HASH
%token FORWARD_SLASH
%token COMMA

%token ARROW
%token DECREMENT
%token INCREMENT
%token RIGHT_SHIFT
%token LEFT_SHIFT
%token GREATER_THAN_EQUAL
%token LESS_THAN_EQUAL
%token NOT_EQUAL
%token EQUALITY
%token OR
%token AND
%token ELLIPSIS
%token PLUS_EQUAL
%token MINUS_EQUAL
%token MULTIPLY_EQUAL
%token MOD_EQUAL
%token DIVIDE_EQUAL
%token AND_EQUAL
%token OR_EQUAL
%token XOR_EQUAL
%token RIGHT_SHIFT_EQUAL
%token LEFT_SHIFT_EQUAL

%token WHITESPACE
%token COMMENT
%token IDENTIFIER
%token <intval> INTEGER_CONSTANT
%token <intval> FLOAT_CONSTANT
%token <intval> CHARACTER_CONSTANT
%token <intval> STRING_LITERAL

%start translation_unit

/* Below list is the set of all Production Rules */

%%
constant: INTEGER_CONSTANT
	| FLOAT_CONSTANT
	| CHARACTER_CONSTANT
	;

primary_expression: IDENTIFIER
	{ printf("primary_expression\n"); }
	| constant
	{ printf("primary_expression\n"); }
	| STRING_LITERAL
	{ printf("primary_expression\n"); }
	| PARENTHESISOPEN expression PARENTHESISCLOSE
	{ printf("primary_expression\n"); }
	;

postfix_expression: primary_expression
	{ printf("primary_expression\n"); }
	| postfix_expression SQUAREBRACEOPEN expression SQUAREBRACECLOSE
	{ printf("postfix_expression\n"); }
	| postfix_expression PARENTHESISOPEN PARENTHESISCLOSE
	{ printf("postfix_expression\n"); }
	| postfix_expression PARENTHESISOPEN argument_expression_list PARENTHESISCLOSE
	| postfix_expression DOT IDENTIFIER
	{ printf("postfix_expression\n"); }	
	| postfix_expression ARROW IDENTIFIER
	{ printf("postfix_expression\n"); }
	| postfix_expression INCREMENT
	{ printf("postfix_expression\n"); }
	| postfix_expression DECREMENT
	{ printf("postfix_expression\n"); }
	| PARENTHESISOPEN type_name PARENTHESISCLOSE CURLYBRACEOPEN initializer_list CURLYBRACECLOSE
	{ printf("postfix_expression\n"); }
	|  PARENTHESISOPEN type_name PARENTHESISCLOSE CURLYBRACEOPEN initializer_list COMMA CURLYBRACECLOSE
	{ printf("postfix_expression\n"); }
	;

argument_expression_list: assignment_expression
	{ printf("argument_expression_list\n"); }
	| argument_expression_list COMMA assignment_expression
	{ printf("argument_expression_list\n"); }
	;

unary_expression: postfix_expression
	{ printf("unary_expression\n"); }
	| INCREMENT unary_expression
	{ printf("unary_expression\n"); }
	| DECREMENT unary_expression
	{ printf("unary_expression\n"); }
	| unary_operator cast_expression
	{ printf("unary_expression\n"); }
	| SIZEOF unary_expression
	{ printf("unary_expression\n"); }
	| SIZEOF PARENTHESISOPEN type_name PARENTHESISCLOSE
	{ printf("unary_expression\n"); }
	;

unary_operator: BITWISE_AND
	{ printf("unary_operator\n"); }
	| MULTIPLY
	{ printf("unary_operator\n"); }
	| ADD
	{ printf("unary_operator\n"); }
	| SUBTRACT
	{ printf("unary_operator\n"); }
	| BITWISE_NOR
	{ printf("unary_operator\n"); }
	| NOT
	{ printf("unary_operator\n"); }
	;		

cast_expression: unary_expression
	{ printf("cast_expression\n"); }
	| PARENTHESISOPEN type_name PARENTHESISCLOSE cast_expression
	{ printf("cast_expression\n"); }
	;

multiplicative_expression: cast_expression
	{ printf("multiplicative_expression\n"); }
	| multiplicative_expression MULTIPLY cast_expression
	{ printf("multiplicative_expression\n"); }
	| multiplicative_expression FORWARD_SLASH cast_expression
	{ printf("multiplicative_expression\n"); }
	| multiplicative_expression MODULO cast_expression
	{ printf("multiplicative_expression\n"); }
	;

additive_expression: multiplicative_expression
	{ printf("additive_expression\n"); }
	| additive_expression ADD multiplicative_expression
	{ printf("additive_expression\n"); }
	| additive_expression SUBTRACT multiplicative_expression
	{ printf("additive_expression\n"); }
	;

shift_expression: additive_expression
	{ printf("shift_expression\n"); }
	| shift_expression LEFT_SHIFT additive_expression
	{ printf("shift_expression\n"); }
	| shift_expression RIGHT_SHIFT additive_expression
	{ printf("shift_expression\n"); }
	;	

relational_expression: shift_expression
	{ printf("relational_expression\n"); }
	| relational_expression LESS_THAN shift_expression
	{ printf("relational_expression\n"); }
	| relational_expression GREATER_THAN shift_expression
	{ printf("relational_expression\n"); }
	| relational_expression LESS_THAN_EQUAL shift_expression
	{ printf("relational_expression\n"); }
	| relational_expression GREATER_THAN_EQUAL shift_expression
	{ printf("relational_expression\n"); }
	;

equality_expression: relational_expression
	{ printf("equality_expression\n"); }
	| equality_expression EQUALITY relational_expression
	{ printf("equality_expression\n"); }
	| equality_expression NOT_EQUAL relational_expression
	{ printf("equality_expression\n"); }
	;

and_expression: equality_expression
	{ printf("and_expression\n"); }
	| and_expression BITWISE_AND equality_expression
	{ printf("and_expression\n"); }
	;

exclusive_or_expression: and_expression
	{ printf("exclusive_or_expression\n"); }
	| exclusive_or_expression BITWISE_XOR and_expression
	{ printf("exclusive_or_expression\n"); }
	;

inclusive_or_expression: exclusive_or_expression
	{ printf("inclusive_or_expression\n"); }
	| inclusive_or_expression BITWISE_OR exclusive_or_expression
	{ printf("inclusive_or_expression\n"); }
	;

logical_and_expression: inclusive_or_expression
	{ printf("logical_and_expression\n"); }
	| logical_and_expression AND inclusive_or_expression
	{ printf("logical_and_expression\n"); }
	;

logical_or_expression: logical_and_expression
	{ printf("logical_or_expression\n"); }
	| logical_or_expression OR logical_and_expression
	{ printf("logical_or_expression\n"); }
	;

conditional_expression: logical_or_expression
	{ printf("conditional_expression\n"); }
	| logical_or_expression TERNARY_OP expression COLON conditional_expression
	{ printf("conditional_expression\n"); }
	;

assignment_expression: conditional_expression
	{ printf("assignment_expression\n"); }
	| unary_expression assignment_operator assignment_expression
	{ printf("assignment_expression\n"); }
	;

assignment_operator: ASSIGNMENT
	{ printf("assignment_operator\n"); }
	| MULTIPLY_EQUAL
	{ printf("assignment_operator\n"); }
	| DIVIDE_EQUAL
	{ printf("assignment_operator\n"); }
	| MOD_EQUAL
	{ printf("assignment_operator\n"); }
	| PLUS_EQUAL
	{ printf("assignment_operator\n"); }
	| MINUS_EQUAL	
	{ printf("assignment_operator\n"); }
	| LEFT_SHIFT_EQUAL	
	{ printf("assignment_operator\n"); }
	| RIGHT_SHIFT_EQUAL
	{ printf("assignment_operator\n"); }
	| AND_EQUAL
	{ printf("assignment_operator\n"); }
	| XOR_EQUAL
	{ printf("assignment_operator\n"); }
	| OR_EQUAL
	{ printf("assignment_operator\n"); }
	;

expression: assignment_expression
	{ printf("expression\n"); }
	| expression COMMA assignment_expression
	{ printf("expression\n"); }
	;

constant_expression: conditional_expression
	{ printf("constant_expression\n"); }
	;

expression_optional: expression
			  | %empty
			  ;

declaration: declaration_specifiers SEMICOLON
	{ printf("declaration\n"); }
	| declaration_specifiers init_declarator_list SEMICOLON
	{ printf("declaration\n"); }
	;

declaration_specifiers: storage_class_specifier
	{ printf("declaration_specifiers\n"); }
	| storage_class_specifier declaration_specifiers
	{ printf("declaration_specifiers\n"); }
	| type_specifier
	{ printf("declaration_specifiers\n"); }
	| type_specifier declaration_specifiers
	{ printf("declaration_specifiers\n"); }	
	| type_qualifier
	{ printf("declaration_specifiers\n"); }	
	| type_qualifier declaration_specifiers
	{ printf("declaration_specifiers\n"); }
	| function_specifier 
	{ printf("declaration_specifiers\n"); }
	| function_specifier declaration_specifiers
	{ printf("declaration_specifiers\n"); }
	;	

init_declarator_list: init_declarator
	{ printf("init_declarator_list\n"); }
	| init_declarator_list COMMA init_declarator
	{ printf("init_declarator_list\n"); }
	;

init_declarator: declarator
	{ printf("init_declarator\n"); }
	| declarator ASSIGNMENT initializer
	{ printf("init_declarator\n"); }
	;

storage_class_specifier: EXTERN
	{ printf("storage_class_specifier\n"); }
	| STATIC
	{ printf("storage_class_specifier\n"); }
	;	

type_specifier: VOID
	{ printf("type_specifier\n"); }
	| CHAR
	{ printf("type_specifier\n"); }
	| SHORT
	{ printf("type_specifier\n"); }
	| INT
	{ printf("type_specifier\n"); }
	| LONG
	{ printf("type_specifier\n"); }
	| FLOAT
	{ printf("type_specifier\n"); }
	| DOUBLE
	;

specifier_qualifier_list: type_specifier specifier_qualifier_list
	{ printf("specifier_qualifier_list\n"); }
	| type_specifier
	{ printf("specifier_qualifier_list\n"); }
	| type_qualifier specifier_qualifier_list
	{ printf("specifier_qualifier_list\n"); }
	| type_qualifier
	{ printf("specifier_qualifier_list\n"); }
	;	

type_qualifier: CONST
	{ printf("type_qualifier\n"); }
	| RESTRICT
	{ printf("type_qualifier\n"); }
    | VOLATILE
	{ printf("type_qualifier\n"); }
	;

function_specifier: INLINE
	{ printf("function_specifier\n"); }
	;

declarator: pointer direct_declarator
	{ printf("declarator\n"); }
	| direct_declarator
	{ printf("declarator\n"); }
	;	

direct_declarator: IDENTIFIER
	{ printf("direct_declarator\n"); }
	| PARENTHESISOPEN declarator PARENTHESISCLOSE
	{ printf("direct_declarator\n"); }
	| direct_declarator SQUAREBRACEOPEN  type_qualifier_list_opt assignment_expression_opt SQUAREBRACECLOSE
	{ printf("direct_declarator\n"); }
	| direct_declarator SQUAREBRACEOPEN STATIC type_qualifier_list_opt assignment_expression SQUAREBRACECLOSE
    { printf("direct_declarator\n"); }
    | direct_declarator SQUAREBRACEOPEN type_qualifier_list STATIC assignment_expression SQUAREBRACECLOSE
	{ printf("direct_declarator\n"); }
	| direct_declarator SQUAREBRACEOPEN type_qualifier_list_opt MULTIPLY SQUAREBRACECLOSE
	{ printf("direct_declarator\n"); }
	| direct_declarator PARENTHESISOPEN parameter_type_list PARENTHESISCLOSE
	{ printf("direct_declarator\n"); }
	| direct_declarator PARENTHESISOPEN identifier_list PARENTHESISCLOSE
	{ printf("direct_declarator\n"); }
	| direct_declarator PARENTHESISOPEN PARENTHESISCLOSE
	{ printf("direct_declarator\n"); }
	;

assignment_expression_opt: %empty
	{ printf("assignment_expression_opt\n"); }
	| assignment_expression
	{ printf("assignment_expression_opt\n"); }
	;

type_qualifier_list_opt: %empty
	| type_qualifier_list
	{ printf("type_qualifier_list_opt\n"); }
	;

pointer: MULTIPLY
	{ printf("pointer\n"); }
	| MULTIPLY type_qualifier_list
	{ printf("pointer\n"); }
	| MULTIPLY pointer
	{ printf("pointer\n"); }
	| MULTIPLY type_qualifier_list pointer
	{ printf("pointer\n"); }
	;

type_qualifier_list: type_qualifier
	{ printf("type_qualifier_list\n"); }
	| type_qualifier_list type_qualifier
	{ printf("type_qualifier_list\n"); }
	;
	
parameter_type_list: parameter_list
	{ printf("parameter_type_list\n"); }
	| parameter_list COMMA ELLIPSIS
	{ printf("parameter_type_list\n"); }
	;

parameter_list: parameter_declaration
	{ printf("parameter_list\n"); }
	| parameter_list COMMA parameter_declaration
	{ printf("parameter_list\n"); }
	;

parameter_declaration: declaration_specifiers declarator
	{ printf("parameter_declaration\n"); }
	| declaration_specifiers
	{ printf("parameter_declaration\n"); }
	;

identifier_list: IDENTIFIER
	{ printf("identifier_list\n"); }
	| identifier_list COMMA IDENTIFIER
	{ printf("identifier_list\n"); }
	;

type_name: specifier_qualifier_list
	{ printf("type_name\n"); }
	;

initializer: assignment_expression
	{ printf("initializer\n"); }
	| CURLYBRACEOPEN initializer_list CURLYBRACECLOSE
	{ printf("initializer\n"); }
	| CURLYBRACEOPEN initializer_list COMMA CURLYBRACECLOSE
	{ printf("initializer\n"); }
	;

initializer_list: initializer
	{ printf("initializer_list\n"); }
	| designation initializer
	{ printf("initializer_list\n"); }
	| initializer_list COMMA initializer
	{ printf("initializer_list\n"); }
	|  initializer_list COMMA designation initializer
	{ printf("initializer_list\n"); }
	;

designation: designator_list ASSIGNMENT
	{ printf("designation\n"); }
	;

designator_list: designator
	{ printf("designator_list\n"); }
	| designator_list designator
	{ printf("designator_list\n"); }
	;

designator: SQUAREBRACEOPEN constant_expression SQUAREBRACECLOSE
	{ printf("designator\n"); }
	| DOT IDENTIFIER
	{ printf("designator\n"); }
	;	



statement: labeled_statement
	{ printf("statement\n"); }
	| compound_statement
	{ printf("statement\n"); }
	| expression_statement
	{ printf("statement\n"); }
	| selection_statement
	{ printf("statement\n"); }
	| iteration_statement
	{ printf("statement\n"); }
	| jump_statement
	{ printf("statement\n"); }
	;

labeled_statement: IDENTIFIER COLON statement
	{ printf("labeled_statement\n"); }
	| CASE constant_expression COLON statement
	{ printf("labeled_statement\n"); }
	| DEFAULT COLON statement
	{ printf("labeled_statement\n"); }
	;

compound_statement: CURLYBRACEOPEN CURLYBRACECLOSE
	{ printf("compound_statement\n"); }
	| CURLYBRACEOPEN block_item_list CURLYBRACECLOSE
	{ printf("compound_statement\n"); }
	;

block_item_list: block_item
	{ printf("block_item_list\n"); }
	| block_item_list block_item
	{ printf("block_item_list\n"); }
	;

block_item: declaration
	{ printf("block_item\n"); }
	| statement
	{ printf("block_item\n"); }
	;

expression_statement: SEMICOLON
	{ printf("expression_statement\n"); }
	| expression SEMICOLON
	{ printf("expression_statement\n"); }
	;

selection_statement: IF PARENTHESISOPEN expression PARENTHESISCLOSE statement  %prec THEN
	{ printf("selection_statement\n"); }
	| IF PARENTHESISOPEN expression PARENTHESISCLOSE statement ELSE statement
	{ printf("selection_statement\n"); }
	| SWITCH PARENTHESISOPEN expression PARENTHESISCLOSE statement
	{ printf("selection_statement\n"); }
	;

iteration_statement: WHILE PARENTHESISOPEN expression PARENTHESISCLOSE statement
	{ printf("iteration_statement\n"); }
	| DO statement WHILE PARENTHESISOPEN expression PARENTHESISCLOSE SEMICOLON
	{ printf("iteration_statement\n"); }
	| FOR PARENTHESISOPEN expression_optional SEMICOLON expression_optional SEMICOLON expression_optional PARENTHESISCLOSE statement 
	{ printf("iteration_statement\n"); }
	| FOR PARENTHESISOPEN declaration expression_optional SEMICOLON expression_optional PARENTHESISCLOSE statement
	{ printf("iteration_statement\n"); }
	;

jump_statement: GOTO IDENTIFIER SEMICOLON
	{ printf("jump_statement\n"); }
	| CONTINUE SEMICOLON
	{ printf("jump_statement\n"); }
	| BREAK SEMICOLON
	{ printf("jump_statement\n"); }
	| RETURN expression_optional SEMICOLON
	{ printf("jump_statement\n"); }
	;



translation_unit:external_declaration
	{ printf("translation_unit\n"); }
	| translation_unit external_declaration
	{ printf("translation_unit\n"); }
	;

external_declaration: function_definition
	{ printf("external_declaration\n"); }	
	| declaration
	{ printf("external_declaration\n"); }
	;

function_definition: declaration_specifiers declarator declaration_list compound_statement
	{ printf("function_definition\n"); }	
	| declaration_specifiers declarator compound_statement
	{ printf("function_definition\n"); }
	;
    
declaration_list: declaration
	{ printf("declaration_list\n"); }
	| declaration_list declaration
	{ printf("declaration_list\n"); }
	;
%%

void yyerror(const char *s) {
	printf ("ERROR is %s\n", s);
	printf("ERROR is %s\n", yytext);
	printf("Line Number is %d", yylineno);
}
