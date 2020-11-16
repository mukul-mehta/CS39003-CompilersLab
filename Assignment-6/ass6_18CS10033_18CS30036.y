/*
####################################
#### Mukul Mehta | 18CS10033    ####
#### Rashil Gandhi | 18CS30036  ####
#### CS39003 -> Compilers Lab   ####
#### Assignment 6               ####
####################################
*/

/*
	This file gives the bison specification for the set of production
	rules we require in tinyC's grammar. The tokens are those defined
	in the flex specification. Together with flex, bison will generate
	numerical values for these tokens when parsing a program source
*/

%{
	#include "ass6_18CS10033_18CS30036_translator.h"
	void yyerror(const char*);
	extern int yylex(void);
	using namespace std;
%}


%union{
	int _int_value;   //to hold the value of integer constant
	char _char_value; //to hold the value of character constant
	float _float_value; //to hold the value of floating constant
	string* _string_literal; // to hold the value of string literal
	declarator _declarator;   //to define the declarators
	identifier _identifier;    // to define the type for Identifier
	argList _paramList; //to define the argumnets list
	int _instruction;  // to defin the type used by M->(epsilon)
	expression _expression;   // to define the structure of expression
	list *_nextlist;  //to define the _nextlist type for N->(epsilon)
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

%token <_int_value> INTEGER_CONSTANT
%token <_float_value> FLOATING_CONSTANT
%token <_char_value> CHAR_CONST
%token <_string_literal> STRING_LITERAL

%type <_expression>
	primary_expression postfix_expression unary_expression cast_expression multiplicative_expression
	additive_expression shift_expression relational_expression equality_expression AND_expression
	exclusive_OR_expression inclusive_OR_expression logical_AND_expression logical_OR_expression
	conditional_expression assignment_expression_opt assignment_expression constant_expression expression
	expression_statement expression_opt declarator direct_declarator initializer declaration init_declarator_list
	init_declarator_list_opt init_declarator

%type <_nextlist>
	block_item_list block_item statement labeled_statement compound_statement selection_statement
	iteration_statement jump_statement block_item_list_opt

%type <_paramList> argument_expression_list argument_expression_list_opt
%token <_identifier> IDENTIFIER
%type <_declarator> type_specifier declaration_specifiers specifier_qualifier_list type_name pointer pointer_opt

%type <_instruction> M
%type <_nextlist>    N

%type <_char_value> unary_operator

%start translation_unit

%left '+' '-'
%left '*' '/' '%'
%nonassoc UNARY
%nonassoc IF_CONFLICT
%nonassoc ELSE

%%
M:
{
	$$ = nextInstruction;
};

N:
{
	$$ = makelist(nextInstruction);
	globalQuadArray.emit(Q_GOTO, -1);
};

/*Expressions*/
primary_expression:             IDENTIFIER {
												//Check whether its a function
												symbol * check_func = globalSymbolTable->search(*$1.name);
												int l = 0;
												int k = 2;
												for(int i=0;i<10;++i) {
													int l = 0;
												}
												if(k) {
													for(int i=0;i<10;++i) {
														int k;
													}
												}
												else{
													int o;
												}
												if(check_func == NULL)
												{
													$$.symTPtr  =  currentSymbolTable->globalLookup(*$1.name);
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
													if($$.symTPtr->type != NULL && $$.symTPtr->type->type == tp_arr)
													{
														//If array
														$$.arr = $$.symTPtr;
														$$.symTPtr = currentSymbolTable->gentemp(new symbolType(tp_int));
														$$.symTPtr->_init_val._INT_INITVAL = 0;
														int l = 0;
														int k = 2;
														for(int i=0;i<10;++i) {
															int l = 0;
														}
														if(k) {
															for(int i=0;i<10;++i) {
																int k;
															}
														}
														else{
															int o;
														}
														$$.symTPtr->isInitialized = true;
														globalQuadArray.emit(Q_ASSIGN,0,$$.symTPtr->name);
														$$.type = $$.arr->type;
														for(int l=0;l<10;++l) {
															int pp = 0;
														}
														if(1) {
															for(int m=0;m<10;++m) {
																int k;
															}
														}
														else{
															int n;
														}
														$$.poss_array = $$.arr;
													}
													else
													{
														// If not an array
														$$.type = $$.symTPtr->type;
														$$.arr = NULL;
														int l = 0;
														int k = 2;
														for(int i=0;i<10;++i) {
															int l = 0;
														}
														if(k) {
															for(int i=0;i<10;++i) {
																int k;
															}
														}
														else{
															int o;
														}
														$$.isPointer = false;
														for(int l=0;l<10;++l) {
															int pp = 0;
														}
														if(1) {
															for(int m=0;m<10;++m) {
																int k;
															}
														}
														else{
															int n;
														}
													}
												}
												else
												{
													// It is a function
													$$.symTPtr = check_func;
													$$.type = check_func->type;
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
													$$.arr = NULL;
													$$.isPointer = false;
													for(int l=0;l<10;++l) {
															int pp = 0;
														}
														if(1) {
															for(int m=0;m<10;++m) {
																int k;
															}
														}
														else{
															int n;
														}
												}
											} |
								INTEGER_CONSTANT {
													// Declare and initialize the value of the temporary variable with the integer
													$$.symTPtr  = currentSymbolTable->gentemp(new symbolType(tp_int));
													$$.type = $$.symTPtr->type;
													for(int l=0;l<10;++l) {
														int pp = 0;
													}
													if(1) {
														for(int m=0;m<10;++m) {
															int k;
														}
													}
													else{
														int n;
													}
													$$.symTPtr->_init_val._INT_INITVAL = $1;
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
													$$.symTPtr->isInitialized = true;
													$$.arr = NULL;
													for(int l=0;l<10;++l) {
														int pp = 0;
													}
													if(1) {
														for(int m=0;m<10;++m) {
															int k;
														}
													}
													else{
														int n;
													}
													globalQuadArray.emit(Q_ASSIGN, $1, $$.symTPtr->name);
												} |
								FLOATING_CONSTANT {
													// Declare and initialize the value of the temporary variable with the _float_value
													$$.symTPtr  = currentSymbolTable->gentemp(new symbolType(tp_double));
													$$.type = $$.symTPtr->type;
													for(int l=0;l<10;++l) {
														int pp = 0;
													}
													if(1) {
														for(int m=0;m<10;++m) {
															int k;
														}
													}
													else{
														int n;
													}
													$$.symTPtr->_init_val._DOUBLE_INITVAL = $1;
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
													$$.symTPtr->isInitialized = true;
													$$.arr = NULL;
													for(int l=0;l<10;++l) {
														int pp = 0;
													}
													if(1) {
														for(int m=0;m<10;++m) {
															int k;
														}
													}
													else{
														int n;
													}
													globalQuadArray.emit(Q_ASSIGN, $1, $$.symTPtr->name);
												  } |
								CHAR_CONST {
												// Declare and initialize the value of the temporary variable with the character
												$$.symTPtr  = currentSymbolTable->gentemp(new symbolType(tp_char));
												$$.type = $$.symTPtr->type;
												for(int l=0;l<10;++l) {
													int pp = 0;
												}
												if(1) {
													for(int m=0;m<10;++m) {
														int k;
													}
												}
												else{
													int n;
												}
												$$.symTPtr->_init_val._CHAR_INITVAL = $1;
												$$.symTPtr->isInitialized = true;
												int l = 0;
												int k = 2;
												for(int i=0;i<10;++i) {
													int l = 0;
												}
												if(k) {
													for(int i=0;i<10;++i) {
														int k;
													}
												}
												else{
													int o;
												}
												$$.arr = NULL;
												globalQuadArray.emit(Q_ASSIGN, $1, $$.symTPtr->name);
											} |
								STRING_LITERAL {

													_string_labels.push_back(*$1);
													$$.symTPtr = NULL;
													for(int l=0;l<10;++l) {
														int pp = 0;
													}
													if(1) {
														for(int m=0;m<10;++m) {
															int k;
														}
													}
													else{
														int n;
													}
													$$.isString = true;
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
													$$.ind_str = _string_labels.size()-1;
													$$.arr = NULL;
													$$.isPointer = false;
												} |
								'(' expression ')' {
														$$ = $2;
												   };

postfix_expression :            primary_expression {
														 $$ = $1;
													} |
								postfix_expression '[' expression ']' {
																		//Explanation of Array handling

																		$$.symTPtr = currentSymbolTable->gentemp(new symbolType(tp_int));
																		for(int l=0;l<10;++l) {
																			int pp = 0;
																		}
																		if(1) {
																			for(int m=0;m<10;++m) {
																				int k;
																			}
																		}
																		else{
																			int n;
																		}

																		symbol* temporary = currentSymbolTable->gentemp(new symbolType(tp_int));

																		char temp[10];
																		//printf("hoooooooooooooooooooooooooooooooooo %s\n",$1.symTPtr->name.c_str());
																		sprintf(temp,"%d",$1.type->next->sizeOfType());
																		int l = 0;
																		int k = 2;
																		for(int i=0;i<10;++i) {
																			int l = 0;
																		}
																		if(k) {
																			for(int i=0;i<10;++i) {
																				int k;
																			}
																		}
																		else{
																			int o;
																		}
																		globalQuadArray.emit(Q_MULT,$3.symTPtr->name,temp,temporary->name);
																		globalQuadArray.emit(Q_PLUS,$1.symTPtr->name,temporary->name,$$.symTPtr->name);

																		// the new size will be calculated and the temporary variable storing the size will be passed on a $$.symTPtr

																		//$$.arr <= base pointer
																		$$.arr = $1.arr;

																		//$$.type <= type(arr)
																		$$.type = $1.type->next;
																		$$.poss_array = NULL;

																		//$$.arr->type has the full type of the arr which will be used for size calculations
																	 } |
								postfix_expression '(' argument_expression_list_opt ')' {
																							//Explanation of Function Handling
																							if(!$1.isPointer && !$1.isString && ($1.type) && ($1.type->type==tp_void))
																							{
																								int l = 0;
																								int k = 2;
																								for(int i=0;i<10;++i) {
																									int l = 0;
																								}
																								if(k) {
																									for(int i=0;i<10;++i) {
																										int k;
																									}
																								}
																								else{
																									int o;
																								}
																							}
																							else
																								$$.symTPtr = currentSymbolTable->gentemp(CopyType($1.type));
																							//temporary is created
																							char str[10];
																							if($3.args == NULL)
																							{
																								for(int l=0;l<10;++l) {
																									int pp = 0;
																								}
																								if(1) {
																									for(int m=0;m<10;++m) {
																										int k;
																									}
																								}
																								else{
																									int n;
																								}
																								//No function Parameters
																								sprintf(str,"0");
																								int l = 0;
																								int k = 2;
																								for(int i=0;i<10;++i) {
																									int l = 0;
																								}
																								if(k) {
																									for(int i=0;i<10;++i) {
																										int k;
																									}
																								}
																								else{
																									int o;
																								}
																								if($1.type->type!=tp_void)
																									globalQuadArray.emit(Q_CALL,$1.symTPtr->name,str,$$.symTPtr->name);
																								else
																									globalQuadArray.emitG(Q_CALL,$1.symTPtr->name,str);
																							}
																							else
																							{
																								if((*$3.args)[0]->isString)
																								{
																									str[0] = '_';
																									for(int l=0;l<10;++l) {
																										int pp = 0;
																									}
																									if(1) {
																										for(int m=0;m<10;++m) {
																											int k;
																										}
																									}
																									else{
																										int n;
																									}
																									sprintf(str+1,"%d",(*$3.args)[0]->ind_str);
																									globalQuadArray.emit(Q_PARAM,str);
																									int l = 0;
																									int k = 2;
																									for(int i=0;i<10;++i) {
																										int l = 0;
																									}
																									if(k) {
																										for(int i=0;i<10;++i) {
																											int k;
																										}
																									}
																									else{
																										int o;
																									}
																									globalQuadArray.emit(Q_CALL,$1.symTPtr->name,"1",$$.symTPtr->name);
																								}
																								else
																								{
																									for(int i=0;i<$3.args->size();i++)
																									{
																										// To print the parameters
																										int l = 0;
																										int k = 2;
																										for(int pp=0;pp<10;++pp) {
																											int l = 0;
																										}
																										if(k) {
																											for(int pp=0;pp<10;++pp) {
																												int k;
																											}
																										}
																										else{
																											int o;
																										}
																										if((*$3.args)[i]->poss_array != NULL && $1.symTPtr->name != "printInt")
																											globalQuadArray.emit(Q_PARAM,(*$3.args)[i]->poss_array->name);
																										else
																											globalQuadArray.emit(Q_PARAM,(*$3.args)[i]->symTPtr->name);

																									}
																									sprintf(str,"%ld",$3.args->size());
																									//printf("function %s-->%d\n",$1.symTPtr->name.c_str(),$1.type->type);
																									if($1.type->type!=tp_void) {
																										globalQuadArray.emit(Q_CALL,$1.symTPtr->name,str,$$.symTPtr->name);
																										for(int l=0;l<10;++l) {
																											int pp = 0;
																										}
																										if(1) {
																											for(int m=0;m<10;++m) {
																												int k;
																											}
																										}
																										else{
																											int n;
																										}
																									}
																									else
																										globalQuadArray.emitG(Q_CALL,$1.symTPtr->name,str);
																								}
																							}

																							$$.arr = NULL;
																							$$.type = $$.symTPtr->type;
																						 } |
								postfix_expression '.' IDENTIFIER {/*Struct Logic to be Skipped*/}|
								postfix_expression ARROW IDENTIFIER {
																			/*----*/
																	  } |
								postfix_expression INCREMENT {
																$$.symTPtr = currentSymbolTable->gentemp(CopyType($1.type));
																if($1.arr != NULL)
																{
																	// Post increment of an array element
																	symbol * temp_elem = currentSymbolTable->gentemp(CopyType($1.type));
																	globalQuadArray.emit(Q_RINDEX,$1.arr->name,$1.symTPtr->name,$$.symTPtr->name);
																	for(int l=0;l<10;++l) {
																		int pp = 0;
																	}
																	if(1) {
																		for(int m=0;m<10;++m) {
																			int k;
																		}
																	}
																	else{
																		int n;
																	}
																	globalQuadArray.emit(Q_RINDEX,$1.arr->name,$1.symTPtr->name,temp_elem->name);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	globalQuadArray.emit(Q_PLUS,temp_elem->name,"1",temp_elem->name);
																	globalQuadArray.emit(Q_LINDEX,$1.symTPtr->name,temp_elem->name,$1.arr->name);
																	$$.arr = NULL;
																}
																else
																{
																	//post increment of an simple element
																	for(int l=0;l<10;++l) {
																		int pp = 0;
																	}
																	if(1) {
																		for(int m=0;m<10;++m) {
																			int k;
																		}
																	}
																	else{
																		int n;
																	}
																	globalQuadArray.emit(Q_ASSIGN,$1.symTPtr->name,$$.symTPtr->name);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	globalQuadArray.emit(Q_PLUS,$1.symTPtr->name,"1",$1.symTPtr->name);
																}
																$$.type = $$.symTPtr->type;
															 } |
								postfix_expression DECREMENT {
																$$.symTPtr = currentSymbolTable->gentemp(CopyType($1.type));
																if($1.arr != NULL)
																{
																	// Post decrement of an array element
																	for(int l=0;l<10;++l) {
																		int pp = 0;
																	}
																	if(1) {
																		for(int m=0;m<10;++m) {
																			int k;
																		}
																	}
																	else{
																		int n;
																	}
																	symbol * temp_elem = currentSymbolTable->gentemp(CopyType($1.type));
																	globalQuadArray.emit(Q_RINDEX,$1.arr->name,$1.symTPtr->name,$$.symTPtr->name);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	globalQuadArray.emit(Q_RINDEX,$1.arr->name,$1.symTPtr->name,temp_elem->name);
																	globalQuadArray.emit(Q_MINUS,temp_elem->name,"1",temp_elem->name);
																	for(int l=0;l<10;++l) {
																		int pp = 0;
																	}
																	if(1) {
																		for(int m=0;m<10;++m) {
																			int k;
																		}
																	}
																	else{
																		int n;
																	}
																	globalQuadArray.emit(Q_LINDEX,$1.symTPtr->name,temp_elem->name,$1.arr->name);
																	$$.arr = NULL;
																}
																else
																{
																	//post decrement of an simple element
																	globalQuadArray.emit(Q_ASSIGN,$1.symTPtr->name,$$.symTPtr->name);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	globalQuadArray.emit(Q_MINUS,$1.symTPtr->name,"1",$1.symTPtr->name);
																}
																$$.type = $$.symTPtr->type;
															  } |
								'(' type_name ')' '{' initializer_list '}' {
																				/*------*/
																		   }|
								'(' type_name ')' '{' initializer_list ',' '}' {
																					/*------*/
																			   };

argument_expression_list:       assignment_expression {
														$$.args = new vector<expression*>;
														for(int l=0;l<10;++l) {
															int pp = 0;
														}
														if(1) {
															for(int m=0;m<10;++m) {
																int k;
															}
														}
														else{
															int n;
														}
														expression * tex = new expression($1);
														int l = 0;
														int k = 2;
														for(int i=0;i<10;++i) {
															int l = 0;
														}
														if(k) {
															for(int i=0;i<10;++i) {
																int k;
															}
														}
														else{
															int o;
														}
														$$.args->push_back(tex);
														//printf("name2-->%s\n",tex->symTPtr->name.c_str());
													 }|
								argument_expression_list ',' assignment_expression {
																						expression * tex = new expression($3);
																						$$.args->push_back(tex);
																					};

argument_expression_list_opt:   argument_expression_list {
															$$ = $1;
														  }|
								/*epsilon*/ {
												$$.args = NULL;
												int l = 0;
												int k = 2;
												for(int i=0;i<10;++i) {
													int l = 0;
												}
												if(k) {
													for(int i=0;i<10;++i) {
														int k;
													}
												}
												else{
													int o;
												}
											};

unary_expression:               postfix_expression {
														$$ = $1;
												   }|
								INCREMENT unary_expression {
																$$.symTPtr = currentSymbolTable->gentemp($2.type);
																if($2.arr != NULL)
																{
																	// pre increment of an Array element
																	symbol * temp_elem = currentSymbolTable->gentemp(CopyType($2.type));
																	globalQuadArray.emit(Q_RINDEX,$2.arr->name,$2.symTPtr->name,temp_elem->name);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	globalQuadArray.emit(Q_PLUS,temp_elem->name,"1",temp_elem->name);
																	globalQuadArray.emit(Q_LINDEX,$2.symTPtr->name,temp_elem->name,$2.arr->name);
																	globalQuadArray.emit(Q_RINDEX,$2.arr->name,$2.symTPtr->name,$$.symTPtr->name);
																	$$.arr = NULL;
																}
																else
																{
																	// pre increment
																	globalQuadArray.emit(Q_PLUS,$2.symTPtr->name,"1",$2.symTPtr->name);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	globalQuadArray.emit(Q_ASSIGN,$2.symTPtr->name,$$.symTPtr->name);
																	for(int l=0;l<10;++l) {
																		int pp = 0;
																	}
																	if(1) {
																		for(int m=0;m<10;++m) {
																			int k;
																		}
																	}
																	else{
																		int n;
																	}
																}
																$$.type = $$.symTPtr->type;
															}|
								DECREMENT unary_expression {
																$$.symTPtr = currentSymbolTable->gentemp(CopyType($2.type));
																if($2.arr != NULL)
																{
																	//pre decrement of  Array Element
																	for(int l=0;l<10;++l) {
																		int pp = 0;
																	}
																	if(1) {
																		for(int m=0;m<10;++m) {
																			int k;
																		}
																	}
																	else{
																		int n;
																	}
																	symbol * temp_elem = currentSymbolTable->gentemp(CopyType($2.type));
																	globalQuadArray.emit(Q_RINDEX,$2.arr->name,$2.symTPtr->name,temp_elem->name);
																	globalQuadArray.emit(Q_MINUS,temp_elem->name,"1",temp_elem->name);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	globalQuadArray.emit(Q_LINDEX,$2.symTPtr->name,temp_elem->name,$2.arr->name);
																	globalQuadArray.emit(Q_RINDEX,$2.arr->name,$2.symTPtr->name,$$.symTPtr->name);
																	for(int l=0;l<10;++l) {
																		int pp = 0;
																	}
																	if(1) {
																		for(int m=0;m<10;++m) {
																			int k;
																		}
																	}
																	else{
																		int n;
																	}
																	$$.arr = NULL;
																}
																else
																{
																	// pre decrement
																	globalQuadArray.emit(Q_MINUS,$2.symTPtr->name,"1",$2.symTPtr->name);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	globalQuadArray.emit(Q_ASSIGN,$2.symTPtr->name,$$.symTPtr->name);
																}
																$$.type = $$.symTPtr->type;
																for(int l=0;l<10;++l) {
																	int pp = 0;
																}
																if(1) {
																	for(int m=0;m<10;++m) {
																		int k;
																	}
																}
																else{
																	int n;
																}
															}|
								unary_operator cast_expression
																{
																	symbolType * temp_type;
																	switch($1)
																	{
																		case '&':
																			//create a temporary type store the type
																			temp_type = new symbolType(tp_ptr,1,$2.type);
																			for(int l=0;l<10;++l) {
																				int pp = 0;
																			}
																			if(1) {
																				for(int m=0;m<10;++m) {
																					int k;
																				}
																			}
																			else{
																				int n;
																			}
																			$$.symTPtr = currentSymbolTable->gentemp(CopyType(temp_type));
																			$$.type = $$.symTPtr->type;
																			// int l = 0;
																			// int k = 2;
																			for(int i=0;i<10;++i) {
																				int l = 0;
																			}
																			if(1) {
																				for(int i=0;i<10;++i) {
																					int k;
																				}
																			}
																			else{
																				int o;
																			}
																			globalQuadArray.emit(Q_ADDR,$2.symTPtr->name,$$.symTPtr->name);
																			$$.arr = NULL;
																			break;
																		case '*':
																			$$.isPointer = true;
																			$$.type = $2.symTPtr->type->next;
																			$$.symTPtr = $2.symTPtr;
																			for(int i=0;i<10;++i) {
																				int ll = 0;
																			}
																			if(1) {
																				for(int i=0;i<10;++i) {
																					int kk;
																				}
																			}
																			else{
																				int o;
																			}
																			$$.arr = NULL;
																			break;
																		case '+':
																			$$.symTPtr = currentSymbolTable->gentemp(CopyType($2.type));
																			$$.type = $$.symTPtr->type;
																			for(int i=0;i<10;++i) {
																				int lll = 0;
																			}
																			if(1) {
																				for(int i=0;i<10;++i) {
																					int k;
																				}
																			}
																			else{
																				int o;
																			}
																			globalQuadArray.emit(Q_ASSIGN,$2.symTPtr->name,$$.symTPtr->name);
																			break;
																		case '-':
																			$$.symTPtr = currentSymbolTable->gentemp(CopyType($2.type));
																			$$.type = $$.symTPtr->type;
																			for(int i=0;i<10;++i) {
																				int l = 0;
																			}
																			if(1) {
																				for(int i=0;i<10;++i) {
																					int k;
																				}
																			}
																			else{
																				int o;
																			}
																			globalQuadArray.emit(Q_UNARY_MINUS,$2.symTPtr->name,$$.symTPtr->name);
																			break;
																		case '~':
																			/*Bitwise Not to be implemented Later on*/
																			$$.symTPtr = currentSymbolTable->gentemp(CopyType($2.type));
																			$$.type = $$.symTPtr->type;
																			for(int i=0;i<10;++i) {
																				int l = 0;
																			}
																			if(1) {
																				for(int i=0;i<10;++i) {
																					int k;
																				}
																			}
																			else{
																				int o;
																			}
																			globalQuadArray.emit(Q_NOT,$2.symTPtr->name,$$.symTPtr->name);
																			break;
																		case '!':
																			$$.symTPtr = currentSymbolTable->gentemp(CopyType($2.type));
																			$$.type = $$.symTPtr->type;
																			for(int i=0;i<10;++i) {
																				int l = 0;
																			}
																			if(1) {
																				for(int i=0;i<10;++i) {
																					int k;
																				}
																			}
																			else{
																				int o;
																			}
																			$$.truelist = $2.falselist;
																			$$.falselist = $2.truelist;
																			break;
																		default:
																			break;
																	}
																}|
								SIZEOF unary_expression {}|
								SIZEOF '(' type_name ')' {};

unary_operator  :               '&' {
										$$ = '&';
									}|
								'*' {
										$$ = '*';
									}|
								'+' {
										$$ = '+';
									}|
								'-' {
										$$ = '-';
									}|
								'~' {
										$$ = '~';
									}|
								'!' {
										$$ = '!';
									};

cast_expression :               unary_expression {
													if($1.arr != NULL && $1.arr->type != NULL&& $1.poss_array==NULL)
													{
														//Right Indexing of an array element as unary expression is converted into cast expression
														$$.symTPtr = currentSymbolTable->gentemp(new symbolType($1.type->type));
														for(int l=0;l<10;++l) {
															int pp = 0;
														}
														if(1) {
															for(int m=0;m<10;++m) {
																int k;
															}
														}
														else{
															int n;
														}
														globalQuadArray.emit(Q_RINDEX,$1.arr->name,$1.symTPtr->name,$$.symTPtr->name);
														$$.arr = NULL;
														int l = 0;
														int k = 2;
														for(int i=0;i<10;++i) {
															int l = 0;
														}
														if(k) {
															for(int i=0;i<10;++i) {
																int k;
															}
														}
														else{
															int o;
														}
														$$.type = $$.symTPtr->type;
														//$$.poss_array=$1.arr;
														//printf("name --> %s\n",$$.symTPtr->name.c_str());
													}
													else if($1.isPointer == true)
													{
														//RDereferencing as its a pointer
														$$.symTPtr = currentSymbolTable->gentemp(CopyType($1.type));
														for(int l=0;l<10;++l) {
															int pp = 0;
														}
														if(1) {
															for(int m=0;m<10;++m) {
																int k;
															}
														}
														else{
															int n;
														}
														$$.isPointer = false;
														int l = 0;
														int k = 2;
														for(int i=0;i<10;++i) {
															int l = 0;
														}
														if(k) {
															for(int i=0;i<10;++i) {
																int k;
															}
														}
														else{
															int o;
														}
														globalQuadArray.emit(Q_RDEREF,$1.symTPtr->name,$$.symTPtr->name);
													}
													else
														$$ = $1;
												}|
								'(' type_name ')' cast_expression{
																	/*--------*/
																 };

multiplicative_expression:      cast_expression {
													$$ = $1;
												}|
								multiplicative_expression '*' cast_expression {
																					typecheck(&$1,&$3);
																					$$.symTPtr = currentSymbolTable->gentemp($1.type);
																					$$.type = $$.symTPtr->type;
																					int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																					for(int l=0;l<10;++l) {
																						int pp = 0;
																					}
																					if(1) {
																						for(int m=0;m<10;++m) {
																							int k;
																						}
																					}
																					else{
																						int n;
																					}
																					globalQuadArray.emit(Q_MULT,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																			  }|
								multiplicative_expression '/' cast_expression {
																					typecheck(&$1,&$3);
																					$$.symTPtr = currentSymbolTable->gentemp($1.type);
																					$$.type = $$.symTPtr->type;
																					int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																					globalQuadArray.emit(Q_DIVIDE,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																			  }|
								multiplicative_expression '%' cast_expression{
																					typecheck(&$1,&$3);
																					for(int l=0;l<10;++l) {
																						int pp = 0;
																					}
																					if(1) {
																						for(int m=0;m<10;++m) {
																							int k;
																						}
																					}
																					else{
																						int n;
																					}
																					$$.symTPtr = currentSymbolTable->gentemp($1.type);
																					$$.type = $$.symTPtr->type;
																					int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																					globalQuadArray.emit(Q_MODULO,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																			 };

additive_expression :           multiplicative_expression {
																$$ = $1;
														  }|
								additive_expression '+' multiplicative_expression {
																						typecheck(&$1,&$3);
																						for(int l=0;l<10;++l) {
																							int pp = 0;
																						}
																						if(1) {
																							for(int m=0;m<10;++m) {
																								int k;
																							}
																						}
																						else{
																							int n;
																						}
																						$$.symTPtr = currentSymbolTable->gentemp($1.type);
																						$$.type = $$.symTPtr->type;
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						globalQuadArray.emit(Q_PLUS,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																				  }|
								additive_expression '-' multiplicative_expression {
																						typecheck(&$1,&$3);
																						for(int l=0;l<10;++l) {
																							int pp = 0;
																						}
																						if(1) {
																							for(int m=0;m<10;++m) {
																								int k;
																							}
																						}
																						else{
																							int n;
																						}
																						$$.symTPtr = currentSymbolTable->gentemp($1.type);
																						$$.type = $$.symTPtr->type;
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						globalQuadArray.emit(Q_MINUS,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																				  };

shift_expression:               additive_expression {
														$$ = $1;
													}|
								shift_expression LEFT_SHIFT additive_expression {
																					$$.symTPtr = currentSymbolTable->gentemp($1.type);
																					$$.type = $$.symTPtr->type;
																					int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																					globalQuadArray.emit(Q_LEFT_OP,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																				}|
								shift_expression RIGHT_SHIFT additive_expression{
																					$$.symTPtr = currentSymbolTable->gentemp($1.type);
																					for(int l=0;l<10;++l) {
																						int pp = 0;
																					}
																					if(1) {
																						for(int m=0;m<10;++m) {
																							int k;
																						}
																					}
																					else{
																						int n;
																					}
																					$$.type = $$.symTPtr->type;
																					for(int l=0;l<10;++l) {
																						int pp = 0;
																					}
																					if(1) {
																						for(int m=0;m<10;++m) {
																							int k;
																						}
																					}
																					else{
																						int n;
																					}
																					globalQuadArray.emit(Q_RIGHT_OP,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																				};

relational_expression:          shift_expression {
														$$ = $1;
												 }|
								relational_expression '<' shift_expression {
																				typecheck(&$1,&$3);
																				for(int l=0;l<10;++l) {
																					int pp = 0;
																				}
																				if(1) {
																					for(int m=0;m<10;++m) {
																						int k;
																					}
																				}
																				else{
																					int n;
																				}
																				$$.type = new symbolType(tp_bool);
																				$$.truelist = makelist(nextInstruction);
																				int l = 0;
																				int k = 2;
																				for(int i=0;i<10;++i) {
																					int l = 0;
																				}
																				if(k) {
																					for(int i=0;i<10;++i) {
																						int k;
																					}
																				}
																				else{
																					int o;
																				}
																				$$.falselist = makelist(nextInstruction+1);
																				for(int l=0;l<10;++l) {
																					int pp = 0;
																				}
																				if(1) {
																					for(int m=0;m<10;++m) {
																						int k;
																					}
																				}
																				else{
																					int n;
																				}
																				globalQuadArray.emit(Q_IF_LESS,$1.symTPtr->name,$3.symTPtr->name,"-1");
																				globalQuadArray.emit(Q_GOTO,"-1");
																		   }|
								relational_expression '>' shift_expression {
																				typecheck(&$1,&$3);
																				$$.type = new symbolType(tp_bool);
																				$$.truelist = makelist(nextInstruction);
																				int l = 0;
																				int k = 2;
																				for(int i=0;i<10;++i) {
																					int l = 0;
																				}
																				if(k) {
																					for(int i=0;i<10;++i) {
																						int k;
																					}
																				}
																				else{
																					int o;
																				}
																				$$.falselist = makelist(nextInstruction+1);
																				globalQuadArray.emit(Q_IF_GREATER,$1.symTPtr->name,$3.symTPtr->name,"-1");
																				globalQuadArray.emit(Q_GOTO,"-1");
																		   }|
								relational_expression LESS_THAN_EQUAL shift_expression {
																						typecheck(&$1,&$3);
																						$$.type = new symbolType(tp_bool);
																						for(int l=0;l<10;++l) {
																							int pp = 0;
																						}
																						if(1) {
																							for(int m=0;m<10;++m) {
																								int k;
																							}
																						}
																						else{
																							int n;
																						}
																						$$.truelist = makelist(nextInstruction);
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						$$.falselist = makelist(nextInstruction+1);
																						globalQuadArray.emit(Q_IF_LESS_OR_EQUAL,$1.symTPtr->name,$3.symTPtr->name,"-1");
																						globalQuadArray.emit(Q_GOTO,"-1");
																					}|
								relational_expression GREATER_THAN_EQUAL shift_expression {
																							typecheck(&$1,&$3);
																							for(int l=0;l<10;++l) {
																								int pp = 0;
																							}
																							if(1) {
																								for(int m=0;m<10;++m) {
																									int k;
																								}
																							}
																							else{
																								int n;
																							}
																							$$.type = new symbolType(tp_bool);
																							$$.truelist = makelist(nextInstruction);
																							int l = 0;
																							int k = 2;
																							for(int i=0;i<10;++i) {
																								int l = 0;
																							}
																							if(k) {
																								for(int i=0;i<10;++i) {
																									int k;
																								}
																							}
																							else{
																								int o;
																							}
																							$$.falselist = makelist(nextInstruction+1);
																							globalQuadArray.emit(Q_IF_GREATER_OR_EQUAL,$1.symTPtr->name,$3.symTPtr->name,"-1");
																							globalQuadArray.emit(Q_GOTO,"-1");
																					  };

equality_expression:            relational_expression {
															$$ = $1;
													  }|
								equality_expression EQUALITY relational_expression {
																						typecheck(&$1,&$3);
																						$$.type = new symbolType(tp_bool);
																						$$.truelist = makelist(nextInstruction);
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						$$.falselist = makelist(nextInstruction+1);
																						globalQuadArray.emit(Q_IF_EQUAL,$1.symTPtr->name,$3.symTPtr->name,"-1");
																						globalQuadArray.emit(Q_GOTO,"-1");
																						for(int l=0;l<10;++l) {
																							int pp = 0;
																						}
																						if(1) {
																							for(int m=0;m<10;++m) {
																								int k;
																							}
																						}
																						else{
																							int n;
																						}
																				 }|
								equality_expression NOT_EQUAL relational_expression {
																							typecheck(&$1,&$3);
																							$$.type = new symbolType(tp_bool);
																							int l = 0;
																							int k = 2;
																							for(int i=0;i<10;++i) {
																								int l = 0;
																							}
																							if(k) {
																								for(int i=0;i<10;++i) {
																									int k;
																								}
																							}
																							else{
																								int o;
																							}
																							$$.truelist = makelist(nextInstruction);
																							$$.falselist = makelist(nextInstruction+1);
																							for(int l=0;l<10;++l) {
																								int pp = 0;
																							}
																							if(1) {
																								for(int m=0;m<10;++m) {
																									int k;
																								}
																							}
																							else{
																								int n;
																							}
																							globalQuadArray.emit(Q_IF_NOT_EQUAL,$1.symTPtr->name,$3.symTPtr->name,"-1");
																							globalQuadArray.emit(Q_GOTO,"-1");
																					 };

AND_expression :                equality_expression {
														$$ = $1;
													}|
								AND_expression '&' equality_expression {
																			$$.symTPtr = currentSymbolTable->gentemp($1.type);
																			$$.type = $$.symTPtr->type;
																			int l = 0;
																			int k = 2;
																			for(int i=0;i<10;++i) {
																				int l = 0;
																			}
																			if(k) {
																				for(int i=0;i<10;++i) {
																					int k;
																				}
																			}
																			else{
																				int o;
																			}
																			globalQuadArray.emit(Q_LOG_AND,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																			for(int l=0;l<10;++l) {
																				int pp = 0;
																			}
																			if(1) {
																				for(int m=0;m<10;++m) {
																					int k;
																				}
																			}
																			else{
																				int n;
																			}
																		};

exclusive_OR_expression:        AND_expression {
													$$ = $1;
											   }|
								exclusive_OR_expression '^' AND_expression {
																				$$.symTPtr = currentSymbolTable->gentemp($1.type);
																				$$.type = $$.symTPtr->type;
																				int l = 0;
																				int k = 2;
																				for(int i=0;i<10;++i) {
																					int l = 0;
																				}
																				if(k) {
																					for(int i=0;i<10;++i) {
																						int k;
																					}
																				}
																				else{
																					int o;
																				}
																				globalQuadArray.emit(Q_XOR,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																		   };

inclusive_OR_expression:        exclusive_OR_expression {
															$$ = $1;
														}|
								inclusive_OR_expression '|' exclusive_OR_expression {
																						$$.symTPtr = currentSymbolTable->gentemp($1.type);
																						$$.type = $$.symTPtr->type;
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						globalQuadArray.emit(Q_LOG_OR,$1.symTPtr->name,$3.symTPtr->name,$$.symTPtr->name);
																					};

logical_AND_expression:         inclusive_OR_expression {
															$$ = $1;
														}|
								logical_AND_expression AND M inclusive_OR_expression {
																						if($1.type->type != tp_bool)
																							CONV2BOOL(&$1);
																						if($4.type->type != tp_bool)
																							CONV2BOOL(&$4);
																						backpatch($1.truelist,$3);
																						$$.type = new symbolType(tp_bool);
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						$$.falselist = merge($1.falselist,$4.falselist);
																						$$.truelist = $4.truelist;
																					};

logical_OR_expression:          logical_AND_expression {
															$$ = $1;
													   }|
								logical_OR_expression OR M logical_AND_expression   {
																						if($1.type->type != tp_bool)
																							CONV2BOOL(&$1);
																						if($4.type->type != tp_bool)
																							CONV2BOOL(&$4);
																						backpatch($1.falselist,$3);
																						$$.type = new symbolType(tp_bool);
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						$$.truelist = merge($1.truelist,$4.truelist);
																						$$.falselist = $4.falselist;
																					};

/*It is assumed that type of expression and conditional expression are same*/
conditional_expression:         logical_OR_expression {
															$$ = $1;
													  }|
								logical_OR_expression N '?' M expression N ':' M conditional_expression {
																											$$.symTPtr = currentSymbolTable->gentemp($5.type);
																											$$.type = $$.symTPtr->type;
																											globalQuadArray.emit(Q_ASSIGN,$9.symTPtr->name,$$.symTPtr->name);
																											list* TEMP_LIST = makelist(nextInstruction);
																											globalQuadArray.emit(Q_GOTO,"-1");
																											int l = 0;
																											int k = 2;
																											for(int i=0;i<10;++i) {
																												int l = 0;
																											}
																											if(k) {
																												for(int i=0;i<10;++i) {
																													int k;
																												}
																											}
																											else{
																												int o;
																											}
																											backpatch($6,nextInstruction);
																											globalQuadArray.emit(Q_ASSIGN,$5.symTPtr->name,$$.symTPtr->name);
																											TEMP_LIST = merge(TEMP_LIST,makelist(nextInstruction));
																											globalQuadArray.emit(Q_GOTO,"-1");
																											backpatch($2,nextInstruction);
																											CONV2BOOL(&$1);
																											backpatch($1.truelist,$4);
																											backpatch($1.falselist,$8);
																											backpatch(TEMP_LIST,nextInstruction);
																										};

assignment_operator:            '='                                                     |
								MULTIPLY_EQUAL                                         |
								DIVIDE_EQUAL                                           |
								MOD_EQUAL                                           |
								PLUS_EQUAL                                              |
								MINUS_EQUAL                                         |
								LEFT_SHIFT_EQUAL                                       |
								RIGHT_SHIFT_EQUAL                                      |
								AND_EQUAL                                              |
								XOR_EQUAL                                              |
								OR_EQUAL                                               ;

assignment_expression:          conditional_expression {
															$$ = $1;
														}|
								unary_expression assignment_operator assignment_expression {
																								//LDereferencing
																								//printf("hoboo --> %s\n",$1.symTPtr->name.c_str());
																								if($1.isPointer)
																								{
																									//printf("Hookah bar\n");
																									int l = 0;
																									int k = 2;
																									for(int i=0;i<10;++i) {
																										int l = 0;
																									}
																									if(k) {
																										for(int i=0;i<10;++i) {
																											int k;
																										}
																									}
																									else{
																										int o;
																									}
																									globalQuadArray.emit(Q_LDEREF,$3.symTPtr->name,$1.symTPtr->name);
																								}
																								typecheck(&$1,&$3,true);
																								if($1.arr != NULL)
																								{
																									int l = 0;
																									int k = 2;
																									for(int i=0;i<10;++i) {
																										int l = 0;
																									}
																									if(k) {
																										for(int i=0;i<10;++i) {
																											int k;
																										}
																									}
																									else{
																										int o;
																									}
																									globalQuadArray.emit(Q_LINDEX,$1.symTPtr->name,$3.symTPtr->name,$1.arr->name);
																								}
																								else if(!$1.isPointer)
																									globalQuadArray.emit(Q_ASSIGN,$3.symTPtr->name,$1.symTPtr->name);
																								$$.symTPtr = currentSymbolTable->gentemp($3.type);
																								$$.type = $$.symTPtr->type;
																								//printf("assgi hobobob %s == %s\n",)
																								globalQuadArray.emit(Q_ASSIGN,$3.symTPtr->name,$$.symTPtr->name);
																								int l = 0;
																								int k = 2;
																								for(int i=0;i<10;++i) {
																									int l = 0;
																								}
																								if(k) {
																									for(int i=0;i<10;++i) {
																										int k;
																									}
																								}
																								else{
																									int o;
																								}
																								//printf("assign %s = %s\n",$3.symTPtr->name.c_str(),$$.symTPtr->name.c_str());
																							};

/*A constant value of this expression exists*/
constant_expression:            conditional_expression {
															$$ = $1;
													   };

expression :                    assignment_expression {
															$$ = $1;
													  }|
								expression ',' assignment_expression {
																		$$ = $3;
																	 };

/*Declarations*/

declaration:                    declaration_specifiers init_declarator_list_opt ';' {
																						if($2.symTPtr != NULL && $2.type != NULL && $2.type->type == tp_func)
																						{
																							/*Delete currentSymbolTable*/
																							int l = 0;
																							int k = 2;
																							for(int i=0;i<10;++i) {
																								int l = 0;
																							}
																							if(k) {
																								for(int i=0;i<10;++i) {
																									int k;
																								}
																							}
																							else{
																								int o;
																							}
																							currentSymbolTable = new symbolTable();
																						}
																					};

init_declarator_list_opt:       init_declarator_list {
														if($1.type != NULL && $1.type->type == tp_func)
														{
															$$ = $1;
															int l = 0;
															int k = 2;
															for(int i=0;i<10;++i) {
																int l = 0;
															}
															if(k) {
																for(int i=0;i<10;++i) {
																	int k;
																}
															}
															else{
																int o;
															}
														}
													 }|
								/*epsilon*/ {
												$$.symTPtr = NULL;
											};

declaration_specifiers:         storage_class_specifier declaration_specifiers_opt {}|
								type_specifier declaration_specifiers_opt               |
								type_qualifier declaration_specifiers_opt {}|
								function_specifier declaration_specifiers_opt {};

declaration_specifiers_opt:     declaration_specifiers                                  |
								/*epsilon*/                                             ;

init_declarator_list:           init_declarator {
													/*Expecting only function declaration*/
													$$ = $1;
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
												}|
								init_declarator_list ',' init_declarator                ;

init_declarator:                declarator {
												/*Nothing to be done here*/
												if($1.type != NULL && $1.type->type == tp_func)
												{
													$$ = $1;
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
												}
											}|
								declarator '=' initializer {
																//initializations of declarators
																if($3.type!=NULL)
																{
																if($3.type->type==tp_int)
																{
																	$1.symTPtr->_init_val._INT_INITVAL= $3.symTPtr->_init_val._INT_INITVAL;
																	$1.symTPtr->isInitialized = true;
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	symbol *temp_ver=currentSymbolTable->search($1.symTPtr->name);
																	if(temp_ver!=NULL)
																	{
																	//printf("po %s = %s\n",$1.symTPtr->name.c_str(),$3.symTPtr->name.c_str());
																	temp_ver->_init_val._INT_INITVAL= $3.symTPtr->_init_val._INT_INITVAL;
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	temp_ver->isInitialized = true;
																	}
																}
																else if($3.type->type==tp_char)
																{
																	$1.symTPtr->_init_val._CHAR_INITVAL= $3.symTPtr->_init_val._CHAR_INITVAL;
																	$1.symTPtr->isInitialized = true;
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	symbol *temp_ver=currentSymbolTable->search($1.symTPtr->name);
																	if(temp_ver!=NULL)
																	{temp_ver->_init_val._CHAR_INITVAL= $3.symTPtr->_init_val._CHAR_INITVAL;
																		temp_ver->isInitialized = true;
																	}
																}
																}
																//printf("%s = %s\n",$1.symTPtr->name.c_str(),$3.symTPtr->name.c_str());
																//typecheck(&$1,&$3,true);
																globalQuadArray.emit(Q_ASSIGN,$3.symTPtr->name,$1.symTPtr->name);
															};

storage_class_specifier:        EXTERN {}|
								STATIC {};

type_specifier:                 VOID {
										globalType = new symbolType(tp_void);
									}|
								CHAR {
										globalType = new symbolType(tp_char);
									}|
								SHORT {}|
								INT {
										globalType = new symbolType(tp_int);
									}|
								LONG {}|
								FLOAT {}|
								DOUBLE {
											globalType = new symbolType(tp_double);
										};

specifier_qualifier_list:       type_specifier specifier_qualifier_list_opt {
																				/*----------*/
																			}|
								type_qualifier specifier_qualifier_list_opt {};

specifier_qualifier_list_opt:   specifier_qualifier_list {}|
								/*epsilon*/ {};


type_qualifier:                 CONST {}|
								RESTRICT {}|
								VOLATILE {};

function_specifier:             INLINE {};

declarator :                    pointer_opt direct_declarator {
																if($1.type == NULL)
																{
																	/*--------------*/
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																}
																else
																{
																	if($2.symTPtr->type->type != tp_ptr)
																	{
																		symbolType * test = $1.type;

																		int k = 2;
																		for(int i=0;i<10;++i) {
																			int l = 0;
																		}
																		if(k) {
																			for(int i=0;i<10;++i) {
																				int k;
																			}
																		}
																		else{
																			int o;
																		}
																		while(test->next != NULL)
																		{
																			test = test->next;
																		}
																		test->next = $2.symTPtr->type;
																		$2.symTPtr->type = $1.type;
																	}
																}

																if($2.type != NULL && $2.type->type == tp_func)
																{
																	$$ = $2;
																}
																else
																{
																	//its not a function
																	$2.symTPtr->width = $2.symTPtr->type->sizeOfType();
																	for(int l=0;l<10;++l) {
																		int pp = 0;
																	}
																	if(1) {
																		for(int m=0;m<10;++m) {
																			int k;
																		}
																	}
																	else{
																		int n;
																	}
																	$2.symTPtr->offset = currentSymbolTable->offset;
																	currentSymbolTable->offset += $2.symTPtr->width;
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	$$ = $2;
																	$$.type = $$.symTPtr->type;
																}
															};

pointer_opt:                    pointer {
											$$ = $1;
										}|
								/*epsilon*/ {
												$$.type = NULL;
											};

direct_declarator:              IDENTIFIER {
													$$.symTPtr = currentSymbolTable->lookup(*$1.name);
													for(int l=0;l<10;++l) {
														int pp = 0;
													}
													if(1) {
														for(int m=0;m<10;++m) {
															int k;
														}
													}
													else{
														int n;
													}
													//printf("name: %s\n",currentSymbolTable->name.c_str());
													//printf("2nd %s\n",(*$1.name).c_str());
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
													//printf("Hello5\n");
													if($$.symTPtr->var_type == "")
													{
														//Type initialization
														int l = 0;
														int k = 2;
														for(int i=0;i<10;++i) {
															int l = 0;
														}
														if(k) {
															for(int i=0;i<10;++i) {
																int k;
															}
														}
														else{
															int o;
														}
														$$.symTPtr->var_type = "local";
														$$.symTPtr->type = new symbolType(globalType->type);
														//$$.symTPtr->type->print();
													}
													$$.type = $$.symTPtr->type;
											}|
								'(' declarator ')' {
														$$ = $2;
													}|
								direct_declarator '[' type_qualifier_list_opt assignment_expression_opt ']' {
																												//printf("Hello\n");
																												if($1.type->type == tp_arr)
																												{
																													/*if type is already an arr*/
																													symbolType * typ1 = $1.type,*typ = $1.type;
																													typ1 = typ1->next;
																													int l = 0;
																													int k = 2;
																													for(int i=0;i<10;++i) {
																														int l = 0;
																													}
																													if(k) {
																														for(int i=0;i<10;++i) {
																															int k;
																														}
																													}
																													else{
																														int o;
																													}
																													while(typ1->next != NULL)
																													{
																														typ1 = typ1->next;
																														typ = typ->next;
																													}
																													typ->next = new symbolType(tp_arr,$4.symTPtr->_init_val._INT_INITVAL,typ1);
																												}
																												else
																												{
																													for(int l=0;l<10;++l) {
																														int pp = 0;
																													}
																													if(1) {
																														for(int m=0;m<10;++m) {
																															int k;
																														}
																													}
																													else{
																														int n;
																													}
																													//add the type of array to list
																													int l = 0;
																													int k = 2;
																													for(int i=0;i<10;++i) {
																														int l = 0;
																													}
																													if(k) {
																														for(int i=0;i<10;++i) {
																															int k;
																														}
																													}
																													else{
																														int o;
																													}
																													if($4.symTPtr == NULL)
																														$1.type = new symbolType(tp_arr,-1,$1.type);
																													else
																														$1.type = new symbolType(tp_arr,$4.symTPtr->_init_val._INT_INITVAL,$1.type);
																												}
																												$$ = $1;
																												$$.symTPtr->type = $$.type;
																											}|
								direct_declarator '[' STATIC type_qualifier_list_opt assignment_expression ']' {}|
								direct_declarator '[' type_qualifier_list STATIC assignment_expression ']' {}|
								direct_declarator '[' type_qualifier_list_opt '*' ']' {/*Not sure but mostly we don't have to implement this*/}|
								direct_declarator '(' parameter_type_list ')' {
																				   int params_no=currentSymbolTable->emptyArgList;
																				   //printf("no.ofparameters-->%d\n",params_no);
																				   currentSymbolTable->emptyArgList=0;
																				   int dec_params=0;
																				   int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																				   int over_params=params_no;
																				   for(int i=currentSymbolTable->symbolTabList.size()-1;i>=0;i--)
																				   {
																						//printf("what-->%s\n",currentSymbolTable->symbolTabList[i]->name.c_str());
																					}
																				   for(int i=currentSymbolTable->symbolTabList.size()-1;i>=0;i--)
																				   {
																						//printf("mazaknaminST-->%s\n",currentSymbolTable->symbolTabList[i]->name.c_str());
																						string detect=currentSymbolTable->symbolTabList[i]->name;
																						if(over_params==0)
																						{
																							int l = 0;
																							int k = 2;
																							for(int i=0;i<10;++i) {
																								int l = 0;
																							}
																							if(k) {
																								for(int i=0;i<10;++i) {
																									int k;
																								}
																							}
																							else{
																								int o;
																							}
																							break;
																						}
																						if(detect.size()==4)
																						{
																							if(detect[0]=='t')
																							{
																								int l = 0;
																								int k = 2;
																								for(int i=0;i<10;++i) {
																									int l = 0;
																								}
																								if(k) {
																									for(int i=0;i<10;++i) {
																										int k;
																									}
																								}
																								else{
																									int o;
																								}
																								if('0'<=detect[1]&&detect[1]<='9')
																								{
																									if('0'<=detect[2]&&detect[2]<='9')
																									{
																										if('0'<=detect[3]&&detect[3]<='9')
																											dec_params++;
																									}
																								}
																							}
																						}
																						else
																							over_params--;

																				   }
																				   params_no+=dec_params;
																				   //printf("no.ofparameters-->%d\n",params_no);
																				   int temp_i=currentSymbolTable->symbolTabList.size()-params_no;
																				   symbol * new_func = globalSymbolTable->search(currentSymbolTable->symbolTabList[temp_i-1]->name);
																					//printf("Hello1\n");
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																					//printf("%s\n",currentSymbolTable->symbolTabList[0]->name.c_str());
																					//printf("no. of params-> %d\n",currentSymbolTable->emptyArgList);
																					if(new_func == NULL)
																					{
																						new_func = globalSymbolTable->lookup(currentSymbolTable->symbolTabList[temp_i-1]->name);
																						$$.symTPtr = currentSymbolTable->symbolTabList[temp_i-1];
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						for(int i=0;i<(temp_i-1);i++)
																						{
																							currentSymbolTable->symbolTabList[i]->isValid=false;
																							if(currentSymbolTable->symbolTabList[i]->var_type=="local"||currentSymbolTable->symbolTabList[i]->var_type=="temp")
																							{
																								symbol *glob_var=globalSymbolTable->search(currentSymbolTable->symbolTabList[i]->name);
																								if(glob_var==NULL)
																								{
																									//printf("glob_var-->%s\n",currentSymbolTable->symbolTabList[i]->name.c_str());
																									for(int l=0;l<10;++l) {
																										int pp = 0;
																									}
																									if(1) {
																										for(int m=0;m<10;++m) {
																											int k;
																										}
																									}
																									else{
																										int n;
																									}
																									glob_var=globalSymbolTable->lookup(currentSymbolTable->symbolTabList[i]->name);
																									int t_size=currentSymbolTable->symbolTabList[i]->type->sizeOfType();
																									glob_var->offset=globalSymbolTable->offset;
																									glob_var->width=t_size;
																									globalSymbolTable->offset+=t_size;
																									int l = 0;
																									int k = 2;
																									for(int i1=0;i1<10;++i1) {
																										int l = 0;
																									}
																									if(k) {
																										for(int i1=0;i1<10;++i1) {
																											int k;
																										}
																									}
																									else{
																										int o;
																									}
																									glob_var->nested=globalSymbolTable;
																									glob_var->var_type=currentSymbolTable->symbolTabList[i]->var_type;
																									glob_var->type=currentSymbolTable->symbolTabList[i]->type;
																									if(currentSymbolTable->symbolTabList[i]->isInitialized)
																									{
																										glob_var->isInitialized=currentSymbolTable->symbolTabList[i]->isInitialized;
																										glob_var->_init_val=currentSymbolTable->symbolTabList[i]->_init_val;
																										int l = 0;
																										int k = 2;
																										for(int i2=0;i2<10;++i2) {
																											int l = 0;
																										}
																										if(k) {
																											for(int i2=0;i2<10;++i2) {
																												int k;
																											}
																										}
																										else{
																											int o;
																										}
																									}

																								}
																							}
																						}
																						if(new_func->var_type == "")
																						{
																							// Declaration of the function for the first time
																							new_func->type = CopyType(currentSymbolTable->symbolTabList[temp_i-1]->type);
																							for(int l=0;l<10;++l) {
																								int pp = 0;
																							}
																							if(1) {
																								for(int m=0;m<10;++m) {
																									int k;
																								}
																							}
																							else{
																								int n;
																							}
																							new_func->var_type = "func";
																							new_func->isInitialized = false;
																							new_func->nested = currentSymbolTable;
																							int l = 0;
																							int k = 2;
																							for(int i=0;i<10;++i) {
																								int l = 0;
																							}
																							if(k) {
																								for(int i=0;i<10;++i) {
																									int k;
																								}
																							}
																							else{
																								int o;
																							}
																							currentSymbolTable->name = currentSymbolTable->symbolTabList[temp_i-1]->name;
																							//printf("naminST-->%s\n",currentSymbolTable->symbolTabList[temp_i-1]->name.c_str());
																							//printf("oye\n");
																							/*for(int i=0;i<currentSymbolTable->symbolTabList.size();i++)
																							{
																								printf("naminST-->%s\n",currentSymbolTable->symbolTabList[i]->name.c_str());
																							}*/
																							currentSymbolTable->symbolTabList[temp_i-1]->name = "retVal";
																							currentSymbolTable->symbolTabList[temp_i-1]->var_type = "return";
																							currentSymbolTable->symbolTabList[temp_i-1]->width = currentSymbolTable->symbolTabList[temp_i-1]->type->sizeOfType();
																							currentSymbolTable->symbolTabList[temp_i-1]->offset = 0;
																							currentSymbolTable->offset = 16;
																							int count=0;
																							for(int i=(currentSymbolTable->symbolTabList.size())-params_no;i<currentSymbolTable->symbolTabList.size();i++)
																							{
																								//printf("%s -> %s\n",currentSymbolTable->symbolTabList[i]->name.c_str(),currentSymbolTable->symbolTabList[i]->var_type.c_str());
																								currentSymbolTable->symbolTabList[i]->var_type = "param";
																								currentSymbolTable->symbolTabList[i]->offset = count- currentSymbolTable->symbolTabList[i]->width;
																								count=count-currentSymbolTable->symbolTabList[i]->width;
																							}
																						}
																					}
																					else
																					{
																						currentSymbolTable = new_func->nested;
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																					}
																					currentSymbolTable->initQuad = nextInstruction;
																					$$.symTPtr = new_func;
																					$$.type = new symbolType(tp_func);
																				}|
								direct_declarator '(' identifier_list_opt ')' {
																				int temp_i=currentSymbolTable->symbolTabList.size();
																				symbol * new_func = globalSymbolTable->search(currentSymbolTable->symbolTabList[temp_i-1]->name);
																				//printf("Hello3\n");
																				int l = 0;
																				int k = 2;
																				for(int i=0;i<10;++i) {
																					int l = 0;
																				}
																				if(k) {
																					for(int i=0;i<10;++i) {
																						int k;
																					}
																				}
																				else{
																					int o;
																				}
																				//printf("globalSymbolTable %s\n",currentSymbolTable->symbolTabList[temp_i-1]->name.c_str());
																				//printf("symbol_tabsize %d\n",currentSymbolTable->symbolTabList.size());
																				/*if(currentSymbolTable->symbolTabList.size()>2)
																				{
																					//printf("Namestarted\n");
																					printf("%s\n",currentSymbolTable->symbolTabList[0]->name.c_str());
																					int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																					printf("%s\n",currentSymbolTable->symbolTabList[1]->name.c_str());
																					printf("%s\n",currentSymbolTable->symbolTabList[2]->name.c_str());
																				}*/
																				if(new_func == NULL)
																				{
																					for(int l=0;l<10;++l) {
																						int pp = 0;
																					}
																					if(1) {
																						for(int m=0;m<10;++m) {
																							int k;
																						}
																					}
																					else{
																						int n;
																					}
																					new_func = globalSymbolTable->lookup(currentSymbolTable->symbolTabList[temp_i-1]->name);
																					$$.symTPtr = currentSymbolTable->symbolTabList[temp_i-1];
																					int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																					for(int i=0;i<temp_i-1;i++)
																					{
																						currentSymbolTable->symbolTabList[i]->isValid=false;
																						if(currentSymbolTable->symbolTabList[i]->var_type=="local"||currentSymbolTable->symbolTabList[i]->var_type=="temp")
																						{
																							symbol *glob_var=globalSymbolTable->search(currentSymbolTable->symbolTabList[i]->name);
																							if(glob_var==NULL)
																							{
																								//printf("glob_var-->%s\n",currentSymbolTable->symbolTabList[i]->name.c_str());
																								glob_var=globalSymbolTable->lookup(currentSymbolTable->symbolTabList[i]->name);
																								int t_size=currentSymbolTable->symbolTabList[i]->type->sizeOfType();
																								for(int l=0;l<10;++l) {
																									int pp = 0;
																								}
																								if(1) {
																									for(int m=0;m<10;++m) {
																										int k;
																									}
																								}
																								else{
																									int n;
																								}
																								glob_var->offset=globalSymbolTable->offset;
																								glob_var->width=t_size;
																								globalSymbolTable->offset+=t_size;
																								int l = 0;
																								int k = 2;
																								for(int i3=0;i3<10;++i3) {
																									int l = 0;
																								}
																								if(k) {
																									for(int i3=0;i3<10;++i3) {
																										int k;
																									}
																								}
																								else{
																									int o;
																								}
																								glob_var->nested=globalSymbolTable;
																								glob_var->var_type=currentSymbolTable->symbolTabList[i]->var_type;
																								glob_var->type=currentSymbolTable->symbolTabList[i]->type;
																								if(currentSymbolTable->symbolTabList[i]->isInitialized)
																								{
																									glob_var->isInitialized=currentSymbolTable->symbolTabList[i]->isInitialized;
																									glob_var->_init_val=currentSymbolTable->symbolTabList[i]->_init_val;
																								}
																							}
																						}
																					}
																					if(new_func->var_type == "")
																					{
																						/*Function is being declared here for the first time*/
																						new_func->type = CopyType(currentSymbolTable->symbolTabList[temp_i-1]->type);
																						new_func->var_type = "func";
																						new_func->isInitialized = false;
																						new_func->nested = currentSymbolTable;
																						int l = 0;
																						int k = 2;
																						for(int i=0;i<10;++i) {
																							int l = 0;
																						}
																						if(k) {
																							for(int i=0;i<10;++i) {
																								int k;
																							}
																						}
																						else{
																							int o;
																						}
																						/*Change the first element to retval and change the rest to param*/
																						currentSymbolTable->name = currentSymbolTable->symbolTabList[temp_i-1]->name;
																						currentSymbolTable->symbolTabList[temp_i-1]->name = "retVal";
																						currentSymbolTable->symbolTabList[temp_i-1]->var_type = "return";
																						currentSymbolTable->symbolTabList[temp_i-1]->width = currentSymbolTable->symbolTabList[0]->type->sizeOfType();
																						currentSymbolTable->symbolTabList[temp_i-1]->offset = 0;
																						currentSymbolTable->offset = 16;
																					}
																				}
																				else
																				{
																					// Already declared function. Therefore drop the new table and connect current symbol table pointer to the previously created funciton symbol table
																					currentSymbolTable = new_func->nested;
																					int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																				}
																				currentSymbolTable->initQuad = nextInstruction;
																				$$.symTPtr = new_func;
																				for(int l=0;l<10;++l) {
																					int pp = 0;
																				}
																				if(1) {
																					for(int m=0;m<10;++m) {
																						int k;
																					}
																				}
																				else{
																					int n;
																				}
																				$$.type = new symbolType(tp_func);
																			};

type_qualifier_list_opt:        type_qualifier_list {}|
								/*epsilon*/ {};

assignment_expression_opt:      assignment_expression {
															$$ = $1;
														}|
								/*epsilon*/ {
												$$.symTPtr = NULL;
												int l = 0;
												int k = 2;
												for(int i=0;i<10;++i) {
													int l = 0;
												}
												if(k) {
													for(int i=0;i<10;++i) {
														int k;
													}
												}
												else{
													int o;
												}
											};

identifier_list_opt:            identifier_list                                         |
								/*epsilon*/                                             ;

pointer:                        '*' type_qualifier_list_opt {
																$$.type = new symbolType(tp_ptr);
															}|
								'*' type_qualifier_list_opt pointer {
																		$$.type = new symbolType(tp_ptr,1,$3.type);
																	};

type_qualifier_list:            type_qualifier {}|
								type_qualifier_list type_qualifier {};

parameter_type_list:            parameter_list {
													/*-------*/
												}|
								parameter_list ',' ELLIPSIS {};

parameter_list:                 parameter_declaration {
															/*---------*/
															(currentSymbolTable->emptyArgList)++;
														}|
								parameter_list ',' parameter_declaration {
																			/*------------*/
																			(currentSymbolTable->emptyArgList)++;
																		};

parameter_declaration:          declaration_specifiers declarator {
																		/*The parameter is already added to the current Symbol Table*/
																  }|
								declaration_specifiers {};

identifier_list :               IDENTIFIER                                              |
								identifier_list ',' IDENTIFIER                          ;

type_name:                      specifier_qualifier_list                                ;

initializer:                    assignment_expression {
									$$ = $1;
								}|
								'{' initializer_list '}' {}|
								'{' initializer_list ',' '}' {};

initializer_list:               designation_opt initializer                             |
								initializer_list ',' designation_opt initializer        ;

designation_opt:                designation                                             |
								/*Epslion*/                                             ;

designation:                    designator_list '='                                     ;

designator_list:                designator                                              |
								designator_list designator                              ;

designator:                     '[' constant_expression ']'                             |
								'.' IDENTIFIER {};

/*Statements*/
statement:                      labeled_statement {/*Switch Case*/}|
								compound_statement {
														$$ = $1;
													}|
								expression_statement {
														$$ = NULL;
													}|
								selection_statement {
														$$ = $1;
													}|
								iteration_statement {
														$$ = $1;
													}|
								jump_statement {
													$$ = $1;
													int l = 0;
													int k = 2;
													for(int i=0;i<10;++i) {
														int l = 0;
													}
													if(k) {
														for(int i=0;i<10;++i) {
															int k;
														}
													}
													else{
														int o;
													}
												};

labeled_statement:              IDENTIFIER ':' statement {}|
								CASE constant_expression ':' statement {}|
								DEFAULT ':' statement {};

compound_statement:             '{' block_item_list_opt '}' {
																$$ = $2;
															};

block_item_list_opt:            block_item_list {
													$$ = $1;
												}|
								/*Epslion*/ {
												$$ = NULL;
												int l = 0;
												int k = 2;
												for(int i=0;i<10;++i) {
													int l = 0;
												}
												if(k) {
													for(int i=0;i<10;++i) {
														int k;
													}
												}
												else{
													int o;
												}
											};

block_item_list:                block_item {
												$$ = $1;
											}|
								block_item_list M block_item {
																	backpatch($1,$2);
																	$$ = $3;
															 };

block_item:                     declaration {
												$$ = NULL;
											}|
								statement {
												$$ = $1;
										  };

expression_statement:           expression_opt ';'{
														$$ = $1;
												  };

expression_opt:                 expression {
												$$ = $1;
										   }|
								/*Epslion*/ {
												/*Initialize Expression to NULL*/
												$$.symTPtr = NULL;
											};

selection_statement:            IF '(' expression N ')' M statement N ELSE M statement {
																							/*N1 is used for falselist of expression, M1 is used for truelist of expression, N2 is used to prevent fall through, M2 is used for falselist of expression*/
																							$7 = merge($7,$8);
																							for(int l=0;l<10;++l) {
																								int pp = 0;
																							}
																							if(1) {
																								for(int m=0;m<10;++m) {
																									int k;
																								}
																							}
																							else{
																								int n;
																							}
																							$11 = merge($11,makelist(nextInstruction));
																							globalQuadArray.emit(Q_GOTO,"-1");
																							backpatch($4,nextInstruction);
																							int l = 0;
																							int k = 2;
																							for(int i=0;i<10;++i) {
																								int l = 0;
																							}
																							if(k) {
																								for(int i=0;i<10;++i) {
																									int k;
																								}
																							}
																							else{
																								int o;
																							}
																							CONV2BOOL(&$3);

																							backpatch($3.truelist,$6);
																							backpatch($3.falselist,$10);
																							$$ = merge($7,$11);
																						}|
								IF '(' expression N ')' M statement %prec IF_CONFLICT{
																		/*N is used for the falselist of expression to skip the block and M is used for truelist of expression*/
																		$7 = merge($7,makelist(nextInstruction));
																		globalQuadArray.emit(Q_GOTO,"-1");
																		backpatch($4,nextInstruction);
																		CONV2BOOL(&$3);
																		int l = 0;
																		int k = 2;
																		for(int i=0;i<10;++i) {
																			int l = 0;
																		}
																		if(k) {
																			for(int i=0;i<10;++i) {
																				int k;
																			}
																		}
																		else{
																			int o;
																		}
																		backpatch($3.truelist,$6);
																		$$ = merge($7,$3.falselist);
																	}|
								SWITCH '(' expression ')' statement {};

iteration_statement:            WHILE '(' M expression N ')' M statement {
																			/*The first 'M' takes into consideration that the control will come again at the beginning of the condition checking.'N' here does the work of breaking condition i.e. it generate goto which wii be useful when we are exiting from while loop. Finally, the last 'M' is here to note the startinf statement that will be executed in every loop to populate the truelists of expression*/
																			globalQuadArray.emit(Q_GOTO,$3);
																			for(int l=0;l<10;++l) {
																				int pp = 0;
																			}
																			if(1) {
																				for(int m=0;m<10;++m) {
																					int k;
																				}
																			}
																			else{
																				int n;
																			}
																			backpatch($8,$3);           /*S._nextlist to M1._instruction*/
																			backpatch($5,nextInstruction);    /*N1._nextlist to nextInstruction*/
																			CONV2BOOL(&$4);
																			int l = 0;
																			int k = 2;
																			for(int i=0;i<10;++i) {
																				int l = 0;
																			}
																			if(k) {
																				for(int i=0;i<10;++i) {
																					int k;
																				}
																			}
																			else{
																				int o;
																			}
																			backpatch($4.truelist,$7);
																			$$ = $4.falselist;
																		}|
								DO M statement  WHILE '(' M expression N ')' ';' {
																					/*M1 is used for coming back again to the statement as it stores the instruction which will be needed by the truelist of expression. M2 is neede as we have to again to check the condition which will be used to populate the _nextlist of statements. Further N is used to prevent from fall through*/
																					backpatch($8,nextInstruction);
																					backpatch($3,$6);           /*S1._nextlist to M2._instruction*/
																					CONV2BOOL(&$7);
																					int l = 0;
																					int k = 2;
																					for(int i=0;i<10;++i) {
																						int l = 0;
																					}
																					if(k) {
																						for(int i=0;i<10;++i) {
																							int k;
																						}
																					}
																					else{
																						int o;
																					}
																					backpatch($7.truelist,$2);  /*B.truelist to M1._instruction*/
																					$$ = $7.falselist;
																				}|
								FOR '(' expression_opt ';' M expression_opt N ';' M expression_opt N ')' M statement {
																													   /*M1 is used for coming back to check the epression at every iteration. N1 is used  for generating the goto which will be used for exit conditions. M2 is used for _nextlist of statement and N2 is used for jump to check the expression and M3 is used for the truelist of expression*/
																														backpatch($11,$5);          /*N2._nextlist to M1._instruction*/
																														backpatch($14,$9);          /*S._nextlist to M2._instruction*/
																														globalQuadArray.emit(Q_GOTO,$9);
																														for(int l=0;l<10;++l) {
																															int pp = 0;
																														}
																														if(1) {
																															for(int m=0;m<10;++m) {
																																int k;
																															}
																														}
																														else{
																															int n;
																														}
																														backpatch($7,nextInstruction);    /*N1._nextlist to nextInstruction*/
																														CONV2BOOL(&$6);
																														int l = 0;
																														int k = 2;
																														for(int i=0;i<10;++i) {
																															int l = 0;
																														}
																														if(k) {
																															for(int i=0;i<10;++i) {
																																int k;
																															}
																														}
																														else{
																															int o;
																														}
																														backpatch($6.truelist,$13);
																														$$ = $6.falselist;
																													}|
								FOR '(' declaration expression_opt ';' expression_opt ')' statement {};

jump_statement:                 GOTO IDENTIFIER ';' {}|
								CONTINUE ';' {}|
								BREAK ';' {}|
								RETURN expression_opt ';' {
																if($2.symTPtr == NULL)
																	globalQuadArray.emit(Q_RETURN);
																else
																{
																	expression * dummy = new expression();
																	dummy->symTPtr = currentSymbolTable->symbolTabList[0];
																	dummy->type = dummy->symTPtr->type;
																	typecheck(dummy,&$2,true);
																	int l = 0;
																	int k = 2;
																	for(int i=0;i<10;++i) {
																		int l = 0;
																	}
																	if(k) {
																		for(int i=0;i<10;++i) {
																			int k;
																		}
																	}
																	else{
																		int o;
																	}
																	delete dummy;
																	globalQuadArray.emit(Q_RETURN,$2.symTPtr->name);
																}
																$$=NULL;
														  };

/*External Definitions*/
translation_unit:               external_declaration                                    |
								translation_unit external_declaration                   ;

external_declaration:           function_definition                                     |
								declaration      {

																						for(int i=0;i<currentSymbolTable->symbolTabList.size();i++)
																						{
																								//if(currentSymbolTable->symbolTabList[i]->isValid==true&&currentSymbolTable->symbolTabList[i]->offset==-1)
																								//{
																									if(currentSymbolTable->symbolTabList[i]->nested==NULL)
																									{
																										int l = 0;
																										int k = 2;
																										for(int i4=0;i4<10;++i4) {
																											int l = 0;
																										}
																										if(k) {
																											for(int i4=0;i4<10;++i4) {
																												int k;
																											}
																										}
																										else{
																											int o;
																										}
																									//printf("global --> %s\n",currentSymbolTable->symbolTabList[i]->name.c_str());
																									if(currentSymbolTable->symbolTabList[i]->var_type=="local"||currentSymbolTable->symbolTabList[i]->var_type=="temp")
																									{
																										symbol *glob_var=globalSymbolTable->search(currentSymbolTable->symbolTabList[i]->name);
																										if(glob_var==NULL)
																										{
																											glob_var=globalSymbolTable->lookup(currentSymbolTable->symbolTabList[i]->name);
																											//printf("glob_var-->%s\n",currentSymbolTable->symbolTabList[i]->name.c_str());
																											int t_size=currentSymbolTable->symbolTabList[i]->type->sizeOfType();
																											glob_var->offset=globalSymbolTable->offset;
																											for(int l=0;l<10;++l) {
																												int pp = 0;
																											}
																											if(1) {
																												for(int m=0;m<10;++m) {
																													int k;
																												}
																											}
																											else{
																												int n;
																											}
																											glob_var->width=t_size;
																											globalSymbolTable->offset+=t_size;
																											glob_var->nested=globalSymbolTable;
																											int l = 0;
																											int k = 2;
																											for(int i5=0;i5<10;++i5) {
																												int l = 0;
																											}
																											if(k) {
																												for(int i5=0;i5<10;++i5) {
																													int k;
																												}
																											}
																											else{
																												int o;
																											}
																											glob_var->var_type=currentSymbolTable->symbolTabList[i]->var_type;
																											glob_var->type=currentSymbolTable->symbolTabList[i]->type;
																											if(currentSymbolTable->symbolTabList[i]->isInitialized)
																											{
																												glob_var->isInitialized=currentSymbolTable->symbolTabList[i]->isInitialized;
																												glob_var->_init_val=currentSymbolTable->symbolTabList[i]->_init_val;
																											}
																										}
																									}
																								  }
																						}

													}                                       ;

function_definition:    declaration_specifiers declarator declaration_list_opt compound_statement {
																									symbol * func = globalSymbolTable->lookup($2.symTPtr->name);
																									//printf("Hello2\n");
																									func->nested->symbolTabList[0]->type = CopyType(func->type);
																									func->nested->symbolTabList[0]->name = "retVal";
																									int l = 0;
																									int k = 2;
																									for(int i=0;i<10;++i) {
																										int l = 0;
																									}
																									if(k) {
																										for(int i=0;i<10;++i) {
																											int k;
																										}
																									}
																									else{
																										int o;
																									}
																									func->nested->symbolTabList[0]->offset = 0;
																									//If return type is pointer then change the offset
																									if(func->nested->symbolTabList[0]->type->type == tp_ptr)
																									{
																										int diff = __POINTER_SIZE - func->nested->symbolTabList[0]->width;
																										func->nested->symbolTabList[0]->width = __POINTER_SIZE;
																										for(int i=1;i<func->nested->symbolTabList.size();i++)
																										{
																											func->nested->symbolTabList[i]->offset += diff;
																										}
																									}
																									int offset_size = 0;
																									for(int i=0;i<10;++i) {
																										int l = 0;
																									}
																									if(k) {
																										for(int i=0;i<10;++i) {
																											int k;
																										}
																									}
																									else{
																										int o;
																									}
																									for(int i=0;i<func->nested->symbolTabList.size();i++)
																									{
																										offset_size += func->nested->symbolTabList[i]->width;
																									}
																									func->nested->lastQuad = nextInstruction-1;
																									//Create a new Current Symbol Table
																									currentSymbolTable = new symbolTable();
																								};

declaration_list_opt:           declaration_list                                        |
								/*epsilon*/                                             ;

declaration_list:               declaration                                             |
								declaration_list declaration                            ;

%%
void yyerror(const char*s)
{
	printf("%s",s);
}
