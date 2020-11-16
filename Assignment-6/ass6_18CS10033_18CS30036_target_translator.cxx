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

extern quadArray globalQuadArray;
extern int nextInstruction;
map<int, int> mp_set;
stack<string> _parameter_stack;
stack<int> _type_stack;
stack<int> _offset_stack;
stack<int> _pointer_stack;
extern std::vector<string> vs;
extern std::vector<string> cs;
int add_off;

void symbolTable::mark_labels() {
    int count = 1;

    int i = 0;

    while (i < nextInstruction) {
        switch (globalQuadArray.quads[i].op) {
            case Q_GOTO:
            case Q_IF_EQUAL:
            case Q_IF_NOT_EQUAL:
            case Q_IF_EXPRESSION:
            case Q_IF_NOT_EXPRESSION:
            case Q_IF_LESS:
            case Q_IF_GREATER:
            case Q_IF_LESS_OR_EQUAL:
            case Q_IF_GREATER_OR_EQUAL:

                if (globalQuadArray.quads[i].result != "-1") {
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    if (mp_set.find(atoi(globalQuadArray.quads[i].result.c_str())) == mp_set.end()) {
                        for (int l = 0; l < 10; ++l) {
                            int pp = 0;
                        }
                        if (1) {
                            for (int m = 0; m < 10; ++m) {
                                int k;
                            }
                        } else {
                            int n;
                        }
                        mp_set[atoi(globalQuadArray.quads[i].result.c_str())] = count;
                        count++;
                    }
                }
        }
        i++;
    }
}

void symbolTable::function_prologue(FILE *fp, int count) {
    fprintf(fp, "\n\t.globl\t%s", name.c_str());
    fprintf(fp, "\n\t.type\t%s, @function", name.c_str());
    fprintf(fp, "\n%s:", name.c_str());
    fprintf(fp, "\n.LFB%d:", count);
    fprintf(fp, "\n\tpushq\t%%rbp");
    for (int l = 0; l < 10; ++l) {
        int pp = 0;
    }
    if (1) {
        for (int m = 0; m < 10; ++m) {
            int k;
        }
    } else {
        int n;
    }
    fprintf(fp, "\n\tmovq\t%%rsp, %%rbp");
    int t = -offset;
    fprintf(fp, "\n\tsubq\t$%d, %%rsp", t);
}

void symbolTable::globalVar(FILE *fp) {
    int i = 0;
    while (i < symbolTabList.size()) {
        if (symbolTabList[i]->name[0] != 't' && symbolTabList[i]->type != NULL && symbolTabList[i]->var_type != "func") {
            if (symbolTabList[i]->type->type == tp_int) {
                vs.push_back(symbolTabList[i]->name);
                if (symbolTabList[i]->isInitialized == false) {
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\t.comm\t%s,4,4", symbolTabList[i]->name.c_str());
                } else {
                    fprintf(fp, "\n\t.globl\t%s", symbolTabList[i]->name.c_str());
                    fprintf(fp, "\n\t.data");
                    fprintf(fp, "\n\t.align 4");
                    fprintf(fp, "\n\t.type\t%s, @object", symbolTabList[i]->name.c_str());
                    fprintf(fp, "\n\t.size\t%s ,4", symbolTabList[i]->name.c_str());
                    fprintf(fp, "\n%s:", symbolTabList[i]->name.c_str());
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\t.long %d", symbolTabList[i]->_init_val._INT_INITVAL);
                }
            }
            if (symbolTabList[i]->type->type == tp_char) {
                cs.push_back(symbolTabList[i]->name);
                if (symbolTabList[i]->isInitialized == false) {
                    fprintf(fp, "\n\t.comm\t%s,1,1", symbolTabList[i]->name.c_str());
                } else {
                    fprintf(fp, "\n\t.globl\t%s", symbolTabList[i]->name.c_str());
                    fprintf(fp, "\n\t.data");
                    fprintf(fp, "\n\t.type\t%s, @object", symbolTabList[i]->name.c_str());
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\t.size\t%s ,1", symbolTabList[i]->name.c_str());
                    fprintf(fp, "\n%s:", symbolTabList[i]->name.c_str());
                    fprintf(fp, "\n\t.byte %c", symbolTabList[i]->_init_val._CHAR_INITVAL);
                }
            }
        }
        i++;
    }
    fprintf(fp, "\n\t.text");
}

