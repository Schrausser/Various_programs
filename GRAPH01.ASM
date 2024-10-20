ifndef	??version
?debug	macro
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	S "graph01.c"
	?debug	C E9F8B5773B09677261706830312E63
	?debug	C E920085C1613433A5C54435C494E434C5544455C646F732E68
	?debug	C E920085C1615433A5C54435C494E434C5544455C737464696F2E68
	?debug	C E920085C1616433A5C54435C494E434C5544455C7374646C69622E+
	?debug	C 68
	?debug	C E920085C1614433A5C54435C494E434C5544455C74696D652E68
	?debug	C E920085C1615433A5C54435C494E434C5544455C636F6E696F2E68
GRAPH01_TEXT	segment byte public 'CODE'
GRAPH01_TEXT	ends
	assume	cs:GRAPH01_TEXT,ds:GRAPH01_DATA
GRAPH01_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
b@	label	byte
b@w	label	word
GRAPH01_DATA	ends
GRAPH01_TEXT	segment byte public 'CODE'
   ;	
   ;	void main()
   ;	
	assume	cs:GRAPH01_TEXT
_main	proc	far
	push	bp
	mov	bp,sp
	sub	sp,50
	push	si
	push	di
	push	ds
	mov	ax,GRAPH01_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		FILE *iniStream, *inStream;
   ;	
   ;		int iLauf, jLauf, syst_x, syst_y, x_achse, y_achse, itaste, disp, fn_disp, y_wert, x_wert, y_symb, index;
   ;		int inff=1, inftyp=1, inff_x, inff_y, init=1, symb_sw, fnkt;
   ;	
	mov	word ptr [bp-30],1
	mov	word ptr [bp-32],1
	mov	word ptr [bp-38],1
   ;	
   ;		float p_wert;
   ;		char taste;
   ;		
   ;		if (fopen ("graph.ini", "r") == NULL)//--------------------------------> inidateierzeugung beim fehlen derselben 
   ;	
	push	ds
	mov	ax,offset s@+10
	push	ax
	push	ds
	mov	ax,offset s@
	push	ax
	call	far ptr _fopen
	add	sp,8
	or	ax,dx
	jne	short @1@74
   ;	
   ;		{
   ;			iniStream = fopen ("graph.ini", "w");
   ;	
	push	ds
	mov	ax,offset s@+22
	push	ax
	push	ds
	mov	ax,offset s@+12
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;			fprintf( iniStream,"10 8 31 0"); //--------------------------------> gesamtsystempositionskorrektur x,y, achsenpositionskorrek
   ;	
	push	ds
	mov	ax,offset s@+24
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,8
   ;	
   ;			fclose( iniStream );
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
@1@74:
   ;	
   ;		}	
   ;		iniStream = fopen( "graph.ini", "r" );
   ;	
	push	ds
	mov	ax,offset s@+44
	push	ax
	push	ds
	mov	ax,offset s@+34
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;		fscanf(iniStream,"%i%i%i%i", &syst_x, &syst_y, &x_achse, &y_achse); 
   ;	
	push	ss
	lea	ax,word ptr [bp-18]
	push	ax
	push	ss
	lea	ax,word ptr [bp-16]
	push	ax
	push	ss
	lea	ax,word ptr [bp-14]
	push	ax
	push	ss
	lea	ax,word ptr [bp-12]
	push	ax
	push	ds
	mov	ax,offset s@+46
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fscanf
	add	sp,24
   ;	
   ;		fclose( iniStream  );
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;		
   ;		if (fopen ("xy_vekt.asc", "r") != NULL)//------------------------------> xy_vektor einlesen 
   ;	
	push	ds
	mov	ax,offset s@+67
	push	ax
	push	ds
	mov	ax,offset s@+55
	push	ax
	call	far ptr _fopen
	add	sp,8
	or	ax,dx
	je	short @1@218
   ;	
   ;		{
   ;			inStream = fopen ("xy_vekt.asc", "r");
   ;	
	push	ds
	mov	ax,offset s@+81
	push	ax
	push	ds
	mov	ax,offset s@+69
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-8],ax
	mov	word ptr [bp-6],dx
   ;	
   ;			for(iLauf=1; iLauf<=60; iLauf++) fscanf( inStream,"%f", &xy_vektor[iLauf]); 
   ;	
	mov	di,1
	jmp	short @1@170
@1@122:
	mov	ax,di
	shl	ax,1
	shl	ax,1
	add	ax,offset _xy_vektor
	push	ds
	push	ax
	push	ds
	mov	ax,offset s@+83
	push	ax
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	call	far ptr _fscanf
	add	sp,12
	inc	di
@1@170:
	cmp	di,60
	jle	short @1@122
   ;	
   ;			fclose( inStream );
   ;	
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	call	far ptr _fclose
	add	sp,4
