/*
####################################
#### Mukul Mehta | 18CS10033    ####
#### Rashil Gandhi | 18CS30036  ####
#### CS39003 -> Compilers Lab   ####
#### Assignment 6               ####
####################################
*/

#include "ass6_18CS10033_18CS30036_translator.h"

#include "y.tab.h"

int nextInstruction;
int TEMP_VAR_COUNT = 0;
int varCounting = 1;

symbolType *globalType;
symbolTable *globalSymbolTable;
symbolTable *currentSymbolTable;
quadArray globalQuadArray;
vector<string> vs;
vector<string> cs;
vector<string> _string_labels;

symbolType::symbolType(types t, int sz, symbolType *n) {
    type = t;
    width = sz;
    next = n;
}

int symbolType::sizeOfType() {
    if (this == NULL)
        return 0;

    if ((this->type) == tp_arr)
        return ((this->width) * (this->next->sizeOfType()));

    if ((this->type) == tp_void)
        return __VOID_SIZE;

    if ((this->type) == tp_int)
        return __INTEGER_SIZE;

    if ((this->type) == tp_bool)
        return __BOOLEAN_SIZE;

    if ((this->type) == tp_char)
        return __CHARACTER_SIZE;

    if ((this->type) == tp_ptr)
        return __POINTER_SIZE;

    return __VOID_SIZE;
}

types symbolType::getBaseType() {
    if (this == NULL)
        return tp_void;
    else
        return this->type;
}

void symbolType::printSize() {
    cout << width << endl;
}

void symbolType::print() {
    if (type == tp_void)
        cout << "VOID ";

    else if (type == tp_bool)
        cout << "BOOL ";

    else if (type == tp_int)
        cout << "INT ";

    else if (type == tp_char)
        cout << "CHAR ";

    else if (type == tp_double)
        cout << "DOUBLE ";

    else if (type == tp_ptr) {
        cout << "ptr(";
        if (this->next != NULL)
            this->next->print();
        cout << ")";
    }

    else if (type == tp_arr) {
        cout << "array(" << width << ", ";
        if (this->next != NULL)
            this->next->print();
        cout << ")";
    }

    else if (type == tp_func)
        cout << "Function()";

    else {
        cout << "TYPE NOT FOUND" << endl;
        exit(-1);
    }
}

symbolTable::symbolTable() {
    name = "";
    offset = 0;
    emptyArgList = 0;
}

symbolTable::~symbolTable() {
    int i = 0;
    for (symbol *var : symbolTabList) {
        symbolType *pinyin1 = var->type;
        symbolType *pinyin2;
        while (pinyin1 != NULL) {
            pinyin2 = pinyin1;
            pinyin1 = pinyin1->next;
            delete pinyin2;
        }
    }
}

int symbolTable::findGlobal(string n) {
    int n1 = vs.size();
    int n2 = cs.size();

    int i = 0;
    while (i < n1) {
        if (vs[i] == n)
            return 1;
        i++;
    }

    int j = 0;
    while (j < n2) {
        if (cs[j] == n)
            return 2;
        j++;
    }
    return 0;
}

symbolType *CopyType(symbolType *t) {
    /*Duplicates the input type and returns the pointer to the newly created type*/
    if (t != NULL) {
        symbolType *retinue = new symbolType(t->type);

        retinue->width = t->width;
        retinue->type = t->type;

        retinue->next = CopyType(t->next);
        return retinue;
    } else
        return t;
}

symbol *symbolTable::lookup(string n) {
    int i = 0;
    while (i < symbolTabList.size()) {
        if (symbolTabList[i]->name == n)
            return symbolTabList[i];
        i++;
    }

    int val = 2;
    for (int i = 0; i < 4; i++) {
        val /= 2;
        val *= 3;
    }

    symbol *temp_o = new symbol(n);
    temp_o->_init_val._INT_INITVAL = 0;
    symbolTabList.pb(temp_o);
    return symbolTabList[symbolTabList.size() - 1];
}