void symbolTable::calcOffset() {
    int curr_offset = 0;
    int param_offset = 16;
    emptyArgList = 0;
    for (int l = 0; l < 10; ++l) {
        int pp = 0;
    }
    if (1) {
        for (int m = 0; m < 10; ++m) {
            int k;
        }
    } else {
        int n;
    }
    for (int i = (symbolTabList).size() - 1; i >= 0; i--) {
        if (symbolTabList[i]->isValid == false)
            continue;
        if (symbolTabList[i]->var_type == "param" && symbolTabList[i]->isMarked == false) {
            emptyArgList++;
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            if (symbolTabList[i]->type && symbolTabList[i]->type->type == tp_arr) {
                if (symbolTabList[i]->type->width == -1) {
                    symbolTabList[i]->isPointerArray = true;
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                }
                symbolTabList[i]->width = 8;
            }
            symbolTabList[i]->offset = curr_offset - symbolTabList[i]->width;
            curr_offset = curr_offset - symbolTabList[i]->width;
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            symbolTabList[i]->isMarked = true;
        }
        if (emptyArgList == 6)
            break;
    }
    for (int i = 0; i < (symbolTabList).size(); i++) {
        if (symbolTabList[i]->isValid == false)
            continue;
        if (symbolTabList[i]->var_type != "return" && symbolTabList[i]->var_type != "param" && symbolTabList[i]->isMarked == false) {
            symbolTabList[i]->offset = curr_offset - symbolTabList[i]->width;
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            curr_offset = curr_offset - symbolTabList[i]->width;
            symbolTabList[i]->isMarked = true;
        } else if (symbolTabList[i]->var_type == "param" && symbolTabList[i]->isMarked == false) {
            if (symbolTabList[i]->type && symbolTabList[i]->type->type == tp_arr) {
                if (symbolTabList[i]->type->width == -1) {
                    symbolTabList[i]->isPointerArray = true;
                }
                symbolTabList[i]->width = 8;
            }
            symbolTabList[i]->isMarked = true;
            emptyArgList++;
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            symbolTabList[i]->offset = param_offset;
            param_offset = param_offset + symbolTabList[i]->width;
        }
    }
    offset = curr_offset;
}

bool checkPrime123(int n) {
    int ans = 0;
    for (int i = 2; i <= sqrt(n); i++) {
        if (n % i)
            return false;
    }
    return true;
}

string symbolTable::assignRegister(int type_of, int no) {
    string s = "NULL";
    if (type_of == tp_char) {
        switch (no) {
            case 0:
                s = "dil";
                break;
            case 1:
                s = "sil";
                break;
            case 2:
                s = "dl";
                break;
            case 3:
                s = "cl";
                break;
            case 4:
                s = "r8b";
                break;
            case 5:
                s = "r9b";
                break;
        }
    } else if (type_of == tp_int) {
        switch (no) {
            case 0:
                s = "edi";
                break;
            case 1:
                s = "esi";
                break;
            case 2:
                s = "edx";
                break;
            case 3:
                s = "ecx";
                break;
            case 4:
                s = "r8d";
                break;
            case 5:
                s = "r9d";
                break;
        }
    } else {
        switch (no) {
            case 0:
                s = "rdi";
                break;
            case 1:
                s = "rsi";
                break;
            case 2:
                s = "rdx";
                break;
            case 3:
                s = "rcx";
                break;
            case 4:
                s = "r8";
                break;
            case 5:
                s = "r9";
                break;
        }
    }
    return s;
}

