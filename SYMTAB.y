%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>

extern int num_line;

struct SYMTAB
{
int line,type,isar;
char name[100];
char size[100];
char init[100];
};
typedef struct SYMTAB ST;
ST table[100];
int count=0,temp=0,size=1,isstring=0;
void add_symtab(char *);
void update_symtab(int);
void update_init(char *);
void update_isar();
void update_isar2();
void look_up();
void show_symtab();
%}

%token SIGNED DOUBLE SIZEOF STATIC STRUCT AUTO BREAK CASE CHAR CONST CONTINUE DEFAULT DO ELSE ENUM EXTERN FLOAT FOR GOTO
%token IF INT LONG REGISTER RETURN SHORT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE WHILE ASSIGN_OPERATOR
%token ADDITION_OPERATOR SUBTRACTION_OPERATOR MULTIPLICATION_OPERATOR MODULO_OPERATOR INCREMENT_OPERATOR IDENTIFIER STRING_CONST CHARACTER_CONST NUMBER
%token DECREMENT_OPERATOR EQUAL_TO_OPERATOR NOT_ASSIGNMENT_OPERATOR GREATER_THAN_OPERATOR LESS_THAN_OPERATOR GREATER_THAN_OR_EQUAL_TO_OPERATOR
%token LESS_THAN_OR_EQUAL_TO_OPERATOR LOGICAL_NOT_OPERATOR LOGICAL_AND_OPERATOR LOGICAL_OR_OPERATOR BITWISE_NOT_OPERATOR BITWISE_AND_OPERATOR BITWISE_OR_OPERATOR
%token BITWISE_XOR_OPERATOR BITWISE_LEFT_SHIFT_OPERATOR BITWISE_RIGHT_SHIFT_OPERATOR ADDITION_ASSIGNMENT_OPERATOR SUBTRACTION_ASSIGNMENT_OPERATOR REAL_NUMBER
%token MULTIPLICATION_ASSIGNMENT_OPERATOR DIVISION_ASSIGNMENT_OPERATOR MODULO_ASSIGNMENT_OPERATOR BITWISE_AND_ASSIGNMENT_OPERATOR BITWISE_OR_ASSIGNMENT_OPERATOR
%token BITWISE_XOR_ASSIGNMENT_OPERATOR BITWISE_LEFT_SHIFT_ASSIGNMENT_OPERATOR BITWISE_RIGHT_SHIFT_ASSIGNMENT_OPERATOR COMMA SEMI_COLON HASH OPENING_BRACES
%token CLOSING_BRACES LEFT_BRACKETS RIGHT_BRACKETS OPENING_PARENTHESIS CLOSING_PARENTHESIS COLON ELLIPSE QUES DOT GOES_TO_OPERATOR DIVISION_OPERATOR

%union{
ST st_entry;
int data_type;
char name2[100];
}

%type<st_entry>direct_declarator
%type<data_type>type_specifier declaration_specifiers
%type<name2>IDENTIFIER initializer constant_expression assignment_expression
%%

translation_unit		: external_declaration															{printf("\tReduced translation_unit_>external_declaration\n") ;}
						| translation_unit external_declaration											{printf("\tReduced  translation_unit_>translation_unit external_declaration\n");}
						;

external_declaration	: function_definition                                                            {printf("\tReduced  external_declaration>function_definition\n");}
						| declaration                                                                    {printf("\tReduced  external_declaration>declaration\n");}
						;
function_definition		: declaration_specifiers declarator declaration_list compound_statement          {printf("\tReduced  function_definition>declaration_specifiers declarator declaration_list compound_statement\n");}
						| declaration_specifiers declarator compound_statement                           {printf("\tReduced  function_definition>declaration_specifiers declarator compound_statement\n");}
						| declarator declaration_list compound_statement                                 {printf("\tReduced  function_definition>declarator declaration_list compound_statement\n");}
						| declarator compound_statement                                                   {printf("\tReduced  function_definition>declarator compund_statement\n");}
						;
declaration				: declaration_specifiers init_declarator_list SEMI_COLON                         {update_symtab($1); printf("\tReduced  declaration>declaration_specifiers init_declarator_list SEMI_COLON\n");}
						| declaration_specifiers SEMI_COLON                                              {printf("\tReduced  external_declaration>declaration_specifiers SEMI_COLON\n");}
						;
declaration_list		: declaration                                                                    {printf("\tReduced  declaration_list>declaration\n");}
						| declaration_list declaration                                                   {printf("\tReduced  declaration_list>declaration_list declaration\n");}
						;
declaration_specifiers	: storage_class_specifier declaration_specifiers                                  {printf("\tReduced  declaration_specifiers>storage_class_specifier declaration_specifiers\n");} 
						| storage_class_specifier                                                         {printf("\tReduced  declaration_specifiers>storage_class_specifier\n");} 
						| type_specifier declaration_specifiers                                           {printf("\tReduced  declaration_specifiers>type_specifier declaration_specifiers\n");} 
						| type_specifier                                                                  {$$=$1; printf("\tReduced  declaration_specifiers>type_specifier\n");} 
						| type_qualifier declaration_specifiers                                           {printf("\tReduced  declaration_specifiers>type_qualifier declaration_specifiers\n");} 
						| type_qualifier                                                                  {printf("\tReduced  declaration_specifiers>type_qualifier\n");} 
						;