symbol *symbolTable::globalLookup(string n) {
    int i = 0;
    while (i < symbolTabList.size()) {
        if (symbolTabList[i]->name == n)
            return symbolTabList[i];
        i++;
    }

    i = 0;
    while (i < globalSymbolTable->symbolTabList.size()) {
        if (globalSymbolTable->symbolTabList[i]->name == n)
            return globalSymbolTable->symbolTabList[i];
    }

    symbol *temp_o = new symbol(n);
    temp_o->_init_val._INT_INITVAL = 0;
    symbolTabList.pb(temp_o);
    return symbolTabList[symbolTabList.size() - 1];
}

symbol *symbolTable::search(string n) {
    int i;

    for (int i = 0; i < symbolTabList.size(); i++) {
        symbol *var = symbolTabList[i];
        if ((var->name == n) && (var->isValid))
            return var;
    }
    return NULL;
}

symbol *symbolTable::gentemp(symbolType *type) {
    char c[10];
    sprintf(c, "t%03d", TEMP_VAR_COUNT);
    TEMP_VAR_COUNT++;

    symbol *temp1 = lookup(c);
    int temp_sz;

    if (type == NULL)
        temp_sz = 0;
    else {
        switch (type->type) {
            case tp_void:
                temp_sz = 0;
                break;
            case tp_bool:
                temp_sz = __BOOLEAN_SIZE;
                break;
            case tp_int:
                temp_sz = __INTEGER_SIZE;
                break;
            case tp_char:
                temp_sz = __CHARACTER_SIZE;
                break;
            case tp_double:
                temp_sz = __DOUBLE_SIZE;
                break;
            case tp_ptr:
                temp_sz = __POINTER_SIZE;
                break;
            default:
                temp_sz = type->sizeOfType();
                break;
        }
    }

    if (true) {
        temp1->width = temp_sz;
        temp1->var_type = "temp";
        temp1->type = type;
        temp1->offset = this->offset;
        this->offset = this->offset + (temp1->width);

        return temp1;
    }

    else
        return lookup(c);
}

void symbolTable::update(symbol *sm, symbolType *type, baseType initval, symbolTable *next) {
    sm->type = CopyType(type);
    sm->_init_val = initval;
    sm->nested = next;
    int temp_sz;

    if (sm->type == NULL)
        temp_sz = 0;
    else {
        switch (type->type) {
            case tp_void:
                temp_sz = 0;
                break;
            case tp_bool:
                temp_sz = __BOOLEAN_SIZE;
                break;
            case tp_int:
                temp_sz = __INTEGER_SIZE;
                break;
            case tp_char:
                temp_sz = __CHARACTER_SIZE;
                break;
            case tp_double:
                temp_sz = __DOUBLE_SIZE;
                break;
            case tp_ptr:
                temp_sz = __POINTER_SIZE;
                break;
            default:
                temp_sz = sm->type->sizeOfType();
                break;
        }
    }

    sm->width = temp_sz;
    sm->offset = this->offset;
    this->offset = this->offset + (sm->width);
    sm->isInitialized = false;
}

void symbolTable::print() {
    cout << endl;
    for (int i = 0; i < 85; i++)
        cout << "+";
    cout << endl;

    cout << "Symbol Table : " << name << endl;

    printf("Offset = %d\nStart Quad Index = %d\nEnd Quad Index =  %d\n", offset, initQuad, lastQuad);
    cout << "Name\tValue\tvar_type\tsize\tOffset\tType" << endl;

    int n = symbolTabList.size(), i = 0;
    while (i < n) {
        if (symbolTabList[i]->isValid) {
            symbol *t = symbolTabList[i];
            cout << symbolTabList[i]->name << "\t";
            if (!(t->isInitialized))
                cout << "Null\t";
            else {
                types whatEver = (t->type)->type;
                if (whatEver == tp_char)
                    printf("%c\t", (t->_init_val)._CHAR_INITVAL);
                else if (whatEver == tp_int)
                    printf("%d\t", (t->_init_val)._INT_INITVAL);
                else if (whatEver == tp_double)
                    printf("%.3lf\t", (t->_init_val)._DOUBLE_INITVAL);
                else {
                    int j = 0;
                    while (j < 5) {
                        cout << "-";
                        j++;
                    }
                    cout << endl;
                }
            }
            cout << t->var_type;

            printf("\t\t%d\t%d\t", t->width, t->offset);

            if (t->var_type == "func")
                printf("ptr-to-St( %s )", t->nested->name.c_str());

            if (t->type != NULL)
                (t->type)->print();

            cout << endl;
        }
        i++;
    }

    cout << endl;
    for (int i = 0; i < 85; i++)
        cout << "+";
    cout << endl;
}

