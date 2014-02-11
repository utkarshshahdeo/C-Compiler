%{
int num_line=1;
%}
ID [A-Za-z_][A-Za-z0-9_]*

%%


"signed" {printf("%d %s\n",num_line,yytext); return SIGNED;}
"double" {printf("%d %s\n",num_line,yytext); return DOUBLE;}
"sizeof" {printf("%d %s\n",num_line,yytext); return SIZEOF;}
"static" {printf("%d %s\n",num_line,yytext); return STATIC;}
"struct" {printf("%d %s\n",num_line,yytext); return STRUCT;}
"auto" {printf("%d %s\n",num_line,yytext); return AUTO;}
"break" {printf("%d %s\n",num_line,yytext); return BREAK;}
"case" {printf("%d %s\n",num_line,yytext); return CASE;}
"char" {printf("%d %s\n",num_line,yytext); return CHAR;}
"const" {printf("%d %s\n",num_line,yytext); return CONST;}
"continue" {printf("%d %s\n",num_line,yytext); return CONTINUE;}
"default" {printf("%d %s\n",num_line,yytext); return DEFAULT;}
"do" {printf("%d %s\n",num_line,yytext); return DO;}
"else" {printf("%d %s\n",num_line,yytext); return ELSE;}
"enum" {printf("%d %s\n",num_line,yytext); return ENUM;}
"extern" {printf("%d %s\n",num_line,yytext); return EXTERN;}
"float" {printf("%d %s\n",num_line,yytext); return FLOAT;}
"for" {printf("%d %s\n",num_line,yytext); return FOR;}
"goto" {printf("%d %s\n",num_line,yytext); return GOTO;}
"if" {printf("%d %s\n",num_line,yytext); return IF;}
"int" {printf("%d %s\n",num_line,yytext); return INT;}
"long" {printf("%d %s\n",num_line,yytext); return LONG;}
"register" {printf("%d %s\n",num_line,yytext); return REGISTER;}
"return" {printf("%d %s\n",num_line,yytext); return RETURN;}
"short" {printf("%d %s\n",num_line,yytext); return SHORT;}
"switch" {printf("%d %s\n",num_line,yytext); return SWITCH;}
"typedef" {printf("%d %s\n",num_line,yytext); return TYPEDEF;}
"union" {printf("%d %s\n",num_line,yytext); return UNION;}
"unsigned" {printf("%d %s\n",num_line,yytext); return UNSIGNED;}
"void" {printf("%d %s\n",num_line,yytext); return VOID;}
"volatile" {printf("%d %s\n",num_line,yytext); return VOLATILE;}
"while" {printf("%d %s\n",num_line,yytext); return WHILE;}
"\n" {num_line++;}
"=" {printf("%d %s\n",num_line,yytext); return ASSIGN_OPERATOR;}
"+" {printf("%d %s\n",num_line,yytext); return ADDITION_OPERATOR;}
"-" {printf("%d %s\n",num_line,yytext); return SUBTRACTION_OPERATOR;}
"*" {printf("%d %s\n",num_line,yytext); return MULTIPLICATION_OPERATOR;}
"/" {printf("%d %s\n",num_line,yytext); return DIVISION_OPERATOR;}
"%" {printf("%d %s\n",num_line,yytext); return MODULO_OPERATOR;}
"++" {printf("%d %s\n",num_line,yytext); return INCREMENT_OPERATOR;}
"--" {printf("%d %s\n",num_line,yytext); return DECREMENT_OPERATOR;}
"==" {printf("%d %s\n",num_line,yytext); return EQUAL_TO_OPERATOR;}
"!=" {printf("%d %s\n",num_line,yytext); return NOT_ASSIGNMENT_OPERATOR;}
">" {printf("%d %s\n",num_line,yytext); return GREATER_THAN_OPERATOR;}
"<" {printf("%d %s\n",num_line,yytext); return LESS_THAN_OPERATOR;}
">=" {printf("%d %s\n",num_line,yytext); return GREATER_THAN_OR_EQUAL_TO_OPERATOR;}
"<=" {printf("%d %s\n",num_line,yytext); return LESS_THAN_OR_EQUAL_TO_OPERATOR;}
"!" {printf("%d %s\n",num_line,yytext); return LOGICAL_NOT_OPERATOR;}
"&&" {printf("%d %s\n",num_line,yytext); return LOGICAL_AND_OPERATOR;}
"||" {printf("%d %s\n",num_line,yytext); return LOGICAL_OR_OPERATOR;}
"~" {printf("%d %s\n",num_line,yytext); return BITWISE_NOT_OPERATOR;}
"&" {printf("%d %s\n",num_line,yytext); return BITWISE_AND_OPERATOR;}
"|" {printf("%d %s\n",num_line,yytext); return BITWISE_OR_OPERATOR;}
"^" {printf("%d %s\n",num_line,yytext); return BITWISE_XOR_OPERATOR;}
"<<" {printf("%d %s\n",num_line,yytext); return BITWISE_LEFT_SHIFT_OPERATOR;}
">>" {printf("%d %s\n",num_line,yytext); return BITWISE_RIGHT_SHIFT_OPERATOR;}
"+=" {printf("%d %s\n",num_line,yytext); return ADDITION_ASSIGNMENT_OPERATOR;}
"-=" {printf("%d %s\n",num_line,yytext); return SUBTRACTION_ASSIGNMENT_OPERATOR;}
"*=" {printf("%d %s\n",num_line,yytext); return MULTIPLICATION_ASSIGNMENT_OPERATOR;}
"/=" {printf("%d %s\n",num_line,yytext); return DIVISION_ASSIGNMENT_OPERATOR;}
"%=" {printf("%d %s\n",num_line,yytext); return MODULO_ASSIGNMENT_OPERATOR;}
"&=" {printf("%d %s\n",num_line,yytext); return BITWISE_AND_ASSIGNMENT_OPERATOR;}
"|=" {printf("%d %s\n",num_line,yytext); return BITWISE_OR_ASSIGNMENT_OPERATOR;}
"^=" {printf("%d %s\n",num_line,yytext); return BITWISE_XOR_ASSIGNMENT_OPERATOR;}
"<<=" {printf("%d %s\n",num_line,yytext); return BITWISE_LEFT_SHIFT_ASSIGNMENT_OPERATOR;}
">>=" {printf("%d %s\n",num_line,yytext); return BITWISE_RIGHT_SHIFT_ASSIGNMENT_OPERATOR;}
"->" {printf("%d %s\n",num_line,yytext); return GOES_TO_OPERATOR;}
"?" {printf("%d %s\n",num_line,yytext); return QUES;}
"," {printf("%d %s\n",num_line,yytext); return COMMA;}
";" {printf("%d %s\n",num_line,yytext); return SEMI_COLON;}
"#" {printf("%d %s\n",num_line,yytext); return HASH;}
"{" {printf("%d %s\n",num_line,yytext); return OPENING_BRACES;}
"}" {printf("%d %s\n",num_line,yytext); return CLOSING_BRACES;}
"[" {printf("%d %s\n",num_line,yytext); return LEFT_BRACKETS;}
"]" {printf("%d %s\n",num_line,yytext); return RIGHT_BRACKETS;}
"(" {printf("%d %s\n",num_line,yytext); return OPENING_PARENTHESIS;}
")" {printf("%d %s\n",num_line,yytext); return CLOSING_PARENTHESIS;}
":" {printf("%d %s\n",num_line,yytext); return COLON;}
"..." {printf("%d %s\n",num_line,yytext); return ELLIPSE;}
"." {printf("%d %s\n",num_line,yytext); return DOT;}
{ID} {printf("%d %s\n",num_line,yytext); return IDENTIFIER ;}
[0-9]* {printf("%d %s\n",num_line,yytext); return NUMBER ;}
[0-9]+(.[0-9])*? {printf("%d %s\n",num_line,yytext); return REAL_NUMBER ;}
\"(\\.|[^"])*\" {printf("%d %s\n",num_line,yytext); return STRING_CONST ;}
\'(\\.|[^'])\' {printf("%d %s\n",num_line,yytext); return CHARACTER_CONST ;}
. {}

%%

int yywrap()
{
return -1;
}
 