storage_class_specifier : AUTO                                                                            {printf("\tReduced  storage_class_specifier>AUTO\n");}
						| REGISTER                                                                         {printf("\tReduced  storage_class_specifier>REGISTER\n");}
						| STATIC                                                                           {printf("\tReduced  storage_class_specifier>STATIC\n");}
						| EXTERN                                                                           {printf("\tReduced  storage_class_specifier>EXTERN\n");}
						| TYPEDEF                                                                           {printf("\tReduced  storage_class_specifier>TYPEDEF\n");}
						;
type_specifier			: VOID                            {$$=10; printf("\tReduced  type_specifier>VOID\n");}
						| CHAR                             {$$=1; printf("\tReduced  type_specifier>CHAR\n");}
						| SHORT                           {$$=6; printf("\tReduced  type_specifier>SHORT\n");}
						| INT                             {$$=2; printf("\tReduced  type_specifier>INT\n");}
						| LONG                            {$$=5; printf("\tReduced  type_specifier>LONG\n");}
 						| FLOAT                            {$$=3; printf("\tReduced  type_specifier>FLOAT\n");}
						| DOUBLE                           {$$=4; printf("\tReduced  type_specifier>DOUBLE\n");}
						| SIGNED                           {$$=7; printf("\tReduced  type_specifier>SIGNED\n");}
						| UNSIGNED                          {$$=8; printf("\tReduced  type_specifier>UNSIGNED\n");}
						| struct_or_union_specifier        {$$=9; printf("\tReduced  type_specifier>struct_or_union_specifier\n");}
						| enum_specifier                    {$$=11; printf("\tReduced  type_specifier>enum_specifier\n");}
						;
type_qualifier			: CONST                {printf("\tReduced  type_qualifier>CONST\n");}
						| VOLATILE              {printf("\tReduced  type_qualifier>VOLATILE\n");} 
						;
struct_or_union_specifier  : struct_or_union IDENTIFIER OPENING_BRACES struct_declaration_list CLOSING_BRACES     {printf("\tReduced  struct_or_union_specifier>struct_or_union IDENTIFIER OPENING_BRACES struct_declaration_list CLOSING_BRACES\n");} 
						   | struct_or_union OPENING_BRACES struct_declaration_list CLOSING_BRACES                 {printf("\tReduced  struct_or_union_specifier>struct_or_union OPENING_BRACES struct_declaration_list CLOSING_BRACES\n");} 
						   | struct_or_union IDENTIFIER                                                            {printf("\tReduced  struct_or_union_specifier>struct_or_union IDENTIFIER\n");} 
						   ;
struct_or_union			   : STRUCT     {printf("\tReduced  struct_or_union>struct\n");} 
						   | UNION     {printf("\tReduced  struct_or_union>union\n");}
						   ;
struct_declaration_list		: struct_declaration                           {printf("\tReduced  struct_declaration_list>struct_declarationt\n");} 
							| struct_declaration_list struct_declaration   {printf("\tReduced  struct_declaration_list>struct_declaration_list struct_declaration\n");} 
							;
init_declarator_list		: init_declarator                                 {printf("\tReduced  init_declarator_list>init_declarator\n");} 
							| init_declarator_list COMMA init_declarator      {printf("\tReduced  init_declarator_list>init_declarator_list COMMA init_declarator\n");} 
							;
init_declarator				: declarator                                       {printf("\tReduced  init_declarator>declarator\n");}
							| declarator ASSIGN_OPERATOR initializer       {printf("\tReduced  init_declarator>declarator ASSIGNMENT_OPERATOR initializer\n");}
							;
struct_declaration			: specifier_qualifier_list struct_declarator_list SEMI_COLON    {printf("\tReduced  struct_declaration>specifier_qualifier_list struct_declarator_list SEMI_COLON\n");} 
							;
specifier_qualifier_list    : type_specifier specifier_qualifier_list          {printf("\tReduced  specifier_qualifier_list>type_specifier specifier_qualifier_list\n");}
							| type_specifier                                  {printf("\tReduced  specifier_qualifier_list>type_specifier \n");}
							| type_qualifier specifier_qualifier_list          {printf("\tReduced  specifier_qualifier_list>type_qualifier specifier_qualifier_list\n");}
							| type_qualifier                                    {printf("\tReduced  specifier_qualifier_list>type_qualifer\n");}
							;
struct_declarator_list      : struct_declarator                                {printf("\tReduced  struct_declarator_list>struct_declarator\n");}
							| struct_declarator_list COMMA struct_declarator   {printf("\tReduced  struct_declarator_list>struct_declarator_list COMMA struct_declarator\n");} 
							;
struct_declarator			: declarator                                       {printf("\tReduced  struct_declarator>declarator\n");}
							| declarator COLON constant_expression             {printf("\tReduced  struct_declarator>declarator COLON constant_expression\n");}
							| COLON constant_expression                         {printf("\tReduced  struct_declarator>COLON constant_expression\n");}
							;
