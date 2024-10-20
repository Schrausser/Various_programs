//--------------------------------------------------------------------------------------------------| SCHRAUSSER 2009  //        
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

void cad_()
{
	FILE *inStream;

	int iLauf, jLauf, x_pos, y_pos, x_cpos, y_cpos, disp, tx_disp, tx_disp2, tx_disp21, f1, fix, lng, lng2, txlng, schub;

	int index = 1, index1 = 1, zeile[300];
	char taste, text[100][100] ;
	
	_setcursortype(_NOCURSOR);//-------------------------------------------> unterdr�ckt cursoranzeige

	disp = 0; tx_disp = 6;tx_disp2= 8;//-------------------------------------> farbvoreinstellungen
	x_pos=6, y_pos=14 ;//---------------------------------------------------> fensterposition
	x_cpos=10, y_cpos=20 ;//-----------------------------------------------> cursorposition
	
	fix= -1;

	f1= 2 +1;
	lng=46;
	lng2=7;
	schub=0;

	inStream = fopen( "txwnd.txt", "r" );
	
	for(iLauf=1;iLauf<300;iLauf++) zeile[iLauf]=0;
	
	do
	{
		while(1)
		{
			text[index1][index] = fgetc(inStream);
			if (text[index1][index] == '\n') break;
			index++;zeile[index1]++;
			if (feof (inStream) != 0) break;
		}
		index1++;index=1;txlng=index1;
	
	}while (feof (inStream) == 0);


	fclose( inStream  );



	while(1)//--------------------------------------------------------------| hauptschleife
	{
		textbackground(disp);
		clrscr();
		//cprintf("x:%i y:%i tx_disp:%i",x_cpos, y_cpos-1, tx_disp);
		
		
		//----------------------------------------------------------------------------> fenster
		
		if(fix==1)if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){tx_disp21=7;}else{tx_disp21=8;}
		if(fix == -1)tx_disp21=tx_disp2;
		
		textcolor(tx_disp21);

		if(y_pos - lng2  >0) 
		{
			gotoxy(x_pos-1, y_pos - lng2);cprintf("\xDA");
			for(iLauf=1;iLauf<=lng-2;iLauf++)cprintf("\xC4");
			cprintf("\xC2");
		
		}
		textcolor(tx_disp);
		for(iLauf=1;iLauf<= lng2-1 ;iLauf++) 
		{
			if(y_pos+1-iLauf >0) 
			for(jLauf=1;jLauf<= lng-4 ;jLauf+=1)
			{	
					gotoxy( x_pos+jLauf , (y_pos+1)-iLauf ); cprintf("%c", text[ ((txlng-3)-iLauf)+schub ][jLauf]);
			}
		}
		
		textcolor(tx_disp21);
		if(y_pos+2 >0) 
		{
			gotoxy(x_pos-1, y_pos+2);	cprintf("\xC0\xC4o");
			for(iLauf=1;iLauf<=lng-4;iLauf++)cprintf("\xC4");
			cprintf("\xD9");
		
		}

		
		//------------------------------------------------------------------------------> cursor
		textcolor(tx_disp);
		gotoxy(x_cpos, y_cpos-1);cprintf(".");
		gotoxy(x_cpos, y_cpos);cprintf("\x1E");
		
		if(fix==1){gotoxy(x_cpos, y_cpos+1);cprintf("\xEE");}//-------------------------> fixierungsschaltersymbol
		

		//---------------------------------------------------------------> zuordnung der aktivierten taste
		
		taste=getch();
		
		//-----------------------------------------------------------------> ereignisse
		
		if(taste == 'v') {tx_disp--;if(tx_disp<0)tx_disp = 15;}//--------------------> v_taste �ndert fensterfarbe
		if(taste == 'c') {tx_disp2--;if(tx_disp2<7)tx_disp2 = 8;}//-------------------> c_taste �ndert text
		if(taste == 'b') {disp--;if(disp<0) disp = 7;}//---------------------------> b_taste �ndert displayfarbe
		
		if(taste == 'u') fix*=-1;//--------------------------------------> u_schaltet markierungsfixierung

		if(taste == 'w' && y_cpos  > 3)//------------------------------------------------------------------------------> w_taste verschiebt  nach oben
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))y_pos--;
				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng2-schub<=txlng-4)lng2++;
				
			}
			y_cpos--;
		}
		
		if(taste == 's' && y_cpos  < 49) //---------------------------------------------------------------------------> s_taste verschiebt  nach unten
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))y_pos++;
				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng2>=0)lng2--;
				
			}
			y_cpos++;
		}
		
		if(taste == 'a' && x_cpos  > 3) //----------------------------------------------------------------------------> a_taste verschiebt  nach links
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))x_pos--;
				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng>4)lng--;
				
			}

			x_cpos--;
		}
		
		if(taste == 'd' && x_cpos  < 78) //---------------------------------------------------------------------------> d_taste verschiebt  nach rechts
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))x_pos++;
				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))lng++;
				
			}
			x_cpos++;
		}
		
		if(taste == 'i')schub++;
		if(taste == 'k')if(lng2-(txlng-4)<=schub)schub--;
		
		
		if(taste == 'q')  break;  // q_ende


	}	
}
