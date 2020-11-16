/*
####################################
#### Mukul Mehta | 18CS10033    ####
#### Rashil Gandhi | 18CS30036  ####
#### CS39003 -> Compilers Lab   ####
#### Assignment 5               ####
####################################
*/

#ifndef __TRANSLATION_UNIT
#define __TRANSLATION_UNIT

#include <iostream>
#include <list>
#include <map>
#include <vector>
using namespace std;

/*
	Hardcode sizes for variable types
	These sizes are for x86_64 target platform

	In order to target a different platform, these values need
	to be changed for that specific target architecture
	------------------
	Sizes:
		`function` -> 0 bytes (Since C doesn't support closures, functions don't occupy memory)
		`char`     -> 1 byte
		`int`      -> 4 bytes
		`double`   -> 8 bytes
		`pointer`  -> 4 bytes (Irrespective of type it points to)
*/
#define __VOID_SIZE 0
#define __FUNCTION_SIZE 0
#define __CHARACTER_SIZE 1
#define __INTEGER_SIZE 4
#define __POINTER_SIZE 4
#define __DOUBLE_SIZE 8

/*
	Class Declarations
	------------------
	Classes:
		symbol    -> Element of Symbol Table
		symbolType   -> Symbol Type Class
		symbolTable  -> Symbol Table

		quad      -> Element of Quad Array
		quadArray -> Array of quads
	------------------
*/
class symbol;
class symbolType;
class symbolTable;

class quad;
class quadArray;

/*
	Global Symbols used in `ass5_18CS10033_translator.cxx` and `ass5_18CS10033_18CS30036.y`
	------------------
	Symbols:
		table: symbolTable*       -> Symbol Table for the code
		globalTable: symbolTable* -> Global Symbol Table
		currentSymbol: symbol* -> Pointer to the current symbol
		quadList: quadArray    -> Array of quads in the present program

		yytext: char*          -> Function used by flex that holds current tokens
		yyparse(): int         -> Function used by flex that reads stream from yylex()
	------------------
*/
extern symbol* currentSymbol;
extern symbolTable* table;
extern symbolTable* globalTable;
extern quadArray quadList;

extern char* yytext;
extern int yyparse();

/*
	class symbol
	symbol(string name, string t="INTEGER", symbolType* ptr = NULL, int width = 0);
	------------------
	Member Variables:
		name: string          	   -> Name of the symbol
		type: symbolType* 		   -> Type of the symbol
		initValue: string 	  	   -> Initial Value of the symbol if any
		size: int     	 	  	   -> Size of the symbol
		offset: int			  	   -> Offset from base pointer
		nested: symbolTable* 	  	   -> Points to nested symbol table if any

	Member Methods:
		update(symbolType *): symbol* -> Update existing symbol
	------------------
*/
class symbol {
   public:
    string name;
    symbolType* type;
    string initValue;
    int size;
    int offset;
    symbolTable* nested;

    symbol(string name, string t = "INTEGER", symbolType* ptr = NULL, int width = 0);
    symbol* update(symbolType* t);
};

/*
	class symbolType
	symbolType(string type, symbolType* ptr = NULL, int width = 1);
	------------------
	Member Variables:
		type: symbolType* 		   -> Type of the symbol
		ptr: symbolType*		   -> For complex types like arrays or structs, points to type of the inner elements
		width: int				   -> Size of array, 1 in case of simple types
	------------------
*/
class symbolType {
   public:
    string type;
    symbolType* ptr;
    int width;
    symbolType(string type, symbolType* ptr = NULL, int width = 1);
};

/*
	class symbolTable
	symbolTable(string name = "NULL");
	------------------
	Member Variables:
		name: string 	 	 	-> Name of the Symbol Table
		tempCount: int   	 	-> Number of temporary variables inserted in the symbol table
		table: list<symbol>  	-> List of all symbols present in that symbol table
		parent: symbolTable* 	-> Parent of the given symbol table, NULL for global symbol table

	Member Methods:
		print(): void           -> Print the symbol table
		update(): void		    -> Update entries of the symbol table
		lookup(string): symbol* -> Find a symbol in the symbol table, returns pointer to that symbol
	------------------
*/
class symbolTable {
   public:
    string name;
    int tempCount;
    list<symbol> table;
    symbolTable* parent;

    symbolTable(string name = "NULL");
    symbol* lookup(string name);
    void print();
    void update();
};

/*
	class quad
	quad(string res, string arg1, string operation = "EQUAL", string arg2 = "");
	quad(string res, int arg1, string operation = "EQUAL", string arg2 = "");
	quad(string res, float arg1, string operation = "EQUAL", string arg2 = "");
	------------------
	Member Variables:
		op: string     -> Operator
		arg1: string   -> First argument
		arg2: string   -> Second argument
		result: string -> Result of the TAC

	Member Methods:
		print: void    -> Print a quad
	------------------
	Multiple constructors are present for constructor overloading, to instantiate with different argument lists
*/
class quad {
   public:
    string op;
    string arg1;
    string arg2;
    string result;