enum_specifier				: ENUM IDENTIFIER OPENING_BRACES enumerator_list CLOSING_BRACES    {printf("\tReduced  enum_specifier>enum IDENTIFIER OPENING_BRACES enumerator_list CLOSING_BRACES\n");}
							| ENUM OPENING_BRACES enumerator_list CLOSING_BRACES                 {printf("\tReduced  enum_specifier>enum OPENING_BRACES enumerator_list CLOSING_BRACES \n");}
							| ENUM IDENTIFIER                                                  {printf("\tReduced  enum_specifier>enum IDENTIFIER\n");}
							;
enumerator_list				: enumerator                             {printf("\tReduced  enumerator_list>enumerator\n");}
							| enumerator_list COMMA enumerator       {printf("\tReduced  enumerator_list>enumerator_list COMMA enumerator\n");}
							;
enumerator					: IDENTIFIER                                                  {printf("\tReduced  enumerator>IDENTIFIER\n");}
							| IDENTIFIER ASSIGN_OPERATOR constant_expression          {printf("\tReduced  enumerator>IDENTIFIER\n");}
							;
declarator					: pointer direct_declarator                                   {printf("\tReduced  declarator>pointer direct_declarator\n");}                 
							| direct_declarator                                            {printf("\tReduced  declarator>direct_declarator\n");} 
							;
direct_declarator			: IDENTIFIER                                                                      {strcpy($$.name,$1) ;printf("\tReduced  direct_declarator>IDENTIFIER\n"); add_symtab($1);} 
							| OPENING_PARENTHESIS declarator CLOSING_PARENTHESIS                                {printf("\tReduced  direct_declarator>OPENING_PARENTHESIS declarator CLOSING_PARENTHESIS \n");}
							| direct_declarator LEFT_BRACKETS constant_expression RIGHT_BRACKETS               {update_isar($3); printf("\tReduced  direct_declarator>direct_declarator LEFT_BRACKETS constant_expression RIGHT_BRACKETS\n");}
							| direct_declarator LEFT_BRACKETS RIGHT_BRACKETS                                     {size=0;update_isar2();printf("\tReduced  direct_declarator>direct_declarator LEFT_BRACKETS RIGHT_BRACKETS \n");}
							| direct_declarator OPENING_PARENTHESIS parameter_type_list CLOSING_PARENTHESIS      {printf("\tReduced  direct_declarator>direct_declarator OPENING_PARENTHESIS parameter_type_list CLOSING_PARENTHESIS\n");}
							| direct_declarator OPENING_PARENTHESIS identifier_list CLOSING_PARENTHESIS           {printf("\tReduced  direct_declarator>direct_declarator OPENING_PARENTHESIS IDENTIFIER_list CLOSING_PARENTHESIS\n");}
							| direct_declarator OPENING_PARENTHESIS CLOSING_PARENTHESIS                            {printf("\tReduced  direct_declarator>direct_declarator OPENING_PARENTHESIS CLOSING_PARENTHESIS\n");}
							;
pointer						: MULTIPLICATION_OPERATOR type_qualifier_list                  {printf("\tReduced  pointer>MULTIPLICATION_OPERATOR type_qualifier_list \n");}
							| MULTIPLICATION_OPERATOR                                       {printf("\tReduced  pointer>MULTIPLICATION_OPERATOR\n");}
							| MULTIPLICATION_OPERATOR type_qualifier_list pointer          {printf("\tReduced  pointer>MULTIPLICATION_OPERATOR type_qualifier_list pointer\n");}
							| MULTIPLICATION_OPERATOR pointer                              {printf("\tReduced  pointer>MULTIPLICATION_OPERATOR pointer\n");}
							;
type_qualifier_list			: type_qualifier                                   {printf("\tReduced  type_qualifier_list>direct_declarator\n");} 
							| type_qualifier_list type_qualifier               {printf("\tReduced  type_qualifier_list>type_qualifier_list type_qualifier \n");}
							;
parameter_type_list			: parameter_list                                    {printf("\tReduced  type_qualifier_list>parameter_list\n");} 
							| parameter_list COMMA ELLIPSE                      {printf("\tReduced  type_qualifier_list>parameter_list COMMA ELLIPSE\n");} 
							;
parameter_list				: parameter_declaration                              {printf("\tReduced  parameter_list>parameter_declaration\n");}
							| parameter_list COMMA parameter_declaration         {printf("\tReduced  parameter_list>parameter_list COMMA parameter_declaration\n");} 
							;
parameter_declaration		: declaration_specifiers declarator                   {printf("\tReduced  parameter_declaration>declaration_specifiers declarator\n");} 
							| declaration_specifiers abstract_declarator          {printf("\tReduced  parameter_declaration>declaration_specifiers abstract_declarator\n");} 
							| declaration_specifiers                               {printf("\tReduced  parameter_declaration>declaration_specifers\n");}
							;
identifier_list				: IDENTIFIER                                  {printf("\tReduced  IDENTIFIER_list>IDENTIFIER\n");} 
							| identifier_list COMMA IDENTIFIER            {printf("\tReduced  IDENTIFIER_list>IDENTIFIER_list COMMA IDENTIFIER\n");}  
							;