@1@218:
   ;	
   ;		}
   ;			
   ;		_setcursortype(_NOCURSOR);//-------------------------------------------> unterdr�ckt cursoranzeige
   ;	
	xor	ax,ax
	push	ax
	call	far ptr __setcursortype
	inc	sp
	inc	sp
   ;	
   ;		disp = 7; fn_disp= 15;//-----------------------------------------------> voreinstellungen
   ;	
	mov	word ptr [bp-20],7
	mov	word ptr [bp-22],15
   ;	
   ;		y_symb=6; inff_x=2; inff_y=4; fnkt=1; 
   ;	
	mov	si,6
	mov	word ptr [bp-34],2
	mov	word ptr [bp-36],4
	mov	word ptr [bp-42],1
@1@242:
   ;	
   ;	
   ;		while(1)//--------------------------------------------------------------| hauptschleife
   ;		{
   ;			clrscr(); gotoxy(2,2); 
   ;	
	call	far ptr _clrscr
	mov	ax,2
	push	ax
	mov	ax,2
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;			if(disp < 0) disp = 7;//-------------------------------------------> farbr�ckstellung bei erreichen von 0
   ;	
	cmp	word ptr [bp-20],0
	jge	short @1@290
	mov	word ptr [bp-20],7
@1@290:
   ;	
   ;			textcolor(BLACK);textbackground(disp);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	push	word ptr [bp-20]
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;			cprintf("+: x%i y%i", syst_x+y_achse, syst_y+x_achse);//-----------> koordinatenursprungsmonitor
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,word ptr [bp-16]
	push	ax
	mov	ax,word ptr [bp-12]
	add	ax,word ptr [bp-18]
	push	ax
	push	ds
	mov	ax,offset s@+86
	push	ax
	call	far ptr _cprintf
	add	sp,8
   ;	
   ;			cprintf("  xy: x%i y%i", y_achse, 31-x_achse);//-------------------> roh-koordinatenmonitor
   ;	
	mov	ax,31
	sub	ax,word ptr [bp-16]
	push	ax
	push	word ptr [bp-18]
	push	ds
	mov	ax,offset s@+97
	push	ax
	call	far ptr _cprintf
	add	sp,8
   ;	
   ;			if(y_symb != 0)//--------------------------------------------------> F() monitor wenn sich beide achsen im funktionsbereich be
   ;	
	or	si,si
	jne	@@0
	jmp	@1@506
@@0:
   ;	
   ;			{
   ;				if((31-x_achse) > 0 && (31-x_achse) <= 30 && y_achse > 0 && y_achse < 61)
   ;	
	mov	ax,31
	sub	ax,word ptr [bp-16]
	jg	@@1
	jmp	@1@506
@@1:
	mov	ax,31
	sub	ax,word ptr [bp-16]
	cmp	ax,30
	jle	@@2
	jmp	@1@506
@@2:
	cmp	word ptr [bp-18],0
	jle	short @1@506
	cmp	word ptr [bp-18],61
	jge	short @1@506
   ;	
   ;				{
   ;					if(fnkt ==  1)cprintf("  F(x=n): n%i F(n)%.2f", y_achse, xy_vektor[(31-x_achse)*2]);  // F(n=x) monitor
   ;	
	cmp	word ptr [bp-42],1
	jne	short @1@458
	mov	bx,31
	sub	bx,word ptr [bp-16]
	shl	bx,1
	shl	bx,1
	shl	bx,1
	FLD	dword ptr _xy_vektor[bx]
	add	sp,65528
	FSTP	qword ptr [bp-64]
	FWAIT	
	push	word ptr [bp-18]
	push	ds
	mov	ax,offset s@+111
	push	ax
	call	far ptr _cprintf
	add	sp,14
@1@458:
   ;	
   ;					if(fnkt == -1)cprintf("  F(y=n): n%i F(n)%.2f", 62-(x_achse*2), xy_vektor[(y_achse)]);// F(n=y) monitor
   ;	
	cmp	word ptr [bp-42],65535
	jne	short @1@506
	mov	bx,word ptr [bp-18]
	shl	bx,1
	shl	bx,1
	FLD	dword ptr _xy_vektor[bx]
	add	sp,65528
	FSTP	qword ptr [bp-64]
	FWAIT	
	mov	ax,word ptr [bp-16]
	shl	ax,1
	mov	dx,62
	sub	dx,ax
	push	dx
	push	ds
	mov	ax,offset s@+134
	push	ax
	call	far ptr _cprintf
	add	sp,14
@1@506:
   ;	
   ;				}
   ;			}
   ;	
   ;			textcolor(DARKGRAY);textbackground(BLACK);cprintf("             ");
   ;	
	mov	ax,8
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	xor	ax,ax
	push	ax
	call	far ptr _textbackground
	inc	sp
	inc	sp
	push	ds
	mov	ax,offset s@+157
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;	
   ;	     	for(iLauf=syst_x; iLauf <=61+syst_x; iLauf++)//--------------------> erzeugung der x-achse
   ;	
	mov	di,word ptr [bp-12]
	jmp	short @1@578
@1@530:
   ;	
   ;	     	{
   ;	   			gotoxy(iLauf, syst_y+x_achse); cprintf("\xc4");
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,word ptr [bp-16]
	push	ax
	push	di
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+171
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	di
@1@578:
	mov	ax,word ptr [bp-12]
	add	ax,61
	cmp	ax,di
	jge	short @1@530
   ;	
   ;			}
   ;			if(fnkt ==  1)//---------------------------------------------------> F(x)
   ;	
	cmp	word ptr [bp-42],1
	jne	short @1@650
   ;	
   ;			{
   ;				gotoxy(iLauf+1, syst_y+x_achse); cprintf("x=n");//-------------> x achsenbeschriftung
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,word ptr [bp-16]
	push	ax
	mov	ax,di
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+173
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				gotoxy(syst_x+y_achse, syst_y-2); cprintf("y=\x9B");//---------> y achsenbeschriftung
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,65534
	push	ax
	mov	ax,word ptr [bp-12]
	add	ax,word ptr [bp-18]
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+177
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@650:
   ;	
   ;			}
   ;			
   ;			if(fnkt ==  -1)//--------------------------------------------------> F(y)
   ;	
	cmp	word ptr [bp-42],65535
	jne	short @1@698
   ;	
   ;			{
   ;				gotoxy(iLauf+1, syst_y+x_achse); cprintf("x=\x9B");//----------> x achsenbeschriftung
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,word ptr [bp-16]
	push	ax
	mov	ax,di
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+181
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				gotoxy(syst_x+y_achse, syst_y-2); cprintf("y=n");//------------> y achsenbeschriftung
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,65534
	push	ax
	mov	ax,word ptr [bp-12]
	add	ax,word ptr [bp-18]
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+185
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@698:
   ;	
   ;			}
   ;			
   ;			for(iLauf=syst_y; iLauf <=31+syst_y; iLauf++)//--------------------> erzeugung der y-achse
   ;	
	mov	di,word ptr [bp-14]
	jmp	short @1@770
@1@722:
   ;	
   ;	     	{
   ;	   			gotoxy(syst_x+y_achse, iLauf); cprintf("\xb3");
   ;	
	push	di
	mov	ax,word ptr [bp-12]
	add	ax,word ptr [bp-18]
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+189
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	di
@1@770:
	mov	ax,word ptr [bp-14]
	add	ax,31
	cmp	ax,di
	jge	short @1@722
   ;	
   ;			}
   ;			
   ;			gotoxy(syst_x+y_achse, syst_y+x_achse); cprintf("\xc5");//---------> koordinatenursprungserzeugung
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,word ptr [bp-16]
	push	ax
	mov	ax,word ptr [bp-12]
	add	ax,word ptr [bp-18]
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+191
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			
   ;			if(fn_disp < 1) fn_disp = 15;//------------------------------------> farbr�ckstellung bei erreichen von 1
   ;	
	cmp	word ptr [bp-22],1
	jge	short @1@842
	mov	word ptr [bp-22],15
@1@842:
   ;	
   ;			textcolor(fn_disp);
   ;	
	push	word ptr [bp-22]
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;			
   ;			if(y_symb != 0)//--------------------------------------------------> Funktionserzeugung F()
   ;	
	or	si,si
	jne	@@3
	jmp	@1@2042
@@3:
   ;	
   ;			{
   ;				index=1;symb_sw=1;
   ;	
	mov	word ptr [bp-28],1
	mov	word ptr [bp-40],1
   ;	
   ;				if(y_symb < 0) y_symb = 6;//-----------------------------------> kurvensymbolr�ckstellung bei erreichen von -1
   ;	
	or	si,si
	jge	short @1@914
	mov	si,6
@1@914:
   ;	
   ;				
   ;				if(fnkt == 1)//------------------------------------------------> xy funktionskurvenerzeugung F(x)
   ;	
	cmp	word ptr [bp-42],1
	je	@@4
	jmp	@1@1442
@@4:
   ;	
   ;				{
   ;					for(iLauf=syst_x+1; iLauf <=61-1+syst_x; iLauf++)
   ;	
	mov	ax,word ptr [bp-12]
	inc	ax
	mov	di,ax
	jmp	@1@1418
@1@962:
   ;	
   ;	     			{
   ;	   					//-----------------------------------------------------> y' transformation
   ;						//
   ;						y_wert=((xy_vektor[index]/(xy_vektor[60]/((31-1)*2)))-(xy_vektor[1]/(xy_vektor[60]/((31-1)*2))));index++;
   ;	
	mov	bx,word ptr [bp-28]
	shl	bx,1
	shl	bx,1
	FLD	dword ptr _xy_vektor[bx]
	FLD	dword ptr _xy_vektor+240
	FDIV	dword ptr s@+193
	FDIV	
	FLD	dword ptr _xy_vektor+240
	FDIV	dword ptr s@+193
	FDIVR	dword ptr _xy_vektor+4
	FSUB	
	call	far ptr F_FTOL@
	mov	word ptr [bp-24],ax
	inc	word ptr [bp-28]
   ;	
   ;				
   ;						gotoxy(iLauf, 31-1+syst_y-y_wert);
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,30
	sub	ax,word ptr [bp-24]
	push	ax
	push	di
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;	    				if(y_symb == 0) cprintf("-");
   ;	
	or	si,si
	jne	short @1@1010
	push	ds
	mov	ax,offset s@+197
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1010:
   ;	
   ;						if(y_symb == 1) cprintf("\xB0");
   ;	
	cmp	si,1
	jne	short @1@1058
	push	ds
	mov	ax,offset s@+199
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1058:
   ;	
   ;						if(y_symb == 2) cprintf("\xDC");
   ;	
	cmp	si,2
	jne	short @1@1106
	push	ds
	mov	ax,offset s@+201
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1106:
   ;	
   ;						if(y_symb == 3) cprintf("\x2E");
   ;	
	cmp	si,3
	jne	short @1@1154
	push	ds
	mov	ax,offset s@+203
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1154:
   ;	
   ;						if(y_symb == 4) cprintf("\xF7");
   ;	
	cmp	si,4
	jne	short @1@1202
	push	ds
	mov	ax,offset s@+205
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1202:
   ;	
   ;						if(y_symb == 5) 
   ;	
	cmp	si,5
	jne	short @1@1346
   ;	
   ;						{
   ;							if (symb_sw ==   1)cprintf(".");
   ;	
	cmp	word ptr [bp-40],1
	jne	short @1@1274
	push	ds
	mov	ax,offset s@+207
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1274:
   ;	
   ;							if (symb_sw ==  -1)cprintf("-");
   ;	
	cmp	word ptr [bp-40],65535
	jne	short @1@1322
	push	ds
	mov	ax,offset s@+209
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1322:
   ;	
   ;							symb_sw *=-1;
   ;	
	mov	dx,65535
	mov	ax,word ptr [bp-40]
	imul	dx
	mov	word ptr [bp-40],ax
@1@1346:
   ;	
   ;						}
   ;						if(y_symb == 6) cprintf(",");
   ;	
	cmp	si,6
	jne	short @1@1394
	push	ds
	mov	ax,offset s@+211
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1394:
	inc	di
@1@1418:
	mov	ax,word ptr [bp-12]
	add	ax,60
	cmp	ax,di
	jl	@@5
	jmp	@1@962
@@5:
@1@1442:
   ;	
   ;					}
   ;				}
   ;				
   ;				if(fnkt == -1)//-----------------------------------------------> yx funktionskurvenerzeugung F(y)
   ;	
	cmp	word ptr [bp-42],65535
	je	@@6
	jmp	@1@2042
@@6:
   ;	
   ;				{
   ;					for(iLauf=syst_y+30; iLauf >= syst_y+1; iLauf--)
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,30
	mov	di,ax
	jmp	@1@2018
@1@1490:
   ;	
   ;	     			{
   ;	   					for(jLauf=1; jLauf <=2; jLauf++)//---------------------> 2maliger plot von y auf x wegen(x'max=2y'max)
   ;	
	mov	word ptr [bp-10],1
	jmp	@1@1970
@1@1514:
   ;	
   ;						{
   ;							//-------------------------------------------------> x' transformation
   ;							//
   ;							x_wert=((xy_vektor[index]/(xy_vektor[60]/((61-1)*2)))-(xy_vektor[1]/(xy_vektor[60]/((61-1)*2))));index++;
   ;	
	mov	bx,word ptr [bp-28]
	shl	bx,1
	shl	bx,1
	FLD	dword ptr _xy_vektor[bx]
	FLD	dword ptr _xy_vektor+240
	FDIV	dword ptr s@+213
	FDIV	
	FLD	dword ptr _xy_vektor+240
	FDIV	dword ptr s@+213
	FDIVR	dword ptr _xy_vektor+4
	FSUB	
	call	far ptr F_FTOL@
	mov	word ptr [bp-26],ax
	inc	word ptr [bp-28]
   ;	
   ;				
   ;							gotoxy(1+syst_x+x_wert, iLauf);
   ;	
	push	di
	mov	ax,word ptr [bp-12]
	add	ax,word ptr [bp-26]
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;	    					if(y_symb == 0) cprintf("-");
   ;	
	or	si,si
	jne	short @1@1562
	push	ds
	mov	ax,offset s@+217
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1562:
   ;	
   ;							if(y_symb == 1) cprintf("\xB0");
   ;	
	cmp	si,1
	jne	short @1@1610
	push	ds
	mov	ax,offset s@+219
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1610:
   ;	
   ;							if(y_symb == 2) cprintf("\xDC");
   ;	
	cmp	si,2
	jne	short @1@1658
	push	ds
	mov	ax,offset s@+221
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1658:
   ;	
   ;							if(y_symb == 3) cprintf("\x2E");
   ;	
	cmp	si,3
	jne	short @1@1706
	push	ds
	mov	ax,offset s@+223
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1706:
   ;	
   ;							if(y_symb == 4) cprintf("\xF7");
   ;	
	cmp	si,4
	jne	short @1@1754
	push	ds
	mov	ax,offset s@+225
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1754:
   ;	
   ;							if(y_symb == 6) 
   ;	
	cmp	si,6
	jne	short @1@1898
   ;	
   ;							{
   ;								if (symb_sw ==   1)cprintf(".");
   ;	
	cmp	word ptr [bp-40],1
	jne	short @1@1826
	push	ds
	mov	ax,offset s@+227
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1826:
   ;	
   ;								if (symb_sw ==  -1)cprintf("-");
   ;	
	cmp	word ptr [bp-40],65535
	jne	short @1@1874
	push	ds
	mov	ax,offset s@+229
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1874:
   ;	
   ;								symb_sw *=-1;
   ;	
	mov	dx,65535
	mov	ax,word ptr [bp-40]
	imul	dx
	mov	word ptr [bp-40],ax
@1@1898:
   ;	
   ;							}
   ;							if(y_symb == 5) cprintf(",");	
   ;	
	cmp	si,5
	jne	short @1@1946
	push	ds
	mov	ax,offset s@+231
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1946:
	inc	word ptr [bp-10]
@1@1970:
	cmp	word ptr [bp-10],2
	jg	@@7
	jmp	@1@1514
@@7:
	dec	di
@1@2018:
	mov	ax,word ptr [bp-14]
	inc	ax
	cmp	ax,di
	jg	@@8
	jmp	@1@1490
@@8:
@1@2042:
   ;	
   ;						}
   ;					}
   ;				}
   ;			}//F() end
   ;			
   ;			if(init == 1)//----------------------------------------------------> initialfenster
   ;	
	cmp	word ptr [bp-38],1
	jne	short @1@2090
   ;	
   ;			{
   ;				textcolor(DARKGRAY);
   ;	
	mov	ax,8
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;				gotoxy(45, 48);cprintf("GRAPH01 by Dietmar Schrausser \r\n");//> fenster
   ;	
	mov	ax,48
	push	ax
	mov	ax,45
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+233
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				gotoxy(45, 49);cprintf("compiled on %s @ %s", __DATE__, __TIME__);// fenster
   ;	
	mov	ax,49
	push	ax
	mov	ax,45
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+298
	push	ax
	push	ds
	mov	ax,offset s@+286
	push	ax
	push	ds
	mov	ax,offset s@+266
	push	ax
	call	far ptr _cprintf
	add	sp,12
@1@2090:
   ;	
   ;			}
   ;		
   ;			if(inff == 1)//----------------------------------------------------> infofenster
   ;	
	cmp	word ptr [bp-30],1
	je	@@9
	jmp	@1@2450
@@9:
   ;	
   ;			{
   ;				if(inftyp == 1)//----------------------------------------------> Tastaturbelegung
   ;	
	cmp	word ptr [bp-32],1
	je	@@10
	jmp	@1@2162
@@10:
   ;	
   ;				{
   ;					textcolor(BLACK);textbackground(WHITE);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	mov	ax,15
	push	ax
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;					gotoxy(inff_x, inff_y);
   ;	
	push	word ptr [bp-36]
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("Tastaturbelegung:   \r\n");
   ;	
	push	ds
	mov	ax,offset s@+307
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					textcolor(DARKGRAY);textbackground(BLACK);
   ;	
	mov	ax,8
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	xor	ax,ax
	push	ax
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;					gotoxy(inff_x, inff_y+1);
   ;	
	mov	ax,word ptr [bp-36]
	inc	ax
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\r\n");
   ;	
	push	ds
	mov	ax,offset s@+330
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+2);
   ;	
	mov	ax,word ptr [bp-36]
	inc	ax
	inc	ax
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("xyAchsen: xySystem: \r\n");
   ;	
	push	ds
	mov	ax,offset s@+353
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+3);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,3
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("                    \r\n");
   ;	
	push	ds
	mov	ax,offset s@+376
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+4);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,4
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("   [W]        [I]   \r\n");
   ;	
	push	ds
	mov	ax,offset s@+399
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+5);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,5
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("    \x1E          \x1E    \r\n");
   ;	
	push	ds
	mov	ax,offset s@+422
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+6);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,6
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("[A]\x11 \x10[D]  [J]\x11 \x10[L]\r\n");
   ;	
	push	ds
	mov	ax,offset s@+445
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+7);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,7
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("    \x1F          \x1F    \r\n");
   ;	
	push	ds
	mov	ax,offset s@+468
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+8);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,8
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("   [S]        [K]   \r\n");
   ;	
	push	ds
	mov	ax,offset s@+491
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+9);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,9
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("                    \r\n");
   ;	
	push	ds
	mov	ax,offset s@+514
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+10);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,10
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("[X]F(x)/F(y)        \r\n");
   ;	
	push	ds
	mov	ax,offset s@+537
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+11);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,11
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("[Y]Kurve [C][V]Farbe\r\n");
   ;	
	push	ds
	mov	ax,offset s@+560
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+12);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,12
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("[Q]Ende  [M][P]Infrm\r\n");
   ;	
	push	ds
	mov	ax,offset s@+583
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(inff_x, inff_y+13);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,13
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("                [R]\x1A\r\n");
   ;	
	push	ds
	mov	ax,offset s@+606
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@2162:
   ;	
   ;				}
   ;				
   ;				if(inftyp == -1)//----------------------------------------------> Funktionswerte
   ;	
	cmp	word ptr [bp-32],65535
	je	@@11
	jmp	@1@2450
