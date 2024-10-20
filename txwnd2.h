//-------------------------------------------------------------------------------------------------------------------| Textfenster Prototyp, 
//                                                                                                                   | C Header txwnd2.h, 
//                                                                                                                   | von Dietmar Schrausser, SCHRAUSSER 2009    //    
#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

int iLauf, jLauf, /*fLauf,*///--------------------------------------------------------------------------------------> laufindizes
	index = 1,index1 = 1,//-----------------------------------------------------------------------------------------> indizes

	zeile[300], //--------------------------------------------------------------------------------------------------> zeilenlängenvektor
	txlng, zlnlng=0, //---------------------------------------------------------------------------------------------> textlänge, maximalzeilenlänge=textbreite

	x_pos=21,  y_pos=17, //-----------------------------------------------------------------------------------------> fensterkoordinaten
	x_cpos=22, y_cpos=22, //----------------------------------------------------------------------------------------> cursorkoordinaten
	x_grd=1,   y_grd=1, //------------------------------------------------------------------------------------------> fenster grid koordinaten
	
	disp=0, tx_disp=6, tx_disp2=8, tx_disp21, idisp=2,//------------------------------------------------------------> hintergrund- und textfarben
	
	lng=40, //------------------------------------------------------------------------------------------------------> fensterdehnung x-achse
	lng2=7, //------------------------------------------------------------------------------------------------------> fensterdehnung y-achse nach oben
	lng3=0, //------------------------------------------------------------------------------------------------------> fensterdehnung y-achse nach unten

	schub, //-------------------------------------------------------------------------------------------------------> text schub y_achse
	zschub=0, //----------------------------------------------------------------------------------------------------> text schub x_achse

	f1=3, fix=-1, grd=-1, max_zln=50;/*, max_spl=79*/ //------------------------------------------------------------> steuervariablen
	  