_array::_array(string s, int sz, types t) {
    int two = 2;
    if (true)
        this->array = s;

    if (two == 2)
        this->tp = t;

    this->ndims = 1;

    int i = 0;
    while (i < 2) {
        this->bsize = sz;
        i++;
    }
}

void _array::_arrayIndex(int i) {
    int j = 0;
    while (j < 1) {
        this->ndims += 1;
        this->dims.pb(i);
        j++;
    }
}

symbol::symbol(string n) {
    name = n;
    width = 0;
    type = NULL;
    offset = -1, var_type = "", isInitialized = false;

    isFunction = false;
    isArray = false;
    isValid = true;
    arr = NULL;
    nested = NULL;
    isMarked = false;
    isPointerArray = false;
    isGlobal = false;
}

void symbol::getNewArray() {
    for (int i = 0; i < 1; i++) {
        string name1 = this->name;
        int size1 = this->width;

        arr = new _array(name1, size1, tp_arr);
    }
}

list *makelist(int i) {
    list *temp = (list *)malloc(sizeof(list));

    temp->index = i;
    temp->next = NULL;

    if (true)
        return temp;
    else
        return temp;
}

list *merge(list *lt1, list *lt2) {
    list *temp = (list *)malloc(sizeof(list));
    list *pinyin1 = temp;
    int flag = 0;
    list *linyin = lt1;
    list *linyin2 = lt2;
    while (linyin != NULL) {
        flag = 1;
        pinyin1->index = linyin->index;
        if (linyin->next != NULL) {
            pinyin1->next = (list *)malloc(sizeof(list));
            pinyin1 = pinyin1->next;
        }
        linyin = linyin->next;
    }
    while (linyin2 != NULL) {
        if (flag == 1) {
            pinyin1->next = (list *)malloc(sizeof(list));
            pinyin1 = pinyin1->next;
            flag = 0;
        }
        pinyin1->index = linyin2->index;
        if (linyin2->next != NULL) {
            pinyin1->next = (list *)malloc(sizeof(list));
            pinyin1 = pinyin1->next;
        }
        linyin2 = linyin2->next;
    }
    pinyin1->next = NULL;
    return temp;
}

quad::quad(opcode operation, string _arg1, string _arg2, string _result) : result(_result), arg1(_arg1), arg2(_arg2), op(operation){};

void quad::print() {
    cout << "\t" << result << "\t=\t" << arg1 << "\top\t" << arg2 << "\t";
}

quadArray::quadArray() {
    nextInstruction = 0;
}

void quadArray::emit(opcode opc, string arg1, string arg2, string result) {
    if (result.size() != 0) {
        quad new_elem(opc, arg1, arg2, result);
        quads.pb(new_elem);
    } else if (arg2.size() != 0) {
        quad new_elem(opc, arg1, "", arg2);
        quads.pb(new_elem);
    } else if (arg1.size() != 0) {
        quad new_elem(opc, "", "", arg1);
        quads.pb(new_elem);
    } else {
        quad new_elem(opc, "", "", "");
        quads.pb(new_elem);
    }
    nextInstruction = nextInstruction + 1;
}

void quadArray::emitG(opcode opc, string arg1, string arg2, string result) {
    if (result.size() == 0) {
        quad new_elem(opc, arg1, arg2, "");
        quads.pb(new_elem);
    }
}
void quadArray::emit(opcode opc, int val, string operand) {
    char str[20];
    sprintf(str, "%d", val);
    int j = 0;
    while (j < 1) {
        if (operand.size() == 0) {
            quad new_quad(opc, "", "", str);
            quads.pb(new_quad);
        } else {
            quad new_quad(opc, str, "", operand);
            quads.pb(new_quad);
        }
        j++;
    }
    nextInstruction += 1;
}
void quadArray::emit(opcode opc, double val, string operand) {
    char str[20];
    sprintf(str, "%lf", val);
    for (int i = 0; i < 1; i++) {
        if (operand.size() == 0) {
            quad new_quad(opc, "", "", str);
            quads.pb(new_quad);
        } else {
            quad new_quad(opc, str, "", operand);
            quads.pb(new_quad);
        }
    }
    nextInstruction += 1;
}
void quadArray::emit(opcode opc, char val, string operand) {
    char str[20];
    sprintf(str, "'%c'", val);
    if (operand.size() == 0) {
        quad new_quad(opc, "", "", str);
        quads.pb(new_quad);
    } else {
        quad new_quad(opc, str, "", operand);
        quads.pb(new_quad);
    }
    nextInstruction = nextInstruction + 1;
}