@@11:
   ;	
   ;				{
   ;					textcolor(BLACK);textbackground(WHITE);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	mov	ax,15
	push	ax
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;					gotoxy(inff_x, inff_y);
   ;	
	push	word ptr [bp-36]
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("Funktionswerte:     \r\n");
   ;	
	push	ds
	mov	ax,offset s@+629
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					textcolor(DARKGRAY);textbackground(BLACK);
   ;	
	mov	ax,8
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	xor	ax,ax
	push	ax
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;					gotoxy(inff_x, inff_y+1);
   ;	
	mov	ax,word ptr [bp-36]
	inc	ax
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\r\n");
   ;	
	push	ds
	mov	ax,offset s@+652
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					if(fnkt ==  1)p_wert = 1-((31-x_achse)/30.0);//-------------> Prozentrangberechnung py
   ;	
	cmp	word ptr [bp-42],1
	jne	short @1@2234
	mov	ax,31
	sub	ax,word ptr [bp-16]
	mov	word ptr [bp-50],ax
	FILD	word ptr [bp-50]
	FDIV	dword ptr s@+675
	FLD1	
	FSUBR	
	FSTP	dword ptr [bp-46]
	FWAIT	
@1@2234:
   ;	
   ;					if(fnkt == -1)p_wert = 1-(y_achse/60.0);//------------------> Prozentrangberechnung px
   ;	
	cmp	word ptr [bp-42],65535
	jne	short @1@2282
	mov	ax,word ptr [bp-18]
	mov	word ptr [bp-50],ax
	FILD	word ptr [bp-50]
	FDIV	dword ptr s@+193
	FLD1	
	FSUBR	
	FSTP	dword ptr [bp-46]
	FWAIT	
@1@2282:
   ;	
   ;					gotoxy(inff_x, inff_y+2);
   ;	
	mov	ax,word ptr [bp-36]
	inc	ax
	inc	ax
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					//----------------------------------------------------------> p_wert monitor wenn sich beide achsen im funktionsbereich befi
   ;					if((31-x_achse) > 0 && (31-x_achse) <= 30 && y_achse > 0 && y_achse < 61)
   ;	
	mov	ax,31
	sub	ax,word ptr [bp-16]
	jle	short @1@2402
	mov	ax,31
	sub	ax,word ptr [bp-16]
	cmp	ax,30
	jg	short @1@2402
	cmp	word ptr [bp-18],0
	jle	short @1@2402
	cmp	word ptr [bp-18],61
	jge	short @1@2402
   ;	
   ;					{
   ;						cprintf("p=%.3f  \r\n", p_wert);
   ;	
	FLD	dword ptr [bp-46]
	add	sp,65528
	FSTP	qword ptr [bp-64]
	push	ds
	mov	ax,offset s@+679
	push	ax
	FWAIT	
	call	far ptr _cprintf
	add	sp,12
   ;	
   ;					}
   ;	
	jmp	short @1@2426
@1@2402:
   ;	
   ;					else
   ;					{	cprintf("p={}  \r\n");
   ;	
	push	ds
	mov	ax,offset s@+690
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@2426:
   ;	
   ;					}
   ;					gotoxy(inff_x, inff_y+3);
   ;	
	mov	ax,word ptr [bp-36]
	add	ax,3
	push	ax
	push	word ptr [bp-34]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					cprintf("                [R]\x1A\r\n");
   ;	
	push	ds
	mov	ax,offset s@+699
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@2450:
   ;	
   ;				}
   ;			}
   ;			
   ;	    	gotoxy(1, syst_y+x_achse+1);//-------------------------------------> endposition
   ;	
	mov	ax,word ptr [bp-14]
	add	ax,word ptr [bp-16]
	inc	ax
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	jmp	short @1@2474
@1@2474:
   ;	
   ;	    		
   ;			while (!kbhit());//------------------------------------------------> tastendruckerwartung
   ;	
	call	far ptr _kbhit
	or	ax,ax
	je	short @1@2474
   ;	
   ;			taste=getch();//---------------------------------------------------> zuordnung der aktivierten taste
   ;	
	call	far ptr _getch
	mov	byte ptr [bp-47],al
   ;	
   ;			
   ;			//-----------------------------------------------------------------> ereignisse
   ;			if(taste == 'm') init *=-1;//--------------------------------------> m_taste schaltet das initialfenster
   ;	
	cmp	byte ptr [bp-47],109
	jne	short @1@2546
	mov	dx,65535
	mov	ax,word ptr [bp-38]
	imul	dx
	mov	word ptr [bp-38],ax
