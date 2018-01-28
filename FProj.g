grammar Proj;

options {
	k = 1;
	backtrack = false;
	output = AST;
}

tokens {

    	PROGRAM;
    	CLASS_DECL;
	CLASS_ITEM_DECL;
	VAR_DECLARATION;
	METHOD_DECLARATION;
	METHOD_PARAMETRE;
	PRINT;
	READ;
	RETURNRULE;
	DO;
	BLOC_INSTRUCTION;
	BOUCLE;
	INSTRUCTION_TEST;
	VAR_AFFECTATION;
	VOID;
	ARGUMENT;
	BLOC_DECL_VAR;
	BLOC_DECL_CLASS;
	BLOC_DECLARATION_METHOD;
	DO_BLOC_INSTRUCTION;
	
}

@header {
}

@members {
}

program		: (class_decl)* (var_decl)* (instruction)+ ;

class_decl	: 'class' IDFC ('inherit' IDFC)? '=' '(' class_item_decl ')' -> ^(CLASS_DECL  IDFC IDFC? class_item_decl*);

class_item_decl	 : (var_decl* method_decl*) -> ^(CLASS_ITEM_DECL var_decl* method_decl*);

var_decl	: 'var' IDF':' type (',' 'var' IDF':' type)* ';' -> ^(VAR_DECLARATION IDF type)+;

type		: IDFC 
		| 'int' 
		| 'string';

method_decl	: 'method' IDF'(' method_args* ')' (':' type)? '{' var_decl* instruction+ '}' 
		-> ^(METHOD_DECLARATION IDF method_args* type? ^(BLOC_DECL_VAR var_decl*)?  ^(BLOC_INSTRUCTION instruction+))
		;

method_args	: IDF':' type (',' IDF':' type)*
		-> ^(METHOD_PARAMETRE (IDF type)*)
		;

instruction	: IDF':=' instruction_IDF-> ^(VAR_AFFECTATION IDF instruction_IDF)
		| 'if' expression 'then' instruction ('else' instruction)? 'fi' -> ^(INSTRUCTION_TEST expression instruction instruction?)
		| 'for' IDF'in' expression '..' expression 'do' instruction 'end' -> ^(BOUCLE IDF expression expression instruction)
		| '{' var_decl* instruction+ '}' -> ^(DO_BLOC_INSTRUCTION var_decl* instruction+)
		| 'do' expression ';' -> ^(DO expression)
		| print
		| read
		| returnrule
		;

instruction_IDF	: expression ';'!
		| 'nil' ';' -> ^('nil')
		;

print		: 'write' expression ';' -> ^(PRINT expression);

read		: 'read' IDF';' -> ^(READ IDF);

returnrule	: 'return' '(' expression ')' ';' -> ^(RETURNRULE expression);

expression_args	: expression (',' expression)* -> ^(ARGUMENT expression*); 

expression		: expr_asso ; 
expr_asso	        : exprm  ( ('-'|'+')^ exprm )* ;
exprm           	: expr_oper ( ('*'|'/')^ expr_oper)*;
expr_oper	        : expr_less ( ('<'|'>'|'<='|'>='|'=='|'!=')^ expr_less)*;
expr_less	: '-'^ expr_less
		| expr_end
		;
		
expr_end	: expr_F ('.'^ IDF'('! expression_args ')'! )*;

expr_F	: IDF
		| 'this'
		| 'super'
		| CSTE_ENT
		| CSTE_CHAINE
		| 'new' IDFC ->^(IDFC)
		| '(' expression ')' -> expression
		;


IDFC : ('A'..'Z')('a'..'z'|'A'..'Z'|'0'..'9'|'_')* ;
IDF: ('a'..'z')('a'..'z'|'A'..'Z'|'0'..'9'|'_')* ;
CSTE_CHAINE: ('"').+('"');
CSTE_ENT: '0'..'9'+ ;
WS : (' '|'\n'|'\t'| ('/*').*('*/') )+ {$channel=HIDDEN;} ;

