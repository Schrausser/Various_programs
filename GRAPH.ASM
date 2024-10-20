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
	?debug	S "graph.c"
	?debug	C E93B03773A0767726170682E63
	?debug	C E920085C1613433A5C54435C494E434C5544455C646F732E68
	?debug	C E920085C1615433A5C54435C494E434C5544455C737464696F2E68
	?debug	C E920085C1616433A5C54435C494E434C5544455C7374646C69622E+
	?debug	C 68
	?debug	C E920085C1615433A5C54435C494E434C5544455C636F6E696F2E68
GRAPH_TEXT	segment byte public 'CODE'
GRAPH_TEXT	ends
	assume	cs:GRAPH_TEXT,ds:GRAPH_DATA
GRAPH_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
b@	label	byte
b@w	label	word
GRAPH_DATA	ends
GRAPH_TEXT	segment byte public 'CODE'
   ;	
   ;	void main()
   ;	
	assume	cs:GRAPH_TEXT
_main	proc	far
	push	bp
	mov	bp,sp
	sub	sp,16
	push	si
	push	di
	push	ds
	mov	ax,GRAPH_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		FILE *iniStream;
   ;	
   ;		int iLauf, syst_x, syst_y, x_achse, y_achse, itaste, disp, fn_disp;
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
	lea	ax,word ptr [bp-12]
	push	ax
	push	ss
	lea	ax,word ptr [bp-10]
	push	ax
	push	ss
	lea	ax,word ptr [bp-8]
	push	ax
	push	ss
	lea	ax,word ptr [bp-6]
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
   ;		_setcursortype(_NOCURSOR);//-------------------------------------------> unterdr�ckt cursoranzeige
   ;	
	xor	ax,ax
	push	ax
	call	far ptr __setcursortype
	inc	sp
	inc	sp
   ;	
   ;		disp = 7; fn_disp= 15;//-----------------------------------------------> farbvoreinstellungen
   ;	
	mov	word ptr [bp-14],7
	mov	di,15
@1@98:
   ;	
   ;		
   ;		while(1)//--------------------------------------------------------------| hauptschleife
   ;		{
   ;			clrscr(); gotoxy(2, 2); 
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
	cmp	word ptr [bp-14],0
	jge	short @1@146
	mov	word ptr [bp-14],7
@1@146:
   ;	
   ;			textcolor(BLACK);textbackground(disp);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	push	word ptr [bp-14]
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;			cprintf("+: x%i y%i", syst_x+y_achse, syst_y+x_achse);//-----------> koordinatenursprungsmonitor
   ;	
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-10]
	push	ax
	mov	ax,word ptr [bp-6]
	add	ax,word ptr [bp-12]
	push	ax
	push	ds
	mov	ax,offset s@+55
	push	ax
	call	far ptr _cprintf
	add	sp,8
   ;	
   ;	
   ;			textcolor(DARKGRAY);textbackground(BLACK);
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
   ;	
   ;	     	for(iLauf=syst_x; iLauf <=61+syst_x; iLauf++)//--------------------> erzeugung der x-achse
   ;	
	mov	si,word ptr [bp-6]
	jmp	short @1@218
@1@170:
   ;	
   ;	     	{
   ;	   			gotoxy(iLauf, syst_y+x_achse); cprintf("\xc4");
   ;	
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-10]
	push	ax
	push	si
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+66
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	si
@1@218:
	mov	ax,word ptr [bp-6]
	add	ax,61
	cmp	ax,si
	jge	short @1@170
   ;	
   ;			}
   ;	
   ;			for(iLauf=syst_y; iLauf <=31+syst_y; iLauf++)//--------------------> erzeugung y-achse
   ;	
	mov	si,word ptr [bp-8]
	jmp	short @1@314
@1@266:
   ;	
   ;	     	{
   ;	   			gotoxy(syst_x+y_achse, iLauf); cprintf("\xb3");
   ;	
	push	si
	mov	ax,word ptr [bp-6]
	add	ax,word ptr [bp-12]
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+68
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	si
@1@314:
	mov	ax,word ptr [bp-8]
	add	ax,31
	cmp	ax,si
	jge	short @1@266
   ;	
   ;			}
   ;		
   ;			gotoxy(syst_x+y_achse, syst_y+x_achse); cprintf("\xc5");//---------> koordinatenursprungserzeugung
   ;	
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-10]
	push	ax
	mov	ax,word ptr [bp-6]
	add	ax,word ptr [bp-12]
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+70
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			
   ;			
   ;			if(fn_disp < 0) fn_disp = 15;//------------------------------------> farbr�ckstellung bei erreichen von 0
   ;	
	or	di,di
	jge	short @1@386
	mov	di,15
@1@386:
   ;	
   ;			textcolor(fn_disp);
   ;	
	push	di
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;			
   ;			for(iLauf=syst_x+10; iLauf <=31+syst_x; iLauf++)//-----------------> demonstrationsfunktionskurve
   ;	
	mov	ax,word ptr [bp-6]
	add	ax,10
	mov	si,ax
	jmp	short @1@458
