/*
####################################
#### Mukul Mehta | 18CS10033    ####
#### Rashil Gandhi | 18CS30036  ####
#### CS39003 -> Compilers Lab   ####
#### Assignment 5               ####
####################################
*/

#include "ass5_18CS10033_18CS30036_translator.h"

#include <iomanip>
using namespace std;

/*
    Global variables imported from the corresponding header (`ass5_18CS10033_18CS30036_translator.h`)
*/
symbol* currentSymbol;
symbolTable* table;
symbolTable* globalTable;
quadArray quadList;
string Type;

void symbolTableEntry(symbol temp) {
    cout << left << setw(20) << temp.name;
    cout << left << setw(25) << checkType(temp.type);
    cout << left << setw(17) << temp.initValue;
    cout << left << setw(12) << temp.size;
    cout << left << setw(11) << temp.offset;
    cout << left;
}

symbol::symbol(string name, string t, symbolType* ptr, int width) : name(name) {
    type = new symbolType(t, ptr, width);
    nested = NULL;
    initValue = "";
    offset = 0;
    size = sizeOfType(type);
}

symbol* symbol::update(symbolType* t) {
    type = t;
    this->size = sizeOfType(t);
    return this;
}

symbolType::symbolType(string name, symbolType* ptr, int width) : type(name),
                                                                  ptr(ptr),
                                                                  width(width){};

symbolTable::symbolTable(string name) : name(name), tempCount(0){};

void symbolTable::print() {
    list<symbolTable*> tablelist;
    cout << "-------------------------------------------------------------------------------------------------------------------" << endl;
    cout << "Symbol Table -> " << setfill(' ') << left << setw(50) << this->name << endl;
    cout << "Parent -> " << setfill(' ') << left << setw(50);

    if (this->parent != NULL)
        cout << this->parent->name << endl;

    else
        cout << "NULL"<<endl;

    cout << "----------------------------------------------------------------------------------------------------" << endl;

    cout << setfill(' ') << left << setw(20) << "Name";
    cout << left << setw(25) << "Type";
    cout << left << setw(17) << "Initial Value";
    cout << left << setw(12) << "Size";
    cout << left << setw(11) << "Offset";
    cout << left << "Nested" << endl;
    cout << "----------------------------------------------------------------------------------------------------" << endl;

    for (auto it = table.begin(); it != table.end(); it++) {
        symbolTableEntry(*it);
        if (it->nested == NULL) {
            cout << "NULL" << endl;
        }

        else {
            cout << it->nested->name << endl;
            tablelist.push_back(it->nested);
        }
    }
    cout << "-------------------------------------------------------------------------------------------------------------------" << endl;
    cout << endl;

    for (auto it = tablelist.begin(); it != tablelist.end(); it++)
        (*it)->print();
}

void symbolTable::update() {
    list<symbolTable*> tablelist;
    int off;

    for (auto it = table.begin(); it != table.end(); it++) {
        if (it == table.begin()) {
            it->offset = 0;
            off = it->size;
        }

        else {
            it->offset = off;
            off = it->offset + it->size;
        }

        if (it->nested != NULL)
            tablelist.push_back(it->nested);
    }

    for (auto it = tablelist.begin(); it != tablelist.end(); it++)
        (*it)->update();

    return;
}

symbol* symbolTable::lookup(string name) {
    symbol* s;

    auto it = table.begin();
    for (; it != table.end(); it++) {
        if (it->name == name)
            break;
    }

    if (it != table.end())
        return &(*it);

    else {
        s = new symbol(name);
        table.push_back(*s);
        return &table.back();
    }
}

quad::quad(string res, string _arg1, string operation, string _arg2) : result(res), arg1(_arg1), arg2(_arg2), op(operation){};

quad::quad(string res, int _arg1, string operation, string _arg2) : result(res), arg2(_arg2), op(operation) {
    arg1 = to_string(_arg1);
}

quad::quad(string res, float _arg1, string operation, string _arg2) : result(res), arg2(_arg2), op(operation) {
    arg1 = to_string(_arg1);
}

