//---------------------------------------------------------------------------------------------------------------------| CAD by Dietmar Schrausser 2009 
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "txwnd1.h" // test //

#define _nSYMB_  14 //------------------------------------------------------------------------------------------------> anzahl der zeichensymbole am cursorschalter

int iLauf, jLauf, 
	
	x_pos=70, y_pos=4 ,//---------------------------------------------------------------------------------------------> fensterposition
	x_2pos=4, y_2pos=34 ,//-------------------------------------------------------------------------------------------> fensterposition2
	x_3pos=62, y_3pos=41 ,//------------------------------------------------------------------------------------------> fensterposition3
	x_cpos=40, y_cpos=26 ,//------------------------------------------------------------------------------------------> cursorposition
	grdy=5, grdx=6,
	drw0x, drw0y,
	cadx_pos[2000], cady_pos[2000], 
	
	n_=0, cad_in=1, cadini=0, 
	
	index = 1,
	grid=1, lin=1, 
	fix=-1, fix1=0, 
	set=1, wnd3=1,   
	drw=-1,  drw_m=0,
	
	f1=7,//(6+1)------------------------------------------------------------------------------------------------------> fenster endposition
	f2=15,//(14+1)----------------------------------------------------------------------------------------------------> fenster2 endposition
	f3=8,//(7+1)------------------------------------------------------------------------------------------------------> fenster3 endposition
	
	symb[2000], symb_=4,//--------------------------------------------------------------------------------------------> standard symbol 
	tx_disp= 15, disp = 2, tx_disp2 = 7;//----------------------------------------------------------------------------> farbvoreinstellungen

