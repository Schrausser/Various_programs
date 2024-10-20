//---------------------------------------------------------------------------------------------------------------------| CAD by Dietmar Schrausser 2009 
#include "CAD.h"

void main()
{
	FILE *Stream, *mStream;

	_setcursortype(_NOCURSOR);//--------------------------------------------------------------------------------------> unterdrückt systemcursoranzeige
	
	sprintf(string," "); sprintf(o_string," ");
	sprintf(tx_string,"CAD_(c)_SCHRAUSSER_2009");

	if(fopen( "c000.cad", "r" ) != NULL) //---------------------------------------------------------------------------->  einlesen der graphik koordinatenmatrix
	{
		Stream = fopen( "c000n.cad", "r" );fscanf(Stream,"%i",&n_);fclose(Stream);
		cadini=1;
	}
	 
	//Stream = fopen( "c000.cad", "w" );fclose(Stream);


	while(1)//---------------------------------------------------------------------------------------------------------| hauptschleife
	{
		textbackground(disp);
		clrscr();
		set=1;
		
		gotoxy(1, 1); textcolor(tx_disp2); cprintf("%s",tx_string);//-------------------------------------------------> textüberschrift
		
		if(fix==1 &&  (((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)) &&
	                   ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))) )//-------------------------------------------> fensterüberlappung
		{
			y_2pos++;
			fix=-1;
		}

		if(fix==1 &&  (!((x_cpos == x_pos+1)  && (y_cpos == y_pos+f1))  &&
					   !((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)) &&
	                   !((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))) )//------------------------------------------> cursormarkierungsfixierung
		{
			if(fix1==1)
			{
				Stream = fopen( "c000.cad", "a" );
				fprintf(Stream,"%i %i %i\n", x_cpos, y_cpos-1, symb_);
				fclose(Stream);
				cad_in=1; n_++;fix1=1;
			}
			fix1=1;
		}

		if(grid==1) //------------------------------------------------------------------------------------------------> grid erzeugung
		{
			textcolor(DARKGRAY);
			for(jLauf=5;jLauf<=45;jLauf+=grdy)//----------------------------------------------------------------------> dichte +=y
			{
				for(iLauf=10;iLauf<=70;iLauf+=grdx)//-----------------------------------------------------------------> dichte +=x
				{
					gotoxy(iLauf, jLauf);cprintf(".");
				}
			}	
		}
	
		if(lin==1) //-------------------------------------------------------------------------------------------------> koordinatenlinienerzeugung
		{
			textcolor(DARKGRAY);
			gotoxy(1, y_cpos-1);cprintf("y\r\n%i", y_cpos-1);
			gotoxy(2, y_cpos-1);for(iLauf=2;iLauf<80;iLauf++)cprintf(".");
			gotoxy(x_cpos-1, 1);cprintf(" x%i ", x_cpos);
			for(iLauf=2;iLauf<=50;iLauf++)
			{
				gotoxy(x_cpos, iLauf);cprintf(".");
			}
		}
		
		if(cad_in==1) //----------------------------------------------------------------------------------------------> einlesen der aktuellen koordinatenmatrix
		{	
			Stream = fopen( "c000.cad", "r" );
			for(iLauf=1;iLauf<=n_;iLauf++)fscanf(Stream,"%i%i%i",&cadx_pos[iLauf], &cady_pos[iLauf], &symb[iLauf]);
			fclose(Stream);
			cad_in=0;
		}
		
		if(disp < 0) disp = 7;//--------------------------------------------------------------------------------------> farbr�ckstellung bei erreichen von 0
		if(tx_disp < 0) tx_disp = 15;
		textbackground(disp);textcolor(tx_disp);
		
		if(cadini==1)for(iLauf=1;iLauf<=n_;iLauf++) symbole();//------------------------------------------------------> graphikerzeugung


		if(drw==1)//--------------------------------------------------------------------------------------------------> linienziehung
		{	
			if(drw_m==1)Stream = fopen( "c000.cad", "a" );
			
			if(y_cpos<=drw0y+1)
			for(jLauf=1; jLauf <=drw0y-y_cpos+2; jLauf++)
			{
				if(x_cpos>=drw0x)
				for(iLauf=0;iLauf<=(x_cpos-drw0x)/(drw0y-y_cpos+2);iLauf++) 
				{
					gotoxy(drw0x+iLauf+(jLauf-1)*(x_cpos-drw0x)/(drw0y-y_cpos+2), drw0y-jLauf+1);cprintf(".");
					
					if(drw_m==1){fprintf(Stream,"%i %i 4\n", drw0x+iLauf+(jLauf-1)*(x_cpos-drw0x)/(drw0y-y_cpos+2), drw0y-jLauf+1);n_++;}
				}
			
				if(x_cpos<drw0x)
				for(iLauf=0;iLauf<=(drw0x-x_cpos)/(drw0y-y_cpos+2);iLauf++) 
				{
					gotoxy(drw0x-iLauf+(jLauf-1)*(x_cpos-drw0x)/(drw0y-y_cpos+2), drw0y-jLauf+1);cprintf(".");
				
					if(drw_m==1){fprintf(Stream,"%i %i 4\n", drw0x-iLauf+(jLauf-1)*(x_cpos-drw0x)/(drw0y-y_cpos+2), drw0y-jLauf+1);n_++;}
				}
			}
			
			if(y_cpos>drw0y+1)
			for(jLauf=1; jLauf <=y_cpos-1-drw0y; jLauf++)
			{
				if(x_cpos>=drw0x)
				for(iLauf=0;iLauf<=(x_cpos-drw0x)/(y_cpos-1-drw0y);iLauf++) 
				{
					gotoxy(drw0x+iLauf+(jLauf-1)*(x_cpos-drw0x)/(y_cpos-1-drw0y), drw0y+jLauf-1);cprintf(".");
					
					if(drw_m==1){fprintf(Stream,"%i %i 4\n", drw0x+iLauf+(jLauf-1)*(x_cpos-drw0x)/(y_cpos-1-drw0y), drw0y+jLauf-1);n_++;}
				}
			
				if(x_cpos<drw0x)
				for(iLauf=0;iLauf<=(drw0x-x_cpos)/(y_cpos-1-drw0y);iLauf++) 
				{
					gotoxy(drw0x-iLauf+(jLauf-1)*(x_cpos-drw0x)/(y_cpos-1-drw0y), drw0y+jLauf-1);cprintf(".");

					if(drw_m==1){fprintf(Stream,"%i %i 4\n", drw0x-iLauf+(jLauf-1)*(x_cpos-drw0x)/(y_cpos-1-drw0y), drw0y+jLauf-1);n_++;}
				}
			}

			if(drw_m==1){ fclose(Stream);  drw_m=0; drw=-1;  	cad_in=1; cadini=1;set=0;  }			
		}
		
		textcolor(tx_disp2);
		
		//------------------------------------------------------------------------------------------------------------> fenster2
		if(y_2pos > 0 ){gotoxy(x_2pos-1, y_2pos);cprintf("\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xBF");}
		if(y_2pos+1 > 0 ){gotoxy(x_2pos, y_2pos+1);cprintf("[P]Cls ");}
		if(y_2pos+2 > 0 ){gotoxy(x_2pos, y_2pos+2);cprintf("[V]tx:%i", tx_disp);}
		if(y_2pos+3 > 0 ){gotoxy(x_2pos, y_2pos+3);cprintf("[B]dsp:%i", disp );}
		if(y_2pos+4 > 0 ){gotoxy(x_2pos, y_2pos+4);cprintf("[Z]Symbol");}
		if(y_2pos+5 > 0 ){gotoxy(x_2pos, y_2pos+5);cprintf("[\xB0\xB1\xB2\xDB\xDC\xFE\xDF]");}
		if(y_2pos+6 > 0 ){gotoxy(x_2pos, y_2pos+6);cprintf("[\xB4\xC1><\xC2^\xC3]");}
		if(y_2pos+7 > 0 ){gotoxy(x_2pos, y_2pos+7);cprintf("[\x16\xDA\xC0\xD9\xBF\xC5\x9E]");}
		if(y_2pos+8 > 0 ){gotoxy(x_2pos, y_2pos+8);cprintf("[/_\xC4\xEE-\\\xB3]");}
		if(y_2pos+9 > 0 ){gotoxy(x_2pos, y_2pos+9);cprintf("[\xB9\xBB\xBC\xC8\xC9\xBA\xCD]");}
		if(y_2pos+10 > 0 ){gotoxy(x_2pos, y_2pos+10);cprintf("[=\xCB\xCC\xCE\xCF\xDD\xCA]");}
		if(y_2pos+11 > 0 ){gotoxy(x_2pos, y_2pos+11);cprintf("[\x10\x11\x1E\x1F\x1A\x1B\x1C]");}
		if(y_2pos+12 > 0 ){gotoxy(x_2pos, y_2pos+12);cprintf("[\x18\x19\x17\x1D\xF9\xF7\xAA]");}
		gotoxy(x_2pos, y_2pos+13);cprintf("[\xA7\xA9\xAE\xAF\x0F\x0E*]");
		gotoxy(x_2pos-1, y_2pos+14);cprintf("\xC0\xC4o\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xD9");

		//------------------------------------------------------------------------------------------------------------> fenster
		if(y_pos   > 0 ){gotoxy(x_pos-1, y_pos);cprintf("\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xBF");}
		if(y_pos+1 > 0 ){gotoxy(x_pos, y_pos+1);cprintf("x:%i y:%i", x_cpos, y_cpos-1 );}
		if(y_pos+2 > 0 )
		{
			gotoxy(x_pos-1, y_pos+2);
			if(grid==1)cprintf("\xFE[G]Grd#\xBA\xCD");
			if(grid==-1)cprintf(" [G]Grd  ");
		}
		if(y_pos+3 > 0 )
		{
			gotoxy(x_pos-1, y_pos+3);
			if(lin==1)cprintf("\xFE[F]Linie ");
			if(lin==-1)cprintf(" [F]Linie ");
		}
		if(y_pos+4 > 0 )
		{
			gotoxy(x_pos-1, y_pos+4);
			if(tx_disp2==8)cprintf(" [C]Wnd  ");
			if(tx_disp2==7)cprintf("\xFE[C]Wnd  ");

		}
		gotoxy(x_pos, y_pos+5);cprintf("[.]Ende  ");
		gotoxy(x_pos-1, y_pos+6);cprintf("\xC0\xC4o\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xD9");

		//------------------------------------------------------------------------------------------------------------> fenster3
		if(wnd3==1)
		{
			if(y_3pos   > 0 ){ gotoxy(x_3pos-1, y_3pos);cprintf("\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xBF");}
			if(y_3pos+1 > 0 ){gotoxy(x_3pos, y_3pos+1);cprintf("|Q||W||E| |H|. ");}
			if(y_3pos+2 > 0 ){gotoxy(x_3pos, y_3pos+2);cprintf("|A| * |D| |U|Fix ");}
			if(y_3pos+3 > 0 ){gotoxy(x_3pos, y_3pos+3);cprintf("|Y||S||X| |J|Ldrw");}
			if(y_3pos+4 > 0 ){gotoxy(x_3pos, y_3pos+4);cprintf("|K|Gd\xBA    |L|Gd\xCD");}
			if(y_3pos+5 > 0 ){gotoxy(x_3pos, y_3pos+5);cprintf("|M|mem    |O|opn");}
			gotoxy(x_3pos, y_3pos+6);cprintf("[T]Cmnd   |+|    i");
			gotoxy(x_3pos-1, y_3pos+7);cprintf("\xC0\xC4o\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xD9");//	
		}
		
		if(wnd3==-1)
		{
			gotoxy(x_3pos-1, y_3pos+6);cprintf("\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xBF");
			gotoxy(x_3pos-1, y_3pos+7);cprintf("\xC0\xC4o\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4i");
		}

		//------------------------------------------------------------------------------------------------------------> cursor
		textcolor(tx_disp);
		gotoxy(x_cpos, y_cpos);cprintf("\x1E");
		if(fix==1){gotoxy(x_cpos, y_cpos+1);cprintf("\xEE");}//-------------------------------------------------------> fixierungsschaltersymbol
		if(drw==1){gotoxy(x_cpos, y_cpos+1);cprintf("\x1D");}//-------------------------------------------------------> linienziehungsschaltersymbol
		
		cursor_symbole();//-------------------------------------------------------------------------------------------> markierungssymboldarstellung												 
		
		//------------------------------------------------------------------------------------------------------------> zuordnung der aktivierten taste
		
		
		taste=getch();
		
		
		//------------------------------------------------------------------------------------------------------------> ereignisse
		
		if(taste == 'h'&& ((x_cpos == x_pos+1) && (y_cpos == y_pos+6))) //--------------------------------------------> h_cursor+fenster > ende
		{
			Stream = fopen( "c000n.cad", "w" );fprintf(Stream,"%i\n",n_);fclose(Stream);			
			exit(1);
		}
		if(taste == 'h'&& ((x_cpos == x_pos+1) && (y_cpos == y_pos+5))) //--------------------------------------------> h_cursor+fenster > menü farbe
		{
			tx_disp2--;if(tx_disp2<7)tx_disp2=8;set=0;
		}
		
		if(taste == 'h'&& ((x_cpos == x_pos+1) && (y_cpos == y_pos+4))) {lin*=-1;set=0;}//----------------------------> h_cursor+fenster > linie schalter
		if(taste == 'h'&& ((x_cpos == x_pos+1) && (y_cpos == y_pos+3))) {grid*=-1;set=0;}//---------------------------> h_cursor+fenster > grid schalter
		if(taste == 'h'&& ((x_cpos == x_pos+6) && (y_cpos == y_pos+3))) //--------------------------------------------> h_cursor+fenster > grid xy dichte schalter
		{
			grdy-=2;if(grdy<2)grdy=10;grdx-=2;if(grdx<2)grdx=10;set=0;//----------------------------------------------> gesamtgrobeinstellung
		}
		if(taste == 'h'&& ((x_cpos == x_pos+7) && (y_cpos == y_pos+3))) {grdy--;if(grdy<2)grdy=10;set=0;}//-----------> h_cursor+fenster > grid y dichte schalter
		if(taste == 'h'&& ((x_cpos == x_pos+8) && (y_cpos == y_pos+3))) {grdx--;if(grdx<2)grdx=10;set=0;}//-----------> h_cursor+fenster > grid x dichte schalter
		
		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+5))) //------------------------------------------> h_cursor+fenster > ändert markierungssymbol
		{
			symb_--;if(symb_==0)symb_=_nSYMB_;//set=0;
		}
		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+4))) {disp--;set=0;}//---------------------------> h_cursor+fenster > disp schalter
		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+3))) {tx_disp--;set=0;}//------------------------> h_cursor+fenster > tx schalter
		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+2))) //------------------------------------------> h_cursor+fenster >löscht markierungen
		{
			Stream = fopen( "c000.cad", "w" );fclose(Stream);
			cad_in=1;n_=0; set=0;
		}
		
		symbol_taste();

		if(taste == 'c') {tx_disp2--;if(tx_disp2<7)tx_disp2=8;}//-----------------------------------------------------> c_taste �ndert men�farbe
		if(taste == 'v') tx_disp--;//---------------------------------------------------------------------------------> v_taste ändert text
		if(taste == 'b') disp--;//------------------------------------------------------------------------------------> b_taste ändert displayfarbe 

		if(taste == 'w' && y_cpos  > 3) //----------------------------------------------------------------------------> w_taste verschiebt  nach oben
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))y_pos--;
				if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))y_2pos--;
				if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))y_3pos--;
			}
			y_cpos--;
		}
		
		if(taste == 's' && y_cpos  < 49) //---------------------------------------------------------------------------> s_taste verschiebt  nach unten
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))y_pos++;
				if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))y_2pos++;
				if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))y_3pos++;
			}
			y_cpos++;
		}
		
		if(taste == 'a' && x_cpos  > 3) //----------------------------------------------------------------------------> a_taste verschiebt  nach links
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))x_pos--;
				if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))x_2pos--;
				if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))x_3pos--;
			}
			x_cpos--;
		}
		
		if(taste == 'd' && x_cpos  < 78) //---------------------------------------------------------------------------> d_taste verschiebt  nach rechts
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))x_pos++;
				if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))x_2pos++;
				if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))x_3pos++;
			}
			x_cpos++;
		}
		
		if(taste == 'e' && y_cpos  > 3 && x_cpos  < 78) //------------------------------------------------------------> e_taste verschiebt  nach rechts oben
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){x_pos++;y_pos--;}
				if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)){x_2pos++;y_2pos--;}
				if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3)){x_3pos++;y_3pos--;}
			}
			x_cpos++;y_cpos--;
		}
		
		if(taste == 'q' && y_cpos  > 3 && x_cpos  > 3) //-------------------------------------------------------------> q_taste verschiebt  nach links oben
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){x_pos--;y_pos--;}
				if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)){x_2pos--;y_2pos--;}
				if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3)){x_3pos--;y_3pos--;}
			}
			x_cpos--;y_cpos--;
		}
		
		if(taste == 'y' && y_cpos  < 49 && x_cpos  > 3) //------------------------------------------------------------> y_taste verschiebt  nach links unten
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){x_pos--;y_pos++;}
				if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)){x_2pos--;y_2pos++;}
				if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3)){x_3pos--;y_3pos++;}
			}
			x_cpos--;y_cpos++;
		}
		
		if(taste == 'x' & y_cpos  < 49 && x_cpos  < 78) //------------------------------------------------------------> x_taste verschiebt  nach rechts unten
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){x_pos++;y_pos++;}
				if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)){x_2pos++;y_2pos++;}
				if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3)){x_3pos++;y_3pos++;}
			}
			x_cpos++;y_cpos++;
		}

		if(taste == 'k') {grdy--;if(grdy<2)grdy=10;}//----------------------------------------------------------------> k_grid y dichte schalter
		if(taste == 'l') {grdx--;if(grdx<2)grdx=10;}//----------------------------------------------------------------> l_grid x dichte schalter

		if(taste == 'g') grid*=-1;//----------------------------------------------------------------------------------> g_grid schalter
		if(taste == 'f') lin*=-1;//-----------------------------------------------------------------------------------> f_linien schalter

		if(taste == 'u') {fix*=-1;fix1=0;}//--------------------------------------------------------------------------> u_schaltet markierungsfixierung

		if(taste == 'j') {drw*=-1;drw0x=x_cpos; drw0y=y_cpos-1;}//----------------------------------------------------> j_schaltet linienziehung
		if(taste == 'h' && drw==1) {drw_m=1;set=0;}//-----------------------------------------------------------------> h_schaltet linienspeicherung
	
		if(taste == '+') wnd3*=-1;//----------------------------------------------------------------------------------> +_schaltet fenster3
		
		if(taste == 'h' && set ==1) //--------------------------------------------------------------------------------> h_setzt markierung
		{
			Stream = fopen( "c000.cad", "a" );
			fprintf(Stream,"%i %i %i\n", x_cpos, y_cpos-1, symb_);
			fclose(Stream);
			cad_in=1; cadini=1;n_++;set=0;
		}
		
		if(taste == 'z') {symb_--;if(symb_==0)symb_=_nSYMB_;}//-------------------------------------------------------> z_�ndert markierungssymbol

		if(taste == 't') //-------------------------------------------------------------------------------------------> t_liest text ein
		{
			gotoxy(x_cpos, y_cpos+1);cprintf("|");
			gotoxy(x_cpos+1, y_cpos+1);scanf("%s",&string);
			if(strcmp(string,"end")==0) 
			{
				Stream = fopen( "c000n.cad", "w" );fprintf(Stream,"%i\n",n_);fclose(Stream);exit(1);
			}	
			
			if(strlen(string)==1) symbol_inpt();
			
			if( strlen(string) != 1) sprintf(tx_string,"%s", string);
			
			if(strcmp(string,"neu")==0) sprintf(tx_string," ");
		}
		
		if(taste == 'p') //-------------------------------------------------------------------------------------------> p_löscht markierungen
		{
			Stream = fopen( "c000.cad", "w" );fclose(Stream);
			Stream = fopen( "c000n.cad", "w" );fclose(Stream);
			cad_in=1;n_=0;
		}
		if(taste == 'r') cad_(); // test //
		if(taste == 'm') //-------------------------------------------------------------------------------------------> m_speichert graphik
		{
			Stream = fopen( "c000.cad", "r" ); mStream = fopen( "c000_m.cad", "w" );
	
			do
			{
				c_1 = fgetc(Stream); if (index > 2) fputc (c_3,mStream); 
				c_3 = c_2; c_2 = c_1; index++;
		
			}while (feof (Stream) == 0); 
 
			fclose( Stream  );	fclose( mStream ); index = 1;
		
			mStream = fopen( "c000n_m.cad", "w" );
		
			fprintf(mStream,"%i", n_);	
 
			fclose( mStream );	index = 1;
		}
		if(taste == 'o') //-------------------------------------------------------------------------------------------> o_öffnet graphik
		{
			gotoxy(x_cpos, y_cpos+1);cprintf("<");
			gotoxy(x_cpos+1, y_cpos+1);scanf("%s",&string);
			
			if(fopen( string, "r" ) != NULL)
			{
				sprintf(o_string,"%s", string);

				gotoxy(x_cpos, y_cpos+1);cprintf("\xAE               ");
				gotoxy(x_cpos+1, y_cpos+1);scanf("%s",&string);
				
				if(fopen( string, "r" ) != NULL)
				{
					Stream = fopen( o_string, "a" );fprintf(Stream,"\n");fclose(Stream);
					Stream = fopen( string, "r" );fscanf(Stream,"%i",&n_);fclose(Stream);
					
					Stream = fopen( "c000n.cad", "w" );fclose( Stream  );
					Stream = fopen( "c000n.cad", "w" );fprintf(Stream,"%i", n_);fclose(Stream);
					
					Stream = fopen( "c000.cad", "w" );fclose( Stream  );
					Stream = fopen( o_string, "r" ); mStream = fopen( "c000.cad", "w" );
					
					do
					{
						c_1 = fgetc(Stream); if (index > 2) fputc (c_3,mStream); 
						c_3 = c_2; c_2 = c_1; index++;
			
					}while (feof (Stream) == 0); 
					
					fprintf(mStream, "\n");
					
					fclose( Stream  );	fclose( mStream ); index = 1;
				
					sprintf(o_string," ");
					
					cad_in=1;
				}	
			}
		}
	}	
}


