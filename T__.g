lexer grammar T;

T6 : 'call' ;
T7 : ';' ;

// $ANTLR src "T.g" 4
ID: 'a'..'z'+ ;
// $ANTLR src "T.g" 5
WS: (' '|'\n'|'\r')+   {$channel=HIDDEN;} ; // ignore whitespace