initializer					: assignment_expression                                                 {update_init($1); printf("\tReduced  initializer>assignment_expression\n");} 
							| OPENING_BRACES initializer_list CLOSING_BRACES                         {printf("\tReduced  initializer>OPENING_BRACES initializer_list CLOSING_BRACES\n");}                     
							| OPENING_BRACES initializer_list COMMA CLOSING_BRACES        {printf("\tReduced  initializer>OPENING_BRACES initializer_list COMMA initializer CLOSING_BRACES\n");} 
							;
initializer_list			: initializer                          {printf("\tReduced  initializer_list>initializer\n");} 
							| initializer_list COMMA initializer    {printf("\tReduced  initializer_list>initializer_list COMMA initializer\n");}
							;
type_name					: specifier_qualifier_list abstract_declarator                  {printf("\tReduced  type_name>specifier_qualifier_list abstract_declarator\n");} 
							| specifier_qualifier_list                                         {printf("\tReduced  type_name>specifier_qualifer_list\n");} 
							;
abstract_declarator			: pointer                              {printf("\tReduced  abstract_declarator>pointer\n");} 
							| pointer direct_abstract_declarator   {printf("\tReduced  abstract_declarator>pointer direct_abstract_declarator\n");} 
							| direct_abstract_declarator           {printf("\tReduced  abstract_declarator>direct_abstract_declarator\n");} 
							;
direct_abstract_declarator  : OPENING_PARENTHESIS abstract_declarator CLOSING_PARENTHESIS                               {printf("\tReduced  direct_abstract_declarator>OPENING_PARENTHESIS abstract_declarator CLOSING_PARENTHESIS\n");} 
							| direct_abstract_declarator LEFT_BRACKETS constant_expression RIGHT_BRACKETS               {printf("\tReduced  direct_abstract_declarator>direct_abstract_declarator LEFT_BRACKETS constant_expression RIGHT_BRACKETS\n");}
							| LEFT_BRACKETS constant_expression RIGHT_BRACKETS 									{printf("\tReduced  direct_abstract_declarator>LEFT_BRACKETS constant_expression RIGHT_BRACKETS\n");}
							| direct_abstract_declarator LEFT_BRACKETS RIGHT_BRACKETS     						{printf("\tReduced  direct_abstract_declarator>LEFT_BRACKETS RIGHT_BRACKETS\n");}
							| LEFT_BRACKETS RIGHT_BRACKETS														{printf("\tReduced  direct_abstract_declarator>direct_abstract_declarator LEFT_BRACKETS RIGHT_BRACKETS\n");}
							| direct_abstract_declarator OPENING_PARENTHESIS parameter_type_list CLOSING_PARENTHESIS     {printf("\tReduced  direct_abstract_declarator>direct_abstract_declarator OPENING_PARENTHESIS parameter_type_list CLOSING_PARENTHESIS\n");}
							| direct_abstract_declarator OPENING_PARENTHESIS CLOSING_PARENTHESIS						 {printf("\tReduced  direct_abstract_declarator>direct_abstract_declarator OPENING_PARENTHESIS CLOSING_PARENTHESIS\n");}
							| OPENING_PARENTHESIS CLOSING_PARENTHESIS													 {printf("\tReduced  direct_abstract_declarator>OPENING_PARENTHESIS CLOSING_PARENTHESIS\n");}
							| OPENING_PARENTHESIS parameter_type_list CLOSING_PARENTHESIS                                 {printf("\tReduced  direct_abstract_declarator>OPENING_PARENTHESIS parameter_type_list CLOSING_PARENTHESIS\n");}
							;

statement					: labeled_statement         {printf("\tReduced  statement>labeled_statement\n");} 
							| expression_statement      {printf("\tReduced  statement>expression_statement\n");} 
							| compound_statement        {printf("\tReduced  statement>compound_statement\n");}
							| selection_statement       {printf("\tReduced  statement>selection_statement\n");}
							| iteration_statement        {printf("\tReduced  statement>iteration_statement\n");}
							| jump_statement             {printf("\tReduced  statement>jump_statement\n");}
							;
labeled_statement			: IDENTIFIER COLON statement                      {printf("\tReduced  labeled_statement>IDENTIFIER COLON statement\n");}
							| CASE constant_expression COLON statement        {printf("\tReduced  labeled_statement>case constant_expression COLON statement\n");}
							| DEFAULT COLON statement                          {printf("\tReduced  labeled_statement>default COLON statement\n");}
							;
expression_statement		: expression SEMI_COLON   {printf("\tReduced  expression_statement>expression SEMI_COLON\n");}
							| SEMI_COLON
							;
compound_statement			: OPENING_BRACES declaration_list statement_list CLOSING_BRACES  {printf("\tReduced  compound_statement>OPENING_BRACES declaration_list statement_list CLOSING_BRACES\n");}
							| OPENING_BRACES statement_list CLOSING_BRACES                   {printf("\tReduced  compound_statement>OPENING_BRACES statement_list CLOSING_BRACES\n");}
							| OPENING_BRACES declaration_list CLOSING_BRACES                  {printf("\tReduced  compound_statement>OPENING_BRACES declaration_list CLOSING_BRACES\n");}
							| OPENING_BRACES CLOSING_BRACES                                   {printf("\tReduced  compound_statement>OPENING_BRACES CLOSING_BRACES\n");}
							;
