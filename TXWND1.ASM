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
	?debug	S "txwnd1.c"
	?debug	C E9A988973A087478776E64312E63
	?debug	C E92CB3973A087478776E64312E68
	?debug	C E920105C1613433A5C54435C494E434C5544455C646F732E68
	?debug	C E920105C1615433A5C54435C494E434C5544455C737464696F2E68
	?debug	C E920105C1616433A5C54435C494E434C5544455C7374646C69622E+
	?debug	C 68
	?debug	C E920105C1615433A5C54435C494E434C5544455C636F6E696F2E68
TXWND1_TEXT	segment byte public 'CODE'
TXWND1_TEXT	ends
	assume	cs:TXWND1_TEXT,ds:TXWND1_DATA
TXWND1_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
b@	label	byte
b@w	label	word
_index	label	word
	db	1
	db	0
_index1	label	word
	db	1
	db	0
_zlnlng	label	word
	db	0
	db	0
_x_pos	label	word
	db	21
	db	0
_y_pos	label	word
	db	17
	db	0
_x_cpos	label	word
	db	22
	db	0
_y_cpos	label	word
	db	22
	db	0
_x_grd	label	word
	db	1
	db	0
_y_grd	label	word
	db	1
	db	0
_disp	label	word
	db	0
	db	0
_tx_disp	label	word
	db	6
	db	0
_tx_disp2	label	word
	db	8
	db	0
_idisp	label	word
	db	2
	db	0
_lng	label	word
	db	40
	db	0
_lng2	label	word
	db	7
	db	0
_lng3	label	word
	db	0
	db	0
_zschub	label	word
	db	0
	db	0
_f1	label	word
	db	3
	db	0
_fix	label	word
	db	255
	db	255
_grd	label	word
	db	255
	db	255
_max_zln	label	word
	db	50
	db	0
_datei	label	byte
	db	116
	db	120
	db	119
	db	110
	db	100
	db	49
	db	46
	db	116
	db	120
	db	116
	db	10 dup (0)
TXWND1_DATA	ends
TXWND1_TEXT	segment byte public 'CODE'
   ;	
   ;	void datei_in()
   ;	
	assume	cs:TXWND1_TEXT
_datei_in	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
	push	ds
	mov	ax,TXWND1_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		FILE *inStream;
   ;		inStream = fopen( datei, "r" );
   ;	
	push	ds
	mov	ax,offset s@
	push	ax
	push	ds
	mov	ax,offset _datei
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;		
   ;		for(iLauf=1;iLauf<300;iLauf++) zeile[iLauf]=0;//----------------------------------------------------------------> zeilenvektorr
   ;	
	mov	word ptr _iLauf,1
	jmp	short @1@98
@1@50:
	mov	bx,word ptr _iLauf
	shl	bx,1
	mov	word ptr _zeile[bx],0
	inc	word ptr _iLauf
@1@98:
	cmp	word ptr _iLauf,300
	jl	short @1@50
   ;	
   ;		for(iLauf=1;iLauf<100;iLauf++)for(jLauf=1;jLauf<100;jLauf++)text[iLauf][jLauf]=' '; //--------------------------> textmatrix re
   ;	
	mov	word ptr _iLauf,1
	jmp	short @1@266
@1@146:
	mov	word ptr _jLauf,1
	jmp	short @1@218
@1@170:
	mov	ax,word ptr _iLauf
	mov	dx,200
	imul	dx
	add	ax,word ptr _jLauf
	mov	bx,ax
	mov	byte ptr _text[bx],32
	inc	word ptr _jLauf
@1@218:
	cmp	word ptr _jLauf,100
	jl	short @1@170
	inc	word ptr _iLauf
@1@266:
	cmp	word ptr _iLauf,100
	jl	short @1@146
@1@290:
   ;	
   ;	
   ;		do //-----------------------------------------------------------------------------------------------------------> zeilen einles
   ;		{
   ;			if(zlnlng<zeile[index1-1])zlnlng=zeile[index1-1]; //--------------------------------------------------------> bestimmung der m
   ;	
	mov	bx,word ptr _index1
	shl	bx,1
	mov	ax,word ptr _zeile[bx-2]
	cmp	ax,word ptr _zlnlng
	jle	short @1@338
	mov	bx,word ptr _index1
	shl	bx,1
	mov	ax,word ptr _zeile[bx-2]
	mov	word ptr _zlnlng,ax
@1@338:
   ;	
   ;			
   ;			while(1) //-------------------------------------------------------------------------------------------------> spalten (einzels
   ;			{
   ;				text[index1][index] = fgetc(inStream);//----------------------------------------------------------------> string�bergabe an t
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fgetc
	add	sp,4
	push	ax
	mov	ax,word ptr _index1
	mov	dx,200
	imul	dx
	add	ax,word ptr _index
	mov	bx,ax
	pop	ax
	mov	byte ptr _text[bx],al
   ;	
   ;				if (text[index1][index] == '\n') break;//---------------------------------------------------------------> bis steuerzeichen '
   ;	
	mov	ax,word ptr _index1
	mov	dx,200
	imul	dx
	add	ax,word ptr _index
	mov	bx,ax
	cmp	byte ptr _text[bx],10
	jne	short @1@386
	jmp	short @1@482
@1@386:
   ;	
   ;				if (feof (inStream) != 0) break;//----------------------------------------------------------------------> bis EOF
   ;	
	les	bx,dword ptr [bp-4]
	test	word ptr es:[bx+2],32
	je	short @1@434
	jmp	short @1@482
@1@434:
   ;	
   ;				index++;zeile[index1]++;
   ;	
	inc	word ptr _index
	mov	bx,word ptr _index1
	shl	bx,1
	inc	word ptr _zeile[bx]
	jmp	short @1@338
@1@482:
   ;	
   ;			}
   ;			index1++;index=1; //----------------------------------------------------------------------------------------> index1 zeilenind
   ;	
	inc	word ptr _index1
	mov	word ptr _index,1
   ;	
   ;		
   ;		}while (feof (inStream) == 0); //-------------------------------------------------------------------------------> solange nicht
   ;	
	les	bx,dword ptr [bp-4]
	test	word ptr es:[bx+2],32
	jne	@@0
	jmp	@1@290
@@0:
   ;	
   ;	
   ;		fclose( inStream  );
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;	
   ;		txlng=index1-2;//-----------------------------------------------------------------------------------------------> textl�ngenbes
   ;	
	mov	ax,word ptr _index1
	add	ax,65534
	mov	word ptr _txlng,ax
   ;	
   ;		schub=-1*(txlng-lng2);//----------------------------------------------------------------------------------------> text schub y_
   ;	
	mov	ax,word ptr _txlng
	sub	ax,word ptr _lng2
	mov	dx,65535
	imul	dx
	mov	word ptr _schub,ax
   ;	
   ;	};
   ;	
	pop	ds
	mov	sp,bp
	pop	bp
	ret	
_datei_in	endp
   ;	
   ;	void var_inf_()
   ;	
	assume	cs:TXWND1_TEXT
_var_inf_	proc	far
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,TXWND1_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		textcolor(idisp);//---------------------------------------------------------------------------------------------> textfarbe var
   ;	
	push	word ptr _idisp
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;		gotoxy(x_cpos,y_cpos+2); cprintf("x:%i y:%i ",x_cpos, y_cpos);
   ;	
	mov	ax,word ptr _y_cpos
	inc	ax
	inc	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _y_cpos
	push	word ptr _x_cpos
	push	ds
	mov	ax,offset s@+2
	push	ax
	call	far ptr _cprintf
	add	sp,8
   ;	
   ;		
   ;		gotoxy(x_pos+lng+2,y_pos+1);      if(x_pos+lng+2+12 <80)if(y_pos+1 >0)cprintf("[./.] lng:%i",lng);
   ;	
	mov	ax,word ptr _y_pos
	inc	ax
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	inc	ax
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,14
	cmp	ax,80
	jge	short @2@98
	mov	ax,word ptr _y_pos
	inc	ax
	jle	short @2@98
	push	word ptr _lng
	push	ds
	mov	ax,offset s@+13
	push	ax
	call	far ptr _cprintf
	add	sp,6