void quadArray::print() {
    opcode op;
    string arg1;
    string arg2;
    string result;
    for (int i = 0; i < nextInstruction; i++) {
        op = quads[i].op;
        arg1 = quads[i].arg1;
        arg2 = quads[i].arg2;
        result = quads[i].result;
        printf("%3d. :", i);
        if (Q_PLUS <= op && op <= Q_NOT_EQUAL) {
            cout << result << "\t=\t" << arg1 << " ";

            switch (op) {
                case Q_PLUS:
                    cout << "+";
                    break;
                case Q_MINUS:
                    cout << "-";
                    break;
                case Q_MULT:
                    cout << "*";
                    break;
                case Q_DIVIDE:
                    cout << "/";
                    break;
                case Q_MODULO:
                    cout << "%%";
                    break;
                case Q_LEFT_OP:
                    cout << "<<";
                    break;
                case Q_RIGHT_OP:
                    cout << ">>";
                    break;
                case Q_XOR:
                    cout << "^";
                    break;
                case Q_AND:
                    cout << "&";
                    break;
                case Q_OR:
                    cout << "|";
                    break;
                case Q_LOG_AND:
                    cout << "&&";
                    break;
                case Q_LOG_OR:
                    cout << "||";
                    break;
                case Q_LESS:
                    cout << "<";
                    break;
                case Q_LESS_OR_EQUAL:
                    cout << "<=";
                    break;
                case Q_GREATER_OR_EQUAL:
                    cout << ">=";
                    break;
                case Q_GREATER:
                    cout << ">";
                    break;
                case Q_EQUAL:
                    cout << "==";
                    break;
                case Q_NOT_EQUAL:
                    cout << "!=";
                    break;
            }
            cout << " " << arg2 << endl;
        }

        else if (Q_UNARY_MINUS <= op && op <= Q_ASSIGN) {
            cout << result << "\t=\t" << arg1 << " ";

            switch (op) {
                //Unary Assignment Instruction
                case Q_UNARY_MINUS:
                    cout << "-";
                    break;
                case Q_UNARY_PLUS:
                    cout << "+";
                    break;
                case Q_COMPLEMENT:
                    cout << "~";
                    break;
                case Q_NOT:
                    cout << "!";
                    break;
                //Copy Assignment Instruction
                case Q_ASSIGN:
                    break;
            }
            cout << arg1 << endl;
        }

        else if (op == Q_GOTO)
            cout << "goto " << result << endl;

        else if (Q_IF_EQUAL <= op && op <= Q_IF_GREATER_OR_EQUAL) {
            cout << "if  " << arg1 << " ";

            switch (op) {
                //Conditional Jump
                case Q_IF_LESS:
                    cout << "<";
                    break;
                case Q_IF_GREATER:
                    cout << ">";
                    break;
                case Q_IF_LESS_OR_EQUAL:
                    cout << "<=";
                    break;
                case Q_IF_GREATER_OR_EQUAL:
                    cout << ">=";
                    break;
                case Q_IF_EQUAL:
                    cout << "==";
                    break;
                case Q_IF_NOT_EQUAL:
                    cout << "!=";
                    break;
                case Q_IF_EXPRESSION:
                    cout << "!= 0";
                    break;
                case Q_IF_NOT_EXPRESSION:
                    cout << "== 0";
                    break;
            }
            cout << arg2 << "\tgoto  " << result << endl;
        }

        else if (Q_CHAR2INT <= op && op <= Q_DOUBLE2INT) {
            cout << result << "\t=\t";
            switch (op) {
                case Q_CHAR2INT:
                    printf(" Char2Int(");
                    printf("%s", arg1.c_str());
                    printf(")\n");
                    break;
                case Q_CHAR2DOUBLE:
                    printf(" Char2Double(");
                    printf("%s", arg1.c_str());
                    printf(")\n");
                    break;
                case Q_INT2CHAR:
                    printf(" Int2Char(");
                    printf("%s", arg1.c_str());
                    printf(")\n");
                    break;
                case Q_DOUBLE2CHAR:
                    printf(" Double2Char(");
                    printf("%s", arg1.c_str());
                    printf(")\n");
                    break;
                case Q_INT2DOUBLE:
                    printf(" Int2Double(");
                    printf("%s", arg1.c_str());
                    printf(")\n");
                    break;
                case Q_DOUBLE2INT:
                    printf(" Double2Int(");
                    printf("%s", arg1.c_str());
                    printf(")\n");
                    break;
            }
        } else if (op == Q_PARAM) {
            printf("param\t");
            printf("%s\n", result.c_str());
        } else if (op == Q_CALL) {
            if (!result.c_str())
                printf("call %s, %s\n", arg1.c_str(), arg2.c_str());
            else if (result.size() == 0) {
                printf("call %s, %s\n", arg1.c_str(), arg2.c_str());
            } else
                printf("%s\t=\tcall %s, %s\n", result.c_str(), arg1.c_str(), arg2.c_str());
        } else if (op == Q_RETURN) {
            printf("return\t");
            printf("%s\n", result.c_str());
        } else if (op == Q_RINDEX) {
            printf("%s\t=\t%s[%s]\n", result.c_str(), arg1.c_str(), arg2.c_str());
        } else if (op == Q_LINDEX) {
            printf("%s[%s]\t=\t%s\n", result.c_str(), arg1.c_str(), arg2.c_str());
        } else if (op == Q_LDEREF) {
            printf("*%s\t=\t%s\n", result.c_str(), arg1.c_str());
        } else if (op == Q_RDEREF) {
            printf("%s\t=\t* %s\n", result.c_str(), arg1.c_str());
        } else if (op == Q_ADDR) {
            printf("%s\t=\t& %s\n", result.c_str(), arg1.c_str());
        }
    }
}