statement_list				: statement                                 {printf("\tReduced  statement_list>statement\n");}
							| statement_list statement                   {printf("\tReduced  statement_list>statement_list statement\n");}
							;
selection_statement			: IF OPENING_PARENTHESIS expression CLOSING_PARENTHESIS statement                   {printf("\tReduced  selection_statement>if OPENING_PARENTHESIS expression CLOSING_PARENTHESIS statement\n");}
							| IF OPENING_PARENTHESIS expression CLOSING_PARENTHESIS statement ELSE statement     {printf("\tReduced  selection_statementt>if OPENING_PARENTHESIS expression CLOSING_PARENTHESIS statement else statement\n");}
							| SWITCH OPENING_PARENTHESIS expression CLOSING_PARENTHESIS statement                {printf("\tReduced  selection_statement>statement\n");}
							;
iteration_statement			: WHILE OPENING_PARENTHESIS expression CLOSING_PARENTHESIS statement                                            {printf("\tReduced  iteration_statement>while OPENING_PARENTHESIS expression CLOSING_PARENTHESIS statement\n");}
							| DO statement WHILE OPENING_PARENTHESIS expression CLOSING_PARENTHESIS SEMI_COLON                              {printf("\tReduced  iteration_statement>do statement while OPENING_PARENTHESIS expression CLOSING_PARENTHESIS SEMI_COLON\n");}
							| FOR OPENING_PARENTHESIS expression SEMI_COLON expression SEMI_COLON expression CLOSING_PARENTHESIS statement  {printf("\tReduced  iteration_statement>FOR OPENING_PARENTHESIS expression SEMI_COLON expression SEMI_COLON expression CLOSING_PARENTHESIS statement\n");}
							| FOR OPENING_PARENTHESIS SEMI_COLON expression SEMI_COLON expression CLOSING_PARENTHESIS statement              {printf("\tReduced  iteration_statement>FOR OPENING_PARENTHESIS SEMI_COLON expression SEMI_COLON expression CLOSING_PARENTHESIS statement\n");}
							| FOR OPENING_PARENTHESIS expression SEMI_COLON SEMI_COLON expression CLOSING_PARENTHESIS statement              {printf("\tReduced  iteration_statement>FOR OPENING_PARENTHESIS expression SEMI_COLON SEMI_COLON expression CLOSING_PARENTHESIS statement\n");}
							| FOR OPENING_PARENTHESIS expression SEMI_COLON expression SEMI_COLON CLOSING_PARENTHESIS statement              {printf("\tReduced  iteration_statement>FOR OPENING_PARENTHESIS expression SEMI_COLON expression SEMI_COLON CLOSING_PARENTHESIS statement\n");}
							| FOR OPENING_PARENTHESIS SEMI_COLON SEMI_COLON expression CLOSING_PARENTHESIS statement                         {printf("\tReduced  iteration_statement>FOR OPENING_PARENTHESIS SEMI_COLON SEMI_COLON expression CLOSING_PARENTHESIS statement\n");}
							| FOR OPENING_PARENTHESIS SEMI_COLON expression SEMI_COLON CLOSING_PARENTHESIS statement                         {printf("\tReduced  iteration_statement>FOR OPENING_PARENTHESIS SEMI_COLON expression SEMI_COLON CLOSING_PARENTHESIS statement\n"); }
							| FOR OPENING_PARENTHESIS expression SEMI_COLON SEMI_COLON CLOSING_PARENTHESIS statement                         {printf("\tReduced  iteration_statement>FOR OPENING_PARENTHESIS expression SEMI_COLON SEMI_COLON CLOSING_PARENTHESIS statement\n");}
							| FOR OPENING_PARENTHESIS SEMI_COLON SEMI_COLON CLOSING_PARENTHESIS statement                                    {printf("\tReduced  iteration_statement>FOR OPENING_PARENTHESIS SEMI_COLON SEMI_COLON CLOSING_PARENTHESIS statement\n");}
							;
jump_statement				: GOTO IDENTIFIER SEMI_COLON   {printf("\tReduced  jump_statement>goto IDENTIFIER SEMI_COLON\n");}
							| CONTINUE SEMI_COLON          {printf("\tReduced  jump_statement>continue SEMI_COLON\n");}
							| BREAK SEMI_COLON             {printf("\tReduced  jump_statement>break SEMI_COLON\n");}
							| RETURN expression SEMI_COLON {printf("\tReduced  jump_statement>return expression SEMI_COLON\n");}
							| RETURN SEMI_COLON             {printf("\tReduced  jump_statement>return SEMI_COLON\n");}
							;
expression					: assignment_expression                        {printf("\tReduced  expression>assignment_expression\n");}
							| expression COMMA assignment_expression        {printf("\tReduced  expression>expression COMMA assignment_expression\n");}
							;
assignment_expression		: conditional_expression                                          {printf("\tReduced  assignment_expression>conditional_expression\n");}
							| unary_expression assignment_operator assignment_expression       {printf("\tReduced  assignment_expression>unary_expression assignment_operator assignment_expression\n");}
							;