@2@98:
   ;	
   ;		gotoxy(x_pos+lng+2,y_pos-lng2-1); if(x_pos+lng+2+13 <80)if(y_pos-lng2-1 >0)cprintf("[I/K] lng2:%i",lng2);
   ;	
	mov	ax,word ptr _y_pos
	sub	ax,word ptr _lng2
	dec	ax
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	inc	ax
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,15
	cmp	ax,80
	jge	short @2@170
	mov	ax,word ptr _y_pos
	sub	ax,word ptr _lng2
	dec	ax
	jle	short @2@170
	push	word ptr _lng2
	push	ds
	mov	ax,offset s@+26
	push	ax
	call	far ptr _cprintf
	add	sp,6
@2@170:
   ;	
   ;		gotoxy(x_pos+lng+2,y_pos+lng3+2); if(x_pos+lng+2+13 <80)cprintf("[L/O] lng3:%i",lng3);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	inc	ax
	inc	ax
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	inc	ax
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,15
	cmp	ax,80
	jge	short @2@218
	push	word ptr _lng3
	push	ds
	mov	ax,offset s@+40
	push	ax
	call	far ptr _cprintf
	add	sp,6
@2@218:
   ;	
   ;	
   ;		gotoxy(x_pos-18,y_pos+lng3-6); if(x_pos-18 >0)if(y_pos+lng3-6 >0)cprintf("x_grd:%i y_gid:%i",x_grd, y_grd);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,65530
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,65518
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,65518
	jle	short @2@290
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,65530
	jle	short @2@290
	push	word ptr _y_grd
	push	word ptr _x_grd
	push	ds
	mov	ax,offset s@+54
	push	ax
	call	far ptr _cprintf
	add	sp,8
@2@290:
   ;	
   ;		gotoxy(x_pos-19,y_pos+lng3-4); if(x_pos-19 >0)if(y_pos+lng3-4 >0)cprintf("[G/H]zschub:%i",zschub);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,65532
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,65517
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,65517
	jle	short @2@362
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,65532
	jle	short @2@362
	push	word ptr _zschub
	push	ds
	mov	ax,offset s@+72
	push	ax
	call	far ptr _cprintf
	add	sp,6
@2@362:
   ;	
   ;		gotoxy(x_pos-14,y_pos+lng3-3); if(x_pos-14 >0)if(y_pos+lng3-3 >0)cprintf("zlnlng:%i",zlnlng);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,65533
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,65522
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,65522
	jle	short @2@434
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,65533
	jle	short @2@434
	push	word ptr _zlnlng
	push	ds
	mov	ax,offset s@+87
	push	ax
	call	far ptr _cprintf
	add	sp,6
@2@434:
   ;	
   ;		gotoxy(x_pos-18,y_pos+lng3-2); if(x_pos-18 >0)if(y_pos+lng3-2 >0)cprintf("[J/M]schub:%i",schub);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,65534
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,65518
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,65518
	jle	short @2@506
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,65534
	jle	short @2@506
	push	word ptr _schub
	push	ds
	mov	ax,offset s@+97
	push	ax
	call	far ptr _cprintf
	add	sp,6
@2@506:
   ;	
   ;		gotoxy(x_pos-13,y_pos+lng3-1); if(x_pos-13 >0)if(y_pos+lng3-1 >0)cprintf("txlng:%i",txlng);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	dec	ax
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,65523
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,65523
	jle	short @2@578
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	dec	ax
	jle	short @2@578
	push	word ptr _txlng
	push	ds
	mov	ax,offset s@+111
	push	ax
	call	far ptr _cprintf
	add	sp,6
@2@578:
   ;	
   ;		gotoxy(x_pos-13,y_pos+lng3+1); if(x_pos-13 >0)if(y_pos+lng3+1 >0)cprintf("xf:%i yf:%i",x_pos, y_pos);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	inc	ax
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,65523
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _x_pos
	add	ax,65523
	jle	short @2@650
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	inc	ax
	jle	short @2@650
	push	word ptr _y_pos
	push	word ptr _x_pos
	push	ds
	mov	ax,offset s@+120
	push	ax
	call	far ptr _cprintf
	add	sp,8
@2@650:
   ;	
   ;		
   ;		gotoxy(1,1);cprintf("[B]disp:%i [V]tx_disp:%i [C]tx_disp2:%i tx_disp21:%i [T]Datei_in",disp, tx_disp, tx_disp2, tx_disp21);
   ;	
	mov	ax,1
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _tx_disp21
	push	word ptr _tx_disp2
	push	word ptr _tx_disp
	push	word ptr _disp
	push	ds
	mov	ax,offset s@+132
	push	ax
	call	far ptr _cprintf
	add	sp,12
   ;	
   ;		gotoxy(1,50);cprintf("[U]fix:%i [F]grd:%i",fix, grd);
   ;	
	mov	ax,50
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _grd
	push	word ptr _fix
	push	ds
	mov	ax,offset s@+197
	push	ax
	call	far ptr _cprintf
	add	sp,8
   ;	
   ;		gotoxy(71,50);cprintf("[\x18][Q]End");
   ;	
	mov	ax,50
	push	ax
	mov	ax,71
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+217
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;		textcolor(15); gotoxy(77,1);cprintf("[p]");
   ;	
	mov	ax,15
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	mov	ax,1
	push	ax
	mov	ax,77
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+227
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;	};
   ;	
	pop	ds
	pop	bp
	ret	
_var_inf_	endp
   ;	
   ;	void fenster_()
   ;	
	assume	cs:TXWND1_TEXT
_fenster_	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	ds
	mov	ax,TXWND1_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		if(fix==1)//----------------------------------------------------------------------------------------------------> fensterfarbe 
   ;	
	cmp	word ptr _fix,1
	jne	short @3@242
   ;	
   ;		{
   ;			if( ( (x_cpos == x_pos+1)     &&  (y_cpos == (y_pos+f1)+lng3) ) || 
   ;	
   ;	
   ;				( (x_cpos == x_pos+lng-2) &&  (y_cpos == y_pos+1-lng2)    ) ||
   ;				( (x_cpos == x_pos+lng-2) &&  (y_cpos == (y_pos+f1)+lng3) )   ) {tx_disp21=7;} else {tx_disp21=8;}		
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @3@98
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	je	short @3@194
@3@98:
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @3@146
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	je	short @3@194
@3@146:
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @3@218
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @3@218
@3@194:
	mov	word ptr _tx_disp21,7
	jmp	short @3@242
@3@218:
	mov	word ptr _tx_disp21,8
@3@242:
   ;	
   ;		}
   ;			
   ;		if(fix == -1)tx_disp21=tx_disp2;//------------------------------------------------------------------------------> fensterfarbe 
   ;	
	cmp	word ptr _fix,65535
	jne	short @3@290
	mov	ax,word ptr _tx_disp2
	mov	word ptr _tx_disp21,ax
@3@290:
   ;	
   ;		
   ;		textcolor(tx_disp21);//-----------------------------------------------------------------------------------------> fensterfarbe
   ;	
	push	word ptr _tx_disp21
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;		if(y_pos - lng2  >0) //-----------------------------------------------------------------------------------------> fenster kopfz
   ;	
	mov	ax,word ptr _y_pos
	sub	ax,word ptr _lng2
	jg	@@1
	jmp	@3@434