char  text[300][200], //--------------------------------------------------------------------------------------------> matrix zur aufnahme des dateiinhalts, t[zeile][spalte]
	  datei[20]= "txwnd1.txt", strng[20],//-------------------------------------------------------------------------> dateinamenvariablen
	  taste;//------------------------------------------------------------------------------------------------------> tastaturereignisvariable

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------------------------------------------| einlesen von datei in text[][]
void datei_in()
{
	FILE *inStream;
	inStream = fopen( datei, "r" );
	
	for(iLauf=1;iLauf<300;iLauf++) zeile[iLauf]=0;//----------------------------------------------------------------> zeilenvektorreinigung
	for(iLauf=1;iLauf<100;iLauf++)for(jLauf=1;jLauf<100;jLauf++)text[iLauf][jLauf]=' '; //--------------------------> textmatrix reinigung

	do //-----------------------------------------------------------------------------------------------------------> zeilen einlesen
	{
		if(zlnlng<zeile[index1-1])zlnlng=zeile[index1-1]; //--------------------------------------------------------> bestimmung der maximal zeilenlänge
		
		while(1) //-------------------------------------------------------------------------------------------------> spalten (einzelstrings) einlesen
		{
			text[index1][index] = fgetc(inStream);//----------------------------------------------------------------> string�bergabe an textmatrixzelle
			if (text[index1][index] == '\n') break;//---------------------------------------------------------------> bis steuerzeichen 'zeilenwechsel'
			if (feof (inStream) != 0) break;//----------------------------------------------------------------------> bis EOF
			index++;zeile[index1]++;
		}
		index1++;index=1; //----------------------------------------------------------------------------------------> index1 zeilenindexerhöhung, index spaltenindex auf 1
	
	}while (feof (inStream) == 0); //-------------------------------------------------------------------------------> solange nicht EOF

	fclose( inStream  );

	txlng=index1-2;//-----------------------------------------------------------------------------------------------> textlängenbestimmung
	schub=-1*(txlng-lng2);//----------------------------------------------------------------------------------------> text schub y_achse bestimmung, text darstellung ab position (1,1)
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------------------------------------------| variablenmonitor
void var_inf_()
{
	textcolor(idisp);//---------------------------------------------------------------------------------------------> textfarbe variablenmonitor
	gotoxy(x_cpos,y_cpos+2); cprintf("x:%i y:%i ",x_cpos, y_cpos);
	
	gotoxy(x_pos+lng+2,y_pos+1);      if(x_pos+lng+2+12 <80)if(y_pos+1 >0)cprintf("[./.] lng:%i",lng);
	gotoxy(x_pos+lng+2,y_pos-lng2-1); if(x_pos+lng+2+13 <80)if(y_pos-lng2-1 >0)cprintf("[I/K] lng2:%i",lng2);
	gotoxy(x_pos+lng+2,y_pos+lng3+2); if(x_pos+lng+2+13 <80)cprintf("[L/O] lng3:%i",lng3);

	gotoxy(x_pos-18,y_pos+lng3-6); if(x_pos-18 >0)if(y_pos+lng3-6 >0)cprintf("x_grd:%i y_gid:%i",x_grd, y_grd);
	gotoxy(x_pos-19,y_pos+lng3-4); if(x_pos-19 >0)if(y_pos+lng3-4 >0)cprintf("[G/H]zschub:%i",zschub);
	gotoxy(x_pos-14,y_pos+lng3-3); if(x_pos-14 >0)if(y_pos+lng3-3 >0)cprintf("zlnlng:%i",zlnlng);
	gotoxy(x_pos-18,y_pos+lng3-2); if(x_pos-18 >0)if(y_pos+lng3-2 >0)cprintf("[J/M]schub:%i",schub);
	gotoxy(x_pos-13,y_pos+lng3-1); if(x_pos-13 >0)if(y_pos+lng3-1 >0)cprintf("txlng:%i",txlng);
	gotoxy(x_pos-13,y_pos+lng3+1); if(x_pos-13 >0)if(y_pos+lng3+1 >0)cprintf("xf:%i yf:%i",x_pos, y_pos);
	
	gotoxy(1,1);cprintf("[B]disp:%i [V]tx_disp:%i [C]tx_disp2:%i tx_disp21:%i [T]Datei_in",disp, tx_disp, tx_disp2, tx_disp21);
	gotoxy(1,50);cprintf("[U]fix:%i [F]grd:%i",fix, grd);
	gotoxy(71,50);cprintf("[\x18][Q]End");
	textcolor(15); gotoxy(77,1);cprintf("[p]");
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------------------------------------------|  textfenstererzeugung
void fenster_()
{
	if(fix==1)//----------------------------------------------------------------------------------------------------> fensterfarbe hell bei fixierung
	{
		if( ( (x_cpos == x_pos+1)     &&  (y_cpos == (y_pos+f1)+lng3) ) || 
			( (x_cpos == x_pos+lng-2) &&  (y_cpos == y_pos+1-lng2)    ) ||
			( (x_cpos == x_pos+lng-2) &&  (y_cpos == (y_pos+f1)+lng3) )   ) {tx_disp21=7;} else {tx_disp21=8;}		
	}
		
	if(fix == -1)tx_disp21=tx_disp2;//------------------------------------------------------------------------------> fensterfarbe bei nicht fixierung
	
	textcolor(tx_disp21);//-----------------------------------------------------------------------------------------> fensterfarbe
	if(y_pos - lng2  >0) //-----------------------------------------------------------------------------------------> fenster kopfzeile
	{
		gotoxy(x_pos-1, y_pos - lng2);cprintf("\xDA");//------------------------------------------------------------> beginn eck
		for(iLauf=1;iLauf<=lng-2;iLauf++)cprintf("\xC4"); cprintf("\xBB");//----------------------------------------> linie, end eck
		gotoxy(x_pos+1, y_pos - lng2);cprintf("%s",datei);//--------------------------------------------------------> dateinamendarstellung	
	}

	textcolor(tx_disp);//-------------------------------------------------------------------------------------------> textfarbe
	for(iLauf=1;iLauf<= (lng2-1)+lng3 ;iLauf++) //------------------------------------------------------------------> fenster 
	{
		if(y_pos+1-iLauf+lng3 >0) 
		for(jLauf=1;jLauf<= lng-4 ;jLauf+=1)
		{	
			
			if(grd==-1)//-------------------------------------------------------------------------------------------> dateidarstellung
			{	
				gotoxy( x_pos+jLauf , ((y_pos+1)-iLauf)+lng3 ); cprintf("%c", text[ ((txlng-iLauf)+schub)+lng3 ][jLauf+zschub]);
			}
			
			
			if(grd==1)//--------------------------------------------------------------------------------------------> grid darstellung
			{
				textcolor(tx_disp2);//------------------------------------------------------------------------------> fensterfarbe
				
				gotoxy( x_pos+jLauf , ((y_pos+1)-iLauf)+lng3 ); cprintf("\xB0");//----------------------------------> grid fläche
				
				gotoxy( x_pos+jLauf , ((y_pos+1)-iLauf)+lng3 );//---------------------------------------------------> fadenkreuz
				if(jLauf == x_grd && iLauf == y_grd ){cprintf("\xFE");}//-------------------------------------------> mittelpunktsymbol
				else//----------------------------------------------------------------------------------------------> achsenlinien
				{
					if(iLauf == y_grd )   cprintf("\xCD");
					if(jLauf == x_grd )   cprintf("\xBA");
				}
				
				if(iLauf==(lng2-1)+lng3 && jLauf == lng-4)//--------------------------------------------------------> letzter darstellungsdurchgang
				{	
					gotoxy( x_pos+x_grd+1 , ((y_pos+1)+1)+lng3-y_grd); 
					{
						if(x_grd>1)  cprintf("\x1A%.0f", (zlnlng*(1.0*x_grd)/(lng-4)));//---------------------------> spaltenpositonsdarstellung
						if(x_grd==1) cprintf("\x1A\x30");
					}

					gotoxy( x_pos+x_grd+1 , ((y_pos+1)+2)+lng3-y_grd); 
					cprintf("\x19%.0f", txlng-(txlng*((1.0*(y_grd-1))/(lng2+lng3-2))));//---------------------------> zeilenpositonsdarstellung
					
					gotoxy( x_pos+jLauf-3 , ((y_pos+1)-2)+lng3 ); cprintf("\x1D%i", zlnlng);//----------------------> zeilenlägendarstellung
					gotoxy( x_pos+jLauf-3 , ((y_pos+1)-1)+lng3 ); cprintf("\x12%i",txlng);//------------------------> textlängendarstellung
				}
			}
		}
	}
	
	textcolor(tx_disp21);
	if(y_pos+2+lng3 >0) //------------------------------------------------------------------------------------------> fenster fusszeile
	{
		gotoxy(x_pos-1, y_pos+2+lng3);
		{	
			cprintf("\xC0\xC4o");//---------------------------------------------------------------------------------> beginn eck
			
			//------------------------------------------------------------------------------------------------------> textrollschaltersymbole
			if(lng2-(txlng-1)<=schub){ cprintf("\x19"); } else { cprintf(" ");}
			if(lng3+schub<=0)		 { cprintf("\x18"); } else { cprintf(" ");}
			if(zschub<zlnlng-lng+4)  { cprintf("\x1B"); } else { cprintf(" ");}
			if(zschub >0)			 { cprintf("\x1A"); } else { cprintf(" ");}
			cprintf("\xCD");
		}
		for(iLauf=1;iLauf<=(lng-4)-5;iLauf++)cprintf("\xC4");//-----------------------------------------------------> linie
		cprintf("\xBC");//------------------------------------------------------------------------------------------> end eck
	}
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------------------------------------------| cursorerzeugung
void cursor_()
{
	textcolor(tx_disp);//-------------------------------------------------------------------------------------------> textfarbe
	gotoxy(x_cpos, y_cpos-1);cprintf(".");
	gotoxy(x_cpos, y_cpos);cprintf("\x1E");
	
	if(fix==1){gotoxy(x_cpos, y_cpos+1);cprintf("\xEE");}//---------------------------------------------------------> fixierungsschaltersymbol
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------------------------------------------| tastendruckereignisse
void ereignisse_()
{
	if(taste == 'v') {tx_disp--;if(tx_disp<0)tx_disp = 15;}//-------------------------------------------------------> v_taste ändert fensterfarbe
	if(taste == 'c') {tx_disp2--;if(tx_disp2<7)tx_disp2 = 8;}//-----------------------------------------------------> c_taste ändert text
	if(taste == 'b') {disp--;if(disp<0) disp = 7;}//----------------------------------------------------------------> b_taste ändert displayfarbe

	if(taste == 'f' || (taste == 'u' && (x_cpos == x_pos+6) && (y_cpos == (y_pos+f1)+lng3))) //---------------------> f bzw u_taste schaltet grid
	{
		zschub=zlnlng*((1.0*(x_grd-1))/lng);
		schub=(-1*(txlng*((1.0*(y_grd-1))/(lng2+lng3-2))))+1;if(schub<-1*(txlng-lng2))schub=-1*(txlng-lng2);
		y_grd=lng2+lng3-1;x_grd=1;
		grd*=-1;
	}
	
	if(taste == 'u' && grd==-1)//-----------------------------------------------------------------------------------> u_schaltet textrollung, markierungsfixierung 
	{
		if((x_cpos == x_pos+2) && (y_cpos == (y_pos+f1)+lng3))if(lng3+schub<=0)schub++;
		if((x_cpos == x_pos+3) && (y_cpos == (y_pos+f1)+lng3))if(lng2-(txlng-1)<=schub)schub--;
		if((x_cpos == x_pos+4) && (y_cpos == (y_pos+f1)+lng3))if(zschub>0)zschub--;
		if((x_cpos == x_pos+5) && (y_cpos == (y_pos+f1)+lng3))if(zschub<zlnlng-lng+4)zschub++;
		
		if(! ( ((x_cpos == x_pos+2) && (y_cpos == (y_pos+f1)+lng3)) ||
			   ((x_cpos == x_pos+3) && (y_cpos == (y_pos+f1)+lng3)) ||
			   ((x_cpos == x_pos+4) && (y_cpos == (y_pos+f1)+lng3)) ||
			   ((x_cpos == x_pos+5) && (y_cpos == (y_pos+f1)+lng3))    )  )fix*=-1;
	}
	
	if(taste == 'w' && y_cpos  > 3)//-------------------------------------------------------------------------------> w_taste verschiebt  nach oben
	{
		if(grd==-1)
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))y_pos--;
				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng2-schub<=txlng-1)lng2++;
				if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3))if(lng3>0)lng3--;
				
			}
			y_cpos--;
		}
		if(grd==1)if(y_grd<lng2+lng3-1)y_grd++;

	}
	
	if(taste == 's' && y_cpos  < 49) //-----------------------------------------------------------------------------> s_taste verschiebt  nach unten
	{
		if(grd==-1)
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))y_pos++;
				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng2>=0)lng2--;
				if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3))if(lng3-1<-schub)lng3++;
			
			}
			y_cpos++;
		}
		if(grd==1)if(y_grd>3)y_grd--;
	}
	
	if(taste == 'a' && x_cpos  > 3) //------------------------------------------------------------------------------> a_taste verschiebt  nach links
	{
		if(grd==-1)
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))x_pos--;
				
				if( ((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2)) ||
					((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3    ))    )if(lng>9)lng--;
				
			}
			x_cpos--;
		}
		if(grd==1)if(x_grd>1)x_grd--;
	}
	
	if(taste == 'd' && x_cpos  < 78) //-----------------------------------------------------------------------------> d_taste verschiebt  nach rechts
	{
		if(grd==-1)
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))x_pos++;
				
				if( ((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2)) ||
					((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3    ))    )lng++;
				
			}
			x_cpos++;
		}
		if(grd==1)if(x_grd<lng-8)x_grd++;
	}

	if(taste == 'e' && x_cpos  < 78 && y_cpos  > 3) //--------------------------------------------------------------> e_taste verschiebt  nach rechts oben
	{
		if(grd==-1)
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3)){x_pos++;y_pos--;}
				
				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))    if(lng2-schub<=txlng-1) {lng2++;lng++;}
				if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3)) if(lng3>0)              {lng3--;lng++;}
				
			}
			x_cpos++;y_cpos--;
		}
	}

	if(taste == 'q' && x_cpos  > 3 && y_cpos  > 3) //---------------------------------------------------------------> q_taste verschiebt  nach links oben
	{
		if(grd==-1)
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3)){x_pos--;y_pos--;}

				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))    if(lng>9) if(lng2-schub<=txlng-1) {lng2++;lng--;}
				if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3)) if(lng>9) if(lng3>0)              {lng3--;lng--;}
			
			}
			x_cpos--;y_cpos--;
		}
	
	}

	if(taste == 'x' && x_cpos  < 78 && y_cpos  < 49) //-------------------------------------------------------------> x_taste verschiebt  nach rechts unten
	{
		if(grd==-1)
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3)){x_pos++;y_pos++;}
			
				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))    if(lng2>=0)      { lng2--;lng++; }
				if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3)) if(lng3-1<-schub){ lng3++;lng++; }

			}
		x_cpos++;y_cpos++;
		}
	}
	
	if(taste == 'y' && x_cpos  > 3 && y_cpos  < 49) //--------------------------------------------------------------> y_taste verschiebt  nach links unten
	{
		if(grd==-1)
		{
			if(fix==1)
			{
				if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3)){x_pos--;y_pos++;}

				if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))    if(lng>9) if(lng2>=0)		{lng2--;lng--;}
				if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3)) if(lng>9) if(lng3-1<-schub)  {lng3++;lng--;}

			}
			x_cpos--;y_cpos++;
		}
	}
	
	if(grd==-1)//---------------------------------------------------------------------------------------------------> direktfensterschaltungen (tasten ohne cursor)
	{
		if(taste == 'm')if(lng3+schub<=0)schub++;//-----------------------------------------------------------------> rollt text nach oben
		if(taste == 'j')if(lng2-(txlng-1)<=schub)schub--;//---------------------------------------------------------> rollt text nach unten

		if(taste == 'h')if(zschub<zlnlng-lng+4)zschub++;//----------------------------------------------------------> rollt text nach links
		if(taste == 'g')if(zschub>0)zschub--;//---------------------------------------------------------------------> rollt text nach rechts
	
		if(taste == 'i' && y_pos-lng2 > 1)if(lng2-schub<=txlng-1)lng2++;//------------------------------------------> erweitert fenster OBEN nach oben
		if(taste == 'k')if(lng2>=0)lng2--;//------------------------------------------------------------------------> erweitert fenster OBEN nach unten
	
		if(taste == 'l' && y_pos+lng3+3<max_zln)if(lng3-1<-schub)lng3++;//------------------------------------------> erweitert fenster UNTEN nach unten
		if(taste == 'o')if(lng3>0)lng3--;//-------------------------------------------------------------------------> erweitert fenster UNTEN nach oben
	}

	if(taste == 't' && (x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))//----------------------------------------> t_öffnet datei
	{
		gotoxy(x_cpos, y_cpos+1);cprintf(">"); gotoxy(x_cpos+1, y_cpos+1);scanf("%s", &strng);//--------------------> texteingabe unter cursorsymbol
			
		if(fopen( strng, "r" ) != NULL)//---------------------------------------------------------------------------> wenn datei vorhanden
		{
			index = 1; index1 = 1; zlnlng=0; strcpy(datei,strng); datei_in();//-------------------------------------> indexrückstellung, datei_in funktion
		}
	}

	if(taste == 'p') {idisp--;if(idisp<0)idisp = 2;}//--------------------------------------------------------------> p_variablenmonitofarbenschaltung
};
