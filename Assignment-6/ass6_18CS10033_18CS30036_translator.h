/*
####################################
#### Mukul Mehta | 18CS10033    ####
#### Rashil Gandhi | 18CS30036  ####
#### CS39003 -> Compilers Lab   ####
#### Assignment 6               ####
####################################
*/

/*
	This file is the header with function prototypes, class definitions
	and struct definitons for the translator and the target translator
	This is the header that will be included with the CXX files and any other
	files in the future that require an API for this tinyC compiler
*/

#ifndef _TRANSLATION_UNIT
#define _TRANSLATION_UNIT

#include <cmath>
#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <map>
#include <set>
#include <stack>
#include <string>
#include <vector>

#define pb push_back

using namespace std;

#define __VOID_SIZE 0
#define __FUNCTION_SIZE 0
#define __CHARACTER_SIZE 1
#define __BOOLEAN_SIZE 1
#define __INTEGER_SIZE 4
#define __POINTER_SIZE 4
#define __DOUBLE_SIZE 8

extern map<int, int> mp_set;

extern stack<string> _parameter_stack;
extern stack<int> _type_stack;
extern stack<int> _offset_stack;
extern stack<int> _pointer_stack;
extern vector<string> _string_labels;

/*
    Class Definitions
    ------------------
    class symbolType;
    class _array;
    class symbol;
    class symbolTable;
    class quad;
    class quadArray;
*/

class symbolType;
class _array;
class symbol;
class symbolTable;
class quad;
class quadArray;

/*
	Struct Definitions
	------------------
	struct list;
	struct declarator;
	struct identifier;
	struct expression;
	struct argList;
*/

struct list;
struct declarator;
struct identifier;
struct expression;
struct argList;

extern symbolType *globalType;
extern int nextInstruction;
extern int TEMP_VAR_COUNT;
extern symbolTable *globalSymbolTable;
extern symbolTable *currentSymbolTable;
extern quadArray globalQuadArray;

typedef struct list {
    int index;
    struct list *next;
} list;

/*
	struct declarator
    Stores a declaration
    ------------------
    type: symbolType* -> Type of the current declaration
    width: int        -> Size of the variable declared

*/
typedef struct declarator {
    symbolType *type;
    int width;
} declarator;

/*
	struct identifier
    Stores an identifier
    ------------------
    name: string*     -> Type of the current declaration
    symTPtr: symbol        -> Size of the variable declared

*/
typedef struct identifier {
    symbol *symTPtr;  // pointer to the symboltable
    string *name;     // name of the identifier
} identifier;

/*
	struct argList
    Stores a list of all arguments
    ------------------
    args: vector<expression *> -> Vector of expressions
*/
typedef struct argList {
    vector<expression *> *args;
} argList;

/*
	struct expression
    Stores an expression along with the type it evaluates to, symbol table it is in etc
    ------------------
    args: vector<expression *> -> Vector of expressions
*/
typedef struct expression {
    symbol *symTPtr;
    symbolType *type;
    list *truelist;
    list *falselist;
    bool isPointer;
    bool isArray;
    bool isString;
    int ind_str;
    symbol *arr;
    symbol *poss_array;
} expression;

/*
	Enum Definitions
	------------------
	enum types;
	enum opcodes;
*/

/*
	enum types
	Lists all the types the tinyC compiler understands
	------------------
*/
enum types {
    tp_void = 0,
    tp_bool,
    tp_char,
    tp_int,
    tp_double,
    tp_ptr,
    tp_arr,
    tp_func
};

/*
	enum opcode
	Lists all the opcodes that are possible.These will be used in the translator
	------------------
*/
enum opcode {

    // Binary Operators
    Q_PLUS = 1,
    Q_MINUS,
    Q_MULT,
    Q_DIVIDE,
    Q_MODULO,
    Q_LEFT_OP,
    Q_RIGHT_OP,
    Q_XOR,
    Q_AND,
    Q_OR,
    Q_LOG_AND,
    Q_LOG_OR,
    Q_LESS,
    Q_LESS_OR_EQUAL,
    Q_GREATER_OR_EQUAL,
    Q_GREATER,
    Q_EQUAL,
    Q_NOT_EQUAL,

    //Unary Operators
    Q_UNARY_MINUS,
    Q_UNARY_PLUS,
    Q_COMPLEMENT,
    Q_NOT,

    // Assignment Operator
    Q_ASSIGN,

    // Unconditional Jump (GOTO)
    Q_GOTO,

    //Conditional Jump
    Q_IF_EQUAL,
    Q_IF_NOT_EQUAL,
    Q_IF_EXPRESSION,
    Q_IF_NOT_EXPRESSION,
    Q_IF_LESS,
    Q_IF_GREATER,
    Q_IF_LESS_OR_EQUAL,
    Q_IF_GREATER_OR_EQUAL,

    // Type Conversions
    Q_CHAR2INT,
    Q_CHAR2DOUBLE,
    Q_INT2CHAR,
    Q_DOUBLE2CHAR,
    Q_INT2DOUBLE,
    Q_DOUBLE2INT,