@@1:
   ;	
   ;		{
   ;			gotoxy(x_pos-1, y_pos - lng2);cprintf("\xDA");//------------------------------------------------------------> beginn eck
   ;	
	mov	ax,word ptr _y_pos
	sub	ax,word ptr _lng2
	push	ax
	mov	ax,word ptr _x_pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+231
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			for(iLauf=1;iLauf<=lng-2;iLauf++)cprintf("\xC4"); cprintf("\xBB");//----------------------------------------> linie, end eck
   ;	
	mov	word ptr _iLauf,1
	jmp	short @3@386
@3@338:
	push	ds
	mov	ax,offset s@+233
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	word ptr _iLauf
@3@386:
	mov	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _iLauf
	jge	short @3@338
	push	ds
	mov	ax,offset s@+235
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			gotoxy(x_pos+1, y_pos - lng2);cprintf("%s",datei);//--------------------------------------------------------> dateinamendarste
   ;	
	mov	ax,word ptr _y_pos
	sub	ax,word ptr _lng2
	push	ax
	mov	ax,word ptr _x_pos
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset _datei
	push	ax
	push	ds
	mov	ax,offset s@+237
	push	ax
	call	far ptr _cprintf
	add	sp,8
@3@434:
   ;	
   ;		}
   ;	
   ;		textcolor(tx_disp);//-------------------------------------------------------------------------------------------> textfarbe
   ;	
	push	word ptr _tx_disp
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;		for(iLauf=1;iLauf<= (lng2-1)+lng3 ;iLauf++) //------------------------------------------------------------------> fenster 
   ;	
	mov	word ptr _iLauf,1
	jmp	@3@986
@3@458:
   ;	
   ;		{
   ;			if(y_pos+1-iLauf+lng3 >0) 
   ;	
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _iLauf
	add	ax,word ptr _lng3
	jg	@@2
	jmp	@3@962
@@2:
   ;	
   ;			for(jLauf=1;jLauf<= lng-4 ;jLauf+=1)
   ;	
	mov	word ptr _jLauf,1
	jmp	@3@938
@3@506:
   ;	
   ;			{	
   ;				
   ;				if(grd==-1)//-------------------------------------------------------------------------------------------> dateidarstellung
   ;	
	cmp	word ptr _grd,65535
	jne	short @3@554
   ;	
   ;				{	
   ;					gotoxy( x_pos+jLauf , ((y_pos+1)-iLauf)+lng3 ); cprintf("%c", text[ ((txlng-iLauf)+schub)+lng3 ][jLauf+zschub]);
   ;	
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _iLauf
	add	ax,word ptr _lng3
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _jLauf
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _txlng
	sub	ax,word ptr _iLauf
	add	ax,word ptr _schub
	add	ax,word ptr _lng3
	mov	dx,200
	imul	dx
	mov	bx,word ptr _jLauf
	add	bx,word ptr _zschub
	add	bx,ax
	mov	al,byte ptr _text[bx]
	cbw	
	push	ax
	push	ds
	mov	ax,offset s@+240
	push	ax
	call	far ptr _cprintf
	add	sp,6
@3@554:
   ;	
   ;				}
   ;				
   ;				
   ;				if(grd==1)//--------------------------------------------------------------------------------------------> grid darstellung
   ;	
	cmp	word ptr _grd,1
	je	@@3
	jmp	@3@914
@@3:
   ;	
   ;				{
   ;					textcolor(tx_disp2);//------------------------------------------------------------------------------> fensterfarbe
   ;	
	push	word ptr _tx_disp2
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;					
   ;					gotoxy( x_pos+jLauf , ((y_pos+1)-iLauf)+lng3 ); cprintf("\xB0");//----------------------------------> grid fl�che
   ;	
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _iLauf
	add	ax,word ptr _lng3
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _jLauf
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+243
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					
   ;					gotoxy( x_pos+jLauf , ((y_pos+1)-iLauf)+lng3 );//---------------------------------------------------> fadenkreuz
   ;	
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _iLauf
	add	ax,word ptr _lng3
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _jLauf
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					if(jLauf == x_grd && iLauf == y_grd ){cprintf("\xFE");}//-------------------------------------------> mittelpunktsymbol
   ;	
	mov	ax,word ptr _jLauf
	cmp	ax,word ptr _x_grd
	jne	short @3@650
	mov	ax,word ptr _iLauf
	cmp	ax,word ptr _y_grd
	jne	short @3@650
	push	ds
	mov	ax,offset s@+245
	push	ax
	call	far ptr _cprintf
	add	sp,4
	jmp	short @3@746
@3@650:
   ;	
   ;					else//----------------------------------------------------------------------------------------------> achsenlinien
   ;					{
   ;						if(iLauf == y_grd )   cprintf("\xCD");
   ;	
	mov	ax,word ptr _iLauf
	cmp	ax,word ptr _y_grd
	jne	short @3@698
	push	ds
	mov	ax,offset s@+247
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@698:
   ;	
   ;						if(jLauf == x_grd )   cprintf("\xBA");
   ;	
	mov	ax,word ptr _jLauf
	cmp	ax,word ptr _x_grd
	jne	short @3@746
	push	ds
	mov	ax,offset s@+249
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@746:
   ;	
   ;					}
   ;					
   ;					if(iLauf==(lng2-1)+lng3 && jLauf == lng-4)//--------------------------------------------------------> letzter darstellungsdu
   ;	
	mov	ax,word ptr _lng2
	add	ax,word ptr _lng3
	dec	ax
	cmp	ax,word ptr _iLauf
	je	@@4
	jmp	@3@914
@@4:
	mov	ax,word ptr _lng
	add	ax,65532
	cmp	ax,word ptr _jLauf
	je	@@5
	jmp	@3@914
@@5:
   ;	
   ;					{	
   ;						gotoxy( x_pos+x_grd+1 , ((y_pos+1)+1)+lng3-y_grd); 
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	inc	ax
	inc	ax
	sub	ax,word ptr _y_grd
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _x_grd
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;						{
   ;							if(x_grd>1)  cprintf("\x1A%.0f", (zlnlng*(1.0*x_grd)/(lng-4)));//---------------------------> spaltenpositonsdarstellung
   ;	
	cmp	word ptr _x_grd,1
	jle	short @3@842
	mov	ax,word ptr _x_grd
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FLD1	
	FMUL	
	mov	ax,word ptr _zlnlng
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FMUL	
	mov	ax,word ptr _lng
	add	ax,65532
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FDIV	
	add	sp,65528
	FSTP	qword ptr [bp-12]
	push	ds
	mov	ax,offset s@+251
	push	ax
	FWAIT	
	call	far ptr _cprintf
	add	sp,12
@3@842:
   ;	
   ;							if(x_grd==1) cprintf("\x1A\x30");
   ;	
	cmp	word ptr _x_grd,1
	jne	short @3@890
	push	ds
	mov	ax,offset s@+257
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@890:
   ;	
   ;						}
   ;	
   ;						gotoxy( x_pos+x_grd+1 , ((y_pos+1)+2)+lng3-y_grd); 
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,3
	sub	ax,word ptr _y_grd
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _x_grd
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;						cprintf("\x19%.0f", txlng-(txlng*((1.0*(y_grd-1))/(lng2+lng3-2))));//---------------------------> zeilenpositonsdarstellung
   ;	
	mov	ax,word ptr _y_grd
	dec	ax
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FLD1	
	FMUL	
	mov	ax,word ptr _lng2
	add	ax,word ptr _lng3
	add	ax,65534
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FDIV	
	mov	ax,word ptr _txlng
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FMUL	
	mov	ax,word ptr _txlng
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FSUBR	
	add	sp,65528
	FSTP	qword ptr [bp-12]
	push	ds
	mov	ax,offset s@+260
	push	ax
	FWAIT	
	call	far ptr _cprintf
	add	sp,12
   ;	
   ;						
   ;						gotoxy( x_pos+jLauf-3 , ((y_pos+1)-2)+lng3 ); cprintf("\x1D%i", zlnlng);//----------------------> zeilenl�ngendarstellung
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	dec	ax
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _jLauf
	add	ax,65533
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _zlnlng
	push	ds
	mov	ax,offset s@+266
	push	ax
	call	far ptr _cprintf
	add	sp,6
   ;	
   ;						gotoxy( x_pos+jLauf-3 , ((y_pos+1)-1)+lng3 ); cprintf("\x12%i",txlng);//------------------------> textl�ngendarstellung
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	push	ax
	mov	ax,word ptr _x_pos
	add	ax,word ptr _jLauf
	add	ax,65533
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _txlng
	push	ds
	mov	ax,offset s@+270
	push	ax
	call	far ptr _cprintf
	add	sp,6
@3@914:
	inc	word ptr _jLauf
@3@938:
	mov	ax,word ptr _lng
	add	ax,65532
	cmp	ax,word ptr _jLauf
	jl	@@6
	jmp	@3@506
@@6:
@3@962:
	inc	word ptr _iLauf
@3@986:
	mov	ax,word ptr _lng2
	add	ax,word ptr _lng3
	dec	ax
	cmp	ax,word ptr _iLauf
	jl	@@7
	jmp	@3@458
@@7:
   ;	
   ;					}
   ;				}
   ;			}
   ;		}
   ;		
   ;		textcolor(tx_disp21);
   ;	
	push	word ptr _tx_disp21
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;		if(y_pos+2+lng3 >0) //------------------------------------------------------------------------------------------> fenster fussz
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	inc	ax
	inc	ax
	jg	@@8
	jmp	@3@1442