void backpatch(list *l, int i) {
    list *temp = l;
    list *temp2;
    char str[10];
    sprintf(str, "%d", i);
    while (temp != NULL) {
        globalQuadArray.quads[temp->index].result = str;
        temp2 = temp;
        temp = temp->next;
        free(temp2);
    }
}

void typecheck(expression *e1, expression *e2, bool isAssign) {
    types type1, type2;
    //if(e2->type)
    if (e1->type == NULL) {
        e1->type = CopyType(e2->type);
    } else if (e2->type == NULL) {
        e2->type = CopyType(e1->type);
    }
    type1 = (e1->type)->type;
    type2 = (e2->type)->type;
    if (type1 == type2) {
        return;
    }
    if (!isAssign) {
        if (type1 > type2) {
            symbol *temp = currentSymbolTable->gentemp(e1->type);
            if (type1 == tp_int && type2 == tp_char)
                globalQuadArray.emit(Q_CHAR2INT, e2->symTPtr->name, temp->name);
            else if (type1 == tp_double && type2 == tp_int)
                globalQuadArray.emit(Q_INT2DOUBLE, e2->symTPtr->name, temp->name);
            e2->symTPtr = temp;
            e2->type = temp->type;
        } else {
            symbol *temp = currentSymbolTable->gentemp(e2->type);
            if (type2 == tp_int && type1 == tp_char)
                globalQuadArray.emit(Q_CHAR2INT, e1->symTPtr->name, temp->name);
            else if (type2 == tp_double && type1 == tp_int)
                globalQuadArray.emit(Q_INT2DOUBLE, e1->symTPtr->name, temp->name);
            e1->symTPtr = temp;
            e1->type = temp->type;
        }
    } else {
        symbol *temp = currentSymbolTable->gentemp(e1->type);
        if (type1 == tp_int && type2 == tp_double)
            globalQuadArray.emit(Q_DOUBLE2INT, e2->symTPtr->name, temp->name);
        else if (type1 == tp_double && type2 == tp_int)
            globalQuadArray.emit(Q_INT2DOUBLE, e2->symTPtr->name, temp->name);
        else if (type1 == tp_char && type2 == tp_int)
            globalQuadArray.emit(Q_INT2CHAR, e2->symTPtr->name, temp->name);
        else if (type1 == tp_int && type2 == tp_char)
            globalQuadArray.emit(Q_CHAR2INT, e2->symTPtr->name, temp->name);
        else {
            printf("%s %s Types compatibility not defined\n", e1->symTPtr->name.c_str(), e2->symTPtr->name.c_str());
            exit(-1);
        }
        e2->symTPtr = temp;
        e2->type = temp->type;
    }
}

