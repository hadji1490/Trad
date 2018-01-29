grammar Proj;

options {
	
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

class_decl	: 'class' IDFC ('inherit' IDFC)? '=' '(' class_item_decl ')' ;

class_item_decl	 : (var_decl* method_decl*);

var_decl	: 'var' IDF':' type (',' 'var' IDF':' type)* ';';

type		: IDFC 
		| 'int' 
		| 'string';

method_decl	: 'method' IDF'(' method_args* ')' (':' type)? '{' var_decl* instruction+ '}';

method_args	: IDF':' type (',' IDF':' type)*;

instruction	: IDF':=' instruction_IDF
		| 'if' expression 'then' instruction ('else' instruction)? 'fi' 
		| 'for' IDF'in' expression '..' expression 'do' instruction 'end' 
		| '{' var_decl* instruction+ '}' 
		| 'do' expression ';' 
		| print
		| read
		| returnrule
		;

instruction_IDF	: expression ';'!
		| 'nil' ';' ;

print		: 'write' expression ';' ;

read		: 'read' IDF';';

returnrule	: 'return' '(' expression ')' ';';

expression_args	: expression (',' expression)* ; 

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
		| '(' expression ')' 
		;


IDFC : ('A'..'Z')('a'..'z'|'A'..'Z'|'0'..'9'|'_')* ;
IDF: ('a'..'z')('a'..'z'|'A'..'Z'|'0'..'9'|'_')* ;
CSTE_CHAINE: ('"').+('"');
CSTE_ENT: '0'..'9'+ ;
WS : (' '|'\n'|'\t'| ('/*').*('*/') )+ {$channel=HIDDEN;} ;

