grammar Proj;

@header {
}

@members {
}

program : (class_decl)* (var_decl)* (instruction)+ ;
class_item_decl : (var_decl)* (method_decl)*;
class_decl : 'class' IDCLASS'[' 'inherit' IDCLASS']' '=' '('class_item_decl')';
var_decl : 'var' IDF ':' type';';
type : IDCLASS
     | 'int' 
     | 'string';        
method_decl  : 'method' IDF '('method_args* ')''{' var_decl*instruction+'}'
	    | 'method' IDF '('method_args*')' ':' type '{' var_decl*instruction+'}';
method_args : IDF ':' type '{'',' IDF':' type'}'*;
instruction : IDF ':=' expression ';'
	    | IDF ':=' 'nil' ';'
	    | 'if' expression 'then' instruction ['else' instruction] 'fi'
	    | 'for' IDF 'in' expression '..' expression 'do' instruction+ 'end'
	    | '{' var_decl* instruction+ '}'
	    | 'do' expression '.' IDF '(' expression '{' ',' expression '}'*')'';'
	    | print
	    | read
	    | returnrule;

print       : 'write' expression';'
	    | 'write' CSTE_CHAINE ';';
read	    : 'read' IDF ';';
returnrule  : 'return' '(' expression ')'';';
expression  : IDF
            | 'this'
            | 'super'
            |  CSTE_ENT
            | 'new' IDCLASS
            | expression '.' IDF '(' expression '{' ',' expression '}' * ')'
            | '(' expression ')'
            | '-' expression
            | expression oper expression;
oper	      :   
     	      | '<'
            | '<='
            | '>'
            | '>='
            | '=='
            | '!=';
expr : expr (('+'|'-') expr)*;
exprm : exprm (('*'|'/') exprm)*;
IDF : ('a' .. 'z' | 'A' .. 'Z')('a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '-')*;
IDCLASS : ('A'..'Z') ('a'..'z'|'_'|'A'..'Z')* ; 
CSTE_ENT : '0'..'9'+ ;
CSTE_CHAINE  :  '"' ( . )+  '"' ;
WS : (' '|'\t')+  {$channel=HIDDEN;};
CST_INT : '-'?('0' .. '9')+;
