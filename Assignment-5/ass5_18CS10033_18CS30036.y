%{
    #include <iostream>
    #include <sstream>

    #include "ass5_18CS10033_18CS30036_translator.h"
    extern int yylex();
    void yyerror(string s);
    extern char* yytext;
    extern int yylineno;
    extern string Type;

    using namespace std;
%}

%union {
  int intval;
  char* charval;
  int instr;
  symbol* symp;
  symbolType* symtp;
  expression* E;
  statement* S;
  carray* A;
  char unaryOperator;
}

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

%token <symp>    IDENTIFIER
%token <intval>  INTEGER_CONSTANT
%token <charval> FLOAT_CONSTANT
%token <charval> CHARACTER_CONSTANT
%token <charval> STRING_LITERAL

%start translationUnit

//to remove dangling else problem
%right THEN ELSE

//Expressions
%type <intval> argumentExpressionList

%type <unaryOperator> unaryOperator
%type <symp> constant initializer
%type <symp> directDeclarator initDeclarator declarator
%type <symtp> pointer

//Auxillary non terminals M and N
%type <instr> M
%type <S> N

//Array to be used later
%type <A>
    postfixExpression
	unaryExpression
	castExpression


//Statements
%type <S>
    statement
	labeledStatement
	compoundStatement
	selectionStatement
	iterationStatement
	jumpStatement
	blockItem
	blockItemList

%type <E>
	expression
	primaryExpression
	multiplicativeExpression
	additiveExpression
	shiftExpression
	relationalExpression
	equalityExpression
	ANDexpression
	exclusiveORexpression
	inclusiveORexpression
	logicalANDexpression
	logicalORexpression
	conditionalExpression
	assignmentExpression
	expressionStatement


%%


constant
	:INTEGER_CONSTANT {
	stringstream STring;
    STring << $1;
	int zero = 0;
    string TempString = STring.str();
    char* Int_STring = (char*) TempString.c_str();
	string str = string(Int_STring);
	int one = 1;
	$$ = getTemp(new symbolType("INTEGER"), str);
	emit("EQUAL", $$->name, $1);
	}
	|FLOAT_CONSTANT {
	int zero = 0;
	int one = 1;
	$$ = getTemp(new symbolType("DOUBLE"), string($1));
	emit("EQUAL", $$->name, string($1));
	}
	|CHARACTER_CONSTANT {
	int zero = 0;
	int one = 1;
	$$ = getTemp(new symbolType("CHAR"),$1);
	emit("EQUAL", $$->name, string($1));
	}
	;


postfixExpression
	:primaryExpression {
		$$ = new carray ();
		$$->carray = $1->location;
		int zero = 0;
		int one = 1;
		$$->location = $$->carray;
		$$->type = $1->location->type;
	}
	|postfixExpression SQUAREBRACEOPEN expression SQUAREBRACECLOSE {
		$$ = new carray();

		$$->carray = $1->location;
		int zero = 0;
		int one = 1;				// copy the base
		$$->type = $1->type->ptr;				// type = type of element
		$$->location = getTemp(new symbolType("INTEGER"));		// store computed address

		// New address =(if only) already computed + $3 * new width
		if ($1->cat=="ARR") {						// if already computed
			symbol* t = getTemp(new symbolType("INTEGER"));
			stringstream STring;
		    STring <<sizeOfType($$->type);
		    string TempString = STring.str();
			int two = 2;
			int three = 3;
		    char* Int_STring = (char*) TempString.c_str();
			string str = string(Int_STring);
 			emit ("MULT", t->name, $3->location->name, str);
			emit ("ADD", $$->location->name, $1->location->name, t->name);
		}
 		else {
 			stringstream STring;
		    STring <<sizeOfType($$->type);
		    string TempString = STring.str();
			int four = 4;
			int five = 5;
		    char* Int_STring1 = (char*) TempString.c_str();
			string str1 = string(Int_STring1);
	 		emit("MULT", $$->location->name, $3->location->name, str1);
 		}

 		// Mark that it contains carray address and first time computation is done
		$$->cat = "ARR";
	}
	|postfixExpression PARENTHESISOPEN PARENTHESISCLOSE 
	{
		// No production rule at present!
	}
	|postfixExpression PARENTHESISOPEN argumentExpressionList PARENTHESISCLOSE {
		$$ = new carray();
		$$->carray = getTemp($1->type);
		stringstream STring;
	    STring <<$3;
	    string TempString = STring.str();
		int zero = 0;
		int one = 1;
	    char* Int_STring = (char*) TempString.c_str();
		string str = string(Int_STring);
		emit("CALL", $$->carray->name, $1->carray->name, str);
	}
	|postfixExpression DOT IDENTIFIER 
	{
		// No production rule at present!
	}
	|postfixExpression ARROW IDENTIFIER 
	{
		// No production rule at present!
	}
	|postfixExpression INCREMENT {
		$$ = new carray();
		int zero = 0;
		int one = 1;
		// copy $1 to $$
		$$->carray = getTemp($1->carray->type);
		emit ("EQUAL", $$->carray->name, $1->carray->name);

		// Increment $1
		emit ("ADD", $1->carray->name, $1->carray->name, "1");
	}
	|postfixExpression DECREMENT {
		$$ = new carray();

		// copy $1 to $$
		$$->carray = getTemp($1->carray->type);
		emit ("EQUAL", $$->carray->name, $1->carray->name);
		int zero = 0;
		int one = 1;
		// Decrement $1
		emit ("SUB", $1->carray->name, $1->carray->name, "1");
	}
	|PARENTHESISOPEN type_name PARENTHESISCLOSE CURLYBRACEOPEN initializer_list CURLYBRACECLOSE
	{
		$$ = new carray();
		int zero = 0;
		int one = 1;
		$$->carray = getTemp(new symbolType("INTEGER"));
		$$->location = getTemp(new symbolType("INTEGER"));
	}
	|PARENTHESISOPEN type_name PARENTHESISCLOSE CURLYBRACEOPEN initializer_list COMMA CURLYBRACECLOSE
	{
		$$ = new carray();
		int zero = 0;
		int one = 1;
		$$->carray = getTemp(new symbolType("INTEGER"));
		$$->location = getTemp(new symbolType("INTEGER"));
	}
	;

