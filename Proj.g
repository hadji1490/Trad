grammar Proj;

@header {
}

@members {
}

PROGRAM : CLASS_DECL* VAR_DECL* INSTRUCTION+ ;
CLASS_ITEM_DECL : VAR_DECL* METHOD_DECL*;
CLASS_DECL : 'class' IDF_CLASSE '[' 'inherit' IDF_CLASSE ']' '=' '('CLASS_ITEM_DECL')';
VAR_DECL : 'var' idf ':' TYPE';';
TYPE : IDF_CLASSE 
     | 'int' 
     | 'string';        
METHOD_DECL : 'method' idf '('METHOD_ARGS* ')''{' VAR_DECL*INSTRUCTION+'}'
	    | 'method' idf '('METHOD_ARGS*')' ':' TYPE '{' VAR_DECL*INSTRUCTION+'}';
METHOD_AGRS : idf ':' TYPE '{'',' idf ':' TYPE'}'*;
INSTRUCTION : idf ':=' EXPRESSION ';'
	    | idf ':=' 'nil' ';'
	    | 'if' EXPRESSION 'then' INSTRUCTION ['else' INSTRUCTION] 'fi'
	    | 'for' idf 'in' EXPRESSION '..' EXPRESSION 'do' INSTRUCTION+ 'end'
	    | '{' VAR_DECL* INSTRUCTION+ '}'
	    | 'do' EXPRESSION '.' idf '(' EXPRESSION '{' ',' EXPRESSION '}'*')'';'
	    | PRINT
	    | READ
	    | RETURN;
idf : ('a'..'z') ('a'..'z'|'_'|'A'..'Z'|'0'..'9')* ; 
PRINT       : 'write' EXPRESSION';'
	    | 'write' cste_chaine';';
READ 	    : 'read' idf ';';
RETURN      : 'return (' EXPRESSION ')'';';
EXPRESSION  : idf
            | 'this'
            | 'super'
            |  cste_ent
            | 'new' IDF_CLASSE
            | EXPRESSION '.' idf '(' EXPRESSION '{' ',' EXPRESSION '}' * ')'
            | '(' EXPRESSION ')'
            | '-' EXPRESSION
            | EXPRESSION OPER EXPRESSION;
OPER        : '+'
	    | '-'
	    | '*'
	    | '<'
	    | '<='
	    | '>'
	    | '>='
	    | '=='
	    | '!=';

IDF_CLASSE :  ('A'..'Z') ('a'..'z'|'_'|'A'..'Z')* ;
cste_ent : '0'..'9'+ ;
cste_chaine :  '"' ( . )+  '"' ;
