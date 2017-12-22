// $ANTLR 3.0 T.g 2017-12-21 21:49:08

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class TLexer extends Lexer {
    public static final int T6=6;
    public static final int T7=7;
    public static final int ID=4;
    public static final int WS=5;
    public static final int EOF=-1;
    public static final int Tokens=8;
    public TLexer() {;} 
    public TLexer(CharStream input) {
        super(input);
    }
    public String getGrammarFileName() { return "T.g"; }

    // $ANTLR start T6
    public final void mT6() throws RecognitionException {
        try {
            int _type = T6;
            // T.g:3:6: ( 'call' )
            // T.g:3:6: 'call'
            {
            match("call"); 


            }

            this.type = _type;
        }
        finally {
        }
    }
    // $ANTLR end T6

    // $ANTLR start T7
    public final void mT7() throws RecognitionException {
        try {
            int _type = T7;
            // T.g:4:6: ( ';' )
            // T.g:4:6: ';'
            {
            match(';'); 

            }

            this.type = _type;
        }
        finally {
        }
    }
    // $ANTLR end T7

    // $ANTLR start ID
    public final void mID() throws RecognitionException {
        try {
            int _type = ID;
            // T.g:4:5: ( ( 'a' .. 'z' )+ )
            // T.g:4:5: ( 'a' .. 'z' )+
            {
            // T.g:4:5: ( 'a' .. 'z' )+
            int cnt1=0;
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( ((LA1_0>='a' && LA1_0<='z')) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // T.g:4:5: 'a' .. 'z'
            	    {
            	    matchRange('a','z'); 

            	    }
            	    break;

            	default :
            	    if ( cnt1 >= 1 ) break loop1;
                        EarlyExitException eee =
                            new EarlyExitException(1, input);
                        throw eee;
                }
                cnt1++;
            } while (true);


            }

            this.type = _type;
        }
        finally {
        }
    }
    // $ANTLR end ID

    // $ANTLR start WS
    public final void mWS() throws RecognitionException {
        try {
            int _type = WS;
            // T.g:5:5: ( ( ' ' | '\\n' | '\\r' )+ )
            // T.g:5:5: ( ' ' | '\\n' | '\\r' )+
            {
            // T.g:5:5: ( ' ' | '\\n' | '\\r' )+
            int cnt2=0;
            loop2:
            do {
                int alt2=2;
                int LA2_0 = input.LA(1);

                if ( (LA2_0=='\n'||LA2_0=='\r'||LA2_0==' ') ) {
                    alt2=1;
                }


                switch (alt2) {
            	case 1 :
            	    // T.g:
            	    {
            	    if ( input.LA(1)=='\n'||input.LA(1)=='\r'||input.LA(1)==' ' ) {
            	        input.consume();

            	    }
            	    else {
            	        MismatchedSetException mse =
            	            new MismatchedSetException(null,input);
            	        recover(mse);    throw mse;
            	    }


            	    }
            	    break;

            	default :
            	    if ( cnt2 >= 1 ) break loop2;
                        EarlyExitException eee =
                            new EarlyExitException(2, input);
                        throw eee;
                }
                cnt2++;
            } while (true);

            channel=HIDDEN;

            }

            this.type = _type;
        }
        finally {
        }
    }
    // $ANTLR end WS

    public void mTokens() throws RecognitionException {
        // T.g:1:10: ( T6 | T7 | ID | WS )
        int alt3=4;
        switch ( input.LA(1) ) {
        case 'c':
            {
            int LA3_1 = input.LA(2);

            if ( (LA3_1=='a') ) {
                int LA3_5 = input.LA(3);

                if ( (LA3_5=='l') ) {
                    int LA3_6 = input.LA(4);

                    if ( (LA3_6=='l') ) {
                        int LA3_7 = input.LA(5);

                        if ( ((LA3_7>='a' && LA3_7<='z')) ) {
                            alt3=3;
                        }
                        else {
                            alt3=1;}
                    }
                    else {
                        alt3=3;}
                }
                else {
                    alt3=3;}
            }
            else {
                alt3=3;}
            }
            break;
        case ';':
            {
            alt3=2;
            }
            break;
        case 'a':
        case 'b':
        case 'd':
        case 'e':
        case 'f':
        case 'g':
        case 'h':
        case 'i':
        case 'j':
        case 'k':
        case 'l':
        case 'm':
        case 'n':
        case 'o':
        case 'p':
        case 'q':
        case 'r':
        case 's':
        case 't':
        case 'u':
        case 'v':
        case 'w':
        case 'x':
        case 'y':
        case 'z':
            {
            alt3=3;
            }
            break;
        case '\n':
        case '\r':
        case ' ':
            {
            alt3=4;
            }
            break;
        default:
            NoViableAltException nvae =
                new NoViableAltException("1:1: Tokens : ( T6 | T7 | ID | WS );", 3, 0, input);

            throw nvae;
        }

        switch (alt3) {
            case 1 :
                // T.g:1:10: T6
                {
                mT6(); 

                }
                break;
            case 2 :
                // T.g:1:13: T7
                {
                mT7(); 

                }
                break;
            case 3 :
                // T.g:1:16: ID
                {
                mID(); 

                }
                break;
            case 4 :
                // T.g:1:19: WS
                {
                mWS(); 

                }
                break;

        }

    }


 

}