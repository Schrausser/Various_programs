//------------------------------------------------------------------------------| GAME by Dietmar Schrausser 2009         //
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <conio.h>

double fn_erg;

double qzufall(double min, double max)//---------------------------------------> Quasizufallszahl 
{
	double seed, SIGMA = 34.0/45;
	
	seed=(time(0)-1234567890); 
	
	fn_erg =		   10*( pow(seed,SIGMA) - floor( pow(seed,SIGMA) ) ) 
		      - floor( 10*( pow(seed,SIGMA) - floor( pow(seed,SIGMA) ) ) );
	
	fn_erg= min + (max-min)*fn_erg;
	
	return fn_erg;
};

void main() //-----------------------------------------------------------------> Hauptprogramm
{
	FILE *outStream;

	int iLauf, mode, y1=0,
  
			x_pos, fre_x_pos, fre_x2_pos, x1_pos, x2_pos,  //------------------> x koordinaten            
			y_pos, fre_y_pos, fre_y2_pos, y1_pos, y2_pos,  //------------------> y koordinaten 
			       fre1=0,    fre2=0,     re=0,   re1=0,   //------------------> indikatoren
			       ind1=0,    ind3=0,     ind=0,  ind2=0,
			                              v1=0,   v11=0,
			                              weg=1,  weg1=-1;
	double zf_pos;         		       
	
	char taste, mode_;
	
	x_pos = 40;  x1_pos = 5;  x2_pos = 72; //----------------------------------> x koordinaten initialisierung     	
	y_pos = 41;  y1_pos = 7;  y2_pos = 8;  //----------------------------------> y koordinaten initialisierung
	

	clrscr();
	_setcursortype(_NOCURSOR);
	
	//-------------------------------------------------------------------------> intro
	delay (2000);textcolor(DARKGRAY);printf(" -  ");clrscr();

	gotoxy(1, 1);
	printf("GAME by Dietmar Schrausser, (c) SCHRAUSSER 2009\ncompiled %s @ %s\n\n[0]BEGIN\n[1]DEMO", __DATE__, __TIME__);

	mode_=getch();//-----------------------------------------------------------> modusdefinition

	if (mode_ != '0' && mode_ != '1') exit(1);
	if (mode_ == '0' ) mode= 0;if (mode_ == '1' ) mode= 1;
	
	delay (1000);clrscr();
	
	gotoxy(x_pos, y_pos);
	printf(" \x1E ");delay (1000);
	
	gotoxy(8, 38);
	for(iLauf=1; iLauf<=65; iLauf++) {cprintf("_");delay(30);} delay(1000);
	
	gotoxy(70, 45);//----------------------------------------------------------> modusabh�ngige datenstrom initialisierung 
	if(mode == 0 ){cprintf("BEGIN");getch();clrscr();outStream = fopen( "game_mat.rix", "w" );}
	if(mode == 1 ){cprintf("DEMO");delay (2000);clrscr();outStream = fopen( "game_mat.rix", "r" );}
	
	
	while(1)//------------------------------------------------------------------| hauptschleife
	{
		while (!kbhit())//-----------------------------------------------------> spielschleife
		{ 			
			if(mode == 1 )//---------------------------------------------------> DEMO modus
			fscanf(outStream,"%i %i %i %i %i %i %i %lf\n", //------------------> koordinaten�bernahme aus game_mat.rix
			
			&x_pos, &fre1, &fre_y_pos, &fre_x_pos, &fre2, &fre_y2_pos, &fre_x2_pos, &zf_pos);
			
			gotoxy(70, 45);//--------------------------------------------------> trefferz�hler
			textcolor(DARKGRAY);textbackground(BLACK);cprintf("%i", y1);
			
			gotoxy(8, 38);
			cprintf("_________________________________________________________________");

			//-----------------------------------------------------------------> basis
			textcolor(LIGHTGRAY);textbackground(BLACK);
			gotoxy(x_pos, y_pos); cprintf(" \x1E ");
			
			
			//-----------------------------------------------------------------> feuer1
			if(fre1==1)
			{
				textcolor(YELLOW);
				gotoxy(fre_x_pos, fre_y_pos);	cprintf("\xB3");
				gotoxy(fre_x_pos, fre_y_pos+1);	cprintf(" ");
				 
				ind1++;
				if(ind1==100) //-----------------------------------------------> feuergeschwindigkeit1
				{	
					if(mode == 0 )fre_y_pos--;
					if (fre_y_pos==0) fre1 =0;
				
					ind1=0;
				}	
			}
			gotoxy(fre_x_pos, fre_y_pos+1);	cprintf(" ");
			
			//-----------------------------------------------------------------> feuer2
			if(fre2==1)
			{	
				if(mode == 1 && fre_y2_pos ==39)//-----------------------------> DEMO modus graphikfluss optimierung 
				{
					clrscr();textcolor(DARKGRAY);gotoxy(8, 38);					
					cprintf("_________________________________________________________________");
				}	
				
				textcolor(BROWN);
				gotoxy(fre_x2_pos, fre_y2_pos);	cprintf("\xB3");
				gotoxy(fre_x2_pos, fre_y2_pos+1);	cprintf(" ");
				 
				ind3++;
				if(ind3==100) //-----------------------------------------------> feuergeschwindigkeit2
				{			
					if(mode == 0 )fre_y2_pos--;
					if (fre_y2_pos==0) fre2 =0;
					
					ind3=0;
				}	
			}
			gotoxy(fre_x2_pos, fre_y2_pos+1);	cprintf(" ");
			
	
			//-----------------------------------------------------------------> target1
			textcolor(GREEN);
			gotoxy(x1_pos, y1_pos);
			if(re==0) cprintf(" \x0F ");
			
			if(re == 0) ind++; 
			if(ind==3000-v1) //------------------------------------------------> target1 geschwindigkeit
			{
				if (x1_pos > 72 || x1_pos < 5)
				{
					gotoxy(x1_pos, y1_pos);
					cprintf("   ");
					if(v1 < 2500) v1+=100;//-----------------------------------> target1 beschleunigung
					y1_pos++; weg=weg*-1;
				}
				ind=0; x1_pos+=weg;	
			}
			if(y1_pos > 42) {  x1_pos = 5; y1_pos = 7; v1=0; }
				
			if((x1_pos == fre_x_pos-1) && (y1_pos == fre_y_pos)||
			   (x1_pos == fre_x2_pos-1) && (y1_pos == fre_y2_pos)) //----------> target1 kollisionsabfrage feuer1,2
			{
				y1++;//--------------------------------------------------------> trefferz�hler
				
				gotoxy(x1_pos, y1_pos);
				textbackground(BLACK);
				cprintf(" \xB0 ");delay(100);//--------------------------------> explosion
				
				if(mode == 0 )zf_pos=floor(qzufall(2,75)); //------------------> quasizuf�llige x positionierung nach treffer
				
				re=5000; x1_pos = zf_pos; y1_pos += 1;//-----------------------> target1 ann�herung	
			}

			if (re > 0) re--;//------------------------------------------------> target1 wiedereintrittsverz�gerung
			if (re > 0 && re < 1000) {textcolor(GREEN); gotoxy(x1_pos, y1_pos);cprintf(" \xDB ");}

			//-----------------------------------------------------------------> target2
			textcolor(GREEN);
			gotoxy(x2_pos, y2_pos);
			if(re1==0) cprintf(" \xCF ");
			
			if(re1 == 0) ind2++; 
			if(ind2==2000-v11) //----------------------------------------------> target2 geschwindigkeit
			{
				if (x2_pos > 72 || x2_pos < 5)
				{
					gotoxy(x2_pos, y2_pos);
					cprintf("   ");
					if(v11 < 1500) v11+=100;//---------------------------------> target2 beschleunigung
					y2_pos++; weg1=weg1*-1;
				}
				ind2=0; x2_pos+=weg1;	
			}
			if(y2_pos > 42){   x2_pos = 72; y2_pos = 7; v11=0;  }
			

			if((x2_pos == fre_x_pos-1) && (y2_pos == fre_y_pos)||
			   (x2_pos == fre_x2_pos-1) && (y2_pos == fre_y2_pos)) //----------> target2 kollisionsabfrage feuer1,2
			{
				y1++;//--------------------------------------------------------> trefferz�hler
				
				gotoxy(x2_pos, y2_pos);
				textbackground(BLACK);
				cprintf(" \xB1 ");delay(100);//--------------------------------> explosion
				
				if(mode == 0 )zf_pos=floor(qzufall(2,75));//-------------------> quasizuf�llige x positionierung nach treffer
				
				re1=5000; x2_pos = zf_pos; y2_pos += 1;//----------------------> target2 ann�herung	
			}

			if (re1 > 0) re1--;//----------------------------------------------> target2 wiedereintrittsverz�gerung
			if (re1 > 0 && re1 < 1000) {textcolor(GREEN); gotoxy(x2_pos, y2_pos);cprintf(" \xCE ");}

			
			//-----------------------------------------------------------------> basis kollisionsabfrage 
			if((x1_pos == x_pos-1) && (y1_pos == y_pos)||
			   (x2_pos == x_pos-1) && (y2_pos == y_pos)) 
			{
				clrscr();textcolor(DARKGRAY);
				gotoxy(70, 45);cprintf("END");getch();
				exit(1);//-----------------------------------------------------> spielende
			}
			
			if(mode == 0 )//---------------------------------------------------> modus SPIEL
			fprintf(outStream,"%i %i %i %i %i %i %i %lf\n", //-----------------> koordinatenausgabe in game_mat.rix
			
			x_pos, fre1, fre_y_pos, fre_x_pos, fre2, fre_y2_pos, fre_x2_pos, zf_pos );
		}
		
		while (kbhit())//------------------------------------------------------> Tastendruckschleife
		{
			taste=getch();//---------------------------------------------------> zuordnung der aktivierten taste
			
			//-----------------------------------------------------------------> ereignisse
			if(taste == 'd') if(x_pos < 75) x_pos++;//-------------------------> d_taste schiebt cursor nach rechts
			if(taste == 'a') if(x_pos > 2)  x_pos--;//-------------------------> a_taste schiebt cursor nach links
			if(taste == 'h')//-------------------------------------------------> h_taste spielpause 
			{
				gotoxy(1, 1);textcolor(DARKGRAY);printf("GAME paused"); 
				getch();clrscr();
			}
			if(taste == 'p')//-------------------------------------------------> p_taste feuer
			{
				if (ind1==0){fre1=1; fre_y_pos = 39; fre_x_pos=x_pos+1;clrscr();}
				if (ind1>10){fre2=1; fre_y2_pos = 39;fre_x2_pos=x_pos+1;clrscr();}
			}
			if(taste == 'q') {fclose(outStream);clrscr();exit(1);}//-----------> q_taste spielabbruch
		}
	} 
}