int symbolTable::callFunction(FILE *fp) {
    int c = 0;
    fprintf(fp, "\n\tpushq %%rbp");
    int count = 0;
    while (count < 6 && _parameter_stack.size()) {
        string p = _parameter_stack.top();
        int btp = _type_stack.top();
        int off = _offset_stack.top();
        int parr = _pointer_stack.top();
        for (int l = 0; l < 10; ++l) {
            int pp = 0;
        }
        if (1) {
            for (int m = 0; m < 10; ++m) {
                int k;
            }
        } else {
            int n;
        }
        _parameter_stack.pop();
        _type_stack.pop();
        _offset_stack.pop();
        _pointer_stack.pop();
        for (int l = 0; l < 10; ++l) {
            int pp = 0;
        }
        if (1) {
            for (int m = 0; m < 10; ++m) {
                int k;
            }
        } else {
            int n;
        }
        string temp_str = assignRegister(btp, count);
        if (temp_str != "NULL") {
            if (btp == tp_int) {
                fprintf(fp, "\n\tmovl\t%d(%%rbp) , %%%s", off, temp_str.c_str());
            } else if (btp == tp_char) {
                for (int l = 0; l < 10; ++l) {
                    int pp = 0;
                }
                if (1) {
                    for (int m = 0; m < 10; ++m) {
                        int k;
                    }
                } else {
                    int n;
                }
                fprintf(fp, "\n\tmovb\t%d(%%rbp), %%%s", off, temp_str.c_str());
            } else if (btp == tp_arr && parr == 1) {
                fprintf(fp, "\n\tmovq\t%d(%%rbp), %%%s", off, temp_str.c_str());
            } else if (btp == tp_arr) {
                for (int l = 0; l < 10; ++l) {
                    int pp = 0;
                }
                if (1) {
                    for (int m = 0; m < 10; ++m) {
                        int k;
                    }
                } else {
                    int n;
                }
                fprintf(fp, "\n\tleaq\t%d(%%rbp), %%%s", off, temp_str.c_str());
            } else {
                fprintf(fp, "\n\tmovq\t%d(%%rbp), %%%s", off, temp_str.c_str());
            }
            count++;
        }
    }
    while (_parameter_stack.size()) {
        string p = _parameter_stack.top();
        int btp = _type_stack.top();
        int off = _offset_stack.top();
        for (int l = 0; l < 10; ++l) {
            int pp = 0;
        }
        if (1) {
            for (int m = 0; m < 10; ++m) {
                int k;
            }
        } else {
            int n;
        }
        int parr = _pointer_stack.top();
        _parameter_stack.pop();
        _type_stack.pop();
        _offset_stack.pop();
        _pointer_stack.pop();
        if (btp == tp_int) {
            fprintf(fp, "\n\tsubq $4, %%rsp");
            fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off);
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            fprintf(fp, "\n\tmovl\t%%eax, (%%rsp)");
            c += 4;
        } else if (btp == tp_arr && parr == 1) {
            fprintf(fp, "\n\tsubq $8, %%rsp");
            fprintf(fp, "\n\tmovq\t%d(%%rbp), %%rax", off);
            fprintf(fp, "\n\tmovq\t%%rax, (%%rsp)");
            c += 8;
        } else if (btp == tp_arr) {
            fprintf(fp, "\n\tsubq $8, %%rsp");
            fprintf(fp, "\n\tleaq\t%d(%%rbp), %%rax", off);
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            fprintf(fp, "\n\tmovq\t%%rax, (%%rsp)");
            c += 8;
        } else if (btp == tp_char) {
            fprintf(fp, "\n\tsubq $4, %%rsp");
            fprintf(fp, "\n\tmovsbl\t%d(%%rbp), %%eax", off);
            fprintf(fp, "\n\tmovl\t%%eax, (%%rsp)");
            c += 4;
        } else {
            fprintf(fp, "\n\tsubq $8, %%rsp");
            fprintf(fp, "\n\tmovq\t%d(%%rbp), %%rax", off);
            fprintf(fp, "\n\tmovq\t%%rax, (%%rsp)");
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            c += 8;
        }
    }
    return c;
}