    // Functon Call
    Q_PARAM,
    Q_CALL,
    Q_RETURN,

    // Pointer Arithmetic
    Q_LDEREF,
    Q_RDEREF,
    Q_ADDR,

    // Array Indexing
    Q_RINDEX,
    Q_LINDEX,

};

/*
    The union baseType defines the basic types that can exist in the program. It stores
    the initialized  value of the type inside the symbol table
*/
union baseType {
    int _INT_INITVAL;
    double _DOUBLE_INITVAL;
    char _CHAR_INITVAL;
};

/*
	class symbolType
	symbolType(types t, int width = 1, symbolType *ptr = NULL);
	------------------
	Member Variables:
		type: symbolType* 		   -> Type of the symbol
		next: symbolType*		   -> For complex types like arrays or structs, points to type of the inner elements
		width: int				   -> Size of array, 1 in case of simple types

    Member Functions:
        sizeOfType(): int          -> Get size of a certain type
        getBaseType(): int         -> Get base type (In case of arrays etc, returns type of element)
        printSize(): void          -> Print size of a given type
        print(): void              -> Print a given type
    ------------------
*/
class symbolType {
   public:
    int width;
    types type;
    symbolType *next;

    symbolType(types t, int width = 1, symbolType *next = NULL);

    int sizeOfType();
    types getBaseType();
    void printSize();
    void print();
};

class _array {
   public:
    string array;
    types tp;
    int bsize;
    int ndims;
    vector<int> dims;

    _array(string s, int sz, types t);
    void _arrayIndex(int i);
};

/*
	class symbol
	symbol(string name);
	------------------
	Member Variables:
		name: string          	   -> Name of the symbol
		type: symbolType* 		   -> Type of the symbol
        width: int     	 	  	   -> Size of the symbol
		offset: int			  	   -> Offset from base pointer
		_init_val: baseType 	   -> Initial Value of the symbol if any

		nested: symbolTable* 	   -> Points to nested symbol table if any

	Member Methods:
		update(symbolType *): symbol* -> Update existing symbol
	------------------
*/
class symbol {
   public:
    string name;
    int width;
    int offset;
    symbolType *type;
    baseType _init_val;
    symbolTable *nested;
    bool isValid;
    bool isMarked;
    bool isPointerArray;
    bool isGlobal;
    bool isInitialized;
    bool isFunction;
    bool isArray;
    _array *arr;

    void getNewArray();
    string var_type;  //to store whether the varaible is "null=0" "local=1" "param=2" "func=3" "ret=4" "temporary=5"

    symbol(string name = "");
};

class symbolTable {
   public:
    string name;
    int offset;
    int initQuad;
    int lastQuad;
    vector<symbol *> symbolTabList;
    int emptyArgList;

    symbolTable();
    ~symbolTable();

    symbol *lookup(string n);
    symbol *globalLookup(string n);

    symbol *search(string n);
    symbol *gentemp(symbolType *type);

    void update(symbol *symTPtr, symbolType *type, baseType initval, symbolTable *next = NULL);  //
    void print();
    void mark_labels();
    void function_prologue(FILE *fp, int count);
    void globalVar(FILE *fp);
    void generateTargetCode(FILE *fp, int ret_count);
    int callFunction(FILE *fp);
    void function_epilogue(FILE *fp, int count, int ret_count);
    string assignRegister(int type_of, int no);
    void calcOffset();
    void destroyFunction(FILE *fp);
    int findGlobal(string n);
};

/*
	class quad
	quad(opcode op, string _arg1, string _arg2, string result)
	------------------
	Member Variables:
		op: string     -> Operator
		arg1: string   -> First argument
		arg2: string   -> Second argument
		result: string -> Result of the TAC

	Member Methods:
		print: void    -> Print a quad
	------------------
*/
class quad {
   public:
    opcode op;
    string arg1;
    string arg2;
    string result;

    void print();

    quad(opcode op, string _arg1, string _arg2, string result);
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

    quadArray();

    void emit(opcode opc, string arg1 = "", string arg2 = "", string result = "");
    void emit(opcode opc, int val, string operand = "");
    void emit(opcode opc, double val, string operand = "");
    void emit(opcode opc, char val, string operand = "");
    void emitG(opcode opc, string arg1 = "", string arg2 = "", string result = "");
    void print();
};

/*
	list<int> makelist(int i)
	------------------
	Parameters:
		i: int 		 -> New list with only i
	Returns:
		_: list<int> -> New list created
	------------------
*/
list *makelist(int i);

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
list *merge(list *list1, list *list2);

/*
	void backpatch(list<int> list, int i)
	------------------
	Parameters:
		list: list<int> -> list of quads
		i: int 			-> target label to insert for list of quads
	------------------
*/
void backpatch(list *list, int i);

void CONV2BOOL(expression *e);
void typecheck(expression *e1, expression *e2, bool isAssign = false);
void printList(list *root);

symbolType *CopyType(symbolType *t);

#endif
