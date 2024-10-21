//------------------------------------------------------------------------------| DICE by Dietmar Schrausser 2009         //
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <conio.h>

double fn_erg;

double qzufall(double seed, double min, double max)
{
	double SIGMA = 34.0/45;

	fn_erg =		   10*( pow(seed,SIGMA) - floor( pow(seed,SIGMA) ) ) 
		      - floor( 10*( pow(seed,SIGMA) - floor( pow(seed,SIGMA) ) ) );
	
	fn_erg= min + (max-min)*fn_erg;
	
	return fn_erg;
};

void main() 
{
	int iLauf, jLauf, kLauf;
	char taste;

	double in_seed;
	
	in_seed=(time(0)-1234567890); 

	_setcursortype(_NOCURSOR);
	
	while(1)
	{
		for (iLauf=0; iLauf<=65; iLauf+=5)
		{
			if(iLauf==65) iLauf=54;
			
			qzufall(in_seed,1,7); in_seed = fn_erg;
			
			textcolor(7);textbackground(6);
			clrscr();
			gotoxy(1, 1);cprintf("%f", fn_erg);
			textcolor(0);
			gotoxy(66-iLauf, 6);
			for(jLauf=1; jLauf<=9; jLauf++)cprintf("\xB0");
			
			for(kLauf=1; kLauf<=9; kLauf++)
			{	
				textcolor(0);
				gotoxy(64-iLauf, 6+kLauf);
				
				for(jLauf=1; jLauf<=11; jLauf++)cprintf("\xDB");
				if(kLauf==1){gotoxy(64-iLauf, 6+1);cprintf("\xDC");gotoxy(64-iLauf+10, 6+1);cprintf("\xDC");}
				if(kLauf==9){gotoxy(64-iLauf, 6+9);cprintf("\xDF");gotoxy(64-iLauf+10, 6+9);cprintf("\xDF");}
				if(kLauf<9){cprintf("\xB1\xB0");}
			
			}
			gotoxy(64-iLauf+12, 6+8); cprintf(" ");

			textcolor(7);
			
			if(floor(fn_erg) == 1)
			{
				gotoxy((63-iLauf)+6, 11); cprintf("\xDB");
			}
			if(floor(fn_erg) == 2)
			{	
				gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 14); cprintf("\xDB");
			}
			if(floor(fn_erg) == 3)
			{	
				gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
				gotoxy((63-iLauf)+6, 11); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 14); cprintf("\xDB");	
			}
			if(floor(fn_erg) == 4)
			{
				gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 8); cprintf("\xDB");
				gotoxy((63-iLauf)+3, 14); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 14); cprintf("\xDB");		
			}
			if(floor(fn_erg) == 5)
			{
				gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 8); cprintf("\xDB");
				gotoxy((63-iLauf)+6, 11); cprintf("\xDB");
				gotoxy((63-iLauf)+3, 14); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 14); cprintf("\xDB");
			}
			if(floor(fn_erg) == 6)
			{
				gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 8); cprintf("\xDB");
				gotoxy((63-iLauf)+3, 11); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 11); cprintf("\xDB");
				gotoxy((63-iLauf)+3, 14); cprintf("\xDB");
				gotoxy((63-iLauf)+9, 14); cprintf("\xDB");
			}
			
			if(iLauf==54) iLauf=65;
			delay(100);

		}
		gotoxy(1, 1);printf("%f", fn_erg);
		taste=getch();
		if (taste == 'q') exit(1);
		textcolor(7);clrscr();
		gotoxy(1, 1);cprintf("DICE ...");
		delay(450);
	
	}
} 