@@8:
   ;	
   ;		{
   ;			gotoxy(x_pos-1, y_pos+2+lng3);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	inc	ax
	inc	ax
	push	ax
	mov	ax,word ptr _x_pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;			{	
   ;				cprintf("\xC0\xC4o");//---------------------------------------------------------------------------------> beginn eck
   ;	
	push	ds
	mov	ax,offset s@+274
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				
   ;				//------------------------------------------------------------------------------------------------------> textrollschaltersym
   ;				if(lng2-(txlng-1)<=schub){ cprintf("\x19"); } else { cprintf(" ");}
   ;	
	mov	ax,word ptr _txlng
	dec	ax
	mov	dx,word ptr _lng2
	sub	dx,ax
	cmp	dx,word ptr _schub
	jg	short @3@1082
	push	ds
	mov	ax,offset s@+278
	push	ax
	call	far ptr _cprintf
	add	sp,4
	jmp	short @3@1106
@3@1082:
	push	ds
	mov	ax,offset s@+280
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1106:
   ;	
   ;				if(lng3+schub<=0)		 { cprintf("\x18"); } else { cprintf(" ");}
   ;	
	mov	ax,word ptr _lng3
	add	ax,word ptr _schub
	jg	short @3@1154
	push	ds
	mov	ax,offset s@+282
	push	ax
	call	far ptr _cprintf
	add	sp,4
	jmp	short @3@1178
@3@1154:
	push	ds
	mov	ax,offset s@+284
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1178:
   ;	
   ;				if(zschub<zlnlng-lng+4)  { cprintf("\x1B"); } else { cprintf(" ");}
   ;	
	mov	ax,word ptr _zlnlng
	sub	ax,word ptr _lng
	add	ax,4
	cmp	ax,word ptr _zschub
	jle	short @3@1226
	push	ds
	mov	ax,offset s@+286
	push	ax
	call	far ptr _cprintf
	add	sp,4
	jmp	short @3@1250
@3@1226:
	push	ds
	mov	ax,offset s@+288
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1250:
   ;	
   ;				if(zschub >0)			 { cprintf("\x1A"); } else { cprintf(" ");}
   ;	
	cmp	word ptr _zschub,0
	jle	short @3@1298
	push	ds
	mov	ax,offset s@+290
	push	ax
	call	far ptr _cprintf
	add	sp,4
	jmp	short @3@1322
@3@1298:
	push	ds
	mov	ax,offset s@+292
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1322:
   ;	
   ;				cprintf("\xCD");
   ;	
	push	ds
	mov	ax,offset s@+294
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			}
   ;			for(iLauf=1;iLauf<=(lng-4)-5;iLauf++)cprintf("\xC4");//-----------------------------------------------------> linie
   ;	
	mov	word ptr _iLauf,1
	jmp	short @3@1394
@3@1346:
	push	ds
	mov	ax,offset s@+296
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	word ptr _iLauf
@3@1394:
	mov	ax,word ptr _lng
	add	ax,65527
	cmp	ax,word ptr _iLauf
	jge	short @3@1346
   ;	
   ;			cprintf("\xBC");//------------------------------------------------------------------------------------------> end eck
   ;	
	push	ds
	mov	ax,offset s@+298
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1442:
   ;	
   ;		}
   ;	};
   ;	
	pop	ds
	mov	sp,bp
	pop	bp
	ret	
_fenster_	endp
   ;	
   ;	void cursor_()
   ;	
	assume	cs:TXWND1_TEXT
_cursor_	proc	far
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,TXWND1_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		textcolor(tx_disp);//-------------------------------------------------------------------------------------------> textfarbe
   ;	
	push	word ptr _tx_disp
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;		gotoxy(x_cpos, y_cpos-1);cprintf(".");
   ;	
	mov	ax,word ptr _y_cpos
	dec	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+300
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;		gotoxy(x_cpos, y_cpos);cprintf("\x1E");
   ;	
	push	word ptr _y_cpos
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+302
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;		
   ;		if(fix==1){gotoxy(x_cpos, y_cpos+1);cprintf("\xEE");}//---------------------------------------------------------> fixierungssch
   ;	
	cmp	word ptr _fix,1
	jne	short @4@74
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+304
	push	ax
	call	far ptr _cprintf
	add	sp,4
@4@74:
   ;	
   ;	};
   ;	
	pop	ds
	pop	bp
	ret	
_cursor_	endp
   ;	
   ;	void ereignisse_()
   ;	
	assume	cs:TXWND1_TEXT
_ereignisse_	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	ds
	mov	ax,TXWND1_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		if(taste == 'v') {tx_disp--;if(tx_disp<0)tx_disp = 15;}//-------------------------------------------------------> v_taste �nder
   ;	
	cmp	byte ptr _taste,118
	jne	short @5@98
	dec	word ptr _tx_disp
	cmp	word ptr _tx_disp,0
	jge	short @5@98
	mov	word ptr _tx_disp,15
@5@98:
   ;	
   ;		if(taste == 'c') {tx_disp2--;if(tx_disp2<7)tx_disp2 = 8;}//-----------------------------------------------------> c_taste �nder
   ;	
	cmp	byte ptr _taste,99
	jne	short @5@170
	dec	word ptr _tx_disp2
	cmp	word ptr _tx_disp2,7
	jge	short @5@170
	mov	word ptr _tx_disp2,8
@5@170:
   ;	
   ;		if(taste == 'b') {disp--;if(disp<0) disp = 7;}//----------------------------------------------------------------> b_taste �nder
   ;	
	cmp	byte ptr _taste,98
	jne	short @5@242
	dec	word ptr _disp
	cmp	word ptr _disp,0
	jge	short @5@242
	mov	word ptr _disp,7
@5@242:
   ;	
   ;	
   ;		if(taste == 'f' || (taste == 'u' && (x_cpos == x_pos+6) && (y_cpos == (y_pos+f1)+lng3))) //---------------------> f bzw u_taste
   ;	
	cmp	byte ptr _taste,102
	je	short @5@338
	cmp	byte ptr _taste,117
	je	@@9
	jmp	@5@410
