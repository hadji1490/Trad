grammar Proj;


options {

    backtrack = false;
    

}
tokens {
    METHOD_DECLARATION='METHOD_DECLARATION' ;
    METHOD_BODY='METHOD_BODY';
    METHOD_PARAMETER ='METHOD_PARAMETER';
    VAR_DECLARATION = 'VAR_DECLARATION';
    AFFECTATION = 'AFFECTATION';
    CONSTRUCTOR = 'CONSTRUCTOR';
    SCOPE = 'SCOPE';
    PROGRAM = 'PROGRAM';
    CLASS_VAR_DECL = 'CLASS_VAR_DECL';
    CLASS_METHOD_DECL = 'CLASS_METHOD_DECL';
    CLASS_ITEM_DECL = 'CLASS_ITEM_DECL';
    EXPRESSION_END = 'EXPRESSION_END';
    END_EXPRESSION_END = 'END_EXPRESSION_END';
    BLOCK_INSTRUCTION = 'BLOCK_INSTRUCTION';
    DO_BLOCK_INSTRUCTION = 'DO_BLOCK_INSTRUCTION';
    FUNCTION = 'FUNCTION';
    POINT = 'POINT';
    FUNCTION_CALL_INSTRUCTION ='FUNCTION_CALL_INSTRUCTION';
    FUNCTION_ARGUMENTS_INSTRUCTION = 'FUNCTION_ARGUMENTS_INSTRUCTION';
    CLASS_DECL = 'CLASS_DECL';
}
@header {
}

@members {
}

program : (class_decl)* (var_decl)* (instruction)+ ;

class_decl : 'class' IDF ('inherit' IDF)? '=' '(' class_item_decl ')';

class_item_decl : (var_decl)* (method_decl)*;

var_decl : 'var' IDF ':' type';';

type 	    : IDF | 'int' | 'string'; 

method_decl : 'method' IDF '('method_args ')'  ( ':' type )? '{' body '}';

body        :    var_decl*  instruction+;

method_args : (parameter (','parameter)*   )?;

parameter  : IDF ':' type;

instruction : IDF ':=' expression   ';'

	    | 'if' expression 'then' instruction elserule? 'fi'
	    | 'for' incrementing 'do' instruction+ 'end'       
	    | '{' var_decl* instruction+ '}'			
	    | 'do' expression '.'IDF '('expression*')'';'
	    | print
	    | read
	    | returnrule;
	    
elserule : 'else' instruction 	;

incrementing : IDF 'in' expression '..' expression;

print       : 'write' expression';'
	    | 'write' CSTE_CHAINE ';';
	    
read	    : 'read' IDF ';';

returnrule  : 'return' '(' expression ')'';';

expression  : IDF
            | 'this'
            | 'super'
            |  CSTE_ENT
            |  new_var
            |  '.' IDF '(' expression? end_expr_end ')'
            |  '(' expression ')' 
            ;


end_expr_end : ',' expression ;

new_var	    : 'new' IDF;
            



expr        : expr_asso (('+'|'-') expr_asso)*;
          
expr_asso   : exprm (('*'|'/') exprm)*;

exprm 	    : IDF
            | CSTE_ENT
            ;
oper	    :   
     	    | '<'
            | '<='
            | '>'
            | '>='
            | '=='
            | '!=';
            
IDF : ('a' .. 'z' | 'A' .. 'Z')('a' .. 'z' | 'A' .. 'Z' | '0' .. '9')*;

CSTE_ENT : '0'..'9'+ ;

CSTE_CHAINE  :  '"' ( . )+  '"' ;

WS           : (' '|'\t')+  {$channel=HIDDEN;};

COMMENT      :   '//' ~('\n'|'\r')* ('\r'? '\n') {$channel=HIDDEN;}

             |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;};
