%{
FILE *fout;
%}
 
%%
\/\*([^*]|[\n]|(\*+([^*/]|[\n])))*\*\/
"//".*
\n {fprintf(fout,"%c",yytext[0]);}
. {fprintf(fout,"%s",yytext);}
%%
int yywrap()
{
return -1;
}
 
int main(int argc,char *argv[])
{
if(argc<2)
{
printf("I/P missing\n");
return -1;
}
yyin=fopen(argv[1],"r");
fout=fopen(argv[2],"w");
yylex();
fclose(fout);
fclose(yyin);
return 0;
}