@@9:
	mov	ax,word ptr _x_pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	je	@@10
	jmp	@5@410
@@10:
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	je	@@11
	jmp	@5@410
@@11:
@5@338:
   ;	
   ;		{
   ;			zschub=zlnlng*((1.0*(x_grd-1))/lng);
   ;	
	mov	ax,word ptr _x_grd
	dec	ax
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FLD1	
	FMUL	
	mov	ax,word ptr _lng
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FDIV	
	mov	ax,word ptr _zlnlng
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FMUL	
	call	far ptr F_FTOL@
	mov	word ptr _zschub,ax
   ;	
   ;			schub=(-1*(txlng*((1.0*(y_grd-1))/(lng2+lng3-2))))+1;if(schub<-1*(txlng-lng2))schub=-1*(txlng-lng2);
   ;	
	mov	ax,word ptr _y_grd
	dec	ax
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FLD1	
	FMUL	
	mov	ax,word ptr _lng2
	add	ax,word ptr _lng3
	add	ax,65534
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FDIV	
	mov	ax,word ptr _txlng
	mov	word ptr [bp-2],ax
	FILD	word ptr [bp-2]
	FMUL	
	FMUL	dword ptr s@+306
	FLD1	
	FADD	
	call	far ptr F_FTOL@
	mov	word ptr _schub,ax
	mov	ax,word ptr _txlng
	sub	ax,word ptr _lng2
	mov	dx,65535
	imul	dx
	cmp	ax,word ptr _schub
	jle	short @5@386
	mov	ax,word ptr _txlng
	sub	ax,word ptr _lng2
	mov	dx,65535
	imul	dx
	mov	word ptr _schub,ax
@5@386:
   ;	
   ;			y_grd=lng2+lng3-1;x_grd=1;
   ;	
	mov	ax,word ptr _lng2
	add	ax,word ptr _lng3
	dec	ax
	mov	word ptr _y_grd,ax
	mov	word ptr _x_grd,1
   ;	
   ;			grd*=-1;
   ;	
	mov	dx,65535
	mov	ax,word ptr _grd
	imul	dx
	mov	word ptr _grd,ax
@5@410:
   ;	
   ;		}
   ;		
   ;		if(taste == 'u' && grd==-1)//-----------------------------------------------------------------------------------> u_schaltet te
   ;	
	cmp	byte ptr _taste,117
	je	@@12
	jmp	@5@1058
@@12:
	cmp	word ptr _grd,65535
	je	@@13
	jmp	@5@1058
@@13:
   ;	
   ;		{
   ;			if((x_cpos == x_pos+2) && (y_cpos == (y_pos+f1)+lng3))if(lng3+schub<=0)schub++;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@554
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@554
	mov	ax,word ptr _lng3
	add	ax,word ptr _schub
	jg	short @5@554
	inc	word ptr _schub
@5@554:
   ;	
   ;			if((x_cpos == x_pos+3) && (y_cpos == (y_pos+f1)+lng3))if(lng2-(txlng-1)<=schub)schub--;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @5@650
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@650
	mov	ax,word ptr _txlng
	dec	ax
	mov	dx,word ptr _lng2
	sub	dx,ax
	cmp	dx,word ptr _schub
	jg	short @5@650
	dec	word ptr _schub
@5@650:
   ;	
   ;			if((x_cpos == x_pos+4) && (y_cpos == (y_pos+f1)+lng3))if(zschub>0)zschub--;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @5@746
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@746
	cmp	word ptr _zschub,0
	jle	short @5@746
	dec	word ptr _zschub
@5@746:
   ;	
   ;			if((x_cpos == x_pos+5) && (y_cpos == (y_pos+f1)+lng3))if(zschub<zlnlng-lng+4)zschub++;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @5@842
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@842
	mov	ax,word ptr _zlnlng
	sub	ax,word ptr _lng
	add	ax,4
	cmp	ax,word ptr _zschub
	jle	short @5@842
	inc	word ptr _zschub
@5@842:
   ;	
   ;			
   ;			if(! ( ((x_cpos == x_pos+2) && (y_cpos == (y_pos+f1)+lng3)) ||
   ;	
   ;	
   ;				   ((x_cpos == x_pos+3) && (y_cpos == (y_pos+f1)+lng3)) ||
   ;				   ((x_cpos == x_pos+4) && (y_cpos == (y_pos+f1)+lng3)) ||
   ;				   ((x_cpos == x_pos+5) && (y_cpos == (y_pos+f1)+lng3))    )  )fix*=-1;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@890
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	je	short @5@1058
@5@890:
	mov	ax,word ptr _x_pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @5@938
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	je	short @5@1058
@5@938:
	mov	ax,word ptr _x_pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @5@986
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	je	short @5@1058
@5@986:
	mov	ax,word ptr _x_pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @5@1034
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	je	short @5@1058
@5@1034:
	mov	dx,65535
	mov	ax,word ptr _fix
	imul	dx
	mov	word ptr _fix,ax
@5@1058:
   ;	
   ;		}
   ;		
   ;		if(taste == 'w' && y_cpos  > 3)//-------------------------------------------------------------------------------> w_taste versc
   ;	
	cmp	byte ptr _taste,119
	je	@@14
	jmp	@5@1514
@@14:
	cmp	word ptr _y_cpos,3
	jg	@@15
	jmp	@5@1514
@@15:
   ;	
   ;		{
   ;			if(grd==-1)
   ;	
	cmp	word ptr _grd,65535
	je	@@16
	jmp	@5@1442
@@16:
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	je	@@17
	jmp	@5@1418
@@17:
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))y_pos--;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@1226
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@1226
	dec	word ptr _y_pos
@5@1226:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng2-schub<=txlng-1)lng2++;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@1322
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	jne	short @5@1322
	mov	ax,word ptr _lng2
	sub	ax,word ptr _schub
	mov	dx,word ptr _txlng
	dec	dx
	cmp	ax,dx
	jg	short @5@1322
	inc	word ptr _lng2
@5@1322:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3))if(lng3>0)lng3--;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@1418
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@1418
	cmp	word ptr _lng3,0
	jle	short @5@1418
	dec	word ptr _lng3
@5@1418:
   ;	
   ;					
   ;				}
   ;				y_cpos--;
   ;	
	dec	word ptr _y_cpos
@5@1442:
   ;	
   ;			}
   ;			if(grd==1)if(y_grd<lng2+lng3-1)y_grd++;
   ;	
	cmp	word ptr _grd,1
	jne	short @5@1514
	mov	ax,word ptr _lng2
	add	ax,word ptr _lng3
	dec	ax
	cmp	ax,word ptr _y_grd
	jle	short @5@1514
	inc	word ptr _y_grd
@5@1514:
   ;	
   ;	
   ;		}
   ;		
   ;		if(taste == 's' && y_cpos  < 49) //-----------------------------------------------------------------------------> s_taste versc
   ;	
	cmp	byte ptr _taste,115
	je	@@18
	jmp	@5@1970
@@18:
	cmp	word ptr _y_cpos,49
	jl	@@19
	jmp	@5@1970
@@19:
   ;	
   ;		{
   ;			if(grd==-1)
   ;	
	cmp	word ptr _grd,65535
	je	@@20
	jmp	@5@1898
@@20:
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	je	@@21
	jmp	@5@1874
@@21:
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))y_pos++;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@1682
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@1682
	inc	word ptr _y_pos
@5@1682:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng2>=0)lng2--;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@1778
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	jne	short @5@1778
	cmp	word ptr _lng2,0
	jl	short @5@1778
	dec	word ptr _lng2
@5@1778:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3))if(lng3-1<-schub)lng3++;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@1874
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@1874
	mov	ax,word ptr _lng3
	dec	ax
	mov	dx,word ptr _schub
	neg	dx
	cmp	ax,dx
	jge	short @5@1874
	inc	word ptr _lng3