char taste, string[200], tx_string[200], o_string[15], c_1, c_2, c_3;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------------------------------------------------> graphikerzeugung
void symbole()
{
	gotoxy(cadx_pos[iLauf], cady_pos[iLauf]);
	if(symb[iLauf]==1)cprintf("\xDB");	if(symb[iLauf]==2)cprintf("\x9E");	if(symb[iLauf]==3)cprintf("o");
	if(symb[iLauf]==4)cprintf(".");		if(symb[iLauf]==5)cprintf(" ");		if(symb[iLauf]==6)cprintf("+");
	if(symb[iLauf]==7)cprintf("\xDA");	if(symb[iLauf]==8)cprintf("\xC4");	if(symb[iLauf]==9)cprintf("\xBF");
	if(symb[iLauf]==10)cprintf("\xB3");	if(symb[iLauf]==11)cprintf("\xD9");	if(symb[iLauf]==12)cprintf("\xC0");
	if(symb[iLauf]==13)cprintf("/");	if(symb[iLauf]==14)cprintf("\\");	if(symb[iLauf]==15)cprintf("\xB0");
	if(symb[iLauf]==16)cprintf("\xB1");	if(symb[iLauf]==17)cprintf("\xB2");	
	if(symb[iLauf]==19)cprintf("\xDC");	if(symb[iLauf]==20)cprintf("\xFE");	if(symb[iLauf]==21)cprintf("\xDF");
	if(symb[iLauf]==22)cprintf("\xB4");	if(symb[iLauf]==23)cprintf("\xC1");	if(symb[iLauf]==24)cprintf(">");
	if(symb[iLauf]==25)cprintf("<");	if(symb[iLauf]==26)cprintf("\xC2");	if(symb[iLauf]==27)cprintf("^");
	if(symb[iLauf]==28)cprintf("\xC3");	if(symb[iLauf]==29)cprintf("\x16");	
	if(symb[iLauf]==34)cprintf("\xC5");	
	if(symb[iLauf]==37)cprintf("_");	if(symb[iLauf]==39)cprintf("\xEE");
	if(symb[iLauf]==40)cprintf("-");	
	if(symb[iLauf]==43)cprintf("\xB9");	if(symb[iLauf]==44)cprintf("\xBB");	if(symb[iLauf]==45)cprintf("\xBC");
	if(symb[iLauf]==46)cprintf("\xC8");	if(symb[iLauf]==47)cprintf("\xC9");	if(symb[iLauf]==48)cprintf("\xBA");
	if(symb[iLauf]==49)cprintf("\xCD");	if(symb[iLauf]==50)cprintf("=");	if(symb[iLauf]==51)cprintf("\xCB");
	if(symb[iLauf]==52)cprintf("\xCC");	if(symb[iLauf]==53)cprintf("\xCE");	if(symb[iLauf]==54)cprintf("\xCF");
	if(symb[iLauf]==55)cprintf("\xDD");	if(symb[iLauf]==56)cprintf("\xCA");	if(symb[iLauf]==57)cprintf("\x10");
	if(symb[iLauf]==58)cprintf("\x11");	if(symb[iLauf]==59)cprintf("\x1E");	if(symb[iLauf]==60)cprintf("\x1F");
	if(symb[iLauf]==61)cprintf("\x1A");	if(symb[iLauf]==62)cprintf("\x1B");	if(symb[iLauf]==63)cprintf("\x1C");
	if(symb[iLauf]==64)cprintf("\x18");	if(symb[iLauf]==65)cprintf("\x19");	if(symb[iLauf]==66)cprintf("\x17");
	if(symb[iLauf]==67)cprintf("\x1D");	if(symb[iLauf]==68)cprintf("\xF9");	if(symb[iLauf]==69)cprintf("\xF7");
	if(symb[iLauf]==70)cprintf("\xAA");	if(symb[iLauf]==71)cprintf("\xA7");	if(symb[iLauf]==72)cprintf("\xA9");
	if(symb[iLauf]==73)cprintf("\xAE");	if(symb[iLauf]==74)cprintf("\xAF");	if(symb[iLauf]==75)cprintf("\x0F");
	if(symb[iLauf]==76)cprintf("\x0E");	if(symb[iLauf]==77)cprintf("*");

	if(symb[iLauf]==78)cprintf("1");    if(symb[iLauf]==79)cprintf("2");    if(symb[iLauf]==80)cprintf("3");
	if(symb[iLauf]==81)cprintf("4");	if(symb[iLauf]==82)cprintf("5");    if(symb[iLauf]==83)cprintf("6");    
	if(symb[iLauf]==84)cprintf("7");    if(symb[iLauf]==85)cprintf("8");	if(symb[iLauf]==86)cprintf("9");

	if(symb[iLauf]==87)cprintf("a");    if(symb[iLauf]==88)cprintf("b");    if(symb[iLauf]==89)cprintf("c");
	if(symb[iLauf]==90)cprintf("d");	if(symb[iLauf]==91)cprintf("e");    if(symb[iLauf]==92)cprintf("f");    
	if(symb[iLauf]==93)cprintf("g");    if(symb[iLauf]==94)cprintf("h");	if(symb[iLauf]==95)cprintf("i");
	if(symb[iLauf]==96)cprintf("j");    if(symb[iLauf]==97)cprintf("k");    if(symb[iLauf]==98)cprintf("l");
	if(symb[iLauf]==99)cprintf("m");	if(symb[iLauf]==100)cprintf("n");   if(symb[iLauf]==101)cprintf("o");    
	if(symb[iLauf]==102)cprintf("p");   if(symb[iLauf]==103)cprintf("q");	if(symb[iLauf]==104)cprintf("r");
	if(symb[iLauf]==105)cprintf("s");   if(symb[iLauf]==106)cprintf("t");   if(symb[iLauf]==107)cprintf("u");
	if(symb[iLauf]==108)cprintf("v");	if(symb[iLauf]==109)cprintf("w");   if(symb[iLauf]==110)cprintf("x");    
	if(symb[iLauf]==111)cprintf("y");   if(symb[iLauf]==112)cprintf("z");
	
	if(symb[iLauf]==113)cprintf("A");   if(symb[iLauf]==114)cprintf("B");   if(symb[iLauf]==115)cprintf("C");
	if(symb[iLauf]==116)cprintf("D");	if(symb[iLauf]==117)cprintf("E");   if(symb[iLauf]==118)cprintf("F");    
	if(symb[iLauf]==119)cprintf("G");   if(symb[iLauf]==120)cprintf("H");	if(symb[iLauf]==121)cprintf("I");
	if(symb[iLauf]==122)cprintf("J");   if(symb[iLauf]==123)cprintf("K");   if(symb[iLauf]==124)cprintf("L");
	if(symb[iLauf]==125)cprintf("M");	if(symb[iLauf]==126)cprintf("N");   if(symb[iLauf]==127)cprintf("O");    
	if(symb[iLauf]==128)cprintf("P");   if(symb[iLauf]==129)cprintf("Q");	if(symb[iLauf]==130)cprintf("R");
	if(symb[iLauf]==131)cprintf("S");   if(symb[iLauf]==132)cprintf("T");   if(symb[iLauf]==133)cprintf("U");
	if(symb[iLauf]==134)cprintf("V");	if(symb[iLauf]==135)cprintf("W");   if(symb[iLauf]==136)cprintf("X");    
	if(symb[iLauf]==137)cprintf("Y");   if(symb[iLauf]==138)cprintf("Z");	

	if(symb[iLauf]==139)cprintf("!");   if(symb[iLauf]==140)cprintf("\"");  if(symb[iLauf]==141)cprintf("�");
	if(symb[iLauf]==142)cprintf("$");   if(symb[iLauf]==143)cprintf("\%");  if(symb[iLauf]==144)cprintf("&");
	if(symb[iLauf]==145)cprintf("(");   if(symb[iLauf]==146)cprintf(")");   if(symb[iLauf]==147)cprintf("{");
	if(symb[iLauf]==148)cprintf("}");   if(symb[iLauf]==149)cprintf("[");   if(symb[iLauf]==150)cprintf("]");
	if(symb[iLauf]==151)cprintf("?");   if(symb[iLauf]==152)cprintf("�");   if(symb[iLauf]==153)cprintf("~");
	if(symb[iLauf]==154)cprintf("#");   if(symb[iLauf]==155)cprintf("'");   if(symb[iLauf]==156)cprintf("�");
	if(symb[iLauf]==157)cprintf("�");   if(symb[iLauf]==158)cprintf(",");   if(symb[iLauf]==159)cprintf(":");
	if(symb[iLauf]==160)cprintf(";");   if(symb[iLauf]==161)cprintf("�");   if(symb[iLauf]==162)cprintf("�");
	
	//
	//.. symbole

};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------------------------------------------------> markierungssymboldarstellung
void cursor_symbole()
{
	gotoxy(x_cpos, y_cpos-1);
	
	if(symb_==1)cprintf("\xDB");	if(symb_==2)cprintf("\x9E");    if(symb_==3)cprintf("o");
	if(symb_==4)cprintf(".");		if(symb_==5)cprintf(" ");		if(symb_==6)cprintf("+");
	if(symb_==7)cprintf("\xDA");	if(symb_==8)cprintf("\xC4");	if(symb_==9)cprintf("\xBF");
	if(symb_==10)cprintf("\xB3");	if(symb_==11)cprintf("\xD9");	if(symb_==12)cprintf("\xC0");
	if(symb_==13)cprintf("/");		if(symb_==14)cprintf("\\");		if(symb_==15)cprintf("\xB0");
	if(symb_==16)cprintf("\xB1");	if(symb_==17)cprintf("\xB2");	
	if(symb_==19)cprintf("\xDC");	if(symb_==20)cprintf("\xFE");	if(symb_==21)cprintf("\xDF");
	if(symb_==22)cprintf("\xB4");	if(symb_==23)cprintf("\xC1");	if(symb_==24)cprintf(">");
	if(symb_==25)cprintf("<");		if(symb_==26)cprintf("\xC2");	if(symb_==27)cprintf("^");
	if(symb_==28)cprintf("\xC3");	if(symb_==29)cprintf("\x16");
	if(symb_==34)cprintf("\xC5");	
	if(symb_==37)cprintf("_");		if(symb_==39)cprintf("\xEE");
	if(symb_==40)cprintf("-");		
	if(symb_==43)cprintf("\xB9");	if(symb_==44)cprintf("\xBB");	if(symb_==45)cprintf("\xBC");
	if(symb_==46)cprintf("\xC8");	if(symb_==47)cprintf("\xC9");	if(symb_==48)cprintf("\xBA");
	if(symb_==49)cprintf("\xCD");	if(symb_==50)cprintf("=");		if(symb_==51)cprintf("\xCB");
	if(symb_==52)cprintf("\xCC");	if(symb_==53)cprintf("\xCE");	if(symb_==54)cprintf("\xCF");
	if(symb_==55)cprintf("\xDD");	if(symb_==56)cprintf("\xCA");	if(symb_==57)cprintf("\x10");
	if(symb_==58)cprintf("\x11");	if(symb_==59)cprintf("\x1E");	if(symb_==60)cprintf("\x1F");
	if(symb_==61)cprintf("\x1A");	if(symb_==62)cprintf("\x1B");	if(symb_==63)cprintf("\x1C");
	if(symb_==64)cprintf("\x18");	if(symb_==65)cprintf("\x19");	if(symb_==66)cprintf("\x17");
	if(symb_==67)cprintf("\x1D");	if(symb_==68)cprintf("\xF9");	if(symb_==69)cprintf("\xF7");
	if(symb_==70)cprintf("\xAA");	if(symb_==71)cprintf("\xA7");	if(symb_==72)cprintf("\xA9");
	if(symb_==73)cprintf("\xAE");	if(symb_==74)cprintf("\xAF");	if(symb_==75)cprintf("\x0F");
	if(symb_==76)cprintf("\x0E");	if(symb_==77)cprintf("*");

	if(symb_==78)cprintf("1");    if(symb_==79)cprintf("2");    if(symb_==80)cprintf("3");
	if(symb_==81)cprintf("4");	  if(symb_==82)cprintf("5");    if(symb_==83)cprintf("6");    
	if(symb_==84)cprintf("7");    if(symb_==85)cprintf("8");	if(symb_==86)cprintf("9");
	
	if(symb_==87)cprintf("a");    if(symb_==88)cprintf("b");    if(symb_==89)cprintf("c");
	if(symb_==90)cprintf("d");	  if(symb_==91)cprintf("e");    if(symb_==92)cprintf("f");    
	if(symb_==93)cprintf("g");    if(symb_==94)cprintf("h");	if(symb_==95)cprintf("i");
	if(symb_==96)cprintf("j");    if(symb_==97)cprintf("k");    if(symb_==98)cprintf("l");
	if(symb_==99)cprintf("m");	  if(symb_==100)cprintf("n");   if(symb_==101)cprintf("o");    
	if(symb_==102)cprintf("p");   if(symb_==103)cprintf("q");	if(symb_==104)cprintf("r");
	if(symb_==105)cprintf("s");   if(symb_==106)cprintf("t");   if(symb_==107)cprintf("u");
	if(symb_==108)cprintf("v");	  if(symb_==109)cprintf("w");   if(symb_==110)cprintf("x");    
	if(symb_==111)cprintf("y");   if(symb_==112)cprintf("z");

	if(symb_==113)cprintf("A");   if(symb_==114)cprintf("B");   if(symb_==115)cprintf("C");
	if(symb_==116)cprintf("D");	  if(symb_==117)cprintf("E");   if(symb_==118)cprintf("F");    
	if(symb_==119)cprintf("G");   if(symb_==120)cprintf("H");	if(symb_==121)cprintf("I");
	if(symb_==122)cprintf("J");   if(symb_==123)cprintf("K");   if(symb_==124)cprintf("L");
	if(symb_==125)cprintf("M");	  if(symb_==126)cprintf("N");   if(symb_==127)cprintf("O");    
	if(symb_==128)cprintf("P");   if(symb_==129)cprintf("Q");	if(symb_==130)cprintf("R");
	if(symb_==131)cprintf("S");   if(symb_==132)cprintf("T");   if(symb_==133)cprintf("U");
	if(symb_==134)cprintf("V");	  if(symb_==135)cprintf("W");   if(symb_==136)cprintf("X");    
	if(symb_==137)cprintf("Y");   if(symb_==138)cprintf("Z");

	if(symb_==139)cprintf("!");   if(symb_==140)cprintf("\"");  if(symb_==141)cprintf("�");
	if(symb_==142)cprintf("$");   if(symb_==143)cprintf("\%");  if(symb_==144)cprintf("&");
	if(symb_==145)cprintf("(");   if(symb_==146)cprintf(")");   if(symb_==147)cprintf("{");
	if(symb_==148)cprintf("}");   if(symb_==149)cprintf("[");   if(symb_==150)cprintf("]");
	if(symb_==151)cprintf("?");   if(symb_==152)cprintf("�");   if(symb_==153)cprintf("~");
	if(symb_==154)cprintf("#");   if(symb_==155)cprintf("'");   if(symb_==156)cprintf("�");
	if(symb_==157)cprintf("�");   if(symb_==158)cprintf(",");   if(symb_==159)cprintf(":");
	if(symb_==160)cprintf(";");   if(symb_==161)cprintf("�");   if(symb_==162)cprintf("�");
	
	//
	//.. symbole
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------------------------------------------------> tastendruckereignisse
void symbol_taste()
{
	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+6))) {symb_=15; set=0;}//h_cursor+fenster > symbol 15
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+6))) {symb_=16; set=0;}//h_cursor+fenster > symbol 16
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+6))) {symb_=17; set=0;}//h_cursor+fenster > symbol 17
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+6))) {symb_=1; set=0; }//h_cursor+fenster > symbol 1
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+6))) {symb_=19; set=0;}//h_cursor+fenster > symbol 19
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+6))) {symb_=20; set=0;}//h_cursor+fenster > symbol 20
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+6))) {symb_=21; set=0;}//h_cursor+fenster > symbol 21

	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+7))) {symb_=22; set=0;}//h_cursor+fenster > symbol 22
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+7))) {symb_=23; set=0;}//h_cursor+fenster > symbol 23
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+7))) {symb_=24; set=0;}//h_cursor+fenster > symbol 24
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+7))) {symb_=25; set=0;}//h_cursor+fenster > symbol 25
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+7))) {symb_=26; set=0;}//h_cursor+fenster > symbol 26
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+7))) {symb_=27; set=0;}//h_cursor+fenster > symbol 27
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+7))) {symb_=28; set=0;}//h_cursor+fenster > symbol 28

	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+8))) {symb_=29; set=0;}//h_cursor+fenster > symbol 29
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+8))) {symb_=7; set=0; }//h_cursor+fenster > symbol 7
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+8))) {symb_=12; set=0;}//h_cursor+fenster > symbol 12
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+8))) {symb_=11; set=0;}//h_cursor+fenster > symbol 11
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+8))) {symb_=9; set=0; }//h_cursor+fenster > symbol 9
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+8))) {symb_=34; set=0;}//h_cursor+fenster > symbol 34
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+8))) {symb_=2; set=0; }//h_cursor+fenster > symbol 2

	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+9))) {symb_=13; set=0;}//h_cursor+fenster > symbol 13
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+9))) {symb_=37; set=0;}//h_cursor+fenster > symbol 37
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+9))) {symb_=8; set=0; }//h_cursor+fenster > symbol 8
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+9))) {symb_=39; set=0;}//h_cursor+fenster > symbol 39
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+9))) {symb_=40; set=0;}//h_cursor+fenster > symbol 40
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+9))) {symb_=14; set=0;}//h_cursor+fenster > symbol 14
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+9))) {symb_=10; set=0;}//h_cursor+fenster > symbol 10

	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+10))) {symb_=43; set=0;}//h_cursor+fenster > symbol 43
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+10))) {symb_=44; set=0;}//h_cursor+fenster > symbol 44
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+10))) {symb_=45; set=0;}//h_cursor+fenster > symbol 45
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+10))) {symb_=46; set=0;}//h_cursor+fenster > symbol 46
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+10))) {symb_=47; set=0;}//h_cursor+fenster > symbol 47
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+10))) {symb_=48; set=0;}//h_cursor+fenster > symbol 48
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+10))) {symb_=49; set=0;}//h_cursor+fenster > symbol 49

	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+11))) {symb_=50; set=0;}//h_cursor+fenster > symbol 50
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+11))) {symb_=51; set=0;}//h_cursor+fenster > symbol 51
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+11))) {symb_=52; set=0;}//h_cursor+fenster > symbol 52
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+11))) {symb_=53; set=0;}//h_cursor+fenster > symbol 53
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+11))) {symb_=54; set=0;}//h_cursor+fenster > symbol 54
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+11))) {symb_=55; set=0;}//h_cursor+fenster > symbol 55
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+11))) {symb_=56; set=0;}//h_cursor+fenster > symbol 56

	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+12))) {symb_=57; set=0;}//h_cursor+fenster > symbol 57
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+12))) {symb_=58; set=0;}//h_cursor+fenster > symbol 58
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+12))) {symb_=59; set=0;}//h_cursor+fenster > symbol 59
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+12))) {symb_=60; set=0;}//h_cursor+fenster > symbol 60
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+12))) {symb_=61; set=0;}//h_cursor+fenster > symbol 61
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+12))) {symb_=62; set=0;}//h_cursor+fenster > symbol 62
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+12))) {symb_=63; set=0;}//h_cursor+fenster > symbol 63

	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+13))) {symb_=64; set=0;}//h_cursor+fenster > symbol 64
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+13))) {symb_=65; set=0;}//h_cursor+fenster > symbol 65
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+13))) {symb_=66; set=0;}//h_cursor+fenster > symbol 66
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+13))) {symb_=67; set=0;}//h_cursor+fenster > symbol 67
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+13))) {symb_=68; set=0;}//h_cursor+fenster > symbol 68
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+13))) {symb_=69; set=0;}//h_cursor+fenster > symbol 69
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+13))) {symb_=70; set=0;}//h_cursor+fenster > symbol 70

	if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+14))) {symb_=71; set=0;}//h_cursor+fenster > symbol 71
	if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+14))) {symb_=72; set=0;}//h_cursor+fenster > symbol 72
	if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+14))) {symb_=73; set=0;}//h_cursor+fenster > symbol 73
	if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+14))) {symb_=74; set=0;}//h_cursor+fenster > symbol 74
	if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+14))) {symb_=75; set=0;}//h_cursor+fenster > symbol 75
	if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+14))) {symb_=76; set=0;}//h_cursor+fenster > symbol 76
	if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+14))) {symb_=77; set=0;}//h_cursor+fenster > symbol 77
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------------------------------------------------> symboldirekteingabe
void symbol_inpt()
{
	if(strcmp(string,"1") == 0) symb_= 78; if(strcmp(string,"2") == 0) symb_= 79; if(strcmp(string,"3") == 0) symb_= 80;
	if(strcmp(string,"4") == 0) symb_= 81; if(strcmp(string,"5") == 0) symb_= 82; if(strcmp(string,"6") == 0) symb_= 83;
	if(strcmp(string,"7") == 0) symb_= 84; if(strcmp(string,"8") == 0) symb_= 85; if(strcmp(string,"9") == 0) symb_= 86;
	if(strcmp(string,".") == 0) symb_= 4;

	if(strcmp(string,"a") == 0) symb_= 87; if(strcmp(string,"b") == 0) symb_= 88; if(strcmp(string,"c") == 0) symb_= 89;
	if(strcmp(string,"d") == 0) symb_= 90; if(strcmp(string,"e") == 0) symb_= 91; if(strcmp(string,"f") == 0) symb_= 92;
	if(strcmp(string,"g") == 0) symb_= 93; if(strcmp(string,"h") == 0) symb_= 94; if(strcmp(string,"i") == 0) symb_= 95;
	if(strcmp(string,"j") == 0) symb_= 96; if(strcmp(string,"k") == 0) symb_= 97; if(strcmp(string,"l") == 0) symb_= 98;
	if(strcmp(string,"m") == 0) symb_= 99; if(strcmp(string,"n") == 0) symb_= 100; if(strcmp(string,"o") == 0) symb_= 101;
	if(strcmp(string,"p") == 0) symb_= 102; if(strcmp(string,"q") == 0) symb_= 103; if(strcmp(string,"r") == 0) symb_= 104;
	if(strcmp(string,"s") == 0) symb_= 105; if(strcmp(string,"t") == 0) symb_= 106; if(strcmp(string,"u") == 0) symb_= 107;
	if(strcmp(string,"v") == 0) symb_= 108; if(strcmp(string,"w") == 0) symb_= 109; if(strcmp(string,"x") == 0) symb_= 110;
	if(strcmp(string,"y") == 0) symb_= 111; if(strcmp(string,"z") == 0) symb_= 112;

	if(strcmp(string,"A") == 0) symb_= 113; if(strcmp(string,"B") == 0) symb_= 114; if(strcmp(string,"C") == 0) symb_= 115;
	if(strcmp(string,"D") == 0) symb_= 116; if(strcmp(string,"E") == 0) symb_= 117; if(strcmp(string,"F") == 0) symb_= 118;
	if(strcmp(string,"G") == 0) symb_= 119; if(strcmp(string,"H") == 0) symb_= 120; if(strcmp(string,"I") == 0) symb_= 121;
	if(strcmp(string,"J") == 0) symb_= 122; if(strcmp(string,"K") == 0) symb_= 123; if(strcmp(string,"L") == 0) symb_= 124;
	if(strcmp(string,"M") == 0) symb_= 125; if(strcmp(string,"N") == 0) symb_= 126; if(strcmp(string,"O") == 0) symb_= 127;
	if(strcmp(string,"P") == 0) symb_= 128; if(strcmp(string,"Q") == 0) symb_= 129; if(strcmp(string,"R") == 0) symb_= 130;
	if(strcmp(string,"S") == 0) symb_= 131; if(strcmp(string,"T") == 0) symb_= 132; if(strcmp(string,"U") == 0) symb_= 133;
	if(strcmp(string,"V") == 0) symb_= 134; if(strcmp(string,"W") == 0) symb_= 135; if(strcmp(string,"X") == 0) symb_= 136;
	if(strcmp(string,"Y") == 0) symb_= 137; if(strcmp(string,"Z") == 0) symb_= 138;

	if(strcmp(string,"!") == 0) symb_= 139; if(strcmp(string,"\"") == 0) symb_= 140; if(strcmp(string,"�") == 0) symb_= 141;
	if(strcmp(string,"$") == 0) symb_= 142; if(strcmp(string,"\%") == 0) symb_= 143; if(strcmp(string,"&") == 0) symb_= 144;
	if(strcmp(string,"(") == 0) symb_= 145; if(strcmp(string,")") == 0) symb_= 146;  if(strcmp(string,"{") == 0) symb_= 147;
	if(strcmp(string,"}") == 0) symb_= 148; if(strcmp(string,"[") == 0) symb_= 149;  if(strcmp(string,"]") == 0) symb_= 150;
	if(strcmp(string,"?") == 0) symb_= 151; if(strcmp(string,"�") == 0) symb_= 152;  if(strcmp(string,"~") == 0) symb_= 153;
	if(strcmp(string,"#") == 0) symb_= 154; if(strcmp(string,"'") == 0) symb_= 155;  if(strcmp(string,"�") == 0) symb_= 156;
	if(strcmp(string,"�") == 0) symb_= 157; if(strcmp(string,",") == 0) symb_= 158;  if(strcmp(string,":") == 0) symb_= 159;
	if(strcmp(string,";") == 0) symb_= 160; if(strcmp(string,"�") == 0) symb_= 161;  if(strcmp(string,"�") == 0) symb_= 162;

	//
	//.. symbole
};