@1@2546:
   ;	
   ;			
   ;			if(taste == 'p') inff *=-1;//--------------------------------------> p_taste schaltet das infofenster
   ;	
	cmp	byte ptr [bp-47],112
	jne	short @1@2594
	mov	dx,65535
	mov	ax,word ptr [bp-30]
	imul	dx
	mov	word ptr [bp-30],ax
@1@2594:
   ;	
   ;			if(inff == 1) 
   ;	
	cmp	word ptr [bp-30],1
	jne	short @1@2666
   ;	
   ;			{
   ;				if(taste == 'r') inftyp *=-1;//----------------------------------> r_taste schaltet zwischen infofenstertypus
   ;	
	cmp	byte ptr [bp-47],114
	jne	short @1@2666
	mov	dx,65535
	mov	ax,word ptr [bp-32]
	imul	dx
	mov	word ptr [bp-32],ax
@1@2666:
   ;	
   ;			}
   ;			if(taste == 'f') inff_x--;//---------------------------------------> f_taste verschiebt infofenster nach links 
   ;	
	cmp	byte ptr [bp-47],102
	jne	short @1@2714
	dec	word ptr [bp-34]
@1@2714:
   ;	
   ;			if(taste == 'h') inff_x++;//---------------------------------------> h_taste verschiebt infofenster nach rechts
   ;	
	cmp	byte ptr [bp-47],104
	jne	short @1@2762
	inc	word ptr [bp-34]
