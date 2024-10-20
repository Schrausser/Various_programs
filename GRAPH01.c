//---------------------------------------------------------------------------| GRAPH01 by Dietmar SCHRAUSSER 2009               //
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <conio.h>

float xy_vektor[60];

void main()
{
	FILE *iniStream, *inStream;

	int iLauf, jLauf, syst_x, syst_y, x_achse, y_achse, itaste, disp, fn_disp, y_wert, x_wert, y_symb, index;
	int inff=1, inftyp=1, inff_x, inff_y, init=1, symb_sw, fnkt;
	float p_wert;
	char taste;
	
	if (fopen ("graph.ini", "r") == NULL)//--------------------------------> inidateierzeugung beim fehlen derselben 
	{
		iniStream = fopen ("graph.ini", "w");
		fprintf( iniStream,"10 8 31 0"); //--------------------------------> gesamtsystempositionskorrektur x,y, achsenpositionskorrektur x,y
		fclose( iniStream );
	}	
	iniStream = fopen( "graph.ini", "r" );
	fscanf(iniStream,"%i%i%i%i", &syst_x, &syst_y, &x_achse, &y_achse); 
	fclose( iniStream  );
	
	if (fopen ("xy_vekt.asc", "r") != NULL)//------------------------------> xy_vektor einlesen 
	{
		inStream = fopen ("xy_vekt.asc", "r");
		for(iLauf=1; iLauf<=60; iLauf++) fscanf( inStream,"%f", &xy_vektor[iLauf]); 
		fclose( inStream );
	}
		
	_setcursortype(_NOCURSOR);//-------------------------------------------> unterdrückt cursoranzeige
	disp = 7; fn_disp= 15;//-----------------------------------------------> voreinstellungen
	y_symb=6; inff_x=2; inff_y=4; fnkt=1; 

	while(1)//--------------------------------------------------------------| hauptschleife
	{
		clrscr(); gotoxy(2,2); 
		if(disp < 0) disp = 7;//-------------------------------------------> farbrückstellung bei erreichen von 0
		textcolor(BLACK);textbackground(disp);
		cprintf("+: x%i y%i", syst_x+y_achse, syst_y+x_achse);//-----------> koordinatenursprungsmonitor
		cprintf("  xy: x%i y%i", y_achse, 31-x_achse);//-------------------> roh-koordinatenmonitor
		if(y_symb != 0)//--------------------------------------------------> F() monitor wenn sich beide achsen im funktionsbereich befinden
		{
			if((31-x_achse) > 0 && (31-x_achse) <= 30 && y_achse > 0 && y_achse < 61)
			{
				if(fnkt ==  1)cprintf("  F(x=n): n%i F(n)%.2f", y_achse, xy_vektor[(31-x_achse)*2]);  // F(n=x) monitor
				if(fnkt == -1)cprintf("  F(y=n): n%i F(n)%.2f", 62-(x_achse*2), xy_vektor[(y_achse)]);// F(n=y) monitor
			}
		}

		textcolor(DARKGRAY);textbackground(BLACK);cprintf("             ");

     	for(iLauf=syst_x; iLauf <=61+syst_x; iLauf++)//--------------------> erzeugung der x-achse
     	{
   			gotoxy(iLauf, syst_y+x_achse); cprintf("\xc4");
		}
		if(fnkt ==  1)//---------------------------------------------------> F(x)
		{
			gotoxy(iLauf+1, syst_y+x_achse); cprintf("x=n");//-------------> x achsenbeschriftung
			gotoxy(syst_x+y_achse, syst_y-2); cprintf("y=\x9B");//---------> y achsenbeschriftung
		}
		
		if(fnkt ==  -1)//--------------------------------------------------> F(y)
		{
			gotoxy(iLauf+1, syst_y+x_achse); cprintf("x=\x9B");//----------> x achsenbeschriftung
			gotoxy(syst_x+y_achse, syst_y-2); cprintf("y=n");//------------> y achsenbeschriftung
		}
		
		for(iLauf=syst_y; iLauf <=31+syst_y; iLauf++)//--------------------> erzeugung der y-achse
     	{
   			gotoxy(syst_x+y_achse, iLauf); cprintf("\xb3");
		}
		
		gotoxy(syst_x+y_achse, syst_y+x_achse); cprintf("\xc5");//---------> koordinatenursprungserzeugung
		
		if(fn_disp < 1) fn_disp = 15;//------------------------------------> farbrpckstellung bei erreichen von 1
		textcolor(fn_disp);
		
		if(y_symb != 0)//--------------------------------------------------> Funktionserzeugung F()
		{
			index=1;symb_sw=1;
			if(y_symb < 0) y_symb = 6;//-----------------------------------> kurvensymbolrückstellung bei erreichen von -1
			
			if(fnkt == 1)//------------------------------------------------> xy funktionskurvenerzeugung F(x)
			{
				for(iLauf=syst_x+1; iLauf <=61-1+syst_x; iLauf++)
     			{
   					//-----------------------------------------------------> y' transformation
					//
					y_wert=((xy_vektor[index]/(xy_vektor[60]/((31-1)*2)))-(xy_vektor[1]/(xy_vektor[60]/((31-1)*2))));index++;
			
					gotoxy(iLauf, 31-1+syst_y-y_wert);
    				if(y_symb == 0) cprintf("-");
					if(y_symb == 1) cprintf("\xB0");
					if(y_symb == 2) cprintf("\xDC");
					if(y_symb == 3) cprintf("\x2E");
					if(y_symb == 4) cprintf("\xF7");
					if(y_symb == 5) 
					{
						if (symb_sw ==   1)cprintf(".");
						if (symb_sw ==  -1)cprintf("-");
						symb_sw *=-1;
					}
					if(y_symb == 6) cprintf(",");
				}
			}
			
			if(fnkt == -1)//-----------------------------------------------> yx funktionskurvenerzeugung F(y)
			{
				for(iLauf=syst_y+30; iLauf >= syst_y+1; iLauf--)
     			{
   					for(jLauf=1; jLauf <=2; jLauf++)//---------------------> 2maliger plot von y auf x wegen(x'max=2y'max)
					{
						//-------------------------------------------------> x' transformation
						//
						x_wert=((xy_vektor[index]/(xy_vektor[60]/((61-1)*2)))-(xy_vektor[1]/(xy_vektor[60]/((61-1)*2))));index++;
			
						gotoxy(1+syst_x+x_wert, iLauf);
    					if(y_symb == 0) cprintf("-");
						if(y_symb == 1) cprintf("\xB0");
						if(y_symb == 2) cprintf("\xDC");
						if(y_symb == 3) cprintf("\x2E");
						if(y_symb == 4) cprintf("\xF7");
						if(y_symb == 6) 
						{
							if (symb_sw ==   1)cprintf(".");
							if (symb_sw ==  -1)cprintf("-");
							symb_sw *=-1;
						}
						if(y_symb == 5) cprintf(",");	
					}
				}
			}
		}//F() end
		
		if(init == 1)//----------------------------------------------------> initialfenster
		{
			textcolor(DARKGRAY);
			gotoxy(45, 48);cprintf("GRAPH01 by Dietmar Schrausser \r\n");//> fenster
			gotoxy(45, 49);cprintf("compiled on %s @ %s", __DATE__, __TIME__);// fenster
		}
	
		if(inff == 1)//----------------------------------------------------> infofenster
		{
			if(inftyp == 1)//----------------------------------------------> Tastaturbelegung
			{
				textcolor(BLACK);textbackground(WHITE);
				gotoxy(inff_x, inff_y);
				cprintf("Tastaturbelegung:   \r\n");
				textcolor(DARKGRAY);textbackground(BLACK);
				gotoxy(inff_x, inff_y+1);
				cprintf("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\r\n");
				gotoxy(inff_x, inff_y+2);
				cprintf("xyAchsen: xySystem: \r\n");
				gotoxy(inff_x, inff_y+3);
				cprintf("                    \r\n");
				gotoxy(inff_x, inff_y+4);
				cprintf("   [W]        [I]   \r\n");
				gotoxy(inff_x, inff_y+5);
				cprintf("    \x1E          \x1E    \r\n");
				gotoxy(inff_x, inff_y+6);
				cprintf("[A]\x11 \x10[D]  [J]\x11 \x10[L]\r\n");
				gotoxy(inff_x, inff_y+7);
				cprintf("    \x1F          \x1F    \r\n");
				gotoxy(inff_x, inff_y+8);
				cprintf("   [S]        [K]   \r\n");
				gotoxy(inff_x, inff_y+9);
				cprintf("                    \r\n");
				gotoxy(inff_x, inff_y+10);
				cprintf("[X]F(x)/F(y)        \r\n");
				gotoxy(inff_x, inff_y+11);
				cprintf("[Y]Kurve [C][V]Farbe\r\n");
				gotoxy(inff_x, inff_y+12);
				cprintf("[Q]Ende  [M][P]Infrm\r\n");
				gotoxy(inff_x, inff_y+13);
				cprintf("                [R]\x1A\r\n");
			}
			
			if(inftyp == -1)//----------------------------------------------> Funktionswerte
			{
				textcolor(BLACK);textbackground(WHITE);
				gotoxy(inff_x, inff_y);
				cprintf("Funktionswerte:     \r\n");
				textcolor(DARKGRAY);textbackground(BLACK);
				gotoxy(inff_x, inff_y+1);
				cprintf("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\r\n");
				if(fnkt ==  1)p_wert = 1-((31-x_achse)/30.0);//-------------> Prozentrangberechnung py
				if(fnkt == -1)p_wert = 1-(y_achse/60.0);//------------------> Prozentrangberechnung px
				gotoxy(inff_x, inff_y+2);
				//----------------------------------------------------------> p_wert monitor wenn sich beide achsen im funktionsbereich befinden
				if((31-x_achse) > 0 && (31-x_achse) <= 30 && y_achse > 0 && y_achse < 61)
				{
					cprintf("p=%.3f  \r\n", p_wert);
				}
				else
				{	cprintf("p={}  \r\n");
				}
				gotoxy(inff_x, inff_y+3);
				cprintf("                [R]\x1A\r\n");
			}
		}
		
    	gotoxy(1, syst_y+x_achse+1);//-------------------------------------> endposition
    		
		while (!kbhit());//------------------------------------------------> tastendruckerwartung
		taste=getch();//---------------------------------------------------> zuordnung der aktivierten taste
		
		//-----------------------------------------------------------------> ereignisse
		if(taste == 'm') init *=-1;//--------------------------------------> m_taste schaltet das initialfenster
		
		if(taste == 'p') inff *=-1;//--------------------------------------> p_taste schaltet das infofenster
		if(inff == 1) 
		{
			if(taste == 'r') inftyp *=-1;//----------------------------------> r_taste schaltet zwischen infofenstertypus
		}
		if(taste == 'f') inff_x--;//---------------------------------------> f_taste verschiebt infofenster nach links 
		if(taste == 'h') inff_x++;//---------------------------------------> h_taste verschiebt infofenster nach rechts

		if(taste == 't') inff_y--;//---------------------------------------> t_taste verschiebt infofenster nach oben
		if(taste == 'g') inff_y++;//---------------------------------------> g-taste verschiebt infofenster nach unten
		
		if(taste == 'x') fnkt *=-1;//--------------------------------------> x_taste schaltet zwischen F(x) und F(y)
		if(taste == 'y') y_symb--;//---------------------------------------> y_taste schaltet kurvensymbol	
		
		if(taste == 'v') fn_disp--;//--------------------------------------> v_taste schaltet kurvenfarbe	
		if(taste == 'c') disp--;//-----------------------------------------> c_taste schaltet displayfarbe 

		if(taste == 'w') x_achse--;//--------------------------------------> w_taste verschiebt x_achse nach oben
		if(taste == 's') x_achse++;//--------------------------------------> s_taste verschiebt x_achse nach unten
		
		if(taste == 'a') y_achse--;//--------------------------------------> a_taste verschiebt y_achse nach links
		if(taste == 'd') y_achse++;//--------------------------------------> d_taste verschiebt y_achse nach rechts
		
		if(taste == 'j') syst_x--;//---------------------------------------> j_taste verschiebt graph nach links 
		if(taste == 'l') syst_x++;//---------------------------------------> l_taste verschiebt graph nach rechts
		
		if(taste == 'i') syst_y--;//---------------------------------------> i_taste verschiebt graph nach oben
		if(taste == 'k') syst_y++;//---------------------------------------> k-taste verschiebt graph nach unten
		if(taste == 'q') 
		{
			iniStream = fopen ("graph.ini", "w");//------------------------> schreibt aktuelle koordinatensystempositionen in ini datei
			fprintf( iniStream,"%i %i %i %i", syst_x, syst_y, x_achse, y_achse); 
			fclose( iniStream );
			clrscr(); exit(EXIT_SUCCESS);
		}	
	}		
} 
