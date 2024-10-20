//---------------------------------------------------------------------------| GRAPH by Dietmar SCHRAUSSER 2009               //
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

double x_vektor[60], y_vektor[30];

void main()
{
	FILE *iniStream;

	int iLauf, syst_x, syst_y, x_achse, y_achse, itaste, disp, fn_disp;
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
	
	_setcursortype(_NOCURSOR);//-------------------------------------------> unterdrückt cursoranzeige
	disp = 7; fn_disp= 15;//-----------------------------------------------> farbvoreinstellungen
	
	while(1)//--------------------------------------------------------------| hauptschleife
	{
		clrscr(); gotoxy(2, 2); 
		if(disp < 0) disp = 7;//-------------------------------------------> farbrückstellung bei erreichen von 0
		textcolor(BLACK);textbackground(disp);
		cprintf("+: x%i y%i", syst_x+y_achse, syst_y+x_achse);//-----------> koordinatenursprungsmonitor

		textcolor(DARKGRAY);textbackground(BLACK);

     	for(iLauf=syst_x; iLauf <=61+syst_x; iLauf++)//--------------------> erzeugung der x-achse
     	{
   			gotoxy(iLauf, syst_y+x_achse); cprintf("\xc4");
		}

		for(iLauf=syst_y; iLauf <=31+syst_y; iLauf++)//--------------------> erzeugung y-achse
     	{
   			gotoxy(syst_x+y_achse, iLauf); cprintf("\xb3");
		}
	
		gotoxy(syst_x+y_achse, syst_y+x_achse); cprintf("\xc5");//---------> koordinatenursprungserzeugung
		
		
		if(fn_disp < 0) fn_disp = 15;//------------------------------------> farbrückstellung bei erreichen von 0
		textcolor(fn_disp);
		
		for(iLauf=syst_x+10; iLauf <=31+syst_x; iLauf++)//-----------------> demonstrationsfunktionskurve
     	{
   			gotoxy(iLauf, (34-(iLauf-syst_x))+syst_y);
    		cprintf(",");
		}
	
    	gotoxy(1, syst_y+x_achse+1);//--------------------------------------> endposition
    		
		while (!kbhit());//------------------------------------------------> tastendruckerwartung
		taste=getch();//---------------------------------------------------> zuordnung der aktivierten taste
		
		//-----------------------------------------------------------------> ereignisse
		if(taste == 'v') fn_disp--;//--------------------------------------> v_taste ändert kurvenfarbe	
		if(taste == 'c') disp--;//-----------------------------------------> c_taste ändert displayfarbe 

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
