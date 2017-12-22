// $ANTLR 3.0 T.g 2017-12-21 21:49:08

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class TParser extends Parser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "ID", "WS", "'call'", "';'"
    };
    public static final int ID=4;
    public static final int WS=5;
    public static final int EOF=-1;

        public TParser(TokenStream input) {
            super(input);
        }
        

    public String[] getTokenNames() { return tokenNames; }
    public String getGrammarFileName() { return "T.g"; }



    // $ANTLR start r
    // T.g:2:1: r : 'call' ID ';' ;
    public final void r() throws RecognitionException {
        Token ID1=null;

        try {
            // T.g:3:5: ( 'call' ID ';' )
            // T.g:3:5: 'call' ID ';'
            {
            match(input,6,FOLLOW_6_in_r11); 
            ID1=(Token)input.LT(1);
            match(input,ID,FOLLOW_ID_in_r13); 
            match(input,7,FOLLOW_7_in_r15); 
            System.out.println("invoke "+ID1.getText());

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end r


 

    public static final BitSet FOLLOW_6_in_r11 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_ID_in_r13 = new BitSet(new long[]{0x0000000000000080L});
    public static final BitSet FOLLOW_7_in_r15 = new BitSet(new long[]{0x0000000000000002L});

}