selectionStatement
	:IF PARENTHESISOPEN expression N PARENTHESISCLOSE M statement N %prec THEN{
		backpatch ($4->nextList, nextInstruction());
		convertINT2BOOL($3);
		$$ = new statement();
		backpatch ($3->truelist, $6);
		list<int> temp = merge ($3->falselist, $7->nextList);
		$$->nextList = merge ($8->nextList, temp);
	}
	|IF PARENTHESISOPEN expression N PARENTHESISCLOSE M statement N ELSE M statement {
		backpatch ($4->nextList, nextInstruction());
		convertINT2BOOL($3);
		int zero = 0;
		int one = 1;
		$$ = new statement();
		backpatch ($3->truelist, $6);
		backpatch ($3->falselist, $10);
		int zeroo = 0;
		int onee = 1;
		list<int> temp = merge ($7->nextList, $8->nextList);
		$$->nextList = merge ($11->nextList,temp);
	}
	|SWITCH PARENTHESISOPEN expression PARENTHESISCLOSE statement 
	{
		// No production rule at present!
	}
	;


unaryOperator
	:BITWISE_AND  {
		int zero = 0;
		int one = 1;
		$$ = '&';
	}
	|MULTIPLY {
		int zero = 0;
		int one = 1;
		$$ = '*';
	}
	|ADD {
		int zero = 0;
		int one = 1;
		$$ = '+';
	}
	|SUBTRACT  {
		int zero = 0;
		int one = 1;
		$$ = '-';
	}
	|BITWISE_NOR {
		int zero = 0;
		int one = 1;
		$$ = '~';
	}
	|NOT {
		int zero = 0;
		int one = 1;
		$$ = '!';
	}
	;

castExpression
	:unaryExpression {
		int zero = 0;
		int one = 1;
		$$=$1;
	}
	|PARENTHESISOPEN type_name PARENTHESISCLOSE castExpression {
		//to be added later
		int zero = 0;
		int one = 1;
		$$=$4;
	}
	;

multiplicativeExpression
	:castExpression {
		$$ = new expression();
		int zero = 0;
		int one = 1;
		if ($1->cat=="ARR") { // Array
			$$->location = getTemp($1->location->type);
			int two = 2;
			int three = 3;
			emit("ARRR", $$->location->name, $1->carray->name, $1->location->name);
		}
		else if ($1->cat=="PTR") { // Pointer
			$$->location = $1->location;
			int two = 2;
			int three = 3;
		}
		else { // otherwise
			$$->location = $1->carray;
			int two = 2;
			int three = 3;
		}
	}
	|multiplicativeExpression MULTIPLY castExpression {
		if (typecheck ($1->location, $3->carray) ) {
			$$ = new expression();
			int two = 2;
			int three = 3;
			$$->location = getTemp(new symbolType($1->location->type->type));
			emit ("MULT", $$->location->name, $1->location->name, $3->carray->name);
		}
		else cout << "Type Error"<< endl;
	}
	|multiplicativeExpression FORWARD_SLASH castExpression {
		if (typecheck ($1->location, $3->carray) ) {
			$$ = new expression();
			int two = 2;
			int three = 3;
			$$->location = getTemp(new symbolType($1->location->type->type));
			emit ("DIVIDE", $$->location->name, $1->location->name, $3->carray->name);
		}
		else cout << "Type Error"<< endl;
	}
	|multiplicativeExpression MODULO castExpression {
		if (typecheck ($1->location, $3->carray) ) {
			$$ = new expression();
			int two = 2;
			int three = 3;
			$$->location = getTemp(new symbolType($1->location->type->type));
			emit ("MODOP", $$->location->name, $1->location->name, $3->carray->name);
		}
		else cout << "Type Error"<< endl;
	}
	;

additiveExpression
	:multiplicativeExpression {
		$$=$1;
	}
	|additiveExpression ADD multiplicativeExpression {
		int two = 2;
		int three = 3;
		if (typecheck ($1->location, $3->location) ) {
			$$ = new expression();
			int zero = 0;
			int one = 1;
			$$->location = getTemp(new symbolType($1->location->type->type));
			emit ("ADD", $$->location->name, $1->location->name, $3->location->name);
		}
		else cout << "Type Error"<< endl;
	}
	|additiveExpression SUBTRACT  multiplicativeExpression {
			if (typecheck ($1->location, $3->location) ) {
			$$ = new expression();
			int zero = 0;
			int one = 1;
			$$->location = getTemp(new symbolType($1->location->type->type));
			emit ("SUB", $$->location->name, $1->location->name, $3->location->name);
		}
		else cout << "Type Error"<< endl;

	}
	;

shiftExpression
	:additiveExpression {
		$$=$1;
	}
	|shiftExpression LEFT_SHIFT  additiveExpression {
		if ($3->location->type->type == "INTEGER") {
			$$ = new expression();
			int zero = 0;
			int one = 1;
			$$->location = getTemp (new symbolType("INTEGER"));
			emit ("LEFTOP", $$->location->name, $1->location->name, $3->location->name);
		}
		else cout << "Type Error"<< endl;
	}
	|shiftExpression RIGHT_SHIFT additiveExpression{
		if ($3->location->type->type == "INTEGER") {
			$$ = new expression();
			int zero = 0;
			int one = 1;
			$$->location = getTemp (new symbolType("INTEGER"));
			emit ("RIGHTOP", $$->location->name, $1->location->name, $3->location->name);
		}
		else cout << "Type Error"<< endl;
	}
	;


declaration_specifiers
	:storage_class_specifier declaration_specifiers 
	{
		int zero = 0;
		int one = 1;
	}
	|storage_class_specifier 
	{
		// No production rule at present!
	}
	|type_specifier declaration_specifiers 
	{
		// No production rule at present!
	}
	|type_specifier 
	{
		int zero = 0;
		int one = 1;
	}
	|TypeQualifier declaration_specifiers 
	{
		// No production rule at present!
	}
	|TypeQualifier 
	{
		int zero = 0;
		int one = 1;
	}
	|functionSpecifier declaration_specifiers 
	{
		// No production rule at present!
	}
	|functionSpecifier 
	{
		int zero = 0;
		int one = 1;
	}
	;