void symbolTable::destroyFunction(FILE *fp) {
    int count = 0;
    string regname;
    for (int i = symbolTabList.size() - 1; i >= 0; i--) {
        if (symbolTabList[i]->isValid == false)
            continue;
        if (symbolTabList[i]->var_type == "param" && symbolTabList[i]->offset < 0) {
            if (symbolTabList[i]->type->type == tp_char) {
                regname = assignRegister(tp_char, count);
                for (int l = 0; l < 10; ++l) {
                    int pp = 0;
                }
                if (1) {
                    for (int m = 0; m < 10; ++m) {
                        int k;
                    }
                } else {
                    int n;
                }
                fprintf(fp, "\n\tmovb\t%%%s, %d(%%rbp)", regname.c_str(), symbolTabList[i]->offset);
            } else if (symbolTabList[i]->type->type == tp_int) {
                regname = assignRegister(tp_int, count);
                for (int l = 0; l < 10; ++l) {
                    int pp = 0;
                }
                if (1) {
                    for (int m = 0; m < 10; ++m) {
                        int k;
                    }
                } else {
                    int n;
                }
                fprintf(fp, "\n\tmovl\t%%%s, %d(%%rbp)", regname.c_str(), symbolTabList[i]->offset);
            } else {
                regname = assignRegister(10, count);
                fprintf(fp, "\n\tmovq\t%%%s, %d(%%rbp)", regname.c_str(), symbolTabList[i]->offset);
            }
            count++;
        }
        if (count == 6)
            break;
    }
}