@1@2762:
   ;	
   ;	
   ;			if(taste == 't') inff_y--;//---------------------------------------> t_taste verschiebt infofenster nach oben
   ;	
	cmp	byte ptr [bp-47],116
	jne	short @1@2810
	dec	word ptr [bp-36]
@1@2810:
   ;	
   ;			if(taste == 'g') inff_y++;//---------------------------------------> g-taste verschiebt infofenster nach unten
   ;	
	cmp	byte ptr [bp-47],103
	jne	short @1@2858
	inc	word ptr [bp-36]
@1@2858:
   ;	
   ;			
   ;			if(taste == 'x') fnkt *=-1;//--------------------------------------> x_taste schaltet zwischen F(x) und F(y)
   ;	
	cmp	byte ptr [bp-47],120
	jne	short @1@2906
	mov	dx,65535
	mov	ax,word ptr [bp-42]
	imul	dx
	mov	word ptr [bp-42],ax
@1@2906:
   ;	
   ;			if(taste == 'y') y_symb--;//---------------------------------------> y_taste schaltet kurvensymbol	
   ;	
	cmp	byte ptr [bp-47],121
	jne	short @1@2954
	dec	si
@1@2954:
   ;	
   ;			
   ;			if(taste == 'v') fn_disp--;//--------------------------------------> v_taste schaltet kurvenfarbe	
   ;	
	cmp	byte ptr [bp-47],118
	jne	short @1@3002
	dec	word ptr [bp-22]