@5@1874:
   ;	
   ;				
   ;				}
   ;				y_cpos++;
   ;	
	inc	word ptr _y_cpos
@5@1898:
   ;	
   ;			}
   ;			if(grd==1)if(y_grd>3)y_grd--;
   ;	
	cmp	word ptr _grd,1
	jne	short @5@1970
	cmp	word ptr _y_grd,3
	jle	short @5@1970
	dec	word ptr _y_grd
@5@1970:
   ;	
   ;		}
   ;		
   ;		if(taste == 'a' && x_cpos  > 3) //------------------------------------------------------------------------------> a_taste versc
   ;	
	cmp	byte ptr _taste,97
	je	@@22
	jmp	@5@2378
@@22:
	cmp	word ptr _x_cpos,3
	jg	@@23
	jmp	@5@2378
@@23:
   ;	
   ;		{
   ;			if(grd==-1)
   ;	
	cmp	word ptr _grd,65535
	jne	short @5@2306
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @5@2282
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))x_pos--;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@2138
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@2138
	dec	word ptr _x_pos
@5@2138:
   ;	
   ;					
   ;					if( ((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2)) ||
   ;	
   ;	
   ;						((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3    ))    )if(lng>9)lng--;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@2186
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	je	short @5@2234
@5@2186:
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@2282
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@2282
@5@2234:
	cmp	word ptr _lng,9
	jle	short @5@2282
	dec	word ptr _lng
@5@2282:
   ;	
   ;					
   ;				}
   ;				x_cpos--;
   ;	
	dec	word ptr _x_cpos
@5@2306:
   ;	
   ;			}
   ;			if(grd==1)if(x_grd>1)x_grd--;
   ;	
	cmp	word ptr _grd,1
	jne	short @5@2378
	cmp	word ptr _x_grd,1
	jle	short @5@2378
	dec	word ptr _x_grd
@5@2378:
   ;	
   ;		}
   ;		
   ;		if(taste == 'd' && x_cpos  < 78) //-----------------------------------------------------------------------------> d_taste versc
   ;	
	cmp	byte ptr _taste,100
	je	@@24
	jmp	@5@2762
@@24:
	cmp	word ptr _x_cpos,78
	jl	@@25
	jmp	@5@2762
@@25:
   ;	
   ;		{
   ;			if(grd==-1)
   ;	
	cmp	word ptr _grd,65535
	jne	short @5@2690
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @5@2666
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))x_pos++;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@2546
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@2546
	inc	word ptr _x_pos
@5@2546:
   ;	
   ;					
   ;					if( ((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2)) ||
   ;	
   ;	
   ;						((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3    ))    )lng++;
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@2594
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	je	short @5@2642
@5@2594:
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@2666
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@2666
@5@2642:
	inc	word ptr _lng
@5@2666:
   ;	
   ;					
   ;				}
   ;				x_cpos++;
   ;	
	inc	word ptr _x_cpos
@5@2690:
   ;	
   ;			}
   ;			if(grd==1)if(x_grd<lng-8)x_grd++;
   ;	
	cmp	word ptr _grd,1
	jne	short @5@2762
	mov	ax,word ptr _lng
	add	ax,65528
	cmp	ax,word ptr _x_grd
	jle	short @5@2762
	inc	word ptr _x_grd
@5@2762:
   ;	
   ;		}
   ;	
   ;		if(taste == 'e' && x_cpos  < 78 && y_cpos  > 3) //--------------------------------------------------------------> e_taste versc
   ;	
	cmp	byte ptr _taste,101
	je	@@26
	jmp	@5@3170
@@26:
	cmp	word ptr _x_cpos,78
	jl	@@27
	jmp	@5@3170
@@27:
	cmp	word ptr _y_cpos,3
	jg	@@28
	jmp	@5@3170
@@28:
   ;	
   ;		{
   ;			if(grd==-1)
   ;	
	cmp	word ptr _grd,65535
	je	@@29
	jmp	@5@3170
@@29:
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	je	@@30
	jmp	@5@3146
@@30:
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3)){x_pos++;y_pos--;}
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@2954
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@2954
	inc	word ptr _x_pos
	dec	word ptr _y_pos
@5@2954:
   ;	
   ;					
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))    if(lng2-schub<=txlng-1) {lng2++;lng++;}
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@3050
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	jne	short @5@3050
	mov	ax,word ptr _lng2
	sub	ax,word ptr _schub
	mov	dx,word ptr _txlng
	dec	dx
	cmp	ax,dx
	jg	short @5@3050
	inc	word ptr _lng2
	inc	word ptr _lng
@5@3050:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3)) if(lng3>0)              {lng3--;lng++;}
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@3146
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@3146
	cmp	word ptr _lng3,0
	jle	short @5@3146
	dec	word ptr _lng3
	inc	word ptr _lng
@5@3146:
   ;	
   ;					
   ;				}
   ;				x_cpos++;y_cpos--;
   ;	
	inc	word ptr _x_cpos
	dec	word ptr _y_cpos
@5@3170:
   ;	
   ;			}
   ;		}
   ;	
   ;		if(taste == 'q' && x_cpos  > 3 && y_cpos  > 3) //---------------------------------------------------------------> q_taste versc
   ;	
	cmp	byte ptr _taste,113
	je	@@31
	jmp	@5@3626
@@31:
	cmp	word ptr _x_cpos,3
	jg	@@32
	jmp	@5@3626
@@32:
	cmp	word ptr _y_cpos,3
	jg	@@33
	jmp	@5@3626
@@33:
   ;	
   ;		{
   ;			if(grd==-1)
   ;	
	cmp	word ptr _grd,65535
	je	@@34
	jmp	@5@3626
@@34:
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	je	@@35
	jmp	@5@3602
@@35:
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3)){x_pos--;y_pos--;}
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@3362
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@3362
	dec	word ptr _x_pos
	dec	word ptr _y_pos
@5@3362:
   ;	
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))    if(lng>9) if(lng2-schub<=txlng-1) {lng2++;lng--;}
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@3482
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	jne	short @5@3482
	cmp	word ptr _lng,9
	jle	short @5@3482
	mov	ax,word ptr _lng2
	sub	ax,word ptr _schub
	mov	dx,word ptr _txlng
	dec	dx
	cmp	ax,dx
	jg	short @5@3482
	inc	word ptr _lng2
	dec	word ptr _lng
@5@3482:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3)) if(lng>9) if(lng3>0)              {lng3--;lng--;}
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@3602
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@3602
	cmp	word ptr _lng,9
	jle	short @5@3602
	cmp	word ptr _lng3,0
	jle	short @5@3602
	dec	word ptr _lng3
	dec	word ptr _lng
@5@3602:
   ;	
   ;				
   ;				}
   ;				x_cpos--;y_cpos--;
   ;	
	dec	word ptr _x_cpos
	dec	word ptr _y_cpos
@5@3626:
   ;	
   ;			}
   ;		
   ;		}
   ;	
   ;		if(taste == 'x' && x_cpos  < 78 && y_cpos  < 49) //-------------------------------------------------------------> x_taste versc
   ;	
	cmp	byte ptr _taste,120
	je	@@36
	jmp	@5@4034
@@36:
	cmp	word ptr _x_cpos,78
	jl	@@37
	jmp	@5@4034
@@37:
	cmp	word ptr _y_cpos,49
	jl	@@38
	jmp	@5@4034
@@38:
   ;	
   ;		{
   ;			if(grd==-1)
   ;	
	cmp	word ptr _grd,65535
	je	@@39
	jmp	@5@4034
@@39:
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	je	@@40
	jmp	@5@4010
@@40:
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3)){x_pos++;y_pos++;}
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@3818
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@3818
	inc	word ptr _x_pos
	inc	word ptr _y_pos