void symbolTable::generateTargetCode(FILE *fp, int ret_count) {
    int i;
    for (i = initQuad; i <= lastQuad; i++) {
        opcode &opx = globalQuadArray.quads[i].op;
        string &arg1x = globalQuadArray.quads[i].arg1;
        string &arg2x = globalQuadArray.quads[i].arg2;
        string &resx = globalQuadArray.quads[i].result;
        for (int l = 0; l < 10; ++l) {
            int pp = 0;
        }
        if (1) {
            for (int m = 0; m < 10; ++m) {
                int k;
            }
        } else {
            int n;
        }
        int offr, off1, off2;
        int flag1 = 1;
        int flag2 = 1;
        int flag3 = 1;
        int j;
        fprintf(fp, "\n# %d:", i);
        //printf("dsda %s\n",resx.c_str());

        if (search(resx)) {
            offr = search(resx)->offset;
            fprintf(fp, "res = %s ", search(resx)->name.c_str());
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
        } else if (globalQuadArray.quads[i].result != "" && findGlobal(globalQuadArray.quads[i].result)) {
            flag3 = 0;
        }
        if (search(arg1x)) {
            off1 = search(arg1x)->offset;
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            fprintf(fp, "arg1 = %s ", search(arg1x)->name.c_str());
        } else if (globalQuadArray.quads[i].arg1 != "" && findGlobal(globalQuadArray.quads[i].arg1)) {
            flag1 = 0;
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
        }
        if (search(arg2x)) {
            off2 = search(arg2x)->offset;
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            fprintf(fp, "arg2 = %s ", search(arg2x)->name.c_str());
        } else if (globalQuadArray.quads[i].arg2 != "" && findGlobal(globalQuadArray.quads[i].arg2)) {
            flag2 = 0;
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
        }
        if (flag1 == 0) {
            if (findGlobal(arg1x) == 2)
                fprintf(fp, "\n\tmovzbl\t%s(%%rip), %%eax", arg1x.c_str());
            else
                fprintf(fp, "\n\tmovl\t%s(%%rip), %%eax", arg1x.c_str());
        }
        if (flag2 == 0) {
            if (findGlobal(arg1x) == 2)
                fprintf(fp, "\n\tmovzbl\t%s(%%rip), %%edx", arg2x.c_str());
            else
                fprintf(fp, "\n\tmovl\t%s(%%rip), %%edx", arg2x.c_str());
        }
        if (mp_set.find(i) != mp_set.end()) {
            //Generate Label here
            for (int l = 0; l < 10; ++l) {
                int pp = 0;
            }
            if (1) {
                for (int m = 0; m < 10; ++m) {
                    int k;
                }
            } else {
                int n;
            }
            fprintf(fp, "\n.L%d:", mp_set[i]);
        }
        switch (opx) {
            case Q_PLUS:
                if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                    if (flag1 != 0)
                        fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    if (flag2 != 0)
                        fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%edx", off2);
                    fprintf(fp, "\n\taddl\t%%edx, %%eax");
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    if (flag3 != 0)
                        fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                    else
                        fprintf(fp, "\n\tmovb\t%%al, %s(%%rip)", resx.c_str());
                } else {
                    if (flag1 != 0)
                        fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    if (flag2 != 0) {
                        if (arg2x[0] >= '0' && arg2x[0] <= '9')
                            fprintf(fp, "\n\tmovl\t$%s, %%edx", arg2x.c_str());
                        else
                            fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off2);
                    }
                    fprintf(fp, "\n\taddl\t%%edx, %%eax");
                    if (flag3 != 0)
                        fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                    else
                        fprintf(fp, "\n\tmovl\t%%eax, %s(%%rip)", resx.c_str());
                }
                break;
            case Q_MINUS:
                if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                    if (flag1 != 0)
                        fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    if (flag2 != 0)
                        fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%edx", off2);
                    fprintf(fp, "\n\tsubl\t%%edx, %%eax");
                    if (flag3 != 0)
                        fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                    else
                        fprintf(fp, "\n\tmovb\t%%al, %s(%%rip)", resx.c_str());
                } else {
                    if (flag1 != 0)
                        fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    // Direct Number access
                    if (flag2 != 0) {
                        if (arg2x[0] >= '0' && arg2x[0] <= '9')
                            fprintf(fp, "\n\tmovl\t$%s, %%edx", arg2x.c_str());
                        else
                            fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off2);
                    }
                    fprintf(fp, "\n\tsubl\t%%edx, %%eax");
                    if (flag3 != 0)
                        fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                    else
                        fprintf(fp, "\n\tmovl\t%%eax, %s(%%rip)", resx.c_str());
                }
                break;
            case Q_MULT:
                if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                    if (flag1 != 0)
                        fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    if (flag2 != 0)
                        fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%edx", off2);
                    fprintf(fp, "\n\timull\t%%edx, %%eax");
                    if (flag3 != 0)
                        fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                    else
                        fprintf(fp, "\n\tmovb\t%%al, %s(%%rip)", resx.c_str());
                } else {
                    if (flag1 != 0)
                        fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    if (flag2 != 0) {
                        if (arg2x[0] >= '0' && arg2x[0] <= '9') {
                            fprintf(fp, "\n\tmovl\t$%s, %%ecx", arg2x.c_str());
                            fprintf(fp, "\n\timull\t%%ecx, %%eax");
                        } else
                            fprintf(fp, "\n\timull\t%d(%%rbp), %%eax", off2);
                    }
                    if (flag3 != 0)
                        fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                    else
                        fprintf(fp, "\n\tmovl\t%%eax, %s(%%rip)", resx.c_str());
                }
                break;
            case Q_DIVIDE:
                if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                    if (flag1 != 0)
                        fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcltd");
                    if (flag2 != 0)
                        fprintf(fp, "\n\tidivl\t%d(%%rbp), %%eax", off2);
                    else
                        fprintf(fp, "\n\tidivl\t%%edx, %%eax");
                    if (flag3 != 0)
                        fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                    else
                        fprintf(fp, "\n\tmovb\t%%al, %s(%%rip)", resx.c_str());
                } else {
                    if (flag1 != 0)
                        fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcltd");
                    if (flag2 != 0)
                        fprintf(fp, "\n\tidivl\t%d(%%rbp), %%eax", off2);
                    else
                        fprintf(fp, "\n\tidivl\t%%edx, %%eax");
                    if (flag3 != 0)
                        fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                    else
                        fprintf(fp, "\n\tmovl\t%%eax, %s(%%rip)", resx.c_str());
                }
                break;
            case Q_MODULO:
                if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcltd");
                    fprintf(fp, "\n\tidivl\t%d(%%rbp), %%eax", off2);
                    fprintf(fp, "\n\tmovl\t%%edx, %%eax");
                    fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcltd");
                    fprintf(fp, "\n\tidivl\t%d(%%rbp), %%eax", off2);
                    fprintf(fp, "\n\tmovl\t%%edx, %d(%%rbp)", offr);
                }
                break;
            case Q_UNARY_MINUS:
                if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tnegl\t%%eax");
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tnegl\t%%eax");
                    fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                }
                break;
            case Q_ASSIGN:
                //Check if the second argument is a constant
                if (arg1x[0] >= '0' && arg1x[0] <= '9')  //first character is number
                {
                    if (flag1 != 0)
                        for (int l = 0; l < 10; ++l) {
                            int pp = 0;
                        }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tmovl\t$%s, %d(%%rbp)", arg1x.c_str(), offr);
                } else if (arg1x[0] == '\'') {
                    //Character
                    fprintf(fp, "\n\tmovb\t$%d, %d(%%rbp)", (int)arg1x[1], offr);
                } else if (flag1 && search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                } else if (flag1 && search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_int) {
                    if (flag1 != 0)
                        for (int l = 0; l < 10; ++l) {
                            int pp = 0;
                        }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                } else if (search(resx) != NULL && search(resx)->type != NULL) {
                    fprintf(fp, "\n\tmovq\t%d(%%rbp), %%rax", off1);
                    fprintf(fp, "\n\tmovq\t%%rax, %d(%%rbp)", offr);
                } else {
                    if (flag3 != 0) {
                        fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                        fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                    } else {
                        fprintf(fp, "\n\tmovl\t%%eax, %s(%%rip)", resx.c_str());
                        for (int l = 0; l < 10; ++l) {
                            int pp = 0;
                        }
                        if (1) {
                            for (int m = 0; m < 10; ++m) {
                                int k;
                            }
                        } else {
                            int n;
                        }
                    }
                }
                break;
            case Q_PARAM:
                if (resx[0] == '_') {
                    //string
                    char *temp = (char *)resx.c_str();
                    fprintf(fp, "\n\tmovq\t$.STR%d,\t%%rdi", atoi(temp + 1));
                } else {
                    _parameter_stack.push(resx);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    //printf("resx--> %s\n",resx.c_str());
                    _type_stack.push(search(resx)->type->type);
                    _offset_stack.push(offr);
                    if (search(resx)->isPointerArray == true) {
                        _pointer_stack.push(1);
                    } else {
                        _pointer_stack.push(0);
                    }
                }
                break;
            case Q_GOTO:
                if (resx != "-1" && atoi(resx.c_str()) <= lastQuad)
                    fprintf(fp, "\n\tjmp .L%d", mp_set[atoi(resx.c_str())]);
                else
                    fprintf(fp, "\n\tjmp\t.LRT%d", ret_count);
                break;
            case Q_CALL:
                add_off = callFunction(fp);
                fprintf(fp, "\n\tcall\t%s", arg1x.c_str());
                if (resx == "") {
                } else if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_int) {
                    fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                } else if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                } else if (search(resx) != NULL && search(resx)->type != NULL) {
                    fprintf(fp, "\n\tmovq\t%%rax, %d(%%rbp)", offr);
                } else {
                    fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                }
                if (arg1x == "printStr") {
                    fprintf(fp, "\n\taddq $8 , %%rsp");
                } else {
                    fprintf(fp, "\n\taddq $%d , %%rsp", add_off);
                }
                break;

            case Q_IF_LESS:
                if (search(arg1x) != NULL && search(arg1x)->type != NULL && search(arg1x)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcmpb\t%d(%%rbp), %%al", off2);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tjl .L%d", mp_set[atoi(resx.c_str())]);
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off2);
                    fprintf(fp, "\n\tcmpl\t%%edx, %%eax");
                    fprintf(fp, "\n\tjl .L%d", mp_set[atoi(resx.c_str())]);
                }
                break;
            case Q_IF_LESS_OR_EQUAL:
                if (search(arg1x) != NULL && search(arg1x)->type != NULL && search(arg1x)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcmpb\t%d(%%rbp), %%al", off2);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tjle .L%d", mp_set[atoi(resx.c_str())]);
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off2);
                    fprintf(fp, "\n\tcmpl\t%%edx, %%eax");
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tjle .L%d", mp_set[atoi(resx.c_str())]);
                }
                break;
            case Q_IF_GREATER:
                if (search(arg1x) != NULL && search(arg1x)->type != NULL && search(arg1x)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcmpb\t%d(%%rbp), %%al", off2);
                    fprintf(fp, "\n\tjg .L%d", mp_set[atoi(resx.c_str())]);
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off2);
                    fprintf(fp, "\n\tcmpl\t%%edx, %%eax");
                    fprintf(fp, "\n\tjg .L%d", mp_set[atoi(resx.c_str())]);
                }
                break;
            case Q_IF_GREATER_OR_EQUAL:
                if (search(arg1x) != NULL && search(arg1x)->type != NULL && search(arg1x)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tcmpb\t%d(%%rbp), %%al", off2);
                    fprintf(fp, "\n\tjge .L%d", mp_set[atoi(resx.c_str())]);
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off2);
                    fprintf(fp, "\n\tcmpl\t%%edx, %%eax");
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tjge .L%d", mp_set[atoi(resx.c_str())]);
                }
                break;
            case Q_IF_EQUAL:
                if (search(arg1x) != NULL && search(arg1x)->type != NULL && search(arg1x)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcmpb\t%d(%%rbp), %%al", off2);
                    fprintf(fp, "\n\tje .L%d", mp_set[atoi(resx.c_str())]);
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off2);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tcmpl\t%%edx, %%eax");
                    fprintf(fp, "\n\tje .L%d", mp_set[atoi(resx.c_str())]);
                }
                break;
            case Q_IF_NOT_EQUAL:
                if (search(arg1x) != NULL && search(arg1x)->type != NULL && search(arg1x)->type->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tcmpb\t%d(%%rbp), %%al", off2);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tjne .L%d", mp_set[atoi(resx.c_str())]);
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off1);
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off2);
                    fprintf(fp, "\n\tcmpl\t%%edx, %%eax");
                    fprintf(fp, "\n\tjne .L%d", mp_set[atoi(resx.c_str())]);
                }
                break;
            case Q_ADDR:
                fprintf(fp, "\n\tleaq\t%d(%%rbp), %%rax", off1);
                fprintf(fp, "\n\tmovq\t%%rax, %d(%%rbp)", offr);
                break;
            case Q_LDEREF:
                fprintf(fp, "\n\tmovq\t%d(%%rbp), %%rax", offr);
                fprintf(fp, "\n\tmovl\t%d(%%rbp), %%edx", off1);
                fprintf(fp, "\n\tmovl\t%%edx, (%%rax)");
                break;
            case Q_RDEREF:
                fprintf(fp, "\n\tmovq\t%d(%%rbp), %%rax", off1);
                fprintf(fp, "\n\tmovl\t(%%rax), %%eax");
                fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                break;
            case Q_RINDEX:
                // Get Address, subtract offset, get memory
                if (search(arg1x) && search(arg1x)->isPointerArray == true) {
                    fprintf(fp, "\n\tmovq\t%d(%%rbp), %%rdx", off1);
                    fprintf(fp, "\n\tmovslq\t%d(%%rbp), %%rax", off2);
                    fprintf(fp, "\n\taddq\t%%rax, %%rdx");
                } else {
                    fprintf(fp, "\n\tleaq\t%d(%%rbp), %%rdx", off1);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tmovslq\t%d(%%rbp), %%rax", off2);
                    fprintf(fp, "\n\taddq\t%%rax, %%rdx");
                }
                if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->next && search(resx)->type->next->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t(%%rdx), %%eax");
                    fprintf(fp, "\n\tmovb\t%%al, %d(%%rbp)", offr);
                } else {
                    fprintf(fp, "\n\tmovl\t(%%rdx), %%eax");
                    fprintf(fp, "\n\tmovl\t%%eax, %d(%%rbp)", offr);
                }
                break;
            case Q_LINDEX:
                // Get Address, subtract offset, get memory
                if (search(resx) && search(resx)->isPointerArray == true) {
                    fprintf(fp, "\n\tmovq\t%d(%%rbp), %%rdx", offr);
                    for (int l = 0; l < 10; ++l) {
                        int pp = 0;
                    }
                    if (1) {
                        for (int m = 0; m < 10; ++m) {
                            int k;
                        }
                    } else {
                        int n;
                    }
                    fprintf(fp, "\n\tmovslq\t%d(%%rbp), %%rax", off1);
                    fprintf(fp, "\n\taddq\t%%rax, %%rdx");
                } else {
                    fprintf(fp, "\n\tleaq\t%d(%%rbp), %%rdx", offr);
                    fprintf(fp, "\n\tmovslq\t%d(%%rbp), %%rax", off1);
                    fprintf(fp, "\n\taddq\t%%rax, %%rdx");
                }
                if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->next && search(resx)->type->next->type == tp_char) {
                    fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", off2);
                    fprintf(fp, "\n\tmovb\t%%al, (%%rdx)");
                } else {
                    fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", off2);
                    fprintf(fp, "\n\tmovl\t%%eax, (%%rdx)");
                }
                break;
            case Q_RETURN:
                if (resx != "") {
                    if (search(resx) != NULL && search(resx)->type != NULL && search(resx)->type->type == tp_char) {
                        fprintf(fp, "\n\tmovzbl\t%d(%%rbp), %%eax", offr);
                    } else {
                        fprintf(fp, "\n\tmovl\t%d(%%rbp), %%eax", offr);
                        for (int l = 0; l < 10; ++l) {
                            int pp = 0;
                        }
                        if (1) {
                            for (int m = 0; m < 10; ++m) {
                                int k;
                            }
                        } else {
                            int n;
                        }
                    }
                } else {
                    fprintf(fp, "\n\tmovl\t$0, %%eax");
                }
                fprintf(fp, "\n\tjmp\t.LRT%d", ret_count);
                break;
            default:
                break;
        }
    }
}

void symbolTable::function_epilogue(FILE *fp, int count, int ret_count) {
    fprintf(fp, "\n.LRT%d:", ret_count);
    fprintf(fp, "\n\taddq\t$%d, %%rsp", offset);
    fprintf(fp, "\n\tmovq\t%%rbp, %%rsp");
    fprintf(fp, "\n\tpopq\t%%rbp");
    fprintf(fp, "\n\tret");
    fprintf(fp, "\n.LFE%d:", count);
    fprintf(fp, "\n\t.size\t%s, .-%s", name.c_str(), name.c_str());
}