@1@3002:
   ;	
   ;			if(taste == 'c') disp--;//-----------------------------------------> c_taste schaltet displayfarbe 
   ;	
	cmp	byte ptr [bp-47],99
	jne	short @1@3050
	dec	word ptr [bp-20]
@1@3050:
   ;	
   ;	
   ;			if(taste == 'w') x_achse--;//--------------------------------------> w_taste verschiebt x_achse nach oben
   ;	
	cmp	byte ptr [bp-47],119
	jne	short @1@3098
	dec	word ptr [bp-16]
@1@3098:
   ;	
   ;			if(taste == 's') x_achse++;//--------------------------------------> s_taste verschiebt x_achse nach unten
   ;	
	cmp	byte ptr [bp-47],115
	jne	short @1@3146
	inc	word ptr [bp-16]
@1@3146:
   ;	
   ;			
   ;			if(taste == 'a') y_achse--;//--------------------------------------> a_taste verschiebt y_achse nach links
   ;	
	cmp	byte ptr [bp-47],97
	jne	short @1@3194
	dec	word ptr [bp-18]
@1@3194:
   ;	
   ;			if(taste == 'd') y_achse++;//--------------------------------------> d_taste verschiebt y_achse nach rechts
   ;	
	cmp	byte ptr [bp-47],100
	jne	short @1@3242
	inc	word ptr [bp-18]