@5@3818:
   ;	
   ;				
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))    if(lng2>=0)      { lng2--;lng++; }
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@3914
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	jne	short @5@3914
	cmp	word ptr _lng2,0
	jl	short @5@3914
	dec	word ptr _lng2
	inc	word ptr _lng
@5@3914:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3)) if(lng3-1<-schub){ lng3++;lng++; }
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@4010
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@4010
	mov	ax,word ptr _lng3
	dec	ax
	mov	dx,word ptr _schub
	neg	dx
	cmp	ax,dx
	jge	short @5@4010
	inc	word ptr _lng3
	inc	word ptr _lng
@5@4010:
   ;	
   ;	
   ;				}
   ;			x_cpos++;y_cpos++;
   ;	
	inc	word ptr _x_cpos
	inc	word ptr _y_cpos
@5@4034:
   ;	
   ;			}
   ;		}
   ;		
   ;		if(taste == 'y' && x_cpos  > 3 && y_cpos  < 49) //--------------------------------------------------------------> y_taste versc
   ;	
	cmp	byte ptr _taste,121
	je	@@41
	jmp	@5@4490
@@41:
	cmp	word ptr _x_cpos,3
	jg	@@42
	jmp	@5@4490
@@42:
	cmp	word ptr _y_cpos,49
	jl	@@43
	jmp	@5@4490
@@43:
   ;	
   ;		{
   ;			if(grd==-1)
   ;	
	cmp	word ptr _grd,65535
	je	@@44
	jmp	@5@4490
@@44:
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	je	@@45
	jmp	@5@4466
@@45:
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3)){x_pos--;y_pos++;}
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @5@4226
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@4226
	dec	word ptr _x_pos
	inc	word ptr _y_pos
@5@4226:
   ;	
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))    if(lng>9) if(lng2>=0)		{lng2--;lng--;}
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@4346
	mov	ax,word ptr _y_pos
	inc	ax
	sub	ax,word ptr _lng2
	cmp	ax,word ptr _y_cpos
	jne	short @5@4346
	cmp	word ptr _lng,9
	jle	short @5@4346
	cmp	word ptr _lng2,0
	jl	short @5@4346
	dec	word ptr _lng2
	dec	word ptr _lng
@5@4346:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == (y_pos+f1)+lng3)) if(lng>9) if(lng3-1<-schub)  {lng3++;lng--;}
   ;	
	mov	ax,word ptr _x_pos
	add	ax,word ptr _lng
	add	ax,65534
	cmp	ax,word ptr _x_cpos
	jne	short @5@4466
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	jne	short @5@4466
	cmp	word ptr _lng,9
	jle	short @5@4466
	mov	ax,word ptr _lng3
	dec	ax
	mov	dx,word ptr _schub
	neg	dx
	cmp	ax,dx
	jge	short @5@4466
	inc	word ptr _lng3
	dec	word ptr _lng
@5@4466:
   ;	
   ;	
   ;				}
   ;				x_cpos--;y_cpos++;
   ;	
	dec	word ptr _x_cpos
	inc	word ptr _y_cpos
@5@4490:
   ;	
   ;			}
   ;		}
   ;		
   ;		if(grd==-1)//---------------------------------------------------------------------------------------------------> direktfenster
   ;	
	cmp	word ptr _grd,65535
	je	@@46
	jmp	@5@5138
@@46:
   ;	
   ;		{
   ;			if(taste == 'm')if(lng3+schub<=0)schub++;//-----------------------------------------------------------------> rollt text nach 
   ;	
	cmp	byte ptr _taste,109
	jne	short @5@4586
	mov	ax,word ptr _lng3
	add	ax,word ptr _schub
	jg	short @5@4586
	inc	word ptr _schub
@5@4586:
   ;	
   ;			if(taste == 'j')if(lng2-(txlng-1)<=schub)schub--;//---------------------------------------------------------> rollt text nach 
   ;	
	cmp	byte ptr _taste,106
	jne	short @5@4658
	mov	ax,word ptr _txlng
	dec	ax
	mov	dx,word ptr _lng2
	sub	dx,ax
	cmp	dx,word ptr _schub
	jg	short @5@4658
	dec	word ptr _schub
@5@4658:
   ;	
   ;	
   ;			if(taste == 'h')if(zschub<zlnlng-lng+4)zschub++;//----------------------------------------------------------> rollt text nach 
   ;	
	cmp	byte ptr _taste,104
	jne	short @5@4730
	mov	ax,word ptr _zlnlng
	sub	ax,word ptr _lng
	add	ax,4
	cmp	ax,word ptr _zschub
	jle	short @5@4730
	inc	word ptr _zschub
@5@4730:
   ;	
   ;			if(taste == 'g')if(zschub>0)zschub--;//---------------------------------------------------------------------> rollt text nach 
   ;	
	cmp	byte ptr _taste,103
	jne	short @5@4802
	cmp	word ptr _zschub,0
	jle	short @5@4802
	dec	word ptr _zschub
@5@4802:
   ;	
   ;		
   ;			if(taste == 'i' && y_pos-lng2 > 1)if(lng2-schub<=txlng-1)lng2++;//------------------------------------------> erweitert fenste
   ;	
	cmp	byte ptr _taste,105
	jne	short @5@4898
	mov	ax,word ptr _y_pos
	sub	ax,word ptr _lng2
	cmp	ax,1
	jle	short @5@4898
	mov	ax,word ptr _lng2
	sub	ax,word ptr _schub
	mov	dx,word ptr _txlng
	dec	dx
	cmp	ax,dx
	jg	short @5@4898
	inc	word ptr _lng2
@5@4898:
   ;	
   ;			if(taste == 'k')if(lng2>=0)lng2--;//------------------------------------------------------------------------> erweitert fenste
   ;	
	cmp	byte ptr _taste,107
	jne	short @5@4970
	cmp	word ptr _lng2,0
	jl	short @5@4970
	dec	word ptr _lng2
@5@4970:
   ;	
   ;		
   ;			if(taste == 'l' && y_pos+lng3+3<max_zln)if(lng3-1<-schub)lng3++;//------------------------------------------> erweitert fenste
   ;	
	cmp	byte ptr _taste,108
	jne	short @5@5066
	mov	ax,word ptr _y_pos
	add	ax,word ptr _lng3
	add	ax,3
	cmp	ax,word ptr _max_zln
	jge	short @5@5066
	mov	ax,word ptr _lng3
	dec	ax
	mov	dx,word ptr _schub
	neg	dx
	cmp	ax,dx
	jge	short @5@5066
	inc	word ptr _lng3
@5@5066:
   ;	
   ;			if(taste == 'o')if(lng3>0)lng3--;//-------------------------------------------------------------------------> erweitert fenste
   ;	
	cmp	byte ptr _taste,111
	jne	short @5@5138
	cmp	word ptr _lng3,0
	jle	short @5@5138
	dec	word ptr _lng3
@5@5138:
   ;	
   ;		}
   ;	
   ;		if(taste == 't' && (x_cpos == x_pos+1) && (y_cpos == (y_pos+f1)+lng3))//----------------------------------------> t_�ffnet date
   ;	
	cmp	byte ptr _taste,116
	je	@@47
	jmp	@5@5258
@@47:
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	je	@@48
	jmp	@5@5258
@@48:
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	add	ax,word ptr _lng3
	cmp	ax,word ptr _y_cpos
	je	@@49
	jmp	@5@5258