void quad::print() {
    if (op == "EQUAL")
        cout << result << " = " << arg1;

    else if (op == "GOTOOP")
        cout << "goto " << result;

    else if (op == "PTRL")
        cout << "*" << result << " = " << arg1;

    else if (op == "ARRR")
        cout << result << " = " << arg1 << "[" << arg2 << "]";

    else if (op == "ARRL")
        cout << result << "[" << arg1 << "]" << " = " << arg2;

    else if (op == "RETURN")
        cout << "ret " << result;

    else if (op == "PARAM")
        cout << "param " << result;

    else if (op == "CALL")
        cout << result << " = "
             << "call " << arg1 << ", " << arg2;

    else if (op == "LABEL")
        cout << result << ": ";

    else {
        map<string, string> op_sym_match = {
            {"ADD", " + "},
            {"SUB", " - "},
            {"MULT", " * "},
            {"DIVIDE", " / "},
            {"MODOP", " % "},
            {"XOR", " ^ "},
            {"INOR", " | "},
            {"BAND", " & "},
            {"LEFTOP", " << "},
            {"RIGHTOP", " >> "},
            {"EQOP", " == "},
            {"NEOP", " != "},
            {"LT", " < "},
            {"GT", " > "},
            {"LE", " <= "},
            {"GE", " >= "},
            {"ADDRESS", " = & "},
            {"PTRR", " = * "},
            {"UMINUS", " = - "},
            {"BNOT", " = ~ "},
            {"LNOT", " = ! "}};

        vector<string> binary{"ADD", "SUB", "MULT", "DIVIDE", "MODOP", "XOR", "INOR", "BAND", "LEFTOP", "RIGHTOP"};
        vector<string> relational{"EQOP", "NEOP", "LT", "GT", "LE", "GE"};
        vector<string> unary{"ADDRESS", "PTRR", "UMINUS", "BNOT", "LNOT"};

        for (string i : binary) {
            if (op == i) {
                cout << result << " = " << arg1 << op_sym_match[op] << arg2;
                goto end;
            }
        }

        for (string i : relational) {
            if (op == i) {
                cout << "if " << arg1 << op_sym_match[op] << arg2 << " goto " << result;
                goto end;
            }
        }

        for (string i : unary) {
            if (op == i) {
                cout << result << op_sym_match[op] << arg1;
                goto end;
            }
        }

        cout << op;
    }
end:
    cout << endl;
}

void quadArray::print() {
    cout << "---------------------------------" << endl;
    cout << "|\t\tTAC Translation\t\t\t|" << endl;
    cout << "---------------------------------\n" << endl;

    int base = 100;
    for (quad temp : quads) {
        if (temp.op != "LABEL") {
            cout << "\t" << setw(4) << base << ":\t";
            temp.print();
        }

        else {
            cout << "\n";
            temp.print();
            cout << "\n";
        }
        base++;
    }
    cout << endl;
}

void emit(string op, string result, string arg1, string arg2) {
    auto _temp = new quad(result, arg1, op, arg2);
    quadList.quads.push_back(*_temp);
    return;
}
void emit(string op, string result, int arg1, string arg2) {
    auto _temp = new quad(result, arg1, op, arg2);
    quadList.quads.push_back(*_temp);
    return;
}
void emit(string op, string result, float arg1, string arg2) {
    auto _temp = new quad(result, arg1, op, arg2);
    quadList.quads.push_back(*_temp);
    return;
}

list<int> makelist(int i) {
    list<int> l(1, i);
    return l;
}

list<int> merge(list<int>& a, list<int>& b) {
    a.merge(b);
    return a;
}

void backpatch(list<int> l, int addr) {
    string str = to_string(addr);

    for (auto it = l.begin(); it != l.end(); it++) {
        quadList.quads[*it].result = str;
    }

    return;
}

bool typecheck(symbol*& s1, symbol*& s2) {
    symbolType* type1 = s1->type;
    symbolType* type2 = s2->type;

    if (typecheck(type1, type2))
        return true;

    else if (s1 = conv(s1, type2->type))
        return true;

    else if (s2 = conv(s2, type1->type))
        return true;

    return false;
}
bool typecheck(symbolType* t1, symbolType* t2) {
    if (t1 == NULL && t2 == NULL)
        return true;

    if (t1 == NULL || t2 == NULL)
        return false;

    if (t1->type != t2->type)
        return false;

    return typecheck(t1->ptr, t2->ptr);
}