@1@410:
   ;	
   ;	     	{
   ;	   			gotoxy(iLauf, (34-(iLauf-syst_x))+syst_y);
   ;	
	mov	ax,si
	sub	ax,word ptr [bp-6]
	mov	dx,34
	sub	dx,ax
	add	dx,word ptr [bp-8]
	push	dx
	push	si
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;	    		cprintf(",");
   ;	
	push	ds
	mov	ax,offset s@+72
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	si
@1@458:
	mov	ax,word ptr [bp-6]
	add	ax,31
	cmp	ax,si
	jge	short @1@410
   ;	
   ;			}
   ;		
   ;	    	gotoxy(1, syst_y+x_achse+1);//--------------------------------------> endposition
   ;	
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-10]
	inc	ax
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	jmp	short @1@506
@1@506:
   ;	
   ;	    		
   ;			while (!kbhit());//------------------------------------------------> tastendruckerwartung
   ;	
	call	far ptr _kbhit
	or	ax,ax
	je	short @1@506
   ;	
   ;			taste=getch();//---------------------------------------------------> zuordnung der aktivierten taste
   ;	
	call	far ptr _getch
	mov	byte ptr [bp-15],al
   ;	
   ;			
   ;			//-----------------------------------------------------------------> ereignisse
   ;			if(taste == 'v') fn_disp--;//--------------------------------------> v_taste �ndert kurvenfarbe	
   ;	
	cmp	byte ptr [bp-15],118
	jne	short @1@578
	dec	di
@1@578:
   ;	
   ;			if(taste == 'c') disp--;//-----------------------------------------> c_taste �ndert displayfarbe 
   ;	
	cmp	byte ptr [bp-15],99
	jne	short @1@626
	dec	word ptr [bp-14]
@1@626:
   ;	
   ;	
   ;			if(taste == 'w') x_achse--;//--------------------------------------> w_taste verschiebt x_achse nach oben
   ;	
	cmp	byte ptr [bp-15],119
	jne	short @1@674
	dec	word ptr [bp-10]
@1@674:
   ;	
   ;			if(taste == 's') x_achse++;//--------------------------------------> s_taste verschiebt x_achse nach unten
   ;	
	cmp	byte ptr [bp-15],115
	jne	short @1@722
	inc	word ptr [bp-10]
@1@722:
   ;	
   ;			
   ;			if(taste == 'a') y_achse--;//--------------------------------------> a_taste verschiebt y_achse nach links
   ;	
	cmp	byte ptr [bp-15],97
	jne	short @1@770
	dec	word ptr [bp-12]
@1@770:
   ;	
   ;			if(taste == 'd') y_achse++;//--------------------------------------> d_taste verschiebt y_achse nach rechts
   ;	
	cmp	byte ptr [bp-15],100
	jne	short @1@818
	inc	word ptr [bp-12]
@1@818:
   ;	
   ;			
   ;			if(taste == 'j') syst_x--;//---------------------------------------> j_taste verschiebt graph nach links 
   ;	
	cmp	byte ptr [bp-15],106
	jne	short @1@866
	dec	word ptr [bp-6]
@1@866:
   ;	
   ;			if(taste == 'l') syst_x++;//---------------------------------------> l_taste verschiebt graph nach rechts
   ;	
	cmp	byte ptr [bp-15],108
	jne	short @1@914
	inc	word ptr [bp-6]
@1@914:
   ;	
   ;			
   ;			if(taste == 'i') syst_y--;//---------------------------------------> i_taste verschiebt graph nach oben
   ;	
	cmp	byte ptr [bp-15],105
	jne	short @1@962
	dec	word ptr [bp-8]
@1@962:
   ;	
   ;			if(taste == 'k') syst_y++;//---------------------------------------> k-taste verschiebt graph nach unten
   ;	
	cmp	byte ptr [bp-15],107
	jne	short @1@1010
	inc	word ptr [bp-8]
@1@1010:
   ;	
   ;			if(taste == 'q') 
   ;	
	cmp	byte ptr [bp-15],113
	jne	short @1@1058
   ;	
   ;			{
   ;				iniStream = fopen ("graph.ini", "w");//------------------------> schreibt aktuelle koordinatensystempositionen in ini datei
   ;	
	push	ds
	mov	ax,offset s@+84
	push	ax
	push	ds
	mov	ax,offset s@+74
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;				fprintf( iniStream,"%i %i %i %i", syst_x, syst_y, x_achse, y_achse); 
   ;	
	push	word ptr [bp-12]
	push	word ptr [bp-10]
	push	word ptr [bp-8]
	push	word ptr [bp-6]
	push	ds
	mov	ax,offset s@+86
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
@1@1058:
	jmp	@1@98
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
GRAPH_TEXT	ends
GRAPH_DATA	segment word public 'DATA'
_x_vektor	label	qword
	db	480 dup (?)
_y_vektor	label	qword
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
	db	'+: x%i y%i'
	db	0
	db	-60
	db	0
	db	-77
	db	0
	db	-59
	db	0
	db	','
	db	0
	db	'graph.ini'
	db	0
	db	'w'
	db	0
	db	'%i %i %i %i'
	db	0
GRAPH_DATA	ends
GRAPH_TEXT	segment byte public 'CODE'
GRAPH_TEXT	ends
	extrn	_fopen:far
	extrn	_textcolor:far
	extrn	_kbhit:far
	extrn	__setcursortype:far
	extrn	_fprintf:far
	extrn	_cprintf:far
	extrn	_getch:far
	public	_main
	extrn	_clrscr:far
	public	_y_vektor
	public	_x_vektor
	extrn	_exit:far
	extrn	_gotoxy:far
	extrn	_fclose:far
	extrn	_textbackground:far
	extrn	_fscanf:far
	end
