grammar Proj;


options {

    backtrack = false;
    output = AST;

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

class_decl : 'class' IDCLASS ('inherit' IDCLASS)? '=' '(' (class_item_decl) ')'    -> ^(CLASS_DECL^(IDCLASS (^('inherit' IDCLASS))? class_item_decl));

class_item_decl : (var_decl)* (method_decl)*					-> ^(CLASS_ITEM_DECL var_decl* method_decl*);

var_decl : 'var' IDF ':' type';'						-> ^(VAR_DECLARATION IDF type);

type 	    : IDCLASS | 'int' | 'string'; 

method_decl : 'method' IDF '('method_args ')'  ( ':' type )? '{' body '}'       -> ^(METHOD_DECLARATION IDF method_args type? body);

body        :    var_decl*  instruction+				        -> ^(METHOD_BODY var_decl* instruction+ );

method_args : (parameter (','parameter)*   )?				         -> ^(METHOD_PARAMETER (parameter parameter *)?);

parameter  : IDF ':' type 						        -> ^(type IDF );

instruction : IDF ':=' (expression | 'nil' ) ';'	                        -> ^(AFFECTATION IDF expression? 'nil'?)

	    | 'if' expression 'then' instruction elserule? 'fi'              -> ^('if' expression instruction elserule?)
	    | 'for' incrementing 'do' instruction+ 'end'                        	^('for' expression incrementing instruction+)
	    | '{' var_decl* instruction+ '}'						-> ^(BLOCK_INSTRUCTION var_decl instruction)
	    | 'do' expr_end';'
	    | print
	    | read
	    | returnrule;
	    
elserule : 'else' instruction 							->^('else' instruction);

incrementing : IDF 'in' expression '..' expression  				-> ^(IDF expression expression);

print       : 'write' expression';' 						-> ^('write' expression)
	    | 'write' CSTE_CHAINE ';'						-> ^('write' CSTE_CHAINE);
	    
read	    : 'read' IDF ';'							-> ^('read' IDF);

returnrule  : 'return' '(' expression ')'';' 					-> ^('return' expression);

expression  : (IDF
            | 'this'
            | 'super'
            |  CSTE_ENT
            |  new_var
            |  expr_end*
            |  expr_p 
            )  expr_less				-> ^(FUNCTION_CALL_INSTRUCTION IDF? 'this'? 'super'? CSTE_ENT? new_var? expr_p?  expr_end*);

expr_end : '.' IDF '(' expression? end_expr_end* ')'    -> ^(FUNCTION IDF ^(FUNCTION_ARGUMENTS_INSTRUCTION expression? end_expr_end*));

end_expr_end : ',' expression 							-> ^(expression); 

new_var	    : 'new' IDCLASS 							-> ^('new' IDCLASS);
            
expr_p      : '(' expression ')'						-> ^(expression);  

expr_less   : '-' expression							-> ^(expression);

expr        : expr_asso (('+'|'-') expr_asso)*;
          
expr_asso   : exprm (('*'|'/') exprm)*;

exprm       : atom ('-' atom);

atom        : '-' atom;
oper	    :   
     	    | '<'
            | '<='
            | '>'
            | '>='
            | '=='
            | '!=';
            
IDF : ('a' .. 'z' | 'A' .. 'Z')('a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '-')*;

IDCLASS : ('A'..'Z') ('a'..'z'|'_'|'A'..'Z')* ; 

CSTE_ENT : '0'..'9'+ ;

CSTE_CHAINE  :  '"' ( . )+  '"' ;

WS           : (' '|'\t')+  {$channel=HIDDEN;};

COMMENT      :   '//' ~('\n'|'\r')* ('\r'? '\n') {$channel=HIDDEN;}

             |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;};