symbol* conv(symbol* s, string t) {
    auto _temp = new symbolType(t);
    symbol* temp = getTemp(_temp);

    if (false)
        cout << "Can't convert between types!";

    else if (s->type->type == "DOUBLE") {
        if (t == "INTEGER") {
            emit("EQUAL", temp->name, "double2int(" + s->name + ")");
            return temp;
        }

        else if (t == "CHAR") {
            emit("EQUAL", temp->name, "double2char(" + s->name + ")");
            return temp;
        }
        return s;
    }

    else if (s->type->type == "INTEGER") {
        if (t == "DOUBLE") {
            emit("EQUAL", temp->name, "int2double(" + s->name + ")");
            return temp;
        }

        else if (t == "CHAR") {
            emit("EQUAL", temp->name, "int2char(" + s->name + ")");
            return temp;
        }
        return s;
    }

    else if (s->type->type == "CHAR") {
        if (t == "INTEGER") {
            emit("EQUAL", temp->name, "char2int(" + s->name + ")");
            return temp;
        }
        if (t == "DOUBLE") {
            emit("EQUAL", temp->name, "char2double(" + s->name + ")");
            return temp;
        }
        return s;
    }
    return s;
}

expression* convertINT2BOOL(expression* e) {
    if (e->type != "BOOL") {
        e->falselist = makelist(nextInstruction());
        emit("EQOP", "", e->location->name, "0");

        e->truelist = makelist(nextInstruction());
        emit("GOTOOP", "");
    }
    return e;
}

expression* convertBOOL2INT(expression* e) {
    if (e->type == "BOOL") {
        auto _temp = new symbolType("INTEGER");
        e->location = getTemp(_temp);

        backpatch(e->truelist, nextInstruction());
        emit("EQUAL", e->location->name, "true");

        string str = to_string(nextInstruction() + 1);
        emit("GOTOOP", str);
        backpatch(e->falselist, nextInstruction());
        emit("EQUAL", e->location->name, "false");
    }
    return e;
}

void switchTable(symbolTable* newtable) {
    table = newtable;
}

int nextInstruction() {
    return quadList.quads.size();
}

symbol* getTemp(symbolType* t, string init) {
    char n[10];
    sprintf(n, "t%02d", table->tempCount++);
    symbol* s = new symbol(n);
    s->type = t;
    s->size = sizeOfType(t);
    s->initValue = init;
    table->table.push_back(*s);
    return &table->table.back();
}

int sizeOfType(symbolType* t) {
    if (t->type == "VOID")
        return __VOID_SIZE;

    else if (t->type == "CHAR")
        return __CHARACTER_SIZE;

    else if (t->type == "INTEGER")
        return __INTEGER_SIZE;

    else if (t->type == "DOUBLE")
        return __DOUBLE_SIZE;

    else if (t->type == "PTR")
        return __POINTER_SIZE;

    else if (t->type == "ARR")
        return t->width * sizeOfType(t->ptr);

    else if (t->type == "FUNC")
        return __FUNCTION_SIZE;

    else
        return -1;
}

string checkType(symbolType* t) {
    if (t == NULL)
        return "NULL";

    if (t->type == "VOID")
        return "VOID";

    else if (t->type == "CHAR")
        return "CHAR";

    else if (t->type == "INTEGER")
        return "INTEGER";

    else if (t->type == "DOUBLE")
        return "DOUBLE";

    else if (t->type == "PTR")
        return "POINTER -> " + checkType(t->ptr);

    else if (t->type == "ARR")
        return "ARRAY (" + to_string(t->width) + ", " + checkType(t->ptr) + ")";

    else if (t->type == "FUNC")
        return "FUNCTION";

    else
        return "UNKNOWN";
}

int main() {
    globalTable = new symbolTable("Global");
    table = globalTable;

    yyparse();

    cout<<"========================================================================================================================"<<endl;
    globalTable->update();
    quadList.print();
    cout<<"========================================================================================================================"<<endl;

    cout << "\n\n";
    cout<<"========================================================================================================================"<<endl;
    cout << "---------------------------------" << endl;
    cout << "|\t\tSymbol Tables\t\t\t|" << endl;
    cout << "---------------------------------\n" << endl;
    globalTable->print();
    cout<<"========================================================================================================================"<<endl;
}