assignment_operator			: ASSIGN_OPERATOR                               {printf("\tReduced  assignment_operator>Assignment_operator\n");}
							| MULTIPLICATION_ASSIGNMENT_OPERATOR                {printf("\tReduced  assignment_operator>MULTIPLICATION_ASSIGNMENT_OPERATOR\n");}
							| DIVISION_ASSIGNMENT_OPERATOR                      {printf("\tReduced  assignment_operator>DIVISION_ASSIGNMENT_OPERATOR\n");}
							| MODULO_ASSIGNMENT_OPERATOR                         {printf("\tReduced  assignment_operator>MODULO_ASSIGNMENT_OPERATOR\n");}						
							| ADDITION_ASSIGNMENT_OPERATOR                       {printf("\tReduced  assignment_operator>ADDITION_ASSIGNMENT_OPERATOR \n");}
							| SUBTRACTION_ASSIGNMENT_OPERATOR                    {printf("\tReduced  assignment_operator>SUBTRACTION_ASSIGNMENT_OPERATOR\n");}
						    | BITWISE_LEFT_SHIFT_ASSIGNMENT_OPERATOR             {printf("\tReduced  assignment_operator>BITWISE_LEFT_SHIFT_ASSIGNMENT_OPERATOR\n");}
							| BITWISE_RIGHT_SHIFT_ASSIGNMENT_OPERATOR             {printf("\tReduced  assignment_operator>BITWISE_RIGHT_SHIFT_ASSIGNMENT_OPERATOR\n");}
							| BITWISE_AND_ASSIGNMENT_OPERATOR                     {printf("\tReduced  assignment_operator>BITWISE_AND_ASSIGNMENT_OPERATOR\n");}
							| BITWISE_XOR_ASSIGNMENT_OPERATOR                     {printf("\tReduced  assignment_operator>BITWISE_XOR_ASSIGNMENT_OPERATOR\n");}
							| BITWISE_OR_ASSIGNMENT_OPERATOR                      {printf("\tReduced  assignment_operator>BITWISE_OR_ASSIGNMENT_OPERATOR\n");}
							;
conditional_expression		: logical_OR_expression                                                    {printf("\tReduced  conditional_expression>logical_OR_expression\n");}
							| logical_OR_expression QUES expression COLON conditional_expression       {printf("\tReduced  conditional_expression>logical_OR_expression QUES expression COLON conditional_expression \n");}
                            ;
constant_expression			: conditional_expression                {printf("\tReduced  constant_expression>conditional_expression\n");}
							;
logical_OR_expression		: logical_AND_expression                                               {printf("\tReduced  logical_OR_expression>logical_AND_expression\n");}
							| logical_OR_expression LOGICAL_OR_OPERATOR logical_AND_expression     {printf("\tReduced  logical_OR_expression>logical_OR_expression LOGICAL_OR_OPERATOR logical_AND_expression \n");}
							;
logical_AND_expression		: inclusive_OR_expression                                                {printf("\tReduced  logical_AND_expression>inclusive_OR_expression\n");}
							| logical_AND_expression LOGICAL_AND_OPERATOR inclusive_OR_expression     {printf("\tReduced  logical_AND_expression>logical_AND_expression LOGICAL_AND_OPERATOR inclusive_OR_expression\n");}
							;
inclusive_OR_expression		: exclusive_OR_expression                                                 {printf("\tReduced  inclusive_OR_expression>exclusive_OR_expression\n");}
							| inclusive_OR_expression BITWISE_OR_OPERATOR exclusive_OR_expression      {printf("\tReduced  inclusive_OR_expression>inclusive_OR_expression BITWISE_OR_OPERATOR exclusive_OR_expression\n");}
							;
exclusive_OR_expression		: AND_expression                                                   {printf("\tReduced  exclusive_OR_expression>AND_expression\n");}
							| exclusive_OR_expression BITWISE_XOR_OPERATOR AND_expression      {printf("\tReduced  exclusive_OR_expression>exclusive_OR_expression BITWISE_XOR_OPERATOR AND_expression\n");}
							;
AND_expression				: equality_expression                                             {printf("\tReduced  AND_expression>equality_expression \n");} 
							| AND_expression BITWISE_AND_OPERATOR equality_expression         {printf("\tReduced  AND_expression>AND_expression BITWISE_AND_OPERATOR equality_expression\n");}
							;
equality_expression			: relational_expression                                                         {printf("\tReduced  equality_expression>relational_expression\n");} 
							| equality_expression EQUAL_TO_OPERATOR relational_expression                   {printf("\tReduced  equality_expression>equality_expression EQUAL_TO_OPERATOR relational_expression\n");} 
							| equality_expression NOT_ASSIGNMENT_OPERATOR relational_expression              {printf("\tReduced  equality_expression>equality_expression NOT_ASSIGNMENT_OPERATOR relational_expression \n");} 
							;