@1@3242:
   ;	
   ;			
   ;			if(taste == 'j') syst_x--;//---------------------------------------> j_taste verschiebt graph nach links 
   ;	
	cmp	byte ptr [bp-47],106
	jne	short @1@3290
	dec	word ptr [bp-12]
@1@3290:
   ;	
   ;			if(taste == 'l') syst_x++;//---------------------------------------> l_taste verschiebt graph nach rechts
   ;	
	cmp	byte ptr [bp-47],108
	jne	short @1@3338
	inc	word ptr [bp-12]
@1@3338:
   ;	
   ;			
   ;			if(taste == 'i') syst_y--;//---------------------------------------> i_taste verschiebt graph nach oben
   ;	
	cmp	byte ptr [bp-47],105
	jne	short @1@3386
	dec	word ptr [bp-14]
@1@3386:
   ;	
   ;			if(taste == 'k') syst_y++;//---------------------------------------> k-taste verschiebt graph nach unten
   ;	
	cmp	byte ptr [bp-47],107
	jne	short @1@3434
	inc	word ptr [bp-14]
@1@3434:
   ;	
   ;			if(taste == 'q') 
   ;	
	cmp	byte ptr [bp-47],113
	jne	short @1@3482
   ;	
   ;			{
   ;				iniStream = fopen ("graph.ini", "w");//------------------------> schreibt aktuelle koordinatensystempositionen in ini datei
   ;	
	push	ds
	mov	ax,offset s@+732
	push	ax
	push	ds
	mov	ax,offset s@+722
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;				fprintf( iniStream,"%i %i %i %i", syst_x, syst_y, x_achse, y_achse); 
   ;	
	push	word ptr [bp-18]
	push	word ptr [bp-16]
	push	word ptr [bp-14]
	push	word ptr [bp-12]
	push	ds
	mov	ax,offset s@+734
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,16
   ;	
   ;				fclose( iniStream );
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;				clrscr(); exit(EXIT_SUCCESS);
   ;	
	call	far ptr _clrscr
	xor	ax,ax
	push	ax
	call	far ptr _exit
	inc	sp
	inc	sp
@1@3482:
	jmp	@1@242
   ;	
   ;			}	
   ;		}		
   ;	}
   ;	
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_main	endp
GRAPH01_TEXT	ends
GRAPH01_DATA	segment word public 'DATA'
_xy_vektor	label	dword
	db	240 dup (?)
	?debug	C E9