    void print();

    quad(string res, string arg1, string operation = "EQUAL", string arg2 = "");
    quad(string res, int arg1, string operation = "EQUAL", string arg2 = "");
    quad(string res, float arg1, string operation = "EQUAL", string arg2 = "");
};

/*
	class quadArray
	------------------
	Member Variables:
		quads: vector<quad> -> Vector of all quads

	Member Methods:
		print: void         -> Print the quad array
	------------------
*/
class quadArray {
   public:
    vector<quad> quads;

    void print();
};

/*
	struct statement
	------------------
	Members:
		nextList: list<int> -> Next list for statement
	------------------
*/
struct statement {
    list<int> nextList;
};

/*
	struct carray
	------------------
	Members:
		cat: string
		location: symbol* -> Calculate address of array
		carray: symbol*   -> Symbol table for the array
		type: symbolType* -> Type of the array generated
	------------------
*/
struct carray {
    string cat;
    symbol* location;
    symbol* carray;
    symbolType* type;
};

/*
	struct expression
	------------------
	Members:
		type: string      	 -> Is expression of type `int` or `bool`
		location: symbol* 	 -> Pointer to symbol table entry
		truelist: list<int>  -> Truelist for boolean expressions
		falselist: list<int> -> Falselist for boolean expressions
		nextList: list<int>
	------------------
*/
struct expression {
    string type;
    symbol* location;
    list<int> truelist;
    list<int> falselist;
    list<int> nextList;
};

/*
	void emit
	Function used by parser to add a quad to the list of quads

	emit is overloaded for different types of quads (argument can be string, int or float)
*/
void emit(string op, string result, string arg1 = "", string arg2 = "");
void emit(string op, string result, int arg1, string arg2 = "");
void emit(string op, string result, float arg1, string arg2 = "");

/*
	list<int> makelist(int i)
	------------------
	Parameters:
		i: int 		 -> New list with only i
	Returns:
		_: list<int> -> New list created
	------------------
*/
list<int> makelist(int i);

/*
	list<int> merge(list<int>& list1, list<int>& list2)
	------------------
	Parameters:
		list1: list<int>&  -> First list
		list2: list<int>&  -> Second list
	Returns:
		_: list<int> 	   -> Concatenate two lists and return pointer to the merged list
	------------------
*/
list<int> merge(list<int>& list1, list<int>& list2);

/*
	void backpatch(list<int> list, int i)
	------------------
	Parameters:
		list: list<int> -> list of quads
		i: int 			-> target label to insert for list of quads
	------------------
*/
void backpatch(list<int> list, int i);

/*
	bool typecheck(symbol*& s1, symbol*& s2)
	bool typecheck(symbolType* t1, symbolType* t2)
	------------------
	Parameters:
		s1: symbol*& -> First symbol
		s2: symbol*& -> Second symbol
	Returns:
		_: bool      -> Returns true if s1 and s2 are same or compatible types
	------------------
	Overloaded function, can also check if 2 symbolType objects are specified instead of actual symbols
*/
bool typecheck(symbol*& s1, symbol*& s2);
bool typecheck(symbolType* t1, symbolType* t2);

/*
	symbol* conv(symbol *, string)
	------------------
	Parameters:
		_: symbol* -> Input symbol whose type is to be converted
		_: string  -> Type to convert the symbol to
	Returns:
		_: symbol* -> Pointer to new symbol of type specified in the function
	------------------
	Global function that converts symbol to type of name string
*/
symbol* conv(symbol*, string);

/*
	Functions to convert Integer to Boolean and vice-versa
*/
expression* convertINT2BOOL(expression*);
expression* convertBOOL2INT(expression*);

/*
	void switchTable(symbolTable* newtable)
	------------------
	Parameters:
		newTable: symbolTable* -> Switch to this new symbol table
	------------------
*/
void switchTable(symbolTable* newTable);

/*
	int nextInstruction()
	------------------
	Returns:
		_: int -> Returns the next instruction's number
	------------------
*/
int nextInstruction();

/*
	symbol* getTemp(symbolType* table, string initValue = "")
	------------------
	Parameters:
		table: symbolType* -> Table in which to generate temporary variable
		initValue: string  -> Initial value of the temporary variable generated
	Returns:
		_: symbol* 		   -> Pointer to the temporary symbol generated
	------------------
*/
symbol* getTemp(symbolType* table, string initValue = "");

/*
	Auxillary functions for getting size of a type and printing type
*/
int sizeOfType(symbolType*);
string checkType(symbolType*);

#endif