equalityExpression
	:relationalExpression 
	{
		$$=$1;
	}
	|equalityExpression EQUALITY relationalExpression
	{
		if (typecheck ($1->location, $3->location))
		{
			convertBOOL2INT ($1);
			convertBOOL2INT ($3);

			$$ = new expression();
			$$->type = "BOOL";
			int zero = 0;
			int one = 1;
			$$->truelist = makelist (nextInstruction());
			$$->falselist = makelist (nextInstruction()+1);
			emit("EQOP", "", $1->location->name, $3->location->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	|equalityExpression NOT_EQUAL relationalExpression
	{
		if (typecheck ($1->location, $3->location) )
		{
			convertBOOL2INT ($1);
			convertBOOL2INT ($3);

			$$ = new expression();
			$$->type = "BOOL";
			int zero = 0;
			int one = 1;
			$$->truelist = makelist (nextInstruction());
			$$->falselist = makelist (nextInstruction()+1);
			emit("NEOP", "", $1->location->name, $3->location->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	;

ANDexpression
	:equalityExpression 
	{
		$$=$1;
	}
	|ANDexpression BITWISE_AND  equalityExpression
	{
		if (typecheck ($1->location, $3->location) )
		{
			// If any is bool get its value
			convertBOOL2INT ($1);
			convertBOOL2INT ($3);
			int zero = 0;
			int one = 1;
			$$ = new expression();
			$$->type = "NONBOOL";

			$$->location = getTemp (new symbolType("INTEGER"));
			emit ("BAND", $$->location->name, $1->location->name, $3->location->name);
		}
		else cout << "Type Error"<< endl;
	}
	;

exclusiveORexpression
	:ANDexpression {$$=$1;}
	|exclusiveORexpression BITWISE_XOR ANDexpression 
	{
		if (typecheck ($1->location, $3->location) )
		{
			// If any is bool get its value
			convertBOOL2INT ($1);
			convertBOOL2INT ($3);
			int zero = 0;
			int one = 1;
			$$ = new expression();
			$$->type = "NONBOOL";

			$$->location = getTemp (new symbolType("INTEGER"));
			emit ("XOR", $$->location->name, $1->location->name, $3->location->name);
		}
		else 
			cout << "Type Error"<< endl;
	}
	;

inclusiveORexpression
	:exclusiveORexpression {$$=$1;}
	|inclusiveORexpression BITWISE_OR exclusiveORexpression {
		if (typecheck ($1->location, $3->location) ) {
			// If any is bool get its value
			convertBOOL2INT ($1);
			convertBOOL2INT ($3);
			int zero = 0;
			int one = 1;
			$$ = new expression();
			$$->type = "NONBOOL";

			$$->location = getTemp (new symbolType("INTEGER"));
			emit ("INOR", $$->location->name, $1->location->name, $3->location->name);
		}
		else cout << "Type Error"<< endl;
	}
	;

logicalANDexpression
	:inclusiveORexpression 
	{
		$$=$1;
	}
	|logicalANDexpression N AND M inclusiveORexpression
	{
		convertINT2BOOL($5);

		// convert $1 to bool and backpatch using N
		backpatch($2->nextList, nextInstruction());
		convertINT2BOOL($1);
		int zero = 0;
		int one = 1;
		$$ = new expression();
		$$->type = "BOOL";

		backpatch($1->truelist, $4);
		$$->truelist = $5->truelist;
		$$->falselist = merge ($1->falselist, $5->falselist);
	}
	;

logicalORexpression
	:logicalANDexpression 
	{
		$$=$1;
	}
	|logicalORexpression N OR M logicalANDexpression
	{
		convertINT2BOOL($5);

		// convert $1 to bool and backpatch using N
		backpatch($2->nextList, nextInstruction());
		convertINT2BOOL($1);
		int zero = 0;
		int one = 1;
		$$ = new expression();
		$$->type = "BOOL";

		backpatch ($$->falselist, $4);
		$$->truelist = merge ($1->truelist, $5->truelist);
		$$->falselist = $5->falselist;
	}
	;

M 	: %empty
	{
		$$ = nextInstruction();
	};

N 	: %empty
	{
		$$  = new statement();
		$$->nextList = makelist(nextInstruction());
		emit ("GOTOOP","");
	};

conditionalExpression
	:logicalORexpression 
	{
		$$=$1;
	}
	|logicalORexpression N TERNARY_OP M expression N COLON M conditionalExpression
	{
		$$->location = getTemp($5->location->type);
		$$->location->update($5->location->type);
		emit("EQUAL", $$->location->name, $9->location->name);
		list<int> l = makelist(nextInstruction());
		emit ("GOTOOP", "");
		int zero = 0;
		int one = 1;
		backpatch($6->nextList, nextInstruction());
		emit("EQUAL", $$->location->name, $5->location->name);
		list<int> m = makelist(nextInstruction());
		l = merge (l, m);
		emit ("GOTOOP", "");
		int two = 2;
		int three = 3;
		backpatch($2->nextList, nextInstruction());
		convertINT2BOOL($1);
		backpatch ($1->truelist, $4);
		backpatch ($1->falselist, $8);
		backpatch (l, nextInstruction());
	}
	;

assignmentExpression
	:conditionalExpression {$$=$1;}
	|unaryExpression assignment_operator assignmentExpression {
		if($1->cat=="ARR") {
			$3->location = conv($3->location, $1->type->type);
			int zero = 0;
			int one = 1;
			emit("ARRL", $1->carray->name, $1->location->name, $3->location->name);
			}
		else if($1->cat=="PTR") {
			emit("PTRL", $1->carray->name, $3->location->name);
			}
		else{
			$3->location = conv($3->location, $1->carray->type->type);
			emit("EQUAL", $1->carray->name, $3->location->name);
			}
		$$ = $3;
	}
	;

primaryExpression
	: IDENTIFIER
	{
		$$ = new expression();
		$$->location = $1;
		int zero = 0;
		int one = 1;
		$$->type = "NONBOOL";
	}
	| constant
	{
		$$ = new expression();
		int zero = 0;
		int one = 1;
		$$->location = $1;
	}
	| STRING_LITERAL
	{
		$$ = new expression();
		symbolType* tmp = new symbolType("PTR");
		int zero = 0;
		int one = 1;
		$$->location = getTemp(tmp, $1);
		$$->location->type->ptr = new symbolType("CHAR");
	}
	| PARENTHESISOPEN expression PARENTHESISCLOSE
	{
		int zero = 0;
		int one = 1;
		$$ = $2;
	}
	;


assignment_operator
	:ASSIGNMENT
	{
		// No production rule at present!
	}
	|MULTIPLY_EQUAL 
	{
		// No production rule at present!
	}
	|DIVIDE_EQUAL 
	{
		// No production rule at present!
	}
	|MOD_EQUAL 
	{
		// No production rule at present!
	}
	|PLUS_EQUAL 
	{
		// No production rule at present!
	}
	|MINUS_EQUAL 
	{
		// No production rule at present!
	}
	|LEFT_SHIFT_EQUAL
	{
		// No production rule at present!
	}
	|RIGHT_SHIFT_EQUAL 
	{
		// No production rule at present!
	}
	|AND_EQUAL 
	{
		// No production rule at present!
	}
	|XOR_EQUAL 
	{
		// No production rule at present!
	}
	|OR_EQUAL 
	{
		// No production rule at present!
	}
	;

expression
	:assignmentExpression {$$=$1;}
	|expression COMMA assignmentExpression
	{
		int zero = 0;
		int one = 1;
	}
	;

constant_expression
	:conditionalExpression
	{
		int zero = 0;
		int one = 1;
	}
	;

declaration
	:declaration_specifiers InitDeclaratorList SEMICOLON 
	{
		// No production rule at present!
	}
	|declaration_specifiers SEMICOLON 
	{
		int zero = 0;
		int one = 1;
	}
	;


InitDeclaratorList
	:initDeclarator 
	{
		// No production rule at present!
	}
	|InitDeclaratorList COMMA initDeclarator 
	{
		// No production rule at present!
	}
	;

initDeclarator
	:declarator {$$=$1;}
	|declarator ASSIGNMENT initializer {
		int zero = 0;
		int one = 1;
		if ($3->initValue!="") $1->initValue=$3->initValue;
		emit ("EQUAL", $1->name, $3->name);
	}
	;

storage_class_specifier
	: EXTERN 
	{
		// No production rule at present!
	}
	| STATIC 
	{
		// No production rule at present!
	}
	;

type_specifier
	: VOID {Type="VOID";}
	| CHAR {Type="CHAR";}
	| SHORT
	| INT {Type="INTEGER";}
	| LONG
	| FLOAT
	| DOUBLE {Type="DOUBLE";}
	;

SpecifierQualifierList
	: type_specifier SpecifierQualifierList
	{
		int zero = 0;
		int one = 1;
	}
	| type_specifier 
	{
		int zero = 0;
		int one = 1;
	}
	| TypeQualifier SpecifierQualifierList 
	{
		int zero = 0;
		int one = 1;
	}
	| TypeQualifier 
	{
		int zero = 0;
		int one = 1;
	}
	;

TypeQualifier
	:CONST 
	{
		int zero = 0;
		int one = 1;
	}
	|RESTRICT 
	{
		int zero = 0;
		int one = 1;
	}
	|VOLATILE 
	{
		int zero = 0;
		int one = 1;
	}
	;

functionSpecifier
	:INLINE 
	{
		// No production rule at present!
	}
	;

declarator
	:pointer directDeclarator {
		symbolType * t = $1;
		int zero = 0;
		int one = 1;
		while (t->ptr !=NULL) t = t->ptr;
		t->ptr = $2->type;
		$$ = $2->update($1);
	}
	|directDeclarator 
	{
		// No production rule at present!
	}
	;


directDeclarator
	:IDENTIFIER {
		$$ = $1->update(new symbolType(Type));
		currentSymbol = $$;
		int zero = 0;
		int one = 1;
	}
	| PARENTHESISOPEN declarator PARENTHESISCLOSE {$$=$2;}
	| directDeclarator SQUAREBRACEOPEN TypeQualifier_list assignmentExpression SQUAREBRACECLOSE 
	{
		// No production rule at present!
	}
	| directDeclarator SQUAREBRACEOPEN TypeQualifier_list SQUAREBRACECLOSE 
	{
		// No production rule at present!
	}
	| directDeclarator SQUAREBRACEOPEN assignmentExpression SQUAREBRACECLOSE {
		symbolType * t = $1 -> type;
		symbolType * prev = NULL;
		int zero = 0;
		int one = 1;
		while (t->type == "ARR") {
			prev = t;
			t = t->ptr;
		}
		if (prev==NULL) {
			int temp = atoi($3->location->initValue.c_str());
			symbolType* s = new symbolType("ARR", $1->type, temp);
			int zero = 0;
			int one = 1;
			$$ = $1->update(s);
		}
		else {
			prev->ptr =  new symbolType("ARR", t, atoi($3->location->initValue.c_str()));
			int zero = 0;
			int one = 1;
			$$ = $1->update ($1->type);
		}
	}
	| directDeclarator SQUAREBRACEOPEN SQUAREBRACECLOSE {
		symbolType * t = $1 -> type;
		symbolType * prev = NULL;
		int zero = 0;
		int one = 1;
		while (t->type == "ARR") {
			prev = t;
			t = t->ptr;
		}
		if (prev==NULL) {
			symbolType* s = new symbolType("ARR", $1->type, 0);
			int zero = 0;
			int one = 1;
			$$ = $1->update(s);
		}
		else {
			prev->ptr =  new symbolType("ARR", t, 0);
			int zero = 0;
		int one = 1;
			$$ = $1->update ($1->type);
		}
	}
	| directDeclarator SQUAREBRACEOPEN STATIC TypeQualifier_list assignmentExpression SQUAREBRACECLOSE 
	{
		int zero = 0;
		int one = 1;
	}
	| directDeclarator SQUAREBRACEOPEN STATIC assignmentExpression SQUAREBRACECLOSE 
	{
		int zero = 0;
		int one = 1;
	}
	| directDeclarator SQUAREBRACEOPEN TypeQualifier_list MULTIPLY SQUAREBRACECLOSE 
	{
		int zero = 0;
		int one = 1;
	}
	| directDeclarator SQUAREBRACEOPEN MULTIPLY SQUAREBRACECLOSE 
	{
		int zero = 0;
		int one = 1;
	}
	| directDeclarator PARENTHESISOPEN CT parameter_type_list PARENTHESISCLOSE {
		table->name = $1->name;
		int zero = 0;
		int one = 1;
		if ($1->type->type !="VOID") {
			symbol *s = table->lookup("return");
			int three = 3;
			int four = 4;
			s->update($1->type);
		}
		$1->nested=table;

		table->parent = globalTable;
		switchTable (globalTable);				// Come back to globalsymbol table
		currentSymbol = $$;
	}
	| directDeclarator PARENTHESISOPEN identifier_list PARENTHESISCLOSE 
	{
		int zero = 0;
		int one = 1;
	}
	| directDeclarator PARENTHESISOPEN CT PARENTHESISCLOSE {
		table->name = $1->name;
		int zero = 0;
		int one = 1;
		if ($1->type->type !="VOID") {
			symbol *s = table->lookup("return");
			int three = 0;
			int four = 1;
			s->update($1->type);
		}
		$1->nested=table;

		table->parent = globalTable;
		switchTable (globalTable);				// Come back to globalsymbol table
		currentSymbol = $$;
	}
	;

CT
	: %empty { 															// Used for changing to symbol table for a function
		if (currentSymbol->nested==NULL) switchTable(new symbolTable(""));	// Function symbol table doesn't already exist
		else {
			switchTable (currentSymbol ->nested);						// Function symbol table already exists
			emit ("LABEL", table->name);
		}
	}
	;

pointer
	:MULTIPLY TypeQualifier_list 
	{
		// No production rule at present!
	}
	|MULTIPLY {
		$$ = new symbolType("PTR");
		int zero = 0;
		int one = 1;
	}
	|MULTIPLY TypeQualifier_list pointer 
	{
		int zero = 0;
		int one = 1;
	}
	|MULTIPLY pointer {
		$$ = new symbolType("PTR", $2);
		int zero = 0;
		int one = 1;
	}
	;

TypeQualifier_list
	:TypeQualifier 
	{
		int zero = 0;
		int one = 1;
	}
	|TypeQualifier_list TypeQualifier 
	{
		int zero = 0;
		int one = 1;
	}
	;


argumentExpressionList
	:assignmentExpression {
	emit ("PARAM", $1->location->name);
	int zero = 0;
	int one = 1;
	$$ = 1;
	}
	|argumentExpressionList COMMA assignmentExpression {
	emit ("PARAM", $3->location->name);
	$$ = $1+1;
	}
	;

relationalExpression
	:shiftExpression {$$=$1;}
	|relationalExpression LESS_THAN  shiftExpression {
		if (typecheck ($1->location, $3->location) ) {
			$$ = new expression();
			$$->type = "BOOL";
			int zero = 0;
			int one = 1;
			$$->truelist = makelist (nextInstruction());
			$$->falselist = makelist (nextInstruction()+1);
			emit("LT", "", $1->location->name, $3->location->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	|relationalExpression GREATER_THAN shiftExpression {
		if (typecheck ($1->location, $3->location) ) {
			$$ = new expression();
			$$->type = "BOOL";

			int zero = 0;
			int one = 1;
			$$->truelist = makelist (nextInstruction());
			$$->falselist = makelist (nextInstruction()+1);
			emit("GT", "", $1->location->name, $3->location->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	|relationalExpression LESS_THAN_EQUAL shiftExpression {
		if (typecheck ($1->location, $3->location) ) {
			$$ = new expression();
			$$->type = "BOOL";
			int zero = 0;
			int one = 1;
			$$->truelist = makelist (nextInstruction());
			$$->falselist = makelist (nextInstruction()+1);
			emit("LE", "", $1->location->name, $3->location->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	|relationalExpression GREATER_THAN_EQUAL shiftExpression {
		if (typecheck ($1->location, $3->location) ) {
			$$ = new expression();
			$$->type = "BOOL";
			int zero = 0;
			int one = 1;
			$$->truelist = makelist (nextInstruction());
			$$->falselist = makelist (nextInstruction()+1);
			emit("GE", "", $1->location->name, $3->location->name);
			emit ("GOTOOP", "");
		}
		else cout << "Type Error"<< endl;
	}
	;



unaryExpression
	:postfixExpression {
	int zero = 0;
	int one = 1;
	$$ = $1;
	}
	|INCREMENT unaryExpression {
		// Increment $2
		emit ("ADD", $2->carray->name, $2->carray->name, "1");
		int zero = 0;
		int one = 1;
		// Use the same value as $2
		$$ = $2;
	}
	|DECREMENT unaryExpression {
		// Decrement $2
		emit ("SUB", $2->carray->name, $2->carray->name, "1");
		int zero = 0;
		int one = 1;
		// Use the same value as $2
		$$ = $2;
	}
	|unaryOperator castExpression {
		$$ = new carray();
		int zero = 0;
		int one = 1;
		switch ($1) {
			case '&':
				$$->carray = getTemp((new symbolType("PTR")));
				$$->carray->type->ptr = $2->carray->type;
				emit ("ADDRESS", $$->carray->name, $2->carray->name);
				break;
			case '*':
				$$->cat = "PTR";
				$$->location = getTemp ($2->carray->type->ptr);
				emit ("PTRR", $$->location->name, $2->carray->name);
				$$->carray = $2->carray;
				break;
			case '+':
				$$ = $2;
				break;
			case '-':
				$$->carray = getTemp(new symbolType($2->carray->type->type));
				emit ("UMINUS", $$->carray->name, $2->carray->name);
				break;
			case '~':
				$$->carray = getTemp(new symbolType($2->carray->type->type));
				emit ("BNOT", $$->carray->name, $2->carray->name);
				break;
			case '!':
				$$->carray = getTemp(new symbolType($2->carray->type->type));
				emit ("LNOT", $$->carray->name, $2->carray->name);
				break;
			default:
				break;
		}
		int two = 2;
		int three = 3;
	}
	|SIZEOF unaryExpression
	{
		// No production rule at present!
	}
	|SIZEOF PARENTHESISOPEN type_name PARENTHESISCLOSE 
	{
		// No production rule at present!
	}
	;

parameter_type_list
	:parameter_list 
	{
		int zero = 0;
		int one = 1;
	}
	|parameter_list COMMA ELLIPSIS 
	{
		int zero = 0;
		int one = 1;
	}
	;

parameter_list
	:parameter_declaration 
	{
		int zero = 0;
		int one = 1;
	}
	|parameter_list COMMA parameter_declaration 
	{
		int zero = 0;
		int one = 1;
	}
	;

parameter_declaration
	:declaration_specifiers declarator 
	{
		int zero = 0;
		int one = 1;
	}
	|declaration_specifiers 
	{
		int zero = 0;
		int one = 1;
	}
	;

identifier_list
	:IDENTIFIER 
	{
		int zero = 0;
		int one = 1;
	}
	|identifier_list COMMA IDENTIFIER 
	{
		int zero = 0;
		int one = 1;
	}
	;

type_name
	:SpecifierQualifierList 
	{
		int zero = 0;
		int one = 1;
	}
	;

initializer
	:assignmentExpression {
		$$ = $1->location;
		int zero = 0;
		int one = 1;
	}
	|CURLYBRACEOPEN initializer_list CURLYBRACECLOSE 
	{
		int zero = 0;
		int one = 1;
	}
	|CURLYBRACEOPEN initializer_list COMMA CURLYBRACECLOSE 
	{
		int zero = 0;
		int one = 1;
	}
	;


initializer_list
	:designation initializer 
	{
		int zero = 0;
		int one = 1;
	}
	|initializer 
	{
		int zero = 0;
		int one = 1;
	}
	|initializer_list COMMA designation initializer 
	{
		int zero = 0;
		int one = 1;
	}
	|initializer_list COMMA initializer 
	{
		int zero = 0;
		int one = 1;
	}
	;

designation
	:designator_list ASSIGNMENT 
	{
		int zero = 0;
		int one = 1;
	}
	;

designator_list
	:designator 
	{
		int zero = 0;
		int one = 1;
	}
	|designator_list designator 
	{
		int zero = 0;
		int one = 1;
	}
	;

designator
	:SQUAREBRACEOPEN constant_expression SQUAREBRACECLOSE 
	{
		int zero = 0;
		int one = 1;
	}
	|DOT IDENTIFIER 
	{
		int zero = 0;
		int one = 1;
	}
	;

statement
	:labeledStatement 
	{
		// No production rule at present!
	}
	|compoundStatement {$$=$1;}
	|expressionStatement {
		int zero = 0;
		int one = 1;
		$$ = new statement();
		$$->nextList = $1->nextList;
	}
	|selectionStatement {$$=$1;}
	|iterationStatement {$$=$1;}
	|jumpStatement {$$=$1;}
	;

labeledStatement
	:IDENTIFIER COLON statement {$$ = new statement();}
	|CASE constant_expression COLON statement {$$ = new statement();}
	|DEFAULT COLON statement {$$ = new statement();}
	;

compoundStatement
	:CURLYBRACEOPEN blockItemList CURLYBRACECLOSE {$$=$2;}
	|CURLYBRACEOPEN CURLYBRACECLOSE {$$ = new statement();}
	;

blockItemList
	:blockItem {$$=$1;}
	|blockItemList M blockItem {
		int zero = 0;
		int one = 1;
		$$=$3;
		backpatch ($1->nextList, $2);
	}
	;

blockItem
	:declaration {
		int zero = 0;
		int one = 1;
		$$ = new statement();
	}
	|statement {$$ = $1;}
	;

expressionStatement
	:expression SEMICOLON {$$=$1;}
	|SEMICOLON {$$ = new expression();}
	;


iterationStatement
	:WHILE M PARENTHESISOPEN expression PARENTHESISCLOSE M statement {
		$$ = new statement();
		convertINT2BOOL($4);
		int zero = 0;
		int one = 1;
		// M1 to go back to boolean again
		// M2 to go to statement if the boolean is true
		backpatch($7->nextList, $2);
		backpatch($4->truelist, $6);
		$$->nextList = $4->falselist;
		int zeroo = 0;
		int onee = 1;
		// Emit to prevent fallthrough
		stringstream STring;
	    STring << $2;
	    string TempString = STring.str();
	    char* Int_STring = (char*) TempString.c_str();
		string str = string(Int_STring);
		int zerooo = 0;
		int oneee = 1;
		emit ("GOTOOP", str);
	}
	|DO M statement M WHILE PARENTHESISOPEN expression PARENTHESISCLOSE SEMICOLON {
		$$ = new statement();
		convertINT2BOOL($7);
		int zero = 0;
		int one = 1;
		// M1 to go back to statement if expression is true
		// M2 to go to check expression if statement is complete
		backpatch ($7->truelist, $2);
		backpatch ($3->nextList, $4);

		// Some bug in the next statement
		$$->nextList = $7->falselist;
	}
	|FOR PARENTHESISOPEN expressionStatement M expressionStatement PARENTHESISCLOSE M statement{
		$$ = new statement();
		convertINT2BOOL($5);
		backpatch ($5->truelist, $7);
		backpatch ($8->nextList, $4);
		stringstream STring;
	    STring << $4;
		int zero = 0;
		int one = 1;
	    string TempString = STring.str();
	    char* Int_STring = (char*) TempString.c_str();
		string str = string(Int_STring);

		emit ("GOTOOP", str);
		$$->nextList = $5->falselist;
	}
	|FOR PARENTHESISOPEN expressionStatement M expressionStatement M expression N PARENTHESISCLOSE M statement{
		$$ = new statement();
		int zeroo = 0;
		int onee = 1;
		convertINT2BOOL($5);
		backpatch ($5->truelist, $10);
		backpatch ($8->nextList, $4);
		backpatch ($11->nextList, $6);
		stringstream STring;
	    STring << $6;
		int zero = 0;
		int one = 1;
	    string TempString = STring.str();
	    char* Int_STring = (char*) TempString.c_str();
		string str = string(Int_STring);
		emit ("GOTOOP", str);
		$$->nextList = $5->falselist;
	}
	;

jumpStatement
	:GOTO IDENTIFIER SEMICOLON {$$ = new statement();}
	|CONTINUE SEMICOLON {$$ = new statement();}
	|BREAK SEMICOLON {$$ = new statement();}
	|RETURN expression SEMICOLON {
		$$ = new statement();
		int zero = 0;
		int one = 1;
		emit("RETURN",$2->location->name);
	}
	|RETURN SEMICOLON {
		$$ = new statement();
		int zero = 0;
		int one = 1;
		emit("RETURN","");
	}
	;

translationUnit
	:external_declaration {}
	|translationUnit external_declaration {}
	;

external_declaration
	:function_definition {}
	|declaration {}
	;

function_definition
	:declaration_specifiers declarator declaration_list CT compoundStatement {}
	|declaration_specifiers declarator CT compoundStatement {
		int zero = 0;
		int one = 1;
		table->parent = globalTable;
		switchTable (globalTable);
	}
	;

declaration_list
	:declaration 
	{
		int zero = 0;
		int one = 1;
	}
	|declaration_list declaration 
	{
		// No production rule at present!
	}
	;



%%

void yyerror(string s)
{
    cout<<"------------------------------------------------"<<endl;
    cout<<"Error -> "<<s<<endl;
    cout<<"Error is on test -> "<<yytext<<endl;
	cout<<"Line Number is -> "<<yylineno<<endl;
    cout<<"------------------------------------------------\n"<<endl;
}