@@49:
   ;	
   ;		{
   ;			gotoxy(x_cpos, y_cpos+1);cprintf(">"); gotoxy(x_cpos+1, y_cpos+1);scanf("%s", &strng);//--------------------> texteingabe unte
   ;	
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+310
	push	ax
	call	far ptr _cprintf
	add	sp,4
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	mov	ax,word ptr _x_cpos
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset _strng
	push	ax
	push	ds
	mov	ax,offset s@+312
	push	ax
	call	far ptr _scanf
	add	sp,8
   ;	
   ;				
   ;			if(fopen( strng, "r" ) != NULL)//---------------------------------------------------------------------------> wenn datei vorha
   ;	
	push	ds
	mov	ax,offset s@+315
	push	ax
	push	ds
	mov	ax,offset _strng
	push	ax
	call	far ptr _fopen
	add	sp,8
	or	ax,dx
	je	short @5@5258
   ;	
   ;			{
   ;				index = 1; index1 = 1; zlnlng=0; strcpy(datei,strng); datei_in();//-------------------------------------> indexr�ckstellung, 
   ;	
	mov	word ptr _index,1
	mov	word ptr _index1,1
	mov	word ptr _zlnlng,0
	push	ds
	mov	ax,offset _strng
	push	ax
	push	ds
	mov	ax,offset _datei
	push	ax
	call	far ptr _strcpy
	add	sp,8
	push	cs
	call	near ptr _datei_in
@5@5258:
   ;	
   ;			}
   ;		}
   ;	
   ;		if(taste == 'p') {idisp--;if(idisp<0)idisp = 2;}//--------------------------------------------------------------> p_variablenmo
   ;	
	cmp	byte ptr _taste,112
	jne	short @5@5330
	dec	word ptr _idisp
	cmp	word ptr _idisp,0
	jge	short @5@5330
	mov	word ptr _idisp,2
@5@5330:
   ;	
   ;	};
   ;	
	pop	ds
	mov	sp,bp
	pop	bp
	ret	
_ereignisse_	endp
   ;	
   ;	main()
   ;	
	assume	cs:TXWND1_TEXT
_main	proc	far
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,TXWND1_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		_setcursortype(_NOCURSOR);//----------------------------------------> unterdr�ckt cursoranzeige
   ;	
	xor	ax,ax
	push	ax
	call	far ptr __setcursortype
	inc	sp
	inc	sp
   ;	
   ;		//------------------------------------------------------------------> datei einlesen   
   ;		datei_in();	
   ;	
	push	cs
	call	near ptr _datei_in
@6@50:
   ;	
   ;	
   ;		while(1)//----------------------------------------------------------| hauptschleife
   ;		{
   ;			textbackground(disp);clrscr();
   ;	
	push	word ptr _disp
	call	far ptr _textbackground
	inc	sp
	inc	sp
	call	far ptr _clrscr
   ;	
   ;			//--------------------------------------------------------------> variablenmonitor
   ;			var_inf_();
   ;	
	push	cs
	call	near ptr _var_inf_
   ;	
   ;			//--------------------------------------------------------------> fenstererzeugung
   ;			fenster_();		
   ;	
	push	cs
	call	near ptr _fenster_
   ;	
   ;			//--------------------------------------------------------------> cursorerzeugung
   ;			cursor_();
   ;	
	push	cs
	call	near ptr _cursor_
   ;	
   ;			
   ;			//--------------------------------------------------------------> zuordnung der aktivierten taste
   ;			taste=getch();
   ;	
	call	far ptr _getch
	mov	byte ptr _taste,al
   ;	
   ;			
   ;			//--------------------------------------------------------------> ereignisse
   ;			ereignisse_();
   ;	
	push	cs
	call	near ptr _ereignisse_
   ;	
   ;			if(taste == 'Q') break;//---------------------------------------> Q_ende
   ;	
	cmp	byte ptr _taste,81
	jne	short @6@98
	jmp	short @6@122
@6@98:
	jmp	short @6@50
@6@122:
   ;	
   ;		}
   ;		return 0;
   ;	
	xor	ax,ax
	jmp	short @6@146
@6@146:
   ;	
   ;	}
   ;	
	pop	ds
	pop	bp
	ret	
_main	endp
TXWND1_TEXT	ends
TXWND1_DATA	segment word public 'DATA'
_tx_disp21	label	word
	db	2 dup (0)
_schub	label	word
	db	2 dup (0)
_strng	label	byte
	db	20 dup (0)
_txlng	label	word
	db	2 dup (0)
_iLauf	label	word
	db	2 dup (0)
_jLauf	label	word
	db	2 dup (0)
_zeile	label	word
	db	600 dup (0)
_text	label	byte
	db	60000 dup (0)
_taste	label	byte
	db	1 dup (0)
	?debug	C E9
s@	label	byte
	db	'r'
	db	0
	db	'x:%i y:%i '
	db	0
	db	'[./.] lng:%i'
	db	0
	db	'[I/K] lng2:%i'
	db	0
	db	'[L/O] lng3:%i'
	db	0
	db	'x_grd:%i y_gid:%i'
	db	0
	db	'[G/H]zschub:%i'
	db	0
	db	'zlnlng:%i'
	db	0
	db	'[J/M]schub:%i'
	db	0
	db	'txlng:%i'
	db	0
	db	'xf:%i yf:%i'
	db	0
	db	'[B]disp:%i [V]tx_disp:%i [C]tx_disp2:%i tx_disp21:%i [T]Datei'
	db	'_in'
	db	0
	db	'[U]fix:%i [F]grd:%i'
	db	0
	db	'['
	db	24
	db	'][Q]End'
	db	0
	db	'[p]'
	db	0
	db	-38
	db	0
	db	-60
	db	0
	db	-69
	db	0
	db	'%s'
	db	0
	db	'%c'
	db	0
	db	-80
	db	0
	db	-2
	db	0
	db	-51
	db	0
	db	-70
	db	0
	db	26
	db	'%.0f'
	db	0
	db	26
	db	'0'
	db	0
	db	25
	db	'%.0f'
	db	0
	db	29
	db	'%i'
	db	0
	db	18
	db	'%i'
	db	0
	db	-64
	db	-60
	db	'o'
	db	0
	db	25
	db	0
	db	' '
	db	0
	db	24
	db	0
	db	' '
	db	0
	db	27
	db	0
	db	' '
	db	0
	db	26
	db	0
	db	' '
	db	0
	db	-51
	db	0
	db	-60
	db	0
	db	-68
	db	0
	db	'.'
	db	0
	db	30
	db	0
	db	-18
	db	0
	db	0
	db	0
	db	-128
	db	-65
	db	'>'
	db	0
	db	'%s'
	db	0
	db	'r'
	db	0
TXWND1_DATA	ends
TXWND1_TEXT	segment byte public 'CODE'
TXWND1_TEXT	ends
	extrn	_fopen:far
	public	_index1
	extrn	_textcolor:far
	public	_fenster_
	public	_index
	public	_grd
	public	_cursor_
	public	_datei_in
	public	_var_inf_
	public	_lng3
	public	_lng2
	public	_lng
	public	_max_zln
	extrn	__setcursortype:far
	public	_taste
	public	_text
	public	_zeile
	public	_disp
	public	_tx_disp2
	public	_datei
	public	_tx_disp
	extrn	_cprintf:far
	extrn	_getch:far
	public	_main
	extrn	_strcpy:far
	public	_fix
	public	_zlnlng
	public	_jLauf
	public	_iLauf
	public	_idisp
	public	_txlng
	public	_strng
	public	_f1
	extrn	_clrscr:far
	extrn	_gotoxy:far
	public	_zschub
	extrn	_fclose:far
	public	_y_cpos
	public	_x_cpos
	extrn	F_FTOL@:far
	extrn	_textbackground:far
	public	_schub
	public	_ereignisse_
	public	_y_grd
	public	_x_grd
	extrn	_fgetc:far
	public	_tx_disp21
	public	_y_pos
	public	_x_pos
	extrn	_scanf:far
	end
