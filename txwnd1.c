//-----------------------------------------------------------------------| Textfenster Prototyp, 
//                                                                       | txwnd1.c, 
//                                                                       | von Dietmar Schrausser, SCHRAUSSER 2009    //      

#include "txwnd1.h" //--------------------------------------------------> hauptheader

main()
{
	_setcursortype(_NOCURSOR);//----------------------------------------> unterdrückt cursoranzeige
	//------------------------------------------------------------------> datei einlesen   
	datei_in();	

	while(1)//----------------------------------------------------------| hauptschleife
	{
		textbackground(disp);clrscr();
		//--------------------------------------------------------------> variablenmonitor
		var_inf_();
		//--------------------------------------------------------------> fenstererzeugung
		fenster_();		
		//--------------------------------------------------------------> cursorerzeugung
		cursor_();
		
		//--------------------------------------------------------------> zuordnung der aktivierten taste
		taste=getch();
		
		//--------------------------------------------------------------> ereignisse
		ereignisse_();
		if(taste == 'Q') break;//---------------------------------------> Q_ende
	}
	return 0;
} 