s@	label	byte
	db	'graph.ini'
	db	0
	db	'r'
	db	0
	db	'graph.ini'
	db	0
	db	'w'
	db	0
	db	'10 8 31 0'
	db	0
	db	'graph.ini'
	db	0
	db	'r'
	db	0
	db	'%i%i%i%i'
	db	0
	db	'xy_vekt.asc'
	db	0
	db	'r'
	db	0
	db	'xy_vekt.asc'
	db	0
	db	'r'
	db	0
	db	'%f'
	db	0
	db	'+: x%i y%i'
	db	0
	db	'  xy: x%i y%i'
	db	0
	db	'  F(x=n): n%i F(n)%.2f'
	db	0
	db	'  F(y=n): n%i F(n)%.2f'
	db	0
	db	'             '
	db	0
	db	-60
	db	0
	db	'x=n'
	db	0
	db	'y='
	db	-101
	db	0
	db	'x='
	db	-101
	db	0
	db	'y=n'
	db	0
	db	-77
	db	0
	db	-59
	db	0
	db	0
	db	0
	db	'pB-'
	db	0
	db	-80
	db	0
	db	-36
	db	0
	db	'.'
	db	0
	db	-9
	db	0
	db	'.'
	db	0
	db	'-'
	db	0
	db	','
	db	0
	db	0
	db	0
	db	-16
	db	'B-'
	db	0
	db	-80
	db	0
	db	-36
	db	0
	db	'.'
	db	0
	db	-9
	db	0
	db	'.'
	db	0
	db	'-'
	db	0
	db	','
	db	0
	db	'GRAPH01 by Dietmar Schrausser '
	db	13
	db	10
	db	0
	db	'compiled on %s @ %s'
	db	0
	db	'Nov 23 2009'
	db	0
	db	'22:48:00'
	db	0
	db	'Tastaturbelegung:   '
	db	13
	db	10
	db	0
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	13
	db	10
	db	0
	db	'xyAchsen: xySystem: '
	db	13
	db	10
	db	0
	db	'                    '
	db	13
	db	10
	db	0
	db	'   [W]        [I]   '
	db	13
	db	10
	db	0
	db	'    '
	db	30
	db	'          '
	db	30
	db	'    '
	db	13
	db	10
	db	0
	db	'[A]'
	db	17
	db	' '
	db	16
	db	'[D]  [J]'
	db	17
	db	' '
	db	16
	db	'[L]'
	db	13
	db	10
	db	0
	db	'    '
	db	31
	db	'          '
	db	31
	db	'    '
	db	13
	db	10
	db	0
	db	'   [S]        [K]   '
	db	13
	db	10
	db	0
	db	'                    '
	db	13
	db	10
	db	0
	db	'[X]F(x)/F(y)        '
	db	13
	db	10
	db	0
	db	'[Y]Kurve [C][V]Farbe'
	db	13
	db	10
	db	0
	db	'[Q]Ende  [M][P]Infrm'
	db	13
	db	10
	db	0
	db	'                [R]'
	db	26
	db	13
	db	10
	db	0
	db	'Funktionswerte:     '
	db	13
	db	10
	db	0
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	13
	db	10
	db	0
	db	0
	db	0
	db	-16
	db	'Ap=%.3f  '
	db	13
	db	10
	db	0
	db	'p={}  '
	db	13
	db	10
	db	0
	db	'                [R]'
	db	26
	db	13
	db	10
	db	0
	db	'graph.ini'
	db	0
	db	'w'
	db	0
	db	'%i %i %i %i'
	db	0
GRAPH01_DATA	ends
GRAPH01_TEXT	segment byte public 'CODE'
GRAPH01_TEXT	ends
	extrn	__turboFloat:word
	extrn	_fopen:far
	public	_xy_vektor
	extrn	_textcolor:far
	extrn	_kbhit:far
	extrn	__setcursortype:far
	extrn	_fprintf:far
	extrn	_cprintf:far
	extrn	_getch:far
	public	_main
	extrn	_clrscr:far
	extrn	_exit:far
	extrn	_gotoxy:far
	extrn	_fclose:far
	extrn	F_FTOL@:far
	extrn	_textbackground:far
	extrn	_fscanf:far
	end 