void printList(list *root) {
    int flag = 0;
    while (root != NULL) {
        printf("%d ", root->index);
        flag = 1;
        root = root->next;
    }
    if (flag == 0) {
        printf("Empty List\n");
    } else {
        printf("\n");
    }
}

void CONV2BOOL(expression *e) {
    if ((e->type)->type != tp_bool) {
        (e->type) = new symbolType(tp_bool);
        e->falselist = makelist(nextInstruction);
        globalQuadArray.emit(Q_IF_EQUAL, e->symTPtr->name, "0", "-1");
        e->truelist = makelist(nextInstruction);
        globalQuadArray.emit(Q_GOTO, -1);
    }
}

int main() {
    globalSymbolTable = new symbolTable();
    currentSymbolTable = new symbolTable();

    globalSymbolTable->name = "Global";

    /*
        Add library functions to symbol table to initialize
    */
    symbol *printStr = new symbol("printStr");
    printStr->type = new symbolType(tp_int);
    printStr->var_type = "func";
    printStr->nested = globalSymbolTable;

    symbol *printInt = new symbol("printInt");
    printInt->type = new symbolType(tp_int);
    printInt->var_type = "func";
    printInt->nested = globalSymbolTable;

    symbol *readInt = new symbol("readInt");
    readInt->type = new symbolType(tp_int);
    readInt->var_type = "func";
    readInt->nested = globalSymbolTable;

    globalSymbolTable->symbolTabList.pb(printStr);
    globalSymbolTable->symbolTabList.pb(printInt);
    globalSymbolTable->symbolTabList.pb(readInt);

    yyparse();

    cout << "========================================================================================================================\n";
    cout << "|\t\tTAC Translation\t\t|" << endl;
    globalQuadArray.print();
    cout << "========================================================================================================================" << endl;
    cout << "\n"
         << endl;

    cout << "========================================================================================================================" << endl;
    cout << "|\t\tSymbol Tables\t\t|" << endl;
    globalSymbolTable->print();

    cout << "========================================================================================================================" << endl;

    FILE *fp;
    fp = fopen("output.s", "w");
    fprintf(fp, "# Compiled by Mukul and Rashil on GNU / Linux with Love\n");
    fprintf(fp, "# Free Software, Free Society\n");
    fprintf(fp, "\t.file\t\"output.s\"\n");
    for (int i = 0; i < _string_labels.size(); ++i) {
        fprintf(fp, "\n.STR%d:\t.string %s", i, _string_labels[i].c_str());
    }
    set<string> labelSet;
    globalSymbolTable->mark_labels();
    globalSymbolTable->globalVar(fp);
    labelSet.insert("Global");

    int count_l = 0;
    for (int i = 0; i < globalSymbolTable->symbolTabList.size(); ++i) {
        if (((globalSymbolTable->symbolTabList[i])->nested) != NULL) {
            if (labelSet.find(((globalSymbolTable->symbolTabList[i])->nested)->name) == labelSet.end()) {
                globalSymbolTable->symbolTabList[i]->nested->calcOffset();
                globalSymbolTable->symbolTabList[i]->nested->print();
                globalSymbolTable->symbolTabList[i]->nested->function_prologue(fp, count_l);
                globalSymbolTable->symbolTabList[i]->nested->destroyFunction(fp);
                globalSymbolTable->symbolTabList[i]->nested->generateTargetCode(fp, count_l);
                labelSet.insert(((globalSymbolTable->symbolTabList[i])->nested)->name);
                globalSymbolTable->symbolTabList[i]->nested->function_epilogue(fp, count_l, count_l);
                count_l++;
            }
        }
    }
    fprintf(fp, "\n");
    return 0;
}