relational_expression		: shift_expression                                                          {printf("\tReduced  relational_expression>shift_expression\n");}
							| relational_expression LESS_THAN_OPERATOR shift_expression                  {printf("\tReduced  relational_expression>relational_expression Less_than_operator shift_expression\n");} 
							| relational_expression GREATER_THAN_OPERATOR shift_expression               {printf("\tReduced  relational_expression>relational_expression GREATER_THAN_OPERATOR shift_expression\n");}
							| relational_expression LESS_THAN_OR_EQUAL_TO_OPERATOR shift_expression      {printf("\tReduced  relational_expression>relational_expression LESS_THAN_OR_EQUAL_TO_OPERATOR shift_expression\n");}
							| relational_expression GREATER_THAN_OR_EQUAL_TO_OPERATOR shift_expression    {printf("\tReduced  relational_expression>relational_expression GREATER_THAN_OR_EQUAL_TO_OPERATOR shift_expression\n");}
							;
shift_expression			: additive_expression                                                         {printf("\tReduced  shift_expression>additive_expression\n");}
							| shift_expression BITWISE_LEFT_SHIFT_OPERATOR additive_expression             {printf("\tReduced  shift_expression>shift_expression BITWISE_LEFT_SHIFT_OPERATOR additive_expression\n");}
							| shift_expression BITWISE_RIGHT_SHIFT_OPERATOR additive_expression             {printf("\tReduced  shift_expression>shift_expression BITWISE_RIGHT_SHIFT_OPERATOR additive_expression\n");}
							;
additive_expression			: multiplicative_expression                                                {printf("\tReduced  additive_expression>multiplicative_expression\n");}
							| additive_expression ADDITION_OPERATOR multiplicative_expression           {printf("\tReduced  additive_expression>additive_expression ADDITION_OPERATOR multiplicative_expression\n");}
							| additive_expression SUBTRACTION_OPERATOR multiplicative_expression         {printf("\tReduced  additive_expression>additive_expression SUBTRACTION_OPERATOR multiplicative_expression\n");}
							;
multiplicative_expression   : cast_expression															{printf("\tReduced  multiplicative_expression>cast_expression\n");}
							| multiplicative_expression MULTIPLICATION_OPERATOR cast_expression        {printf("\tReduced  multiplicative_expression>multiplicative_expression MULTIPLICATION_OPERATOR cast_expression\n");}
							| multiplicative_expression DIVISION_OPERATOR cast_expression                {printf("\tReduced  multiplicative_expression>multiplicative_expression DIVISION_OPERATOR cast_expression\n");}
							| multiplicative_expression MODULO_OPERATOR cast_expression                   {printf("\tReduced  multiplicative_expression>multiplicative_expression MODULO_OPERATOR cast_expression\n");}
							;
cast_expression				: unary_expression                                                        {printf("\tReduced  cast_expression>unary_expression\n");}
							| OPENING_PARENTHESIS type_name CLOSING_PARENTHESIS cast_expression       {printf("\tReduced  cast_expression>OPENING_PARENTHESIS type_name CLOSING_PARENTHESIS cast_expression\n");}
							;
unary_expression			: postfix_expression                    {printf("\tReduced  unary_expression>postfix_expression\n");}
							| INCREMENT_OPERATOR unary_expression    {printf("\tReduced  unary_expression>INCREMENT_OPERATOR unary_expression\n");}
							| DECREMENT_OPERATOR unary_expression     {printf("\tReduced  unary_expression>DECREMENT_OPERATOR unary_expression\n");}
							| unary_operator cast_expression          {printf("\tReduced  unary_expression>unary_operator cast_expression\n");}
							| SIZEOF unary_expression                  {printf("\tReduced  unary_expression>SIZEOF unary_expression\n");}
							| SIZEOF OPENING_PARENTHESIS type_name CLOSING_PARENTHESIS    {printf("\tReduced  unary_expression>SIZEOF OPENING_PARENTHESIS type_name CLOSING_PARENTHESIS\n");}
							;
unary_operator				: BITWISE_AND_OPERATOR             {printf("\tReduced  unary operator>BITWISE_AND_OPERATOR\n");}
							| MULTIPLICATION_OPERATOR           {printf("\tReduced  unary operator>MULTIPLICATION_OPERATOR\n");}
							| ADDITION_OPERATOR                 {printf("\tReduced  unary operator> ADDITION_OPERATOR\n");}
							| SUBTRACTION_OPERATOR                {printf("\tReduced  unary operator>SUBTRACTION_OPERATOR\n");}
							| BITWISE_NOT_OPERATOR                {printf("\tReduced  unary operator>BITWISE_NOT_OPERATOR\n");}
							| LOGICAL_NOT_OPERATOR                {printf("\tReduced  unary operator>LOGICAL_NOT_OPERATOR\n");}
						    ;
postfix_expression			: primary_expression                                                            {printf("\tReduced  postfix_expression>primary_expression\n");}
							| postfix_expression LEFT_BRACKETS expression RIGHT_BRACKETS                        {printf("\tReduced  postfix_expression>postfix_expression LEFT_BRACKETS expression RIGHT_BRACKETS\n");}
							| postfix_expression OPENING_PARENTHESIS argument_expression_list CLOSING_PARENTHESIS           {printf("\tReduced  postfix_expression>postfix_expression OPENING_PARENTHESIS argument_expression_list CLOSING_PARENTHESIS\n");}
							| postfix_expression OPENING_PARENTHESIS CLOSING_PARENTHESIS                      {printf("\tReduced  postfix_expression>postfix_expression OPENING_PARENTHESIS CLOSING_PARENTHESIS\n");}
							| postfix_expression DOT IDENTIFIER                                                 {printf("\tReduced  postfix_expression>postfix_expression DOT IDENTIFIER\n");}
							| postfix_expression GOES_TO_OPERATOR IDENTIFIER                                    {printf("\tReduced postfix_expression>postfix_expression GOES_TO_OPERATOR IDENTIFIER \n");}
							| postfix_expression INCREMENT_OPERATOR                                             {printf("\tReduced  postfix_expression>postfix_expression INCREMENT_OPERATOR \n");}
							| postfix_expression DECREMENT_OPERATOR                                              {printf("\tReduced  postfix_expression>postfix_expression DECREMENT_OPERATOR\n");}
							;
primary_expression			: IDENTIFIER                   {printf("\tReduced  primary_expression>IDENTIFIER\n"); look_up($1);}
							| constant                     {printf("\tReduced  primary_expression>constant\n");}
							| STRING_CONST                         {printf("\tReduced  primary_expression>string\n");}
							| OPENING_PARENTHESIS expression CLOSING_PARENTHESIS  {printf("\tReduced  primary_expression>OPENING_PARENTHESIS expression CLOSING_PARENTHESIS\n");}
							;
argument_expression_list	: assignment_expression         {printf("\tReduced  argument_expression_lis>assignment_expression\n");}
							| argument_expression_list COMMA assignment_expression          {printf("\tReduced  argument_expression_lis>assignment_expression_list COMMA assignment_expression\n");}
							;
constant					: integer_constant              {printf("\tReduced  constant>integer_constant\n");temp=1;}
							| CHARACTER_CONST             {printf("\tReduced  constant>character_constant\n");temp=1;}
							| REAL_NUMBER                {printf("\tReduced  constant>floating_constant \n");temp=0;}
							;
integer_constant 			: NUMBER	{temp=1;}
							;

%%

#include "lex.yy.c"
int yyerror()
{

	printf("\nError in line %d\n",num_line);

}
void add_symtab(char *s)
{
int i,flag=0;
	for(i=0;i<count;i++)
	{
	if(strcmp(table[i].name, s)==0)
	{
	printf("\nDouble Declaration: %s already declared in line %d\n",table[i].name,count);
	yyerror();
	exit(0);
	}
}
if(flag==0)
{
	strcpy(table[count].name,s);
	strcpy(table[count].size,"-1");
	table[count].line=num_line;
	table[count].isar=0;
	count++;
}
}

void update_symtab(int datatype)
{
int i;
	for(i=0;i<count;i++)
	{
		if(table[i].type==0)
		{
		table[i].type=datatype;
		}
	}
}
void update_init(char *s)
{
char *sz;
int len;
strcat(table[count-1].init,s);
strcat(table[count-1].init," ");
if(size==0 && isstring==1)
{
	len=strlen(s)-2;
	itoa(len,sz,10);
	strcpy(table[count-1].size,sz);
	isstring=0;
}
else if(size==0 && isstring==0)
{
	len=strlen(table[count-1].init)/2;
	itoa(len,sz,10);
	strcpy(table[count-1].size,sz);
}
}

void look_up(char *id)
{
int i;
int flag=0;
for(i=0;i<count;i++)
{
	if(strcmp(table[i].name,id)==0)
	{
	flag=1;
	break;
	}
}
if(flag==0)
	{
	printf("\n%s not declared\n",id);
	yyerror();
	exit(0);
	}
}

void update_isar(char *sz)
{
	size=1;table[count-1].isar=1;
	if(temp==1)
	{
	table[count-1].isar=1;
	strcpy(table[count-1].size,sz);
	temp=0;
	}
	else 
	{
	yyerror();
	table[count-1].isar=1;
	strcpy(table[count-1].size,"-1");
	temp=0;
	}
}

void update_isar2()
{
	table[count-1].isar=1;
}

void show_symtab()
{
int i;
	for(i=0;i<count;i++)
	{
	if(strcmp(table[i].init,"")==0)
	strcpy(table[i].init,"---");
	printf("%d \t%s \t%d \t%d \t%s \t\t%s\n",table[i].line,table[i].name, table[i].type,table[i].isar,table[i].init,table[i].size);
	}
}

int main(int argc, char *argv[])
{
	
	if (argc != 2)
	
	{
		
		printf("\tReduced Enter filename to be Compiled\n");
			
		return -1;
	
	}

	
	yyin = fopen(argv[1], "r");

	
	yyparse();
	printf("\n\n******SYMBOL TABLE*******\n\n");
	printf("\nNumber of entries in symbol table=%d\n",count);
	printf("\nCHAR=1 INT=2 FLOAT=3 DOUBLE=4 LONG=5 SHORT=6 \n");
	printf("\nLINE\tID \tTYPE \tis_ar \tinit_val \tsize\n");
	show_symtab();
	return 0;

}

