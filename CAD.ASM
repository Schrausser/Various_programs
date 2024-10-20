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
	?debug	S "cad.c"
	?debug	C E9798C973A056361642E63
	?debug	C E9438C973A054341442E68
	?debug	C E920105C1613433A5C54435C494E434C5544455C646F732E68
	?debug	C E920105C1615433A5C54435C494E434C5544455C737464696F2E68
	?debug	C E920105C1616433A5C54435C494E434C5544455C7374646C69622E+
	?debug	C 68
	?debug	C E920105C1615433A5C54435C494E434C5544455C636F6E696F2E68
	?debug	C E92B58943A087478776E64312E68
	?debug	C E920105C1613433A5C54435C494E434C5544455C646F732E68
	?debug	C E920105C1615433A5C54435C494E434C5544455C737464696F2E68
	?debug	C E920105C1616433A5C54435C494E434C5544455C7374646C69622E+
	?debug	C 68
	?debug	C E920105C1615433A5C54435C494E434C5544455C636F6E696F2E68
CAD_TEXT	segment byte public 'CODE'
CAD_TEXT	ends
	assume	cs:CAD_TEXT,ds:CAD_DATA
CAD_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
b@	label	byte
b@w	label	word
CAD_DATA	ends
CAD_TEXT	segment byte public 'CODE'
   ;	
   ;	void cad_()
   ;	
	assume	cs:CAD_TEXT
_cad_	proc	far
	push	bp
	mov	bp,sp
	sub	sp,10638
	push	si
	push	di
	push	ds
	mov	ax,CAD_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		FILE *inStream;
   ;	
   ;		int iLauf, jLauf, x_pos, y_pos, x_cpos, y_cpos, disp, tx_disp, tx_disp2, tx_disp21, f1, fix, lng, lng2, txlng, schub;
   ;	
   ;		int index = 1, index1 = 1, zeile[300];
   ;	
	mov	word ptr [bp-34],1
	mov	word ptr [bp-36],1
   ;	
   ;		char taste, text[100][100] ;
   ;		
   ;		_setcursortype(_NOCURSOR);//-------------------------------------------> unterdr�ckt cursoranzeige
   ;	
	xor	ax,ax
	push	ax
	call	far ptr __setcursortype
	inc	sp
	inc	sp
   ;	
   ;	
   ;		disp = 0; tx_disp = 6;tx_disp2= 8;//-------------------------------------> farbvoreinstellungen
   ;	
	mov	word ptr [bp-14],0
	mov	word ptr [bp-16],6
	mov	word ptr [bp-18],8
   ;	
   ;		x_pos=6, y_pos=14 ;//---------------------------------------------------> fensterposition
   ;	
	mov	word ptr [bp-6],6
	mov	word ptr [bp-8],14
   ;	
   ;		x_cpos=10, y_cpos=20 ;//-----------------------------------------------> cursorposition
   ;	
	mov	word ptr [bp-10],10
	mov	word ptr [bp-12],20
   ;	
   ;		
   ;		fix= -1;
   ;	
	mov	word ptr [bp-24],65535
   ;	
   ;	
   ;		f1= 2 +1;
   ;	
	mov	word ptr [bp-22],3
   ;	
   ;		lng=46;
   ;	
	mov	word ptr [bp-26],46
   ;	
   ;		lng2=7;
   ;	
	mov	word ptr [bp-28],7
   ;	
   ;		schub=0;
   ;	
	mov	word ptr [bp-32],0
   ;	
   ;	
   ;		inStream = fopen( "txwnd.txt", "r" );
   ;	
	push	ds
	mov	ax,offset s@+10
	push	ax
	push	ds
	mov	ax,offset s@
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;		
   ;		for(iLauf=1;iLauf<300;iLauf++) zeile[iLauf]=0;
   ;	
	mov	si,1
	jmp	short @1@98
@1@50:
	mov	bx,si
	shl	bx,1
	lea	ax,word ptr [bp-638]
	add	bx,ax
	mov	word ptr ss:[bx],0
	inc	si
@1@98:
	cmp	si,300
	jl	short @1@50
@1@122:
   ;	
   ;		
   ;		do
   ;		{
   ;			while(1)
   ;			{
   ;				text[index1][index] = fgetc(inStream);
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fgetc
	add	sp,4
	push	ax
	mov	ax,word ptr [bp-36]
	mov	dx,100
	imul	dx
	add	ax,word ptr [bp-34]
	lea	dx,word ptr [bp-10638]
	add	ax,dx
	mov	bx,ax
	pop	ax
	mov	byte ptr ss:[bx],al
   ;	
   ;				if (text[index1][index] == '\n') break;
   ;	
	mov	ax,word ptr [bp-36]
	mov	dx,100
	imul	dx
	add	ax,word ptr [bp-34]
	lea	dx,word ptr [bp-10638]
	add	ax,dx
	mov	bx,ax
	cmp	byte ptr ss:[bx],10
	jne	short @1@170
	jmp	short @1@242
@1@170:
   ;	
   ;				index++;zeile[index1]++;
   ;	
	inc	word ptr [bp-34]
	mov	bx,word ptr [bp-36]
	shl	bx,1
	lea	ax,word ptr [bp-638]
	add	bx,ax
	inc	word ptr ss:[bx]
   ;	
   ;				if (feof (inStream) != 0) break;
   ;	
	les	bx,dword ptr [bp-4]
	test	word ptr es:[bx+2],32
	je	short @1@218
	jmp	short @1@242
@1@218:
	jmp	short @1@122
@1@242:
   ;	
   ;			}
   ;			index1++;index=1;txlng=index1;
   ;	
	inc	word ptr [bp-36]
	mov	word ptr [bp-34],1
	mov	ax,word ptr [bp-36]
	mov	word ptr [bp-30],ax
   ;	
   ;		
   ;		}while (feof (inStream) == 0);
   ;	
	les	bx,dword ptr [bp-4]
	test	word ptr es:[bx+2],32
	je	short @1@122
   ;	
   ;	
   ;	
   ;		fclose( inStream  );
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
@1@314:
   ;	
   ;	
   ;	
   ;	
   ;		while(1)//--------------------------------------------------------------| hauptschleife
   ;		{
   ;			textbackground(disp);
   ;	
	push	word ptr [bp-14]
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;			clrscr();
   ;	
	call	far ptr _clrscr
   ;	
   ;			//cprintf("x:%i y:%i tx_disp:%i",x_cpos, y_cpos-1, tx_disp);
   ;			
   ;			
   ;			//----------------------------------------------------------------------------> fenster
   ;			
   ;			if(fix==1)if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){tx_disp21=7;}else{tx_disp21=8;}
   ;	
	cmp	word ptr [bp-24],1
	jne	short @1@434
	mov	ax,word ptr [bp-6]
	inc	ax
	cmp	ax,word ptr [bp-10]
	jne	short @1@410
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-22]
	cmp	ax,word ptr [bp-12]
	jne	short @1@410
	mov	word ptr [bp-20],7
	jmp	short @1@434
@1@410:
	mov	word ptr [bp-20],8
@1@434:
   ;	
   ;			if(fix == -1)tx_disp21=tx_disp2;
   ;	
	cmp	word ptr [bp-24],65535
	jne	short @1@482
	mov	ax,word ptr [bp-18]
	mov	word ptr [bp-20],ax
@1@482:
   ;	
   ;			
   ;			textcolor(tx_disp21);
   ;	
	push	word ptr [bp-20]
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;	
   ;			if(y_pos - lng2  >0) 
   ;	
	mov	ax,word ptr [bp-8]
	sub	ax,word ptr [bp-28]
	jle	short @1@626
   ;	
   ;			{
   ;				gotoxy(x_pos-1, y_pos - lng2);cprintf("\xDA");
   ;	
	mov	ax,word ptr [bp-8]
	sub	ax,word ptr [bp-28]
	push	ax
	mov	ax,word ptr [bp-6]
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+12
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				for(iLauf=1;iLauf<=lng-2;iLauf++)cprintf("\xC4");
   ;	
	mov	si,1
	jmp	short @1@578
@1@530:
	push	ds
	mov	ax,offset s@+14
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	si
@1@578:
	mov	ax,word ptr [bp-26]
	add	ax,65534
	cmp	ax,si
	jge	short @1@530
   ;	
   ;				cprintf("\xC2");
   ;	
	push	ds
	mov	ax,offset s@+16
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@626:
   ;	
   ;			
   ;			}
   ;			textcolor(tx_disp);
   ;	
	push	word ptr [bp-16]
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;			for(iLauf=1;iLauf<= lng2-1 ;iLauf++) 
   ;	
	mov	si,1
	jmp	short @1@794
@1@650:
   ;	
   ;			{
   ;				if(y_pos+1-iLauf >0) 
   ;	
	mov	ax,word ptr [bp-8]
	inc	ax
	sub	ax,si
	jle	short @1@770
   ;	
   ;				for(jLauf=1;jLauf<= lng-4 ;jLauf+=1)
   ;	
	mov	di,1
	jmp	short @1@746
@1@698:
   ;	
   ;				{	
   ;						gotoxy( x_pos+jLauf , (y_pos+1)-iLauf ); cprintf("%c", text[ ((txlng-3)-iLauf)+schub ][jLauf]);
   ;	
	mov	ax,word ptr [bp-8]
	inc	ax
	sub	ax,si
	push	ax
	mov	ax,word ptr [bp-6]
	add	ax,di
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr [bp-30]
	add	ax,65533
	sub	ax,si
	add	ax,word ptr [bp-32]
	mov	dx,100
	imul	dx
	add	ax,di
	lea	dx,word ptr [bp-10638]
	add	ax,dx
	mov	bx,ax
	mov	al,byte ptr ss:[bx]
	cbw	
	push	ax
	push	ds
	mov	ax,offset s@+18
	push	ax
	call	far ptr _cprintf
	add	sp,6
	inc	di
@1@746:
	mov	ax,word ptr [bp-26]
	add	ax,65532
	cmp	ax,di
	jge	short @1@698
@1@770:
	inc	si
@1@794:
	mov	ax,word ptr [bp-28]
	dec	ax
	cmp	ax,si
	jge	short @1@650
   ;	
   ;				}
   ;			}
   ;			
   ;			textcolor(tx_disp21);
   ;	
	push	word ptr [bp-20]
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;			if(y_pos+2 >0) 
   ;	
	mov	ax,word ptr [bp-8]
	inc	ax
	inc	ax
	jle	short @1@962
   ;	
   ;			{
   ;				gotoxy(x_pos-1, y_pos+2);	cprintf("\xC0\xC4o");
   ;	
	mov	ax,word ptr [bp-8]
	inc	ax
	inc	ax
	push	ax
	mov	ax,word ptr [bp-6]
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+21
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				for(iLauf=1;iLauf<=lng-4;iLauf++)cprintf("\xC4");
   ;	
	mov	si,1
	jmp	short @1@914
@1@866:
	push	ds
	mov	ax,offset s@+25
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	si
@1@914:
	mov	ax,word ptr [bp-26]
	add	ax,65532
	cmp	ax,si
	jge	short @1@866
   ;	
   ;				cprintf("\xD9");
   ;	
	push	ds
	mov	ax,offset s@+27
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@962:
   ;	
   ;			
   ;			}
   ;	
   ;			
   ;			//------------------------------------------------------------------------------> cursor
   ;			textcolor(tx_disp);
   ;	
	push	word ptr [bp-16]
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;			gotoxy(x_cpos, y_cpos-1);cprintf(".");
   ;	
	mov	ax,word ptr [bp-12]
	dec	ax
	push	ax
	push	word ptr [bp-10]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+29
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			gotoxy(x_cpos, y_cpos);cprintf("\x1E");
   ;	
	push	word ptr [bp-12]
	push	word ptr [bp-10]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+31
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			
   ;			if(fix==1){gotoxy(x_cpos, y_cpos+1);cprintf("\xEE");}//-------------------------> fixierungsschaltersymbol
   ;	
	cmp	word ptr [bp-24],1
	jne	short @1@1010
	mov	ax,word ptr [bp-12]
	inc	ax
	push	ax
	push	word ptr [bp-10]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+33
	push	ax
	call	far ptr _cprintf
	add	sp,4
@1@1010:
   ;	
   ;			
   ;	
   ;			//---------------------------------------------------------------> zuordnung der aktivierten taste
   ;			
   ;			taste=getch();
   ;	
	call	far ptr _getch
	mov	byte ptr [bp-37],al
   ;	
   ;			
   ;			//-----------------------------------------------------------------> ereignisse
   ;			
   ;			if(taste == 'v') {tx_disp--;if(tx_disp<0)tx_disp = 15;}//--------------------> v_taste �ndert fensterfarbe
   ;	
	cmp	byte ptr [bp-37],118
	jne	short @1@1082
	dec	word ptr [bp-16]
	cmp	word ptr [bp-16],0
	jge	short @1@1082
	mov	word ptr [bp-16],15
@1@1082:
   ;	
   ;			if(taste == 'c') {tx_disp2--;if(tx_disp2<7)tx_disp2 = 8;}//-------------------> c_taste �ndert text
   ;	
	cmp	byte ptr [bp-37],99
	jne	short @1@1154
	dec	word ptr [bp-18]
	cmp	word ptr [bp-18],7
	jge	short @1@1154
	mov	word ptr [bp-18],8
@1@1154:
   ;	
   ;			if(taste == 'b') {disp--;if(disp<0) disp = 7;}//---------------------------> b_taste �ndert displayfarbe
   ;	
	cmp	byte ptr [bp-37],98
	jne	short @1@1226
	dec	word ptr [bp-14]
	cmp	word ptr [bp-14],0
	jge	short @1@1226
	mov	word ptr [bp-14],7
@1@1226:
   ;	
   ;			
   ;			if(taste == 'u') fix*=-1;//--------------------------------------> u_schaltet markierungsfixierung
   ;	
	cmp	byte ptr [bp-37],117
	jne	short @1@1274
	mov	dx,65535
	mov	ax,word ptr [bp-24]
	imul	dx
	mov	word ptr [bp-24],ax
@1@1274:
   ;	
   ;	
   ;			if(taste == 'w' && y_cpos  > 3)//------------------------------------------------------------------------------> w_taste versc
   ;	
	cmp	byte ptr [bp-37],119
	jne	short @1@1538
	cmp	word ptr [bp-12],3
	jle	short @1@1538
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr [bp-24],1
	jne	short @1@1514
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))y_pos--;
   ;	
	mov	ax,word ptr [bp-6]
	inc	ax
	cmp	ax,word ptr [bp-10]
	jne	short @1@1418
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-22]
	cmp	ax,word ptr [bp-12]
	jne	short @1@1418
	dec	word ptr [bp-8]
@1@1418:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng2-schub<=txlng-4)lng2++;
   ;	
	mov	ax,word ptr [bp-6]
	add	ax,word ptr [bp-26]
	add	ax,65534
	cmp	ax,word ptr [bp-10]
	jne	short @1@1514
	mov	ax,word ptr [bp-8]
	inc	ax
	sub	ax,word ptr [bp-28]
	cmp	ax,word ptr [bp-12]
	jne	short @1@1514
	mov	ax,word ptr [bp-28]
	sub	ax,word ptr [bp-32]
	mov	dx,word ptr [bp-30]
	add	dx,65532
	cmp	ax,dx
	jg	short @1@1514
	inc	word ptr [bp-28]
@1@1514:
   ;	
   ;					
   ;				}
   ;				y_cpos--;
   ;	
	dec	word ptr [bp-12]
@1@1538:
   ;	
   ;			}
   ;			
   ;			if(taste == 's' && y_cpos  < 49) //---------------------------------------------------------------------------> s_taste versch
   ;	
	cmp	byte ptr [bp-37],115
	jne	short @1@1802
	cmp	word ptr [bp-12],49
	jge	short @1@1802
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr [bp-24],1
	jne	short @1@1778
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))y_pos++;
   ;	
	mov	ax,word ptr [bp-6]
	inc	ax
	cmp	ax,word ptr [bp-10]
	jne	short @1@1682
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-22]
	cmp	ax,word ptr [bp-12]
	jne	short @1@1682
	inc	word ptr [bp-8]
@1@1682:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng2>=0)lng2--;
   ;	
	mov	ax,word ptr [bp-6]
	add	ax,word ptr [bp-26]
	add	ax,65534
	cmp	ax,word ptr [bp-10]
	jne	short @1@1778
	mov	ax,word ptr [bp-8]
	inc	ax
	sub	ax,word ptr [bp-28]
	cmp	ax,word ptr [bp-12]
	jne	short @1@1778
	cmp	word ptr [bp-28],0
	jl	short @1@1778
	dec	word ptr [bp-28]
@1@1778:
   ;	
   ;					
   ;				}
   ;				y_cpos++;
   ;	
	inc	word ptr [bp-12]
@1@1802:
   ;	
   ;			}
   ;			
   ;			if(taste == 'a' && x_cpos  > 3) //----------------------------------------------------------------------------> a_taste versch
   ;	
	cmp	byte ptr [bp-37],97
	jne	short @1@2066
	cmp	word ptr [bp-10],3
	jle	short @1@2066
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr [bp-24],1
	jne	short @1@2042
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))x_pos--;
   ;	
	mov	ax,word ptr [bp-6]
	inc	ax
	cmp	ax,word ptr [bp-10]
	jne	short @1@1946
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-22]
	cmp	ax,word ptr [bp-12]
	jne	short @1@1946
	dec	word ptr [bp-6]
@1@1946:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))if(lng>4)lng--;
   ;	
	mov	ax,word ptr [bp-6]
	add	ax,word ptr [bp-26]
	add	ax,65534
	cmp	ax,word ptr [bp-10]
	jne	short @1@2042
	mov	ax,word ptr [bp-8]
	inc	ax
	sub	ax,word ptr [bp-28]
	cmp	ax,word ptr [bp-12]
	jne	short @1@2042
	cmp	word ptr [bp-26],4
	jle	short @1@2042
	dec	word ptr [bp-26]
@1@2042:
   ;	
   ;					
   ;				}
   ;	
   ;				x_cpos--;
   ;	
	dec	word ptr [bp-10]
@1@2066:
   ;	
   ;			}
   ;			
   ;			if(taste == 'd' && x_cpos  < 78) //---------------------------------------------------------------------------> d_taste versch
   ;	
	cmp	byte ptr [bp-37],100
	jne	short @1@2306
	cmp	word ptr [bp-10],78
	jge	short @1@2306
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr [bp-24],1
	jne	short @1@2282
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))x_pos++;
   ;	
	mov	ax,word ptr [bp-6]
	inc	ax
	cmp	ax,word ptr [bp-10]
	jne	short @1@2210
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-22]
	cmp	ax,word ptr [bp-12]
	jne	short @1@2210
	inc	word ptr [bp-6]
@1@2210:
   ;	
   ;					if((x_cpos == x_pos+lng-2) && (y_cpos == y_pos+1-lng2))lng++;
   ;	
	mov	ax,word ptr [bp-6]
	add	ax,word ptr [bp-26]
	add	ax,65534
	cmp	ax,word ptr [bp-10]
	jne	short @1@2282
	mov	ax,word ptr [bp-8]
	inc	ax
	sub	ax,word ptr [bp-28]
	cmp	ax,word ptr [bp-12]
	jne	short @1@2282
	inc	word ptr [bp-26]
@1@2282:
   ;	
   ;					
   ;				}
   ;				x_cpos++;
   ;	
	inc	word ptr [bp-10]
@1@2306:
   ;	
   ;			}
   ;			
   ;			if(taste == 'i')schub++;
   ;	
	cmp	byte ptr [bp-37],105
	jne	short @1@2354
	inc	word ptr [bp-32]
@1@2354:
   ;	
   ;			if(taste == 'k')if(lng2-(txlng-4)<=schub)schub--;
   ;	
	cmp	byte ptr [bp-37],107
	jne	short @1@2426
	mov	ax,word ptr [bp-30]
	add	ax,65532
	mov	dx,word ptr [bp-28]
	sub	dx,ax
	cmp	dx,word ptr [bp-32]
	jg	short @1@2426
	dec	word ptr [bp-32]
@1@2426:
   ;	
   ;			
   ;			
   ;			if(taste == 'q')  break;  // q_ende
   ;	
	cmp	byte ptr [bp-37],113
	jne	short @1@2474
	jmp	short @1@2498
@1@2474:
	jmp	@1@314
@1@2498:
   ;	
   ;	
   ;	
   ;		}	
   ;	}
   ;	
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_cad_	endp
CAD_TEXT	ends
CAD_DATA	segment word public 'DATA'
_x_pos	label	word
	db	70
	db	0
_y_pos	label	word
	db	4
	db	0
_x_2pos	label	word
	db	4
	db	0
_y_2pos	label	word
	db	34
	db	0
_x_3pos	label	word
	db	62
	db	0
_y_3pos	label	word
	db	41
	db	0
_x_cpos	label	word
	db	40
	db	0
_y_cpos	label	word
	db	26
	db	0
_grdy	label	word
	db	5
	db	0
_grdx	label	word
	db	6
	db	0
_n_	label	word
	db	0
	db	0
_cad_in	label	word
	db	1
	db	0
_cadini	label	word
	db	0
	db	0
_index	label	word
	db	1
	db	0
_grid	label	word
	db	1
	db	0
_lin	label	word
	db	1
	db	0
_fix	label	word
	db	255
	db	255
_fix1	label	word
	db	0
	db	0
_set	label	word
	db	1
	db	0
_wnd3	label	word
	db	1
	db	0
_drw	label	word
	db	255
	db	255
_drw_m	label	word
	db	0
	db	0
_f1	label	word
	db	7
	db	0
_f2	label	word
	db	15
	db	0
_f3	label	word
	db	8
	db	0
_symb_	label	word
	db	4
	db	0
_tx_disp	label	word
	db	15
	db	0
_disp	label	word
	db	2
	db	0
_tx_disp2	label	word
	db	7
	db	0
CAD_DATA	ends
CAD_TEXT	segment byte public 'CODE'
   ;	
   ;	void symbole()
   ;	
	assume	cs:CAD_TEXT
_symbole	proc	far
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,CAD_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		gotoxy(cadx_pos[iLauf], cady_pos[iLauf]);
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	push	word ptr _cady_pos[bx]
	mov	bx,word ptr _iLauf
	shl	bx,1
	push	word ptr _cadx_pos[bx]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;		if(symb[iLauf]==1)cprintf("\xDB");	if(symb[iLauf]==2)cprintf("\x9E");	if(symb[iLauf]==3)cprintf("o");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],1
	jne	short @2@74
	push	ds
	mov	ax,offset s@+35
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@74:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],2
	jne	short @2@122
	push	ds
	mov	ax,offset s@+37
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@122:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],3
	jne	short @2@170
	push	ds
	mov	ax,offset s@+39
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@170:
   ;	
   ;		if(symb[iLauf]==4)cprintf(".");		if(symb[iLauf]==5)cprintf(" ");		if(symb[iLauf]==6)cprintf("+");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],4
	jne	short @2@218
	push	ds
	mov	ax,offset s@+41
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@218:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],5
	jne	short @2@266
	push	ds
	mov	ax,offset s@+43
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@266:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],6
	jne	short @2@314
	push	ds
	mov	ax,offset s@+45
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@314:
   ;	
   ;		if(symb[iLauf]==7)cprintf("\xDA");	if(symb[iLauf]==8)cprintf("\xC4");	if(symb[iLauf]==9)cprintf("\xBF");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],7
	jne	short @2@362
	push	ds
	mov	ax,offset s@+47
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@362:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],8
	jne	short @2@410
	push	ds
	mov	ax,offset s@+49
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@410:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],9
	jne	short @2@458
	push	ds
	mov	ax,offset s@+51
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@458:
   ;	
   ;		if(symb[iLauf]==10)cprintf("\xB3");	if(symb[iLauf]==11)cprintf("\xD9");	if(symb[iLauf]==12)cprintf("\xC0");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],10
	jne	short @2@506
	push	ds
	mov	ax,offset s@+53
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@506:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],11
	jne	short @2@554
	push	ds
	mov	ax,offset s@+55
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@554:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],12
	jne	short @2@602
	push	ds
	mov	ax,offset s@+57
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@602:
   ;	
   ;		if(symb[iLauf]==13)cprintf("/");	if(symb[iLauf]==14)cprintf("\\");	if(symb[iLauf]==15)cprintf("\xB0");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],13
	jne	short @2@650
	push	ds
	mov	ax,offset s@+59
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@650:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],14
	jne	short @2@698
	push	ds
	mov	ax,offset s@+61
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@698:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],15
	jne	short @2@746
	push	ds
	mov	ax,offset s@+63
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@746:
   ;	
   ;		if(symb[iLauf]==16)cprintf("\xB1");	if(symb[iLauf]==17)cprintf("\xB2");	
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],16
	jne	short @2@794
	push	ds
	mov	ax,offset s@+65
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@794:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],17
	jne	short @2@842
	push	ds
	mov	ax,offset s@+67
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@842:
   ;	
   ;		if(symb[iLauf]==19)cprintf("\xDC");	if(symb[iLauf]==20)cprintf("\xFE");	if(symb[iLauf]==21)cprintf("\xDF");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],19
	jne	short @2@890
	push	ds
	mov	ax,offset s@+69
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@890:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],20
	jne	short @2@938
	push	ds
	mov	ax,offset s@+71
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@938:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],21
	jne	short @2@986
	push	ds
	mov	ax,offset s@+73
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@986:
   ;	
   ;		if(symb[iLauf]==22)cprintf("\xB4");	if(symb[iLauf]==23)cprintf("\xC1");	if(symb[iLauf]==24)cprintf(">");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],22
	jne	short @2@1034
	push	ds
	mov	ax,offset s@+75
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1034:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],23
	jne	short @2@1082
	push	ds
	mov	ax,offset s@+77
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1082:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],24
	jne	short @2@1130
	push	ds
	mov	ax,offset s@+79
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1130:
   ;	
   ;		if(symb[iLauf]==25)cprintf("<");	if(symb[iLauf]==26)cprintf("\xC2");	if(symb[iLauf]==27)cprintf("^");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],25
	jne	short @2@1178
	push	ds
	mov	ax,offset s@+81
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1178:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],26
	jne	short @2@1226
	push	ds
	mov	ax,offset s@+83
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1226:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],27
	jne	short @2@1274
	push	ds
	mov	ax,offset s@+85
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1274:
   ;	
   ;		if(symb[iLauf]==28)cprintf("\xC3");	if(symb[iLauf]==29)cprintf("\x16");	
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],28
	jne	short @2@1322
	push	ds
	mov	ax,offset s@+87
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1322:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],29
	jne	short @2@1370
	push	ds
	mov	ax,offset s@+89
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1370:
   ;	
   ;		if(symb[iLauf]==34)cprintf("\xC5");	
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],34
	jne	short @2@1418
	push	ds
	mov	ax,offset s@+91
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1418:
   ;	
   ;		if(symb[iLauf]==37)cprintf("_");	if(symb[iLauf]==39)cprintf("\xEE");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],37
	jne	short @2@1466
	push	ds
	mov	ax,offset s@+93
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1466:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],39
	jne	short @2@1514
	push	ds
	mov	ax,offset s@+95
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1514:
   ;	
   ;		if(symb[iLauf]==40)cprintf("-");	
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],40
	jne	short @2@1562
	push	ds
	mov	ax,offset s@+97
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1562:
   ;	
   ;		if(symb[iLauf]==43)cprintf("\xB9");	if(symb[iLauf]==44)cprintf("\xBB");	if(symb[iLauf]==45)cprintf("\xBC");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],43
	jne	short @2@1610
	push	ds
	mov	ax,offset s@+99
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1610:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],44
	jne	short @2@1658
	push	ds
	mov	ax,offset s@+101
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1658:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],45
	jne	short @2@1706
	push	ds
	mov	ax,offset s@+103
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1706:
   ;	
   ;		if(symb[iLauf]==46)cprintf("\xC8");	if(symb[iLauf]==47)cprintf("\xC9");	if(symb[iLauf]==48)cprintf("\xBA");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],46
	jne	short @2@1754
	push	ds
	mov	ax,offset s@+105
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1754:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],47
	jne	short @2@1802
	push	ds
	mov	ax,offset s@+107
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1802:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],48
	jne	short @2@1850
	push	ds
	mov	ax,offset s@+109
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1850:
   ;	
   ;		if(symb[iLauf]==49)cprintf("\xCD");	if(symb[iLauf]==50)cprintf("=");	if(symb[iLauf]==51)cprintf("\xCB");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],49
	jne	short @2@1898
	push	ds
	mov	ax,offset s@+111
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1898:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],50
	jne	short @2@1946
	push	ds
	mov	ax,offset s@+113
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1946:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],51
	jne	short @2@1994
	push	ds
	mov	ax,offset s@+115
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1994:
   ;	
   ;		if(symb[iLauf]==52)cprintf("\xCC");	if(symb[iLauf]==53)cprintf("\xCE");	if(symb[iLauf]==54)cprintf("\xCF");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],52
	jne	short @2@2042
	push	ds
	mov	ax,offset s@+117
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2042:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],53
	jne	short @2@2090
	push	ds
	mov	ax,offset s@+119
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2090:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],54
	jne	short @2@2138
	push	ds
	mov	ax,offset s@+121
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2138:
   ;	
   ;		if(symb[iLauf]==55)cprintf("\xDD");	if(symb[iLauf]==56)cprintf("\xCA");	if(symb[iLauf]==57)cprintf("\x10");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],55
	jne	short @2@2186
	push	ds
	mov	ax,offset s@+123
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2186:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],56
	jne	short @2@2234
	push	ds
	mov	ax,offset s@+125
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2234:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],57
	jne	short @2@2282
	push	ds
	mov	ax,offset s@+127
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2282:
   ;	
   ;		if(symb[iLauf]==58)cprintf("\x11");	if(symb[iLauf]==59)cprintf("\x1E");	if(symb[iLauf]==60)cprintf("\x1F");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],58
	jne	short @2@2330
	push	ds
	mov	ax,offset s@+129
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2330:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],59
	jne	short @2@2378
	push	ds
	mov	ax,offset s@+131
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2378:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],60
	jne	short @2@2426
	push	ds
	mov	ax,offset s@+133
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2426:
   ;	
   ;		if(symb[iLauf]==61)cprintf("\x1A");	if(symb[iLauf]==62)cprintf("\x1B");	if(symb[iLauf]==63)cprintf("\x1C");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],61
	jne	short @2@2474
	push	ds
	mov	ax,offset s@+135
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2474:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],62
	jne	short @2@2522
	push	ds
	mov	ax,offset s@+137
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2522:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],63
	jne	short @2@2570
	push	ds
	mov	ax,offset s@+139
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2570:
   ;	
   ;		if(symb[iLauf]==64)cprintf("\x18");	if(symb[iLauf]==65)cprintf("\x19");	if(symb[iLauf]==66)cprintf("\x17");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],64
	jne	short @2@2618
	push	ds
	mov	ax,offset s@+141
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2618:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],65
	jne	short @2@2666
	push	ds
	mov	ax,offset s@+143
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2666:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],66
	jne	short @2@2714
	push	ds
	mov	ax,offset s@+145
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2714:
   ;	
   ;		if(symb[iLauf]==67)cprintf("\x1D");	if(symb[iLauf]==68)cprintf("\xF9");	if(symb[iLauf]==69)cprintf("\xF7");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],67
	jne	short @2@2762
	push	ds
	mov	ax,offset s@+147
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2762:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],68
	jne	short @2@2810
	push	ds
	mov	ax,offset s@+149
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2810:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],69
	jne	short @2@2858
	push	ds
	mov	ax,offset s@+151
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2858:
   ;	
   ;		if(symb[iLauf]==70)cprintf("\xAA");	if(symb[iLauf]==71)cprintf("\xA7");	if(symb[iLauf]==72)cprintf("\xA9");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],70
	jne	short @2@2906
	push	ds
	mov	ax,offset s@+153
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2906:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],71
	jne	short @2@2954
	push	ds
	mov	ax,offset s@+155
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2954:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],72
	jne	short @2@3002
	push	ds
	mov	ax,offset s@+157
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3002:
   ;	
   ;		if(symb[iLauf]==73)cprintf("\xAE");	if(symb[iLauf]==74)cprintf("\xAF");	if(symb[iLauf]==75)cprintf("\x0F");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],73
	jne	short @2@3050
	push	ds
	mov	ax,offset s@+159
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3050:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],74
	jne	short @2@3098
	push	ds
	mov	ax,offset s@+161
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3098:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],75
	jne	short @2@3146
	push	ds
	mov	ax,offset s@+163
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3146:
   ;	
   ;		if(symb[iLauf]==76)cprintf("\x0E");	if(symb[iLauf]==77)cprintf("*");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],76
	jne	short @2@3194
	push	ds
	mov	ax,offset s@+165
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3194:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],77
	jne	short @2@3242
	push	ds
	mov	ax,offset s@+167
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3242:
   ;	
   ;	
   ;		if(symb[iLauf]==78)cprintf("1");    if(symb[iLauf]==79)cprintf("2");    if(symb[iLauf]==80)cprintf("3");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],78
	jne	short @2@3290
	push	ds
	mov	ax,offset s@+169
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3290:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],79
	jne	short @2@3338
	push	ds
	mov	ax,offset s@+171
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3338:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],80
	jne	short @2@3386
	push	ds
	mov	ax,offset s@+173
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3386:
   ;	
   ;		if(symb[iLauf]==81)cprintf("4");	if(symb[iLauf]==82)cprintf("5");    if(symb[iLauf]==83)cprintf("6");    
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],81
	jne	short @2@3434
	push	ds
	mov	ax,offset s@+175
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3434:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],82
	jne	short @2@3482
	push	ds
	mov	ax,offset s@+177
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3482:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],83
	jne	short @2@3530
	push	ds
	mov	ax,offset s@+179
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3530:
   ;	
   ;		if(symb[iLauf]==84)cprintf("7");    if(symb[iLauf]==85)cprintf("8");	if(symb[iLauf]==86)cprintf("9");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],84
	jne	short @2@3578
	push	ds
	mov	ax,offset s@+181
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3578:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],85
	jne	short @2@3626
	push	ds
	mov	ax,offset s@+183
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3626:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],86
	jne	short @2@3674
	push	ds
	mov	ax,offset s@+185
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3674:
   ;	
   ;	
   ;		if(symb[iLauf]==87)cprintf("a");    if(symb[iLauf]==88)cprintf("b");    if(symb[iLauf]==89)cprintf("c");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],87
	jne	short @2@3722
	push	ds
	mov	ax,offset s@+187
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3722:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],88
	jne	short @2@3770
	push	ds
	mov	ax,offset s@+189
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3770:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],89
	jne	short @2@3818
	push	ds
	mov	ax,offset s@+191
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3818:
   ;	
   ;		if(symb[iLauf]==90)cprintf("d");	if(symb[iLauf]==91)cprintf("e");    if(symb[iLauf]==92)cprintf("f");    
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],90
	jne	short @2@3866
	push	ds
	mov	ax,offset s@+193
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3866:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],91
	jne	short @2@3914
	push	ds
	mov	ax,offset s@+195
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3914:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],92
	jne	short @2@3962
	push	ds
	mov	ax,offset s@+197
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@3962:
   ;	
   ;		if(symb[iLauf]==93)cprintf("g");    if(symb[iLauf]==94)cprintf("h");	if(symb[iLauf]==95)cprintf("i");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],93
	jne	short @2@4010
	push	ds
	mov	ax,offset s@+199
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4010:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],94
	jne	short @2@4058
	push	ds
	mov	ax,offset s@+201
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4058:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],95
	jne	short @2@4106
	push	ds
	mov	ax,offset s@+203
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4106:
   ;	
   ;		if(symb[iLauf]==96)cprintf("j");    if(symb[iLauf]==97)cprintf("k");    if(symb[iLauf]==98)cprintf("l");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],96
	jne	short @2@4154
	push	ds
	mov	ax,offset s@+205
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4154:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],97
	jne	short @2@4202
	push	ds
	mov	ax,offset s@+207
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4202:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],98
	jne	short @2@4250
	push	ds
	mov	ax,offset s@+209
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4250:
   ;	
   ;		if(symb[iLauf]==99)cprintf("m");	if(symb[iLauf]==100)cprintf("n");   if(symb[iLauf]==101)cprintf("o");    
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],99
	jne	short @2@4298
	push	ds
	mov	ax,offset s@+211
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4298:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],100
	jne	short @2@4346
	push	ds
	mov	ax,offset s@+213
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4346:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],101
	jne	short @2@4394
	push	ds
	mov	ax,offset s@+215
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4394:
   ;	
   ;		if(symb[iLauf]==102)cprintf("p");   if(symb[iLauf]==103)cprintf("q");	if(symb[iLauf]==104)cprintf("r");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],102
	jne	short @2@4442
	push	ds
	mov	ax,offset s@+217
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4442:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],103
	jne	short @2@4490
	push	ds
	mov	ax,offset s@+219
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4490:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],104
	jne	short @2@4538
	push	ds
	mov	ax,offset s@+221
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4538:
   ;	
   ;		if(symb[iLauf]==105)cprintf("s");   if(symb[iLauf]==106)cprintf("t");   if(symb[iLauf]==107)cprintf("u");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],105
	jne	short @2@4586
	push	ds
	mov	ax,offset s@+223
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4586:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],106
	jne	short @2@4634
	push	ds
	mov	ax,offset s@+225
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4634:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],107
	jne	short @2@4682
	push	ds
	mov	ax,offset s@+227
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4682:
   ;	
   ;		if(symb[iLauf]==108)cprintf("v");	if(symb[iLauf]==109)cprintf("w");   if(symb[iLauf]==110)cprintf("x");    
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],108
	jne	short @2@4730
	push	ds
	mov	ax,offset s@+229
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4730:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],109
	jne	short @2@4778
	push	ds
	mov	ax,offset s@+231
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4778:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],110
	jne	short @2@4826
	push	ds
	mov	ax,offset s@+233
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4826:
   ;	
   ;		if(symb[iLauf]==111)cprintf("y");   if(symb[iLauf]==112)cprintf("z");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],111
	jne	short @2@4874
	push	ds
	mov	ax,offset s@+235
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4874:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],112
	jne	short @2@4922
	push	ds
	mov	ax,offset s@+237
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4922:
   ;	
   ;		
   ;		if(symb[iLauf]==113)cprintf("A");   if(symb[iLauf]==114)cprintf("B");   if(symb[iLauf]==115)cprintf("C");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],113
	jne	short @2@4970
	push	ds
	mov	ax,offset s@+239
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@4970:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],114
	jne	short @2@5018
	push	ds
	mov	ax,offset s@+241
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5018:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],115
	jne	short @2@5066
	push	ds
	mov	ax,offset s@+243
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5066:
   ;	
   ;		if(symb[iLauf]==116)cprintf("D");	if(symb[iLauf]==117)cprintf("E");   if(symb[iLauf]==118)cprintf("F");    
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],116
	jne	short @2@5114
	push	ds
	mov	ax,offset s@+245
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5114:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],117
	jne	short @2@5162
	push	ds
	mov	ax,offset s@+247
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5162:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],118
	jne	short @2@5210
	push	ds
	mov	ax,offset s@+249
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5210:
   ;	
   ;		if(symb[iLauf]==119)cprintf("G");   if(symb[iLauf]==120)cprintf("H");	if(symb[iLauf]==121)cprintf("I");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],119
	jne	short @2@5258
	push	ds
	mov	ax,offset s@+251
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5258:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],120
	jne	short @2@5306
	push	ds
	mov	ax,offset s@+253
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5306:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],121
	jne	short @2@5354
	push	ds
	mov	ax,offset s@+255
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5354:
   ;	
   ;		if(symb[iLauf]==122)cprintf("J");   if(symb[iLauf]==123)cprintf("K");   if(symb[iLauf]==124)cprintf("L");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],122
	jne	short @2@5402
	push	ds
	mov	ax,offset s@+257
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5402:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],123
	jne	short @2@5450
	push	ds
	mov	ax,offset s@+259
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5450:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],124
	jne	short @2@5498
	push	ds
	mov	ax,offset s@+261
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5498:
   ;	
   ;		if(symb[iLauf]==125)cprintf("M");	if(symb[iLauf]==126)cprintf("N");   if(symb[iLauf]==127)cprintf("O");    
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],125
	jne	short @2@5546
	push	ds
	mov	ax,offset s@+263
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5546:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],126
	jne	short @2@5594
	push	ds
	mov	ax,offset s@+265
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5594:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],127
	jne	short @2@5642
	push	ds
	mov	ax,offset s@+267
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5642:
   ;	
   ;		if(symb[iLauf]==128)cprintf("P");   if(symb[iLauf]==129)cprintf("Q");	if(symb[iLauf]==130)cprintf("R");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],128
	jne	short @2@5690
	push	ds
	mov	ax,offset s@+269
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5690:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],129
	jne	short @2@5738
	push	ds
	mov	ax,offset s@+271
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5738:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],130
	jne	short @2@5786
	push	ds
	mov	ax,offset s@+273
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5786:
   ;	
   ;		if(symb[iLauf]==131)cprintf("S");   if(symb[iLauf]==132)cprintf("T");   if(symb[iLauf]==133)cprintf("U");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],131
	jne	short @2@5834
	push	ds
	mov	ax,offset s@+275
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5834:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],132
	jne	short @2@5882
	push	ds
	mov	ax,offset s@+277
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5882:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],133
	jne	short @2@5930
	push	ds
	mov	ax,offset s@+279
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5930:
   ;	
   ;		if(symb[iLauf]==134)cprintf("V");	if(symb[iLauf]==135)cprintf("W");   if(symb[iLauf]==136)cprintf("X");    
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],134
	jne	short @2@5978
	push	ds
	mov	ax,offset s@+281
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@5978:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],135
	jne	short @2@6026
	push	ds
	mov	ax,offset s@+283
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6026:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],136
	jne	short @2@6074
	push	ds
	mov	ax,offset s@+285
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6074:
   ;	
   ;		if(symb[iLauf]==137)cprintf("Y");   if(symb[iLauf]==138)cprintf("Z");	
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],137
	jne	short @2@6122
	push	ds
	mov	ax,offset s@+287
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6122:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],138
	jne	short @2@6170
	push	ds
	mov	ax,offset s@+289
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6170:
   ;	
   ;	
   ;		if(symb[iLauf]==139)cprintf("!");   if(symb[iLauf]==140)cprintf("\"");  if(symb[iLauf]==141)cprintf("�");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],139
	jne	short @2@6218
	push	ds
	mov	ax,offset s@+291
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6218:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],140
	jne	short @2@6266
	push	ds
	mov	ax,offset s@+293
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6266:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],141
	jne	short @2@6314
	push	ds
	mov	ax,offset s@+295
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6314:
   ;	
   ;		if(symb[iLauf]==142)cprintf("$");   if(symb[iLauf]==143)cprintf("\%");  if(symb[iLauf]==144)cprintf("&");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],142
	jne	short @2@6362
	push	ds
	mov	ax,offset s@+297
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6362:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],143
	jne	short @2@6410
	push	ds
	mov	ax,offset s@+299
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6410:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],144
	jne	short @2@6458
	push	ds
	mov	ax,offset s@+301
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6458:
   ;	
   ;		if(symb[iLauf]==145)cprintf("(");   if(symb[iLauf]==146)cprintf(")");   if(symb[iLauf]==147)cprintf("{");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],145
	jne	short @2@6506
	push	ds
	mov	ax,offset s@+303
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6506:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],146
	jne	short @2@6554
	push	ds
	mov	ax,offset s@+305
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6554:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],147
	jne	short @2@6602
	push	ds
	mov	ax,offset s@+307
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6602:
   ;	
   ;		if(symb[iLauf]==148)cprintf("}");   if(symb[iLauf]==149)cprintf("[");   if(symb[iLauf]==150)cprintf("]");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],148
	jne	short @2@6650
	push	ds
	mov	ax,offset s@+309
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6650:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],149
	jne	short @2@6698
	push	ds
	mov	ax,offset s@+311
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6698:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],150
	jne	short @2@6746
	push	ds
	mov	ax,offset s@+313
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6746:
   ;	
   ;		if(symb[iLauf]==151)cprintf("?");   if(symb[iLauf]==152)cprintf("�");   if(symb[iLauf]==153)cprintf("~");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],151
	jne	short @2@6794
	push	ds
	mov	ax,offset s@+315
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6794:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],152
	jne	short @2@6842
	push	ds
	mov	ax,offset s@+317
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6842:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],153
	jne	short @2@6890
	push	ds
	mov	ax,offset s@+319
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6890:
   ;	
   ;		if(symb[iLauf]==154)cprintf("#");   if(symb[iLauf]==155)cprintf("'");   if(symb[iLauf]==156)cprintf("�");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],154
	jne	short @2@6938
	push	ds
	mov	ax,offset s@+321
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6938:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],155
	jne	short @2@6986
	push	ds
	mov	ax,offset s@+323
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@6986:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],156
	jne	short @2@7034
	push	ds
	mov	ax,offset s@+325
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@7034:
   ;	
   ;		if(symb[iLauf]==157)cprintf("�");   if(symb[iLauf]==158)cprintf(",");   if(symb[iLauf]==159)cprintf(":");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],157
	jne	short @2@7082
	push	ds
	mov	ax,offset s@+327
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@7082:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],158
	jne	short @2@7130
	push	ds
	mov	ax,offset s@+329
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@7130:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],159
	jne	short @2@7178
	push	ds
	mov	ax,offset s@+331
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@7178:
   ;	
   ;		if(symb[iLauf]==160)cprintf(";");   if(symb[iLauf]==161)cprintf("�");   if(symb[iLauf]==162)cprintf("�");
   ;	
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],160
	jne	short @2@7226
	push	ds
	mov	ax,offset s@+333
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@7226:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],161
	jne	short @2@7274
	push	ds
	mov	ax,offset s@+335
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@7274:
	mov	bx,word ptr _iLauf
	shl	bx,1
	cmp	word ptr _symb[bx],162
	jne	short @2@7322
	push	ds
	mov	ax,offset s@+337
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@7322:
   ;	
   ;		
   ;		//
   ;		//.. symbole
   ;	
   ;	};
   ;	
	pop	ds
	pop	bp
	ret	
_symbole	endp
   ;	
   ;	void cursor_symbole()
   ;	
	assume	cs:CAD_TEXT
_cursor_symbole	proc	far
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,CAD_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		gotoxy(x_cpos, y_cpos-1);
   ;	
	mov	ax,word ptr _y_cpos
	dec	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;		
   ;		if(symb_==1)cprintf("\xDB");	if(symb_==2)cprintf("\x9E");    if(symb_==3)cprintf("o");
   ;	
	cmp	word ptr _symb_,1
	jne	short @3@74
	push	ds
	mov	ax,offset s@+339
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@74:
	cmp	word ptr _symb_,2
	jne	short @3@122
	push	ds
	mov	ax,offset s@+341
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@122:
	cmp	word ptr _symb_,3
	jne	short @3@170
	push	ds
	mov	ax,offset s@+343
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@170:
   ;	
   ;		if(symb_==4)cprintf(".");		if(symb_==5)cprintf(" ");		if(symb_==6)cprintf("+");
   ;	
	cmp	word ptr _symb_,4
	jne	short @3@218
	push	ds
	mov	ax,offset s@+345
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@218:
	cmp	word ptr _symb_,5
	jne	short @3@266
	push	ds
	mov	ax,offset s@+347
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@266:
	cmp	word ptr _symb_,6
	jne	short @3@314
	push	ds
	mov	ax,offset s@+349
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@314:
   ;	
   ;		if(symb_==7)cprintf("\xDA");	if(symb_==8)cprintf("\xC4");	if(symb_==9)cprintf("\xBF");
   ;	
	cmp	word ptr _symb_,7
	jne	short @3@362
	push	ds
	mov	ax,offset s@+351
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@362:
	cmp	word ptr _symb_,8
	jne	short @3@410
	push	ds
	mov	ax,offset s@+353
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@410:
	cmp	word ptr _symb_,9
	jne	short @3@458
	push	ds
	mov	ax,offset s@+355
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@458:
   ;	
   ;		if(symb_==10)cprintf("\xB3");	if(symb_==11)cprintf("\xD9");	if(symb_==12)cprintf("\xC0");
   ;	
	cmp	word ptr _symb_,10
	jne	short @3@506
	push	ds
	mov	ax,offset s@+357
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@506:
	cmp	word ptr _symb_,11
	jne	short @3@554
	push	ds
	mov	ax,offset s@+359
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@554:
	cmp	word ptr _symb_,12
	jne	short @3@602
	push	ds
	mov	ax,offset s@+361
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@602:
   ;	
   ;		if(symb_==13)cprintf("/");		if(symb_==14)cprintf("\\");		if(symb_==15)cprintf("\xB0");
   ;	
	cmp	word ptr _symb_,13
	jne	short @3@650
	push	ds
	mov	ax,offset s@+363
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@650:
	cmp	word ptr _symb_,14
	jne	short @3@698
	push	ds
	mov	ax,offset s@+365
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@698:
	cmp	word ptr _symb_,15
	jne	short @3@746
	push	ds
	mov	ax,offset s@+367
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@746:
   ;	
   ;		if(symb_==16)cprintf("\xB1");	if(symb_==17)cprintf("\xB2");	
   ;	
	cmp	word ptr _symb_,16
	jne	short @3@794
	push	ds
	mov	ax,offset s@+369
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@794:
	cmp	word ptr _symb_,17
	jne	short @3@842
	push	ds
	mov	ax,offset s@+371
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@842:
   ;	
   ;		if(symb_==19)cprintf("\xDC");	if(symb_==20)cprintf("\xFE");	if(symb_==21)cprintf("\xDF");
   ;	
	cmp	word ptr _symb_,19
	jne	short @3@890
	push	ds
	mov	ax,offset s@+373
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@890:
	cmp	word ptr _symb_,20
	jne	short @3@938
	push	ds
	mov	ax,offset s@+375
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@938:
	cmp	word ptr _symb_,21
	jne	short @3@986
	push	ds
	mov	ax,offset s@+377
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@986:
   ;	
   ;		if(symb_==22)cprintf("\xB4");	if(symb_==23)cprintf("\xC1");	if(symb_==24)cprintf(">");
   ;	
	cmp	word ptr _symb_,22
	jne	short @3@1034
	push	ds
	mov	ax,offset s@+379
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1034:
	cmp	word ptr _symb_,23
	jne	short @3@1082
	push	ds
	mov	ax,offset s@+381
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1082:
	cmp	word ptr _symb_,24
	jne	short @3@1130
	push	ds
	mov	ax,offset s@+383
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1130:
   ;	
   ;		if(symb_==25)cprintf("<");		if(symb_==26)cprintf("\xC2");	if(symb_==27)cprintf("^");
   ;	
	cmp	word ptr _symb_,25
	jne	short @3@1178
	push	ds
	mov	ax,offset s@+385
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1178:
	cmp	word ptr _symb_,26
	jne	short @3@1226
	push	ds
	mov	ax,offset s@+387
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1226:
	cmp	word ptr _symb_,27
	jne	short @3@1274
	push	ds
	mov	ax,offset s@+389
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1274:
   ;	
   ;		if(symb_==28)cprintf("\xC3");	if(symb_==29)cprintf("\x16");
   ;	
	cmp	word ptr _symb_,28
	jne	short @3@1322
	push	ds
	mov	ax,offset s@+391
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1322:
	cmp	word ptr _symb_,29
	jne	short @3@1370
	push	ds
	mov	ax,offset s@+393
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1370:
   ;	
   ;		if(symb_==34)cprintf("\xC5");	
   ;	
	cmp	word ptr _symb_,34
	jne	short @3@1418
	push	ds
	mov	ax,offset s@+395
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1418:
   ;	
   ;		if(symb_==37)cprintf("_");		if(symb_==39)cprintf("\xEE");
   ;	
	cmp	word ptr _symb_,37
	jne	short @3@1466
	push	ds
	mov	ax,offset s@+397
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1466:
	cmp	word ptr _symb_,39
	jne	short @3@1514
	push	ds
	mov	ax,offset s@+399
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1514:
   ;	
   ;		if(symb_==40)cprintf("-");		
   ;	
	cmp	word ptr _symb_,40
	jne	short @3@1562
	push	ds
	mov	ax,offset s@+401
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1562:
   ;	
   ;		if(symb_==43)cprintf("\xB9");	if(symb_==44)cprintf("\xBB");	if(symb_==45)cprintf("\xBC");
   ;	
	cmp	word ptr _symb_,43
	jne	short @3@1610
	push	ds
	mov	ax,offset s@+403
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1610:
	cmp	word ptr _symb_,44
	jne	short @3@1658
	push	ds
	mov	ax,offset s@+405
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1658:
	cmp	word ptr _symb_,45
	jne	short @3@1706
	push	ds
	mov	ax,offset s@+407
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1706:
   ;	
   ;		if(symb_==46)cprintf("\xC8");	if(symb_==47)cprintf("\xC9");	if(symb_==48)cprintf("\xBA");
   ;	
	cmp	word ptr _symb_,46
	jne	short @3@1754
	push	ds
	mov	ax,offset s@+409
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1754:
	cmp	word ptr _symb_,47
	jne	short @3@1802
	push	ds
	mov	ax,offset s@+411
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1802:
	cmp	word ptr _symb_,48
	jne	short @3@1850
	push	ds
	mov	ax,offset s@+413
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1850:
   ;	
   ;		if(symb_==49)cprintf("\xCD");	if(symb_==50)cprintf("=");		if(symb_==51)cprintf("\xCB");
   ;	
	cmp	word ptr _symb_,49
	jne	short @3@1898
	push	ds
	mov	ax,offset s@+415
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1898:
	cmp	word ptr _symb_,50
	jne	short @3@1946
	push	ds
	mov	ax,offset s@+417
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1946:
	cmp	word ptr _symb_,51
	jne	short @3@1994
	push	ds
	mov	ax,offset s@+419
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@1994:
   ;	
   ;		if(symb_==52)cprintf("\xCC");	if(symb_==53)cprintf("\xCE");	if(symb_==54)cprintf("\xCF");
   ;	
	cmp	word ptr _symb_,52
	jne	short @3@2042
	push	ds
	mov	ax,offset s@+421
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2042:
	cmp	word ptr _symb_,53
	jne	short @3@2090
	push	ds
	mov	ax,offset s@+423
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2090:
	cmp	word ptr _symb_,54
	jne	short @3@2138
	push	ds
	mov	ax,offset s@+425
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2138:
   ;	
   ;		if(symb_==55)cprintf("\xDD");	if(symb_==56)cprintf("\xCA");	if(symb_==57)cprintf("\x10");
   ;	
	cmp	word ptr _symb_,55
	jne	short @3@2186
	push	ds
	mov	ax,offset s@+427
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2186:
	cmp	word ptr _symb_,56
	jne	short @3@2234
	push	ds
	mov	ax,offset s@+429
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2234:
	cmp	word ptr _symb_,57
	jne	short @3@2282
	push	ds
	mov	ax,offset s@+431
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2282:
   ;	
   ;		if(symb_==58)cprintf("\x11");	if(symb_==59)cprintf("\x1E");	if(symb_==60)cprintf("\x1F");
   ;	
	cmp	word ptr _symb_,58
	jne	short @3@2330
	push	ds
	mov	ax,offset s@+433
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2330:
	cmp	word ptr _symb_,59
	jne	short @3@2378
	push	ds
	mov	ax,offset s@+435
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2378:
	cmp	word ptr _symb_,60
	jne	short @3@2426
	push	ds
	mov	ax,offset s@+437
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2426:
   ;	
   ;		if(symb_==61)cprintf("\x1A");	if(symb_==62)cprintf("\x1B");	if(symb_==63)cprintf("\x1C");
   ;	
	cmp	word ptr _symb_,61
	jne	short @3@2474
	push	ds
	mov	ax,offset s@+439
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2474:
	cmp	word ptr _symb_,62
	jne	short @3@2522
	push	ds
	mov	ax,offset s@+441
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2522:
	cmp	word ptr _symb_,63
	jne	short @3@2570
	push	ds
	mov	ax,offset s@+443
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2570:
   ;	
   ;		if(symb_==64)cprintf("\x18");	if(symb_==65)cprintf("\x19");	if(symb_==66)cprintf("\x17");
   ;	
	cmp	word ptr _symb_,64
	jne	short @3@2618
	push	ds
	mov	ax,offset s@+445
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2618:
	cmp	word ptr _symb_,65
	jne	short @3@2666
	push	ds
	mov	ax,offset s@+447
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2666:
	cmp	word ptr _symb_,66
	jne	short @3@2714
	push	ds
	mov	ax,offset s@+449
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2714:
   ;	
   ;		if(symb_==67)cprintf("\x1D");	if(symb_==68)cprintf("\xF9");	if(symb_==69)cprintf("\xF7");
   ;	
	cmp	word ptr _symb_,67
	jne	short @3@2762
	push	ds
	mov	ax,offset s@+451
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2762:
	cmp	word ptr _symb_,68
	jne	short @3@2810
	push	ds
	mov	ax,offset s@+453
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2810:
	cmp	word ptr _symb_,69
	jne	short @3@2858
	push	ds
	mov	ax,offset s@+455
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2858:
   ;	
   ;		if(symb_==70)cprintf("\xAA");	if(symb_==71)cprintf("\xA7");	if(symb_==72)cprintf("\xA9");
   ;	
	cmp	word ptr _symb_,70
	jne	short @3@2906
	push	ds
	mov	ax,offset s@+457
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2906:
	cmp	word ptr _symb_,71
	jne	short @3@2954
	push	ds
	mov	ax,offset s@+459
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@2954:
	cmp	word ptr _symb_,72
	jne	short @3@3002
	push	ds
	mov	ax,offset s@+461
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3002:
   ;	
   ;		if(symb_==73)cprintf("\xAE");	if(symb_==74)cprintf("\xAF");	if(symb_==75)cprintf("\x0F");
   ;	
	cmp	word ptr _symb_,73
	jne	short @3@3050
	push	ds
	mov	ax,offset s@+463
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3050:
	cmp	word ptr _symb_,74
	jne	short @3@3098
	push	ds
	mov	ax,offset s@+465
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3098:
	cmp	word ptr _symb_,75
	jne	short @3@3146
	push	ds
	mov	ax,offset s@+467
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3146:
   ;	
   ;		if(symb_==76)cprintf("\x0E");	if(symb_==77)cprintf("*");
   ;	
	cmp	word ptr _symb_,76
	jne	short @3@3194
	push	ds
	mov	ax,offset s@+469
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3194:
	cmp	word ptr _symb_,77
	jne	short @3@3242
	push	ds
	mov	ax,offset s@+471
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3242:
   ;	
   ;	
   ;		if(symb_==78)cprintf("1");    if(symb_==79)cprintf("2");    if(symb_==80)cprintf("3");
   ;	
	cmp	word ptr _symb_,78
	jne	short @3@3290
	push	ds
	mov	ax,offset s@+473
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3290:
	cmp	word ptr _symb_,79
	jne	short @3@3338
	push	ds
	mov	ax,offset s@+475
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3338:
	cmp	word ptr _symb_,80
	jne	short @3@3386
	push	ds
	mov	ax,offset s@+477
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3386:
   ;	
   ;		if(symb_==81)cprintf("4");	  if(symb_==82)cprintf("5");    if(symb_==83)cprintf("6");    
   ;	
	cmp	word ptr _symb_,81
	jne	short @3@3434
	push	ds
	mov	ax,offset s@+479
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3434:
	cmp	word ptr _symb_,82
	jne	short @3@3482
	push	ds
	mov	ax,offset s@+481
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3482:
	cmp	word ptr _symb_,83
	jne	short @3@3530
	push	ds
	mov	ax,offset s@+483
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3530:
   ;	
   ;		if(symb_==84)cprintf("7");    if(symb_==85)cprintf("8");	if(symb_==86)cprintf("9");
   ;	
	cmp	word ptr _symb_,84
	jne	short @3@3578
	push	ds
	mov	ax,offset s@+485
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3578:
	cmp	word ptr _symb_,85
	jne	short @3@3626
	push	ds
	mov	ax,offset s@+487
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3626:
	cmp	word ptr _symb_,86
	jne	short @3@3674
	push	ds
	mov	ax,offset s@+489
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3674:
   ;	
   ;		
   ;		if(symb_==87)cprintf("a");    if(symb_==88)cprintf("b");    if(symb_==89)cprintf("c");
   ;	
	cmp	word ptr _symb_,87
	jne	short @3@3722
	push	ds
	mov	ax,offset s@+491
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3722:
	cmp	word ptr _symb_,88
	jne	short @3@3770
	push	ds
	mov	ax,offset s@+493
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3770:
	cmp	word ptr _symb_,89
	jne	short @3@3818
	push	ds
	mov	ax,offset s@+495
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3818:
   ;	
   ;		if(symb_==90)cprintf("d");	  if(symb_==91)cprintf("e");    if(symb_==92)cprintf("f");    
   ;	
	cmp	word ptr _symb_,90
	jne	short @3@3866
	push	ds
	mov	ax,offset s@+497
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3866:
	cmp	word ptr _symb_,91
	jne	short @3@3914
	push	ds
	mov	ax,offset s@+499
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3914:
	cmp	word ptr _symb_,92
	jne	short @3@3962
	push	ds
	mov	ax,offset s@+501
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@3962:
   ;	
   ;		if(symb_==93)cprintf("g");    if(symb_==94)cprintf("h");	if(symb_==95)cprintf("i");
   ;	
	cmp	word ptr _symb_,93
	jne	short @3@4010
	push	ds
	mov	ax,offset s@+503
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4010:
	cmp	word ptr _symb_,94
	jne	short @3@4058
	push	ds
	mov	ax,offset s@+505
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4058:
	cmp	word ptr _symb_,95
	jne	short @3@4106
	push	ds
	mov	ax,offset s@+507
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4106:
   ;	
   ;		if(symb_==96)cprintf("j");    if(symb_==97)cprintf("k");    if(symb_==98)cprintf("l");
   ;	
	cmp	word ptr _symb_,96
	jne	short @3@4154
	push	ds
	mov	ax,offset s@+509
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4154:
	cmp	word ptr _symb_,97
	jne	short @3@4202
	push	ds
	mov	ax,offset s@+511
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4202:
	cmp	word ptr _symb_,98
	jne	short @3@4250
	push	ds
	mov	ax,offset s@+513
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4250:
   ;	
   ;		if(symb_==99)cprintf("m");	  if(symb_==100)cprintf("n");   if(symb_==101)cprintf("o");    
   ;	
	cmp	word ptr _symb_,99
	jne	short @3@4298
	push	ds
	mov	ax,offset s@+515
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4298:
	cmp	word ptr _symb_,100
	jne	short @3@4346
	push	ds
	mov	ax,offset s@+517
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4346:
	cmp	word ptr _symb_,101
	jne	short @3@4394
	push	ds
	mov	ax,offset s@+519
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4394:
   ;	
   ;		if(symb_==102)cprintf("p");   if(symb_==103)cprintf("q");	if(symb_==104)cprintf("r");
   ;	
	cmp	word ptr _symb_,102
	jne	short @3@4442
	push	ds
	mov	ax,offset s@+521
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4442:
	cmp	word ptr _symb_,103
	jne	short @3@4490
	push	ds
	mov	ax,offset s@+523
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4490:
	cmp	word ptr _symb_,104
	jne	short @3@4538
	push	ds
	mov	ax,offset s@+525
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4538:
   ;	
   ;		if(symb_==105)cprintf("s");   if(symb_==106)cprintf("t");   if(symb_==107)cprintf("u");
   ;	
	cmp	word ptr _symb_,105
	jne	short @3@4586
	push	ds
	mov	ax,offset s@+527
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4586:
	cmp	word ptr _symb_,106
	jne	short @3@4634
	push	ds
	mov	ax,offset s@+529
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4634:
	cmp	word ptr _symb_,107
	jne	short @3@4682
	push	ds
	mov	ax,offset s@+531
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4682:
   ;	
   ;		if(symb_==108)cprintf("v");	  if(symb_==109)cprintf("w");   if(symb_==110)cprintf("x");    
   ;	
	cmp	word ptr _symb_,108
	jne	short @3@4730
	push	ds
	mov	ax,offset s@+533
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4730:
	cmp	word ptr _symb_,109
	jne	short @3@4778
	push	ds
	mov	ax,offset s@+535
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4778:
	cmp	word ptr _symb_,110
	jne	short @3@4826
	push	ds
	mov	ax,offset s@+537
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4826:
   ;	
   ;		if(symb_==111)cprintf("y");   if(symb_==112)cprintf("z");
   ;	
	cmp	word ptr _symb_,111
	jne	short @3@4874
	push	ds
	mov	ax,offset s@+539
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4874:
	cmp	word ptr _symb_,112
	jne	short @3@4922
	push	ds
	mov	ax,offset s@+541
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4922:
   ;	
   ;	
   ;		if(symb_==113)cprintf("A");   if(symb_==114)cprintf("B");   if(symb_==115)cprintf("C");
   ;	
	cmp	word ptr _symb_,113
	jne	short @3@4970
	push	ds
	mov	ax,offset s@+543
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@4970:
	cmp	word ptr _symb_,114
	jne	short @3@5018
	push	ds
	mov	ax,offset s@+545
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5018:
	cmp	word ptr _symb_,115
	jne	short @3@5066
	push	ds
	mov	ax,offset s@+547
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5066:
   ;	
   ;		if(symb_==116)cprintf("D");	  if(symb_==117)cprintf("E");   if(symb_==118)cprintf("F");    
   ;	
	cmp	word ptr _symb_,116
	jne	short @3@5114
	push	ds
	mov	ax,offset s@+549
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5114:
	cmp	word ptr _symb_,117
	jne	short @3@5162
	push	ds
	mov	ax,offset s@+551
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5162:
	cmp	word ptr _symb_,118
	jne	short @3@5210
	push	ds
	mov	ax,offset s@+553
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5210:
   ;	
   ;		if(symb_==119)cprintf("G");   if(symb_==120)cprintf("H");	if(symb_==121)cprintf("I");
   ;	
	cmp	word ptr _symb_,119
	jne	short @3@5258
	push	ds
	mov	ax,offset s@+555
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5258:
	cmp	word ptr _symb_,120
	jne	short @3@5306
	push	ds
	mov	ax,offset s@+557
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5306:
	cmp	word ptr _symb_,121
	jne	short @3@5354
	push	ds
	mov	ax,offset s@+559
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5354:
   ;	
   ;		if(symb_==122)cprintf("J");   if(symb_==123)cprintf("K");   if(symb_==124)cprintf("L");
   ;	
	cmp	word ptr _symb_,122
	jne	short @3@5402
	push	ds
	mov	ax,offset s@+561
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5402:
	cmp	word ptr _symb_,123
	jne	short @3@5450
	push	ds
	mov	ax,offset s@+563
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5450:
	cmp	word ptr _symb_,124
	jne	short @3@5498
	push	ds
	mov	ax,offset s@+565
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5498:
   ;	
   ;		if(symb_==125)cprintf("M");	  if(symb_==126)cprintf("N");   if(symb_==127)cprintf("O");    
   ;	
	cmp	word ptr _symb_,125
	jne	short @3@5546
	push	ds
	mov	ax,offset s@+567
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5546:
	cmp	word ptr _symb_,126
	jne	short @3@5594
	push	ds
	mov	ax,offset s@+569
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5594:
	cmp	word ptr _symb_,127
	jne	short @3@5642
	push	ds
	mov	ax,offset s@+571
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5642:
   ;	
   ;		if(symb_==128)cprintf("P");   if(symb_==129)cprintf("Q");	if(symb_==130)cprintf("R");
   ;	
	cmp	word ptr _symb_,128
	jne	short @3@5690
	push	ds
	mov	ax,offset s@+573
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5690:
	cmp	word ptr _symb_,129
	jne	short @3@5738
	push	ds
	mov	ax,offset s@+575
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5738:
	cmp	word ptr _symb_,130
	jne	short @3@5786
	push	ds
	mov	ax,offset s@+577
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5786:
   ;	
   ;		if(symb_==131)cprintf("S");   if(symb_==132)cprintf("T");   if(symb_==133)cprintf("U");
   ;	
	cmp	word ptr _symb_,131
	jne	short @3@5834
	push	ds
	mov	ax,offset s@+579
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5834:
	cmp	word ptr _symb_,132
	jne	short @3@5882
	push	ds
	mov	ax,offset s@+581
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5882:
	cmp	word ptr _symb_,133
	jne	short @3@5930
	push	ds
	mov	ax,offset s@+583
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5930:
   ;	
   ;		if(symb_==134)cprintf("V");	  if(symb_==135)cprintf("W");   if(symb_==136)cprintf("X");    
   ;	
	cmp	word ptr _symb_,134
	jne	short @3@5978
	push	ds
	mov	ax,offset s@+585
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@5978:
	cmp	word ptr _symb_,135
	jne	short @3@6026
	push	ds
	mov	ax,offset s@+587
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6026:
	cmp	word ptr _symb_,136
	jne	short @3@6074
	push	ds
	mov	ax,offset s@+589
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6074:
   ;	
   ;		if(symb_==137)cprintf("Y");   if(symb_==138)cprintf("Z");
   ;	
	cmp	word ptr _symb_,137
	jne	short @3@6122
	push	ds
	mov	ax,offset s@+591
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6122:
	cmp	word ptr _symb_,138
	jne	short @3@6170
	push	ds
	mov	ax,offset s@+593
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6170:
   ;	
   ;	
   ;		if(symb_==139)cprintf("!");   if(symb_==140)cprintf("\"");  if(symb_==141)cprintf("�");
   ;	
	cmp	word ptr _symb_,139
	jne	short @3@6218
	push	ds
	mov	ax,offset s@+595
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6218:
	cmp	word ptr _symb_,140
	jne	short @3@6266
	push	ds
	mov	ax,offset s@+597
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6266:
	cmp	word ptr _symb_,141
	jne	short @3@6314
	push	ds
	mov	ax,offset s@+599
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6314:
   ;	
   ;		if(symb_==142)cprintf("$");   if(symb_==143)cprintf("\%");  if(symb_==144)cprintf("&");
   ;	
	cmp	word ptr _symb_,142
	jne	short @3@6362
	push	ds
	mov	ax,offset s@+601
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6362:
	cmp	word ptr _symb_,143
	jne	short @3@6410
	push	ds
	mov	ax,offset s@+603
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6410:
	cmp	word ptr _symb_,144
	jne	short @3@6458
	push	ds
	mov	ax,offset s@+605
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6458:
   ;	
   ;		if(symb_==145)cprintf("(");   if(symb_==146)cprintf(")");   if(symb_==147)cprintf("{");
   ;	
	cmp	word ptr _symb_,145
	jne	short @3@6506
	push	ds
	mov	ax,offset s@+607
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6506:
	cmp	word ptr _symb_,146
	jne	short @3@6554
	push	ds
	mov	ax,offset s@+609
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6554:
	cmp	word ptr _symb_,147
	jne	short @3@6602
	push	ds
	mov	ax,offset s@+611
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6602:
   ;	
   ;		if(symb_==148)cprintf("}");   if(symb_==149)cprintf("[");   if(symb_==150)cprintf("]");
   ;	
	cmp	word ptr _symb_,148
	jne	short @3@6650
	push	ds
	mov	ax,offset s@+613
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6650:
	cmp	word ptr _symb_,149
	jne	short @3@6698
	push	ds
	mov	ax,offset s@+615
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6698:
	cmp	word ptr _symb_,150
	jne	short @3@6746
	push	ds
	mov	ax,offset s@+617
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6746:
   ;	
   ;		if(symb_==151)cprintf("?");   if(symb_==152)cprintf("�");   if(symb_==153)cprintf("~");
   ;	
	cmp	word ptr _symb_,151
	jne	short @3@6794
	push	ds
	mov	ax,offset s@+619
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6794:
	cmp	word ptr _symb_,152
	jne	short @3@6842
	push	ds
	mov	ax,offset s@+621
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6842:
	cmp	word ptr _symb_,153
	jne	short @3@6890
	push	ds
	mov	ax,offset s@+623
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6890:
   ;	
   ;		if(symb_==154)cprintf("#");   if(symb_==155)cprintf("'");   if(symb_==156)cprintf("�");
   ;	
	cmp	word ptr _symb_,154
	jne	short @3@6938
	push	ds
	mov	ax,offset s@+625
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6938:
	cmp	word ptr _symb_,155
	jne	short @3@6986
	push	ds
	mov	ax,offset s@+627
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@6986:
	cmp	word ptr _symb_,156
	jne	short @3@7034
	push	ds
	mov	ax,offset s@+629
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@7034:
   ;	
   ;		if(symb_==157)cprintf("�");   if(symb_==158)cprintf(",");   if(symb_==159)cprintf(":");
   ;	
	cmp	word ptr _symb_,157
	jne	short @3@7082
	push	ds
	mov	ax,offset s@+631
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@7082:
	cmp	word ptr _symb_,158
	jne	short @3@7130
	push	ds
	mov	ax,offset s@+633
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@7130:
	cmp	word ptr _symb_,159
	jne	short @3@7178
	push	ds
	mov	ax,offset s@+635
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@7178:
   ;	
   ;		if(symb_==160)cprintf(";");   if(symb_==161)cprintf("�");   if(symb_==162)cprintf("�");
   ;	
	cmp	word ptr _symb_,160
	jne	short @3@7226
	push	ds
	mov	ax,offset s@+637
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@7226:
	cmp	word ptr _symb_,161
	jne	short @3@7274
	push	ds
	mov	ax,offset s@+639
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@7274:
	cmp	word ptr _symb_,162
	jne	short @3@7322
	push	ds
	mov	ax,offset s@+641
	push	ax
	call	far ptr _cprintf
	add	sp,4
@3@7322:
   ;	
   ;		
   ;		//
   ;		//.. symbole
   ;	};
   ;	
	pop	ds
	pop	bp
	ret	
_cursor_symbole	endp
   ;	
   ;	void symbol_taste()
   ;	
	assume	cs:CAD_TEXT
_symbol_taste	proc	far
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,CAD_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+6))) {symb_=15; set=0;}//h_cursor+fenster > symbol 15
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@122
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@122
	mov	ax,word ptr _y_2pos
	add	ax,6
	cmp	ax,word ptr _y_cpos
	jne	short @4@122
	mov	word ptr _symb_,15
	mov	word ptr _set,0
@4@122:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+6))) {symb_=16; set=0;}//h_cursor+fenster > symbol 16
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@218
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@218
	mov	ax,word ptr _y_2pos
	add	ax,6
	cmp	ax,word ptr _y_cpos
	jne	short @4@218
	mov	word ptr _symb_,16
	mov	word ptr _set,0
@4@218:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+6))) {symb_=17; set=0;}//h_cursor+fenster > symbol 17
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@314
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@314
	mov	ax,word ptr _y_2pos
	add	ax,6
	cmp	ax,word ptr _y_cpos
	jne	short @4@314
	mov	word ptr _symb_,17
	mov	word ptr _set,0
@4@314:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+6))) {symb_=1; set=0; }//h_cursor+fenster > symbol 1
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@410
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@410
	mov	ax,word ptr _y_2pos
	add	ax,6
	cmp	ax,word ptr _y_cpos
	jne	short @4@410
	mov	word ptr _symb_,1
	mov	word ptr _set,0
@4@410:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+6))) {symb_=19; set=0;}//h_cursor+fenster > symbol 19
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@506
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@506
	mov	ax,word ptr _y_2pos
	add	ax,6
	cmp	ax,word ptr _y_cpos
	jne	short @4@506
	mov	word ptr _symb_,19
	mov	word ptr _set,0
@4@506:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+6))) {symb_=20; set=0;}//h_cursor+fenster > symbol 20
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@602
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@602
	mov	ax,word ptr _y_2pos
	add	ax,6
	cmp	ax,word ptr _y_cpos
	jne	short @4@602
	mov	word ptr _symb_,20
	mov	word ptr _set,0
@4@602:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+6))) {symb_=21; set=0;}//h_cursor+fenster > symbol 21
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@698
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@698
	mov	ax,word ptr _y_2pos
	add	ax,6
	cmp	ax,word ptr _y_cpos
	jne	short @4@698
	mov	word ptr _symb_,21
	mov	word ptr _set,0
@4@698:
   ;	
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+7))) {symb_=22; set=0;}//h_cursor+fenster > symbol 22
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@794
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@794
	mov	ax,word ptr _y_2pos
	add	ax,7
	cmp	ax,word ptr _y_cpos
	jne	short @4@794
	mov	word ptr _symb_,22
	mov	word ptr _set,0
@4@794:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+7))) {symb_=23; set=0;}//h_cursor+fenster > symbol 23
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@890
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@890
	mov	ax,word ptr _y_2pos
	add	ax,7
	cmp	ax,word ptr _y_cpos
	jne	short @4@890
	mov	word ptr _symb_,23
	mov	word ptr _set,0
@4@890:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+7))) {symb_=24; set=0;}//h_cursor+fenster > symbol 24
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@986
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@986
	mov	ax,word ptr _y_2pos
	add	ax,7
	cmp	ax,word ptr _y_cpos
	jne	short @4@986
	mov	word ptr _symb_,24
	mov	word ptr _set,0
@4@986:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+7))) {symb_=25; set=0;}//h_cursor+fenster > symbol 25
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1082
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@1082
	mov	ax,word ptr _y_2pos
	add	ax,7
	cmp	ax,word ptr _y_cpos
	jne	short @4@1082
	mov	word ptr _symb_,25
	mov	word ptr _set,0
@4@1082:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+7))) {symb_=26; set=0;}//h_cursor+fenster > symbol 26
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1178
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@1178
	mov	ax,word ptr _y_2pos
	add	ax,7
	cmp	ax,word ptr _y_cpos
	jne	short @4@1178
	mov	word ptr _symb_,26
	mov	word ptr _set,0
@4@1178:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+7))) {symb_=27; set=0;}//h_cursor+fenster > symbol 27
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1274
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@1274
	mov	ax,word ptr _y_2pos
	add	ax,7
	cmp	ax,word ptr _y_cpos
	jne	short @4@1274
	mov	word ptr _symb_,27
	mov	word ptr _set,0
@4@1274:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+7))) {symb_=28; set=0;}//h_cursor+fenster > symbol 28
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1370
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@1370
	mov	ax,word ptr _y_2pos
	add	ax,7
	cmp	ax,word ptr _y_cpos
	jne	short @4@1370
	mov	word ptr _symb_,28
	mov	word ptr _set,0
@4@1370:
   ;	
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+8))) {symb_=29; set=0;}//h_cursor+fenster > symbol 29
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1466
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@1466
	mov	ax,word ptr _y_2pos
	add	ax,8
	cmp	ax,word ptr _y_cpos
	jne	short @4@1466
	mov	word ptr _symb_,29
	mov	word ptr _set,0
@4@1466:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+8))) {symb_=7; set=0; }//h_cursor+fenster > symbol 7
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1562
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@1562
	mov	ax,word ptr _y_2pos
	add	ax,8
	cmp	ax,word ptr _y_cpos
	jne	short @4@1562
	mov	word ptr _symb_,7
	mov	word ptr _set,0
@4@1562:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+8))) {symb_=12; set=0;}//h_cursor+fenster > symbol 12
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1658
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@1658
	mov	ax,word ptr _y_2pos
	add	ax,8
	cmp	ax,word ptr _y_cpos
	jne	short @4@1658
	mov	word ptr _symb_,12
	mov	word ptr _set,0
@4@1658:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+8))) {symb_=11; set=0;}//h_cursor+fenster > symbol 11
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1754
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@1754
	mov	ax,word ptr _y_2pos
	add	ax,8
	cmp	ax,word ptr _y_cpos
	jne	short @4@1754
	mov	word ptr _symb_,11
	mov	word ptr _set,0
@4@1754:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+8))) {symb_=9; set=0; }//h_cursor+fenster > symbol 9
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1850
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@1850
	mov	ax,word ptr _y_2pos
	add	ax,8
	cmp	ax,word ptr _y_cpos
	jne	short @4@1850
	mov	word ptr _symb_,9
	mov	word ptr _set,0
@4@1850:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+8))) {symb_=34; set=0;}//h_cursor+fenster > symbol 34
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@1946
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@1946
	mov	ax,word ptr _y_2pos
	add	ax,8
	cmp	ax,word ptr _y_cpos
	jne	short @4@1946
	mov	word ptr _symb_,34
	mov	word ptr _set,0
@4@1946:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+8))) {symb_=2; set=0; }//h_cursor+fenster > symbol 2
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2042
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@2042
	mov	ax,word ptr _y_2pos
	add	ax,8
	cmp	ax,word ptr _y_cpos
	jne	short @4@2042
	mov	word ptr _symb_,2
	mov	word ptr _set,0
@4@2042:
   ;	
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+9))) {symb_=13; set=0;}//h_cursor+fenster > symbol 13
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2138
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@2138
	mov	ax,word ptr _y_2pos
	add	ax,9
	cmp	ax,word ptr _y_cpos
	jne	short @4@2138
	mov	word ptr _symb_,13
	mov	word ptr _set,0
@4@2138:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+9))) {symb_=37; set=0;}//h_cursor+fenster > symbol 37
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2234
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@2234
	mov	ax,word ptr _y_2pos
	add	ax,9
	cmp	ax,word ptr _y_cpos
	jne	short @4@2234
	mov	word ptr _symb_,37
	mov	word ptr _set,0
@4@2234:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+9))) {symb_=8; set=0; }//h_cursor+fenster > symbol 8
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2330
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@2330
	mov	ax,word ptr _y_2pos
	add	ax,9
	cmp	ax,word ptr _y_cpos
	jne	short @4@2330
	mov	word ptr _symb_,8
	mov	word ptr _set,0
@4@2330:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+9))) {symb_=39; set=0;}//h_cursor+fenster > symbol 39
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2426
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@2426
	mov	ax,word ptr _y_2pos
	add	ax,9
	cmp	ax,word ptr _y_cpos
	jne	short @4@2426
	mov	word ptr _symb_,39
	mov	word ptr _set,0
@4@2426:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+9))) {symb_=40; set=0;}//h_cursor+fenster > symbol 40
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2522
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@2522
	mov	ax,word ptr _y_2pos
	add	ax,9
	cmp	ax,word ptr _y_cpos
	jne	short @4@2522
	mov	word ptr _symb_,40
	mov	word ptr _set,0
@4@2522:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+9))) {symb_=14; set=0;}//h_cursor+fenster > symbol 14
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2618
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@2618
	mov	ax,word ptr _y_2pos
	add	ax,9
	cmp	ax,word ptr _y_cpos
	jne	short @4@2618
	mov	word ptr _symb_,14
	mov	word ptr _set,0
@4@2618:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+9))) {symb_=10; set=0;}//h_cursor+fenster > symbol 10
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2714
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@2714
	mov	ax,word ptr _y_2pos
	add	ax,9
	cmp	ax,word ptr _y_cpos
	jne	short @4@2714
	mov	word ptr _symb_,10
	mov	word ptr _set,0
@4@2714:
   ;	
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+10))) {symb_=43; set=0;}//h_cursor+fenster > symbol 43
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2810
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@2810
	mov	ax,word ptr _y_2pos
	add	ax,10
	cmp	ax,word ptr _y_cpos
	jne	short @4@2810
	mov	word ptr _symb_,43
	mov	word ptr _set,0
@4@2810:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+10))) {symb_=44; set=0;}//h_cursor+fenster > symbol 44
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@2906
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@2906
	mov	ax,word ptr _y_2pos
	add	ax,10
	cmp	ax,word ptr _y_cpos
	jne	short @4@2906
	mov	word ptr _symb_,44
	mov	word ptr _set,0
@4@2906:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+10))) {symb_=45; set=0;}//h_cursor+fenster > symbol 45
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3002
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@3002
	mov	ax,word ptr _y_2pos
	add	ax,10
	cmp	ax,word ptr _y_cpos
	jne	short @4@3002
	mov	word ptr _symb_,45
	mov	word ptr _set,0
@4@3002:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+10))) {symb_=46; set=0;}//h_cursor+fenster > symbol 46
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3098
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@3098
	mov	ax,word ptr _y_2pos
	add	ax,10
	cmp	ax,word ptr _y_cpos
	jne	short @4@3098
	mov	word ptr _symb_,46
	mov	word ptr _set,0
@4@3098:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+10))) {symb_=47; set=0;}//h_cursor+fenster > symbol 47
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3194
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@3194
	mov	ax,word ptr _y_2pos
	add	ax,10
	cmp	ax,word ptr _y_cpos
	jne	short @4@3194
	mov	word ptr _symb_,47
	mov	word ptr _set,0
@4@3194:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+10))) {symb_=48; set=0;}//h_cursor+fenster > symbol 48
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3290
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@3290
	mov	ax,word ptr _y_2pos
	add	ax,10
	cmp	ax,word ptr _y_cpos
	jne	short @4@3290
	mov	word ptr _symb_,48
	mov	word ptr _set,0
@4@3290:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+10))) {symb_=49; set=0;}//h_cursor+fenster > symbol 49
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3386
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@3386
	mov	ax,word ptr _y_2pos
	add	ax,10
	cmp	ax,word ptr _y_cpos
	jne	short @4@3386
	mov	word ptr _symb_,49
	mov	word ptr _set,0
@4@3386:
   ;	
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+11))) {symb_=50; set=0;}//h_cursor+fenster > symbol 50
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3482
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@3482
	mov	ax,word ptr _y_2pos
	add	ax,11
	cmp	ax,word ptr _y_cpos
	jne	short @4@3482
	mov	word ptr _symb_,50
	mov	word ptr _set,0
@4@3482:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+11))) {symb_=51; set=0;}//h_cursor+fenster > symbol 51
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3578
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@3578
	mov	ax,word ptr _y_2pos
	add	ax,11
	cmp	ax,word ptr _y_cpos
	jne	short @4@3578
	mov	word ptr _symb_,51
	mov	word ptr _set,0
@4@3578:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+11))) {symb_=52; set=0;}//h_cursor+fenster > symbol 52
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3674
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@3674
	mov	ax,word ptr _y_2pos
	add	ax,11
	cmp	ax,word ptr _y_cpos
	jne	short @4@3674
	mov	word ptr _symb_,52
	mov	word ptr _set,0
@4@3674:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+11))) {symb_=53; set=0;}//h_cursor+fenster > symbol 53
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3770
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@3770
	mov	ax,word ptr _y_2pos
	add	ax,11
	cmp	ax,word ptr _y_cpos
	jne	short @4@3770
	mov	word ptr _symb_,53
	mov	word ptr _set,0
@4@3770:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+11))) {symb_=54; set=0;}//h_cursor+fenster > symbol 54
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3866
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@3866
	mov	ax,word ptr _y_2pos
	add	ax,11
	cmp	ax,word ptr _y_cpos
	jne	short @4@3866
	mov	word ptr _symb_,54
	mov	word ptr _set,0
@4@3866:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+11))) {symb_=55; set=0;}//h_cursor+fenster > symbol 55
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@3962
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@3962
	mov	ax,word ptr _y_2pos
	add	ax,11
	cmp	ax,word ptr _y_cpos
	jne	short @4@3962
	mov	word ptr _symb_,55
	mov	word ptr _set,0
@4@3962:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+11))) {symb_=56; set=0;}//h_cursor+fenster > symbol 56
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4058
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@4058
	mov	ax,word ptr _y_2pos
	add	ax,11
	cmp	ax,word ptr _y_cpos
	jne	short @4@4058
	mov	word ptr _symb_,56
	mov	word ptr _set,0
@4@4058:
   ;	
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+12))) {symb_=57; set=0;}//h_cursor+fenster > symbol 57
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4154
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@4154
	mov	ax,word ptr _y_2pos
	add	ax,12
	cmp	ax,word ptr _y_cpos
	jne	short @4@4154
	mov	word ptr _symb_,57
	mov	word ptr _set,0
@4@4154:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+12))) {symb_=58; set=0;}//h_cursor+fenster > symbol 58
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4250
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@4250
	mov	ax,word ptr _y_2pos
	add	ax,12
	cmp	ax,word ptr _y_cpos
	jne	short @4@4250
	mov	word ptr _symb_,58
	mov	word ptr _set,0
@4@4250:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+12))) {symb_=59; set=0;}//h_cursor+fenster > symbol 59
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4346
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@4346
	mov	ax,word ptr _y_2pos
	add	ax,12
	cmp	ax,word ptr _y_cpos
	jne	short @4@4346
	mov	word ptr _symb_,59
	mov	word ptr _set,0
@4@4346:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+12))) {symb_=60; set=0;}//h_cursor+fenster > symbol 60
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4442
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@4442
	mov	ax,word ptr _y_2pos
	add	ax,12
	cmp	ax,word ptr _y_cpos
	jne	short @4@4442
	mov	word ptr _symb_,60
	mov	word ptr _set,0
@4@4442:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+12))) {symb_=61; set=0;}//h_cursor+fenster > symbol 61
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4538
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@4538
	mov	ax,word ptr _y_2pos
	add	ax,12
	cmp	ax,word ptr _y_cpos
	jne	short @4@4538
	mov	word ptr _symb_,61
	mov	word ptr _set,0
@4@4538:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+12))) {symb_=62; set=0;}//h_cursor+fenster > symbol 62
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4634
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@4634
	mov	ax,word ptr _y_2pos
	add	ax,12
	cmp	ax,word ptr _y_cpos
	jne	short @4@4634
	mov	word ptr _symb_,62
	mov	word ptr _set,0
@4@4634:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+12))) {symb_=63; set=0;}//h_cursor+fenster > symbol 63
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4730
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@4730
	mov	ax,word ptr _y_2pos
	add	ax,12
	cmp	ax,word ptr _y_cpos
	jne	short @4@4730
	mov	word ptr _symb_,63
	mov	word ptr _set,0
@4@4730:
   ;	
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+13))) {symb_=64; set=0;}//h_cursor+fenster > symbol 64
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4826
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@4826
	mov	ax,word ptr _y_2pos
	add	ax,13
	cmp	ax,word ptr _y_cpos
	jne	short @4@4826
	mov	word ptr _symb_,64
	mov	word ptr _set,0
@4@4826:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+13))) {symb_=65; set=0;}//h_cursor+fenster > symbol 65
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@4922
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@4922
	mov	ax,word ptr _y_2pos
	add	ax,13
	cmp	ax,word ptr _y_cpos
	jne	short @4@4922
	mov	word ptr _symb_,65
	mov	word ptr _set,0
@4@4922:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+13))) {symb_=66; set=0;}//h_cursor+fenster > symbol 66
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5018
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@5018
	mov	ax,word ptr _y_2pos
	add	ax,13
	cmp	ax,word ptr _y_cpos
	jne	short @4@5018
	mov	word ptr _symb_,66
	mov	word ptr _set,0
@4@5018:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+13))) {symb_=67; set=0;}//h_cursor+fenster > symbol 67
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5114
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@5114
	mov	ax,word ptr _y_2pos
	add	ax,13
	cmp	ax,word ptr _y_cpos
	jne	short @4@5114
	mov	word ptr _symb_,67
	mov	word ptr _set,0
@4@5114:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+13))) {symb_=68; set=0;}//h_cursor+fenster > symbol 68
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5210
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@5210
	mov	ax,word ptr _y_2pos
	add	ax,13
	cmp	ax,word ptr _y_cpos
	jne	short @4@5210
	mov	word ptr _symb_,68
	mov	word ptr _set,0
@4@5210:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+13))) {symb_=69; set=0;}//h_cursor+fenster > symbol 69
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5306
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@5306
	mov	ax,word ptr _y_2pos
	add	ax,13
	cmp	ax,word ptr _y_cpos
	jne	short @4@5306
	mov	word ptr _symb_,69
	mov	word ptr _set,0
@4@5306:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+13))) {symb_=70; set=0;}//h_cursor+fenster > symbol 70
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5402
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@5402
	mov	ax,word ptr _y_2pos
	add	ax,13
	cmp	ax,word ptr _y_cpos
	jne	short @4@5402
	mov	word ptr _symb_,70
	mov	word ptr _set,0
@4@5402:
   ;	
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+14))) {symb_=71; set=0;}//h_cursor+fenster > symbol 71
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5498
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@5498
	mov	ax,word ptr _y_2pos
	add	ax,14
	cmp	ax,word ptr _y_cpos
	jne	short @4@5498
	mov	word ptr _symb_,71
	mov	word ptr _set,0
@4@5498:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+2) && (y_cpos == y_2pos+14))) {symb_=72; set=0;}//h_cursor+fenster > symbol 72
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5594
	mov	ax,word ptr _x_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @4@5594
	mov	ax,word ptr _y_2pos
	add	ax,14
	cmp	ax,word ptr _y_cpos
	jne	short @4@5594
	mov	word ptr _symb_,72
	mov	word ptr _set,0
@4@5594:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+3) && (y_cpos == y_2pos+14))) {symb_=73; set=0;}//h_cursor+fenster > symbol 73
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5690
	mov	ax,word ptr _x_2pos
	add	ax,3
	cmp	ax,word ptr _x_cpos
	jne	short @4@5690
	mov	ax,word ptr _y_2pos
	add	ax,14
	cmp	ax,word ptr _y_cpos
	jne	short @4@5690
	mov	word ptr _symb_,73
	mov	word ptr _set,0
@4@5690:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+4) && (y_cpos == y_2pos+14))) {symb_=74; set=0;}//h_cursor+fenster > symbol 74
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5786
	mov	ax,word ptr _x_2pos
	add	ax,4
	cmp	ax,word ptr _x_cpos
	jne	short @4@5786
	mov	ax,word ptr _y_2pos
	add	ax,14
	cmp	ax,word ptr _y_cpos
	jne	short @4@5786
	mov	word ptr _symb_,74
	mov	word ptr _set,0
@4@5786:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+5) && (y_cpos == y_2pos+14))) {symb_=75; set=0;}//h_cursor+fenster > symbol 75
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5882
	mov	ax,word ptr _x_2pos
	add	ax,5
	cmp	ax,word ptr _x_cpos
	jne	short @4@5882
	mov	ax,word ptr _y_2pos
	add	ax,14
	cmp	ax,word ptr _y_cpos
	jne	short @4@5882
	mov	word ptr _symb_,75
	mov	word ptr _set,0
@4@5882:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+6) && (y_cpos == y_2pos+14))) {symb_=76; set=0;}//h_cursor+fenster > symbol 76
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@5978
	mov	ax,word ptr _x_2pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @4@5978
	mov	ax,word ptr _y_2pos
	add	ax,14
	cmp	ax,word ptr _y_cpos
	jne	short @4@5978
	mov	word ptr _symb_,76
	mov	word ptr _set,0
@4@5978:
   ;	
   ;		if(taste == 'h'&& ((x_cpos == x_2pos+7) && (y_cpos == y_2pos+14))) {symb_=77; set=0;}//h_cursor+fenster > symbol 77
   ;	
	cmp	byte ptr _taste,104
	jne	short @4@6074
	mov	ax,word ptr _x_2pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @4@6074
	mov	ax,word ptr _y_2pos
	add	ax,14
	cmp	ax,word ptr _y_cpos
	jne	short @4@6074
	mov	word ptr _symb_,77
	mov	word ptr _set,0
@4@6074:
   ;	
   ;	};
   ;	
	pop	ds
	pop	bp
	ret	
_symbol_taste	endp
   ;	
   ;	void symbol_inpt()
   ;	
	assume	cs:CAD_TEXT
_symbol_inpt	proc	far
	push	bp
	mov	bp,sp
	push	ds
	mov	ax,CAD_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		if(strcmp(string,"1") == 0) symb_= 78; if(strcmp(string,"2") == 0) symb_= 79; if(strcmp(string,"3") == 0) symb_= 80;
   ;	
	push	ds
	mov	ax,offset s@+643
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@74
	mov	word ptr _symb_,78
@5@74:
	push	ds
	mov	ax,offset s@+645
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@122
	mov	word ptr _symb_,79
@5@122:
	push	ds
	mov	ax,offset s@+647
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@170
	mov	word ptr _symb_,80
@5@170:
   ;	
   ;		if(strcmp(string,"4") == 0) symb_= 81; if(strcmp(string,"5") == 0) symb_= 82; if(strcmp(string,"6") == 0) symb_= 83;
   ;	
	push	ds
	mov	ax,offset s@+649
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@218
	mov	word ptr _symb_,81
@5@218:
	push	ds
	mov	ax,offset s@+651
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@266
	mov	word ptr _symb_,82
@5@266:
	push	ds
	mov	ax,offset s@+653
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@314
	mov	word ptr _symb_,83
@5@314:
   ;	
   ;		if(strcmp(string,"7") == 0) symb_= 84; if(strcmp(string,"8") == 0) symb_= 85; if(strcmp(string,"9") == 0) symb_= 86;
   ;	
	push	ds
	mov	ax,offset s@+655
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@362
	mov	word ptr _symb_,84
@5@362:
	push	ds
	mov	ax,offset s@+657
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@410
	mov	word ptr _symb_,85
@5@410:
	push	ds
	mov	ax,offset s@+659
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@458
	mov	word ptr _symb_,86
@5@458:
   ;	
   ;		if(strcmp(string,".") == 0) symb_= 4;
   ;	
	push	ds
	mov	ax,offset s@+661
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@506
	mov	word ptr _symb_,4
@5@506:
   ;	
   ;	
   ;		if(strcmp(string,"a") == 0) symb_= 87; if(strcmp(string,"b") == 0) symb_= 88; if(strcmp(string,"c") == 0) symb_= 89;
   ;	
	push	ds
	mov	ax,offset s@+663
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@554
	mov	word ptr _symb_,87
@5@554:
	push	ds
	mov	ax,offset s@+665
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@602
	mov	word ptr _symb_,88
@5@602:
	push	ds
	mov	ax,offset s@+667
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@650
	mov	word ptr _symb_,89
@5@650:
   ;	
   ;		if(strcmp(string,"d") == 0) symb_= 90; if(strcmp(string,"e") == 0) symb_= 91; if(strcmp(string,"f") == 0) symb_= 92;
   ;	
	push	ds
	mov	ax,offset s@+669
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@698
	mov	word ptr _symb_,90
@5@698:
	push	ds
	mov	ax,offset s@+671
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@746
	mov	word ptr _symb_,91
@5@746:
	push	ds
	mov	ax,offset s@+673
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@794
	mov	word ptr _symb_,92
@5@794:
   ;	
   ;		if(strcmp(string,"g") == 0) symb_= 93; if(strcmp(string,"h") == 0) symb_= 94; if(strcmp(string,"i") == 0) symb_= 95;
   ;	
	push	ds
	mov	ax,offset s@+675
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@842
	mov	word ptr _symb_,93
@5@842:
	push	ds
	mov	ax,offset s@+677
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@890
	mov	word ptr _symb_,94
@5@890:
	push	ds
	mov	ax,offset s@+679
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@938
	mov	word ptr _symb_,95
@5@938:
   ;	
   ;		if(strcmp(string,"j") == 0) symb_= 96; if(strcmp(string,"k") == 0) symb_= 97; if(strcmp(string,"l") == 0) symb_= 98;
   ;	
	push	ds
	mov	ax,offset s@+681
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@986
	mov	word ptr _symb_,96
@5@986:
	push	ds
	mov	ax,offset s@+683
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1034
	mov	word ptr _symb_,97
@5@1034:
	push	ds
	mov	ax,offset s@+685
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1082
	mov	word ptr _symb_,98
@5@1082:
   ;	
   ;		if(strcmp(string,"m") == 0) symb_= 99; if(strcmp(string,"n") == 0) symb_= 100; if(strcmp(string,"o") == 0) symb_= 101;
   ;	
	push	ds
	mov	ax,offset s@+687
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1130
	mov	word ptr _symb_,99
@5@1130:
	push	ds
	mov	ax,offset s@+689
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1178
	mov	word ptr _symb_,100
@5@1178:
	push	ds
	mov	ax,offset s@+691
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1226
	mov	word ptr _symb_,101
@5@1226:
   ;	
   ;		if(strcmp(string,"p") == 0) symb_= 102; if(strcmp(string,"q") == 0) symb_= 103; if(strcmp(string,"r") == 0) symb_= 104;
   ;	
	push	ds
	mov	ax,offset s@+693
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1274
	mov	word ptr _symb_,102
@5@1274:
	push	ds
	mov	ax,offset s@+695
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1322
	mov	word ptr _symb_,103
@5@1322:
	push	ds
	mov	ax,offset s@+697
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1370
	mov	word ptr _symb_,104
@5@1370:
   ;	
   ;		if(strcmp(string,"s") == 0) symb_= 105; if(strcmp(string,"t") == 0) symb_= 106; if(strcmp(string,"u") == 0) symb_= 107;
   ;	
	push	ds
	mov	ax,offset s@+699
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1418
	mov	word ptr _symb_,105
@5@1418:
	push	ds
	mov	ax,offset s@+701
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1466
	mov	word ptr _symb_,106
@5@1466:
	push	ds
	mov	ax,offset s@+703
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1514
	mov	word ptr _symb_,107
@5@1514:
   ;	
   ;		if(strcmp(string,"v") == 0) symb_= 108; if(strcmp(string,"w") == 0) symb_= 109; if(strcmp(string,"x") == 0) symb_= 110;
   ;	
	push	ds
	mov	ax,offset s@+705
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1562
	mov	word ptr _symb_,108
@5@1562:
	push	ds
	mov	ax,offset s@+707
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1610
	mov	word ptr _symb_,109
@5@1610:
	push	ds
	mov	ax,offset s@+709
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1658
	mov	word ptr _symb_,110
@5@1658:
   ;	
   ;		if(strcmp(string,"y") == 0) symb_= 111; if(strcmp(string,"z") == 0) symb_= 112;
   ;	
	push	ds
	mov	ax,offset s@+711
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1706
	mov	word ptr _symb_,111
@5@1706:
	push	ds
	mov	ax,offset s@+713
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1754
	mov	word ptr _symb_,112
@5@1754:
   ;	
   ;	
   ;		if(strcmp(string,"A") == 0) symb_= 113; if(strcmp(string,"B") == 0) symb_= 114; if(strcmp(string,"C") == 0) symb_= 115;
   ;	
	push	ds
	mov	ax,offset s@+715
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1802
	mov	word ptr _symb_,113
@5@1802:
	push	ds
	mov	ax,offset s@+717
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1850
	mov	word ptr _symb_,114
@5@1850:
	push	ds
	mov	ax,offset s@+719
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1898
	mov	word ptr _symb_,115
@5@1898:
   ;	
   ;		if(strcmp(string,"D") == 0) symb_= 116; if(strcmp(string,"E") == 0) symb_= 117; if(strcmp(string,"F") == 0) symb_= 118;
   ;	
	push	ds
	mov	ax,offset s@+721
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1946
	mov	word ptr _symb_,116
@5@1946:
	push	ds
	mov	ax,offset s@+723
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@1994
	mov	word ptr _symb_,117
@5@1994:
	push	ds
	mov	ax,offset s@+725
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2042
	mov	word ptr _symb_,118
@5@2042:
   ;	
   ;		if(strcmp(string,"G") == 0) symb_= 119; if(strcmp(string,"H") == 0) symb_= 120; if(strcmp(string,"I") == 0) symb_= 121;
   ;	
	push	ds
	mov	ax,offset s@+727
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2090
	mov	word ptr _symb_,119
@5@2090:
	push	ds
	mov	ax,offset s@+729
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2138
	mov	word ptr _symb_,120
@5@2138:
	push	ds
	mov	ax,offset s@+731
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2186
	mov	word ptr _symb_,121
@5@2186:
   ;	
   ;		if(strcmp(string,"J") == 0) symb_= 122; if(strcmp(string,"K") == 0) symb_= 123; if(strcmp(string,"L") == 0) symb_= 124;
   ;	
	push	ds
	mov	ax,offset s@+733
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2234
	mov	word ptr _symb_,122
@5@2234:
	push	ds
	mov	ax,offset s@+735
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2282
	mov	word ptr _symb_,123
@5@2282:
	push	ds
	mov	ax,offset s@+737
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2330
	mov	word ptr _symb_,124
@5@2330:
   ;	
   ;		if(strcmp(string,"M") == 0) symb_= 125; if(strcmp(string,"N") == 0) symb_= 126; if(strcmp(string,"O") == 0) symb_= 127;
   ;	
	push	ds
	mov	ax,offset s@+739
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2378
	mov	word ptr _symb_,125
@5@2378:
	push	ds
	mov	ax,offset s@+741
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2426
	mov	word ptr _symb_,126
@5@2426:
	push	ds
	mov	ax,offset s@+743
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2474
	mov	word ptr _symb_,127
@5@2474:
   ;	
   ;		if(strcmp(string,"P") == 0) symb_= 128; if(strcmp(string,"Q") == 0) symb_= 129; if(strcmp(string,"R") == 0) symb_= 130;
   ;	
	push	ds
	mov	ax,offset s@+745
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2522
	mov	word ptr _symb_,128
@5@2522:
	push	ds
	mov	ax,offset s@+747
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2570
	mov	word ptr _symb_,129
@5@2570:
	push	ds
	mov	ax,offset s@+749
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2618
	mov	word ptr _symb_,130
@5@2618:
   ;	
   ;		if(strcmp(string,"S") == 0) symb_= 131; if(strcmp(string,"T") == 0) symb_= 132; if(strcmp(string,"U") == 0) symb_= 133;
   ;	
	push	ds
	mov	ax,offset s@+751
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2666
	mov	word ptr _symb_,131
@5@2666:
	push	ds
	mov	ax,offset s@+753
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2714
	mov	word ptr _symb_,132
@5@2714:
	push	ds
	mov	ax,offset s@+755
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2762
	mov	word ptr _symb_,133
@5@2762:
   ;	
   ;		if(strcmp(string,"V") == 0) symb_= 134; if(strcmp(string,"W") == 0) symb_= 135; if(strcmp(string,"X") == 0) symb_= 136;
   ;	
	push	ds
	mov	ax,offset s@+757
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2810
	mov	word ptr _symb_,134
@5@2810:
	push	ds
	mov	ax,offset s@+759
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2858
	mov	word ptr _symb_,135
@5@2858:
	push	ds
	mov	ax,offset s@+761
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2906
	mov	word ptr _symb_,136
@5@2906:
   ;	
   ;		if(strcmp(string,"Y") == 0) symb_= 137; if(strcmp(string,"Z") == 0) symb_= 138;
   ;	
	push	ds
	mov	ax,offset s@+763
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@2954
	mov	word ptr _symb_,137
@5@2954:
	push	ds
	mov	ax,offset s@+765
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3002
	mov	word ptr _symb_,138
@5@3002:
   ;	
   ;	
   ;		if(strcmp(string,"!") == 0) symb_= 139; if(strcmp(string,"\"") == 0) symb_= 140; if(strcmp(string,"�") == 0) symb_= 141;
   ;	
	push	ds
	mov	ax,offset s@+767
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3050
	mov	word ptr _symb_,139
@5@3050:
	push	ds
	mov	ax,offset s@+769
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3098
	mov	word ptr _symb_,140
@5@3098:
	push	ds
	mov	ax,offset s@+771
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3146
	mov	word ptr _symb_,141
@5@3146:
   ;	
   ;		if(strcmp(string,"$") == 0) symb_= 142; if(strcmp(string,"\%") == 0) symb_= 143; if(strcmp(string,"&") == 0) symb_= 144;
   ;	
	push	ds
	mov	ax,offset s@+773
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3194
	mov	word ptr _symb_,142
@5@3194:
	push	ds
	mov	ax,offset s@+775
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3242
	mov	word ptr _symb_,143
@5@3242:
	push	ds
	mov	ax,offset s@+777
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3290
	mov	word ptr _symb_,144
@5@3290:
   ;	
   ;		if(strcmp(string,"(") == 0) symb_= 145; if(strcmp(string,")") == 0) symb_= 146;  if(strcmp(string,"{") == 0) symb_= 147;
   ;	
	push	ds
	mov	ax,offset s@+779
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3338
	mov	word ptr _symb_,145
@5@3338:
	push	ds
	mov	ax,offset s@+781
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3386
	mov	word ptr _symb_,146
@5@3386:
	push	ds
	mov	ax,offset s@+783
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3434
	mov	word ptr _symb_,147
@5@3434:
   ;	
   ;		if(strcmp(string,"}") == 0) symb_= 148; if(strcmp(string,"[") == 0) symb_= 149;  if(strcmp(string,"]") == 0) symb_= 150;
   ;	
	push	ds
	mov	ax,offset s@+785
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3482
	mov	word ptr _symb_,148
@5@3482:
	push	ds
	mov	ax,offset s@+787
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3530
	mov	word ptr _symb_,149
@5@3530:
	push	ds
	mov	ax,offset s@+789
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3578
	mov	word ptr _symb_,150
@5@3578:
   ;	
   ;		if(strcmp(string,"?") == 0) symb_= 151; if(strcmp(string,"�") == 0) symb_= 152;  if(strcmp(string,"~") == 0) symb_= 153;
   ;	
	push	ds
	mov	ax,offset s@+791
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3626
	mov	word ptr _symb_,151
@5@3626:
	push	ds
	mov	ax,offset s@+793
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3674
	mov	word ptr _symb_,152
@5@3674:
	push	ds
	mov	ax,offset s@+795
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3722
	mov	word ptr _symb_,153
@5@3722:
   ;	
   ;		if(strcmp(string,"#") == 0) symb_= 154; if(strcmp(string,"'") == 0) symb_= 155;  if(strcmp(string,"�") == 0) symb_= 156;
   ;	
	push	ds
	mov	ax,offset s@+797
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3770
	mov	word ptr _symb_,154
@5@3770:
	push	ds
	mov	ax,offset s@+799
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3818
	mov	word ptr _symb_,155
@5@3818:
	push	ds
	mov	ax,offset s@+801
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3866
	mov	word ptr _symb_,156
@5@3866:
   ;	
   ;		if(strcmp(string,"�") == 0) symb_= 157; if(strcmp(string,",") == 0) symb_= 158;  if(strcmp(string,":") == 0) symb_= 159;
   ;	
	push	ds
	mov	ax,offset s@+803
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3914
	mov	word ptr _symb_,157
@5@3914:
	push	ds
	mov	ax,offset s@+805
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@3962
	mov	word ptr _symb_,158
@5@3962:
	push	ds
	mov	ax,offset s@+807
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@4010
	mov	word ptr _symb_,159
@5@4010:
   ;	
   ;		if(strcmp(string,";") == 0) symb_= 160; if(strcmp(string,"�") == 0) symb_= 161;  if(strcmp(string,"�") == 0) symb_= 162;
   ;	
	push	ds
	mov	ax,offset s@+809
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@4058
	mov	word ptr _symb_,160
@5@4058:
	push	ds
	mov	ax,offset s@+811
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@4106
	mov	word ptr _symb_,161
@5@4106:
	push	ds
	mov	ax,offset s@+813
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @5@4154
	mov	word ptr _symb_,162
@5@4154:
   ;	
   ;	
   ;		//
   ;		//.. symbole
   ;	};
   ;	
	pop	ds
	pop	bp
	ret	
_symbol_inpt	endp
   ;	
   ;	void main()
   ;	
	assume	cs:CAD_TEXT
_main	proc	far
	push	bp
	mov	bp,sp
	sub	sp,8
	push	ds
	mov	ax,CAD_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		FILE *Stream, *mStream;
   ;	
   ;		_setcursortype(_NOCURSOR);//--------------------------------------------------------------------------------------> unterdr�ckt
   ;	
	xor	ax,ax
	push	ax
	call	far ptr __setcursortype
	inc	sp
	inc	sp
   ;	
   ;		
   ;		sprintf(string," "); sprintf(o_string," ");
   ;	
	push	ds
	mov	ax,offset s@+815
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _sprintf
	add	sp,8
	push	ds
	mov	ax,offset s@+817
	push	ax
	push	ds
	mov	ax,offset _o_string
	push	ax
	call	far ptr _sprintf
	add	sp,8
   ;	
   ;		sprintf(tx_string,"CAD_(c)_SCHRAUSSER_2009");
   ;	
	push	ds
	mov	ax,offset s@+819
	push	ax
	push	ds
	mov	ax,offset _tx_string
	push	ax
	call	far ptr _sprintf
	add	sp,8
   ;	
   ;	
   ;		if(fopen( "c000.cad", "r" ) != NULL) //---------------------------------------------------------------------------->  einlesen 
   ;	
	push	ds
	mov	ax,offset s@+852
	push	ax
	push	ds
	mov	ax,offset s@+843
	push	ax
	call	far ptr _fopen
	add	sp,8
	or	ax,dx
	je	short @6@74
   ;	
   ;		{
   ;			Stream = fopen( "c000n.cad", "r" );fscanf(Stream,"%i",&n_);fclose(Stream);
   ;	
	push	ds
	mov	ax,offset s@+864
	push	ax
	push	ds
	mov	ax,offset s@+854
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	ds
	mov	ax,offset _n_
	push	ax
	push	ds
	mov	ax,offset s@+866
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fscanf
	add	sp,12
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;			cadini=1;
   ;	
	mov	word ptr _cadini,1
@6@74:
   ;	
   ;		}
   ;		 
   ;		//Stream = fopen( "c000.cad", "w" );fclose(Stream);
   ;	
   ;	
   ;		while(1)//---------------------------------------------------------------------------------------------------------| hauptschle
   ;		{
   ;			textbackground(disp);
   ;	
	push	word ptr _disp
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;			clrscr();
   ;	
	call	far ptr _clrscr
   ;	
   ;			set=1;
   ;	
	mov	word ptr _set,1
   ;	
   ;			
   ;			gotoxy(1, 1); textcolor(tx_disp2); cprintf("%s",tx_string);//-------------------------------------------------> text�berschrif
   ;	
	mov	ax,1
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _tx_disp2
	call	far ptr _textcolor
	inc	sp
	inc	sp
	push	ds
	mov	ax,offset _tx_string
	push	ax
	push	ds
	mov	ax,offset s@+869
	push	ax
	call	far ptr _cprintf
	add	sp,8
   ;	
   ;			
   ;			if(fix==1 &&  (((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)) &&
   ;	
   ;	
   ;		                   ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))) )//-------------------------------------------> fenster�ber
   ;	
	cmp	word ptr _fix,1
	jne	short @6@218
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@218
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@218
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@218
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@218
   ;	
   ;			{
   ;				y_2pos++;
   ;	
	inc	word ptr _y_2pos
   ;	
   ;				fix=-1;
   ;	
	mov	word ptr _fix,65535
@6@218:
   ;	
   ;			}
   ;	
   ;			if(fix==1 &&  (!((x_cpos == x_pos+1)  && (y_cpos == y_pos+f1))  &&
   ;	
   ;	
   ;						   !((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)) &&
   ;		                   !((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))) )//------------------------------------------> cursormarki
   ;	
	cmp	word ptr _fix,1
	je	@@0
	jmp	@6@458
@@0:
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@290
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	@@1
	jmp	@6@458
@@1:
@6@290:
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@338
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	@@2
	jmp	@6@458
@@2:
@6@338:
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@386
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	je	short @6@458
@6@386:
   ;	
   ;			{
   ;				if(fix1==1)
   ;	
	cmp	word ptr _fix1,1
	jne	short @6@434
   ;	
   ;				{
   ;					Stream = fopen( "c000.cad", "a" );
   ;	
	push	ds
	mov	ax,offset s@+881
	push	ax
	push	ds
	mov	ax,offset s@+872
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;					fprintf(Stream,"%i %i %i\n", x_cpos, y_cpos-1, symb_);
   ;	
	push	word ptr _symb_
	mov	ax,word ptr _y_cpos
	dec	ax
	push	ax
	push	word ptr _x_cpos
	push	ds
	mov	ax,offset s@+883
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,14
   ;	
   ;					fclose(Stream);
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;					cad_in=1; n_++;fix1=1;
   ;	
	mov	word ptr _cad_in,1
	inc	word ptr _n_
	mov	word ptr _fix1,1
@6@434:
   ;	
   ;				}
   ;				fix1=1;
   ;	
	mov	word ptr _fix1,1
@6@458:
   ;	
   ;			}
   ;	
   ;			if(grid==1) //------------------------------------------------------------------------------------------------> grid erzeugung
   ;	
	cmp	word ptr _grid,1
	jne	short @6@650
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
   ;				for(jLauf=5;jLauf<=45;jLauf+=grdy)//----------------------------------------------------------------------> dichte +=y
   ;	
	mov	word ptr _jLauf,5
	jmp	short @6@626
@6@506:
   ;	
   ;				{
   ;					for(iLauf=10;iLauf<=70;iLauf+=grdx)//-----------------------------------------------------------------> dichte +=x
   ;	
	mov	word ptr _iLauf,10
	jmp	short @6@578
@6@530:
   ;	
   ;					{
   ;						gotoxy(iLauf, jLauf);cprintf(".");
   ;	
	push	word ptr _jLauf
	push	word ptr _iLauf
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+893
	push	ax
	call	far ptr _cprintf
	add	sp,4
	mov	ax,word ptr _grdx
	add	word ptr _iLauf,ax
@6@578:
	cmp	word ptr _iLauf,70
	jle	short @6@530
	mov	ax,word ptr _grdy
	add	word ptr _jLauf,ax
@6@626:
	cmp	word ptr _jLauf,45
	jle	short @6@506
@6@650:
   ;	
   ;					}
   ;				}	
   ;			}
   ;		
   ;			if(lin==1) //-------------------------------------------------------------------------------------------------> koordinatenlin
   ;	
	cmp	word ptr _lin,1
	je	@@3
	jmp	@6@866
@@3:
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
   ;				gotoxy(1, y_cpos-1);cprintf("y\r\n%i", y_cpos-1);
   ;	
	mov	ax,word ptr _y_cpos
	dec	ax
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _y_cpos
	dec	ax
	push	ax
	push	ds
	mov	ax,offset s@+895
	push	ax
	call	far ptr _cprintf
	add	sp,6
   ;	
   ;				gotoxy(2, y_cpos-1);for(iLauf=2;iLauf<80;iLauf++)cprintf(".");
   ;	
	mov	ax,word ptr _y_cpos
	dec	ax
	push	ax
	mov	ax,2
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	word ptr _iLauf,2
	jmp	short @6@746
@6@698:
	push	ds
	mov	ax,offset s@+901
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	word ptr _iLauf
@6@746:
	cmp	word ptr _iLauf,80
	jl	short @6@698
   ;	
   ;				gotoxy(x_cpos-1, 1);cprintf(" x%i ", x_cpos);
   ;	
	mov	ax,1
	push	ax
	mov	ax,word ptr _x_cpos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _x_cpos
	push	ds
	mov	ax,offset s@+903
	push	ax
	call	far ptr _cprintf
	add	sp,6
   ;	
   ;				for(iLauf=2;iLauf<=50;iLauf++)
   ;	
	mov	word ptr _iLauf,2
	jmp	short @6@842
@6@794:
   ;	
   ;				{
   ;					gotoxy(x_cpos, iLauf);cprintf(".");
   ;	
	push	word ptr _iLauf
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+909
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	word ptr _iLauf
@6@842:
	cmp	word ptr _iLauf,50
	jle	short @6@794
@6@866:
   ;	
   ;				}
   ;			}
   ;			
   ;			if(cad_in==1) //----------------------------------------------------------------------------------------------> einlesen der a
   ;	
	cmp	word ptr _cad_in,1
	je	@@4
	jmp	@6@1010
@@4:
   ;	
   ;			{	
   ;				Stream = fopen( "c000.cad", "r" );
   ;	
	push	ds
	mov	ax,offset s@+920
	push	ax
	push	ds
	mov	ax,offset s@+911
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;				for(iLauf=1;iLauf<=n_;iLauf++)fscanf(Stream,"%i%i%i",&cadx_pos[iLauf], &cady_pos[iLauf], &symb[iLauf]);
   ;	
	mov	word ptr _iLauf,1
	jmp	short @6@962
@6@914:
	mov	ax,word ptr _iLauf
	shl	ax,1
	add	ax,offset _symb
	push	ds
	push	ax
	mov	ax,word ptr _iLauf
	shl	ax,1
	add	ax,offset _cady_pos
	push	ds
	push	ax
	mov	ax,word ptr _iLauf
	shl	ax,1
	add	ax,offset _cadx_pos
	push	ds
	push	ax
	push	ds
	mov	ax,offset s@+922
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fscanf
	add	sp,20
	inc	word ptr _iLauf
@6@962:
	mov	ax,word ptr _iLauf
	cmp	ax,word ptr _n_
	jle	short @6@914
   ;	
   ;				fclose(Stream);
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;				cad_in=0;
   ;	
	mov	word ptr _cad_in,0
@6@1010:
   ;	
   ;			}
   ;			
   ;			if(disp < 0) disp = 7;//--------------------------------------------------------------------------------------> farbr�ckstellu
   ;	
	cmp	word ptr _disp,0
	jge	short @6@1058
	mov	word ptr _disp,7
@6@1058:
   ;	
   ;			if(tx_disp < 0) tx_disp = 15;
   ;	
	cmp	word ptr _tx_disp,0
	jge	short @6@1106
	mov	word ptr _tx_disp,15
@6@1106:
   ;	
   ;			textbackground(disp);textcolor(tx_disp);
   ;	
	push	word ptr _disp
	call	far ptr _textbackground
	inc	sp
	inc	sp
	push	word ptr _tx_disp
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;			
   ;			if(cadini==1)for(iLauf=1;iLauf<=n_;iLauf++) symbole();//------------------------------------------------------> graphikerzeugu
   ;	
	cmp	word ptr _cadini,1
	jne	short @6@1226
	mov	word ptr _iLauf,1
	jmp	short @6@1202
@6@1154:
	push	cs
	call	near ptr _symbole
	inc	word ptr _iLauf
@6@1202:
	mov	ax,word ptr _iLauf
	cmp	ax,word ptr _n_
	jle	short @6@1154
@6@1226:
   ;	
   ;	
   ;	
   ;			if(drw==1)//--------------------------------------------------------------------------------------------------> linienziehung
   ;	
	cmp	word ptr _drw,1
	je	@@5
	jmp	@6@2114
@@5:
   ;	
   ;			{	
   ;				if(drw_m==1)Stream = fopen( "c000.cad", "a" );
   ;	
	cmp	word ptr _drw_m,1
	jne	short @6@1298
	push	ds
	mov	ax,offset s@+938
	push	ax
	push	ds
	mov	ax,offset s@+929
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
@6@1298:
   ;	
   ;				
   ;				if(y_cpos<=drw0y+1)
   ;	
	mov	ax,word ptr _drw0y
	inc	ax
	cmp	ax,word ptr _y_cpos
	jge	@@6
	jmp	@6@1682
@@6:
   ;	
   ;				for(jLauf=1; jLauf <=drw0y-y_cpos+2; jLauf++)
   ;	
	mov	word ptr _jLauf,1
	jmp	@6@1658
@6@1346:
   ;	
   ;				{
   ;					if(x_cpos>=drw0x)
   ;	
	mov	ax,word ptr _x_cpos
	cmp	ax,word ptr _drw0x
	jge	@@7
	jmp	@6@1490
@@7:
   ;	
   ;					for(iLauf=0;iLauf<=(x_cpos-drw0x)/(drw0y-y_cpos+2);iLauf++) 
   ;	
	mov	word ptr _iLauf,0
	jmp	@6@1466
@6@1394:
   ;	
   ;					{
   ;						gotoxy(drw0x+iLauf+(jLauf-1)*(x_cpos-drw0x)/(drw0y-y_cpos+2), drw0y-jLauf+1);cprintf(".");
   ;	
	mov	ax,word ptr _drw0y
	sub	ax,word ptr _jLauf
	inc	ax
	push	ax
	mov	ax,word ptr _jLauf
	dec	ax
	mov	dx,word ptr _x_cpos
	sub	dx,word ptr _drw0x
	imul	dx
	mov	bx,word ptr _drw0y
	sub	bx,word ptr _y_cpos
	inc	bx
	inc	bx
	cwd	
	idiv	bx
	mov	dx,word ptr _drw0x
	add	dx,word ptr _iLauf
	add	dx,ax
	push	dx
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+940
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;						
   ;						if(drw_m==1){fprintf(Stream,"%i %i 4\n", drw0x+iLauf+(jLauf-1)*(x_cpos-drw0x)/(drw0y-y_cpos+2), drw0y-jLauf+1);n_++;}
   ;	
	cmp	word ptr _drw_m,1
	jne	short @6@1442
	mov	ax,word ptr _drw0y
	sub	ax,word ptr _jLauf
	inc	ax
	push	ax
	mov	ax,word ptr _jLauf
	dec	ax
	mov	dx,word ptr _x_cpos
	sub	dx,word ptr _drw0x
	imul	dx
	mov	bx,word ptr _drw0y
	sub	bx,word ptr _y_cpos
	inc	bx
	inc	bx
	cwd	
	idiv	bx
	mov	dx,word ptr _drw0x
	add	dx,word ptr _iLauf
	add	dx,ax
	push	dx
	push	ds
	mov	ax,offset s@+942
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,12
	inc	word ptr _n_
@6@1442:
	inc	word ptr _iLauf
@6@1466:
	mov	ax,word ptr _x_cpos
	sub	ax,word ptr _drw0x
	mov	bx,word ptr _drw0y
	sub	bx,word ptr _y_cpos
	inc	bx
	inc	bx
	cwd	
	idiv	bx
	cmp	ax,word ptr _iLauf
	jl	@@8
	jmp	@6@1394
@@8:
@6@1490:
   ;	
   ;					}
   ;				
   ;					if(x_cpos<drw0x)
   ;	
	mov	ax,word ptr _x_cpos
	cmp	ax,word ptr _drw0x
	jl	@@9
	jmp	@6@1634
@@9:
   ;	
   ;					for(iLauf=0;iLauf<=(drw0x-x_cpos)/(drw0y-y_cpos+2);iLauf++) 
   ;	
	mov	word ptr _iLauf,0
	jmp	@6@1610
@6@1538:
   ;	
   ;					{
   ;						gotoxy(drw0x-iLauf+(jLauf-1)*(x_cpos-drw0x)/(drw0y-y_cpos+2), drw0y-jLauf+1);cprintf(".");
   ;	
	mov	ax,word ptr _drw0y
	sub	ax,word ptr _jLauf
	inc	ax
	push	ax
	mov	ax,word ptr _jLauf
	dec	ax
	mov	dx,word ptr _x_cpos
	sub	dx,word ptr _drw0x
	imul	dx
	mov	bx,word ptr _drw0y
	sub	bx,word ptr _y_cpos
	inc	bx
	inc	bx
	cwd	
	idiv	bx
	mov	dx,word ptr _drw0x
	sub	dx,word ptr _iLauf
	add	dx,ax
	push	dx
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+951
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					
   ;						if(drw_m==1){fprintf(Stream,"%i %i 4\n", drw0x-iLauf+(jLauf-1)*(x_cpos-drw0x)/(drw0y-y_cpos+2), drw0y-jLauf+1);n_++;}
   ;	
	cmp	word ptr _drw_m,1
	jne	short @6@1586
	mov	ax,word ptr _drw0y
	sub	ax,word ptr _jLauf
	inc	ax
	push	ax
	mov	ax,word ptr _jLauf
	dec	ax
	mov	dx,word ptr _x_cpos
	sub	dx,word ptr _drw0x
	imul	dx
	mov	bx,word ptr _drw0y
	sub	bx,word ptr _y_cpos
	inc	bx
	inc	bx
	cwd	
	idiv	bx
	mov	dx,word ptr _drw0x
	sub	dx,word ptr _iLauf
	add	dx,ax
	push	dx
	push	ds
	mov	ax,offset s@+953
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,12
	inc	word ptr _n_
@6@1586:
	inc	word ptr _iLauf
@6@1610:
	mov	ax,word ptr _drw0x
	sub	ax,word ptr _x_cpos
	mov	bx,word ptr _drw0y
	sub	bx,word ptr _y_cpos
	inc	bx
	inc	bx
	cwd	
	idiv	bx
	cmp	ax,word ptr _iLauf
	jl	@@10
	jmp	@6@1538
@@10:
@6@1634:
	inc	word ptr _jLauf
@6@1658:
	mov	ax,word ptr _drw0y
	sub	ax,word ptr _y_cpos
	inc	ax
	inc	ax
	cmp	ax,word ptr _jLauf
	jl	@@11
	jmp	@6@1346
@@11:
@6@1682:
   ;	
   ;					}
   ;				}
   ;				
   ;				if(y_cpos>drw0y+1)
   ;	
	mov	ax,word ptr _drw0y
	inc	ax
	cmp	ax,word ptr _y_cpos
	jl	@@12
	jmp	@6@2066
@@12:
   ;	
   ;				for(jLauf=1; jLauf <=y_cpos-1-drw0y; jLauf++)
   ;	
	mov	word ptr _jLauf,1
	jmp	@6@2042
@6@1730:
   ;	
   ;				{
   ;					if(x_cpos>=drw0x)
   ;	
	mov	ax,word ptr _x_cpos
	cmp	ax,word ptr _drw0x
	jge	@@13
	jmp	@6@1874
@@13:
   ;	
   ;					for(iLauf=0;iLauf<=(x_cpos-drw0x)/(y_cpos-1-drw0y);iLauf++) 
   ;	
	mov	word ptr _iLauf,0
	jmp	@6@1850
@6@1778:
   ;	
   ;					{
   ;						gotoxy(drw0x+iLauf+(jLauf-1)*(x_cpos-drw0x)/(y_cpos-1-drw0y), drw0y+jLauf-1);cprintf(".");
   ;	
	mov	ax,word ptr _drw0y
	add	ax,word ptr _jLauf
	dec	ax
	push	ax
	mov	ax,word ptr _jLauf
	dec	ax
	mov	dx,word ptr _x_cpos
	sub	dx,word ptr _drw0x
	imul	dx
	mov	bx,word ptr _y_cpos
	dec	bx
	sub	bx,word ptr _drw0y
	cwd	
	idiv	bx
	mov	dx,word ptr _drw0x
	add	dx,word ptr _iLauf
	add	dx,ax
	push	dx
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+962
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;						
   ;						if(drw_m==1){fprintf(Stream,"%i %i 4\n", drw0x+iLauf+(jLauf-1)*(x_cpos-drw0x)/(y_cpos-1-drw0y), drw0y+jLauf-1);n_++;}
   ;	
	cmp	word ptr _drw_m,1
	jne	short @6@1826
	mov	ax,word ptr _drw0y
	add	ax,word ptr _jLauf
	dec	ax
	push	ax
	mov	ax,word ptr _jLauf
	dec	ax
	mov	dx,word ptr _x_cpos
	sub	dx,word ptr _drw0x
	imul	dx
	mov	bx,word ptr _y_cpos
	dec	bx
	sub	bx,word ptr _drw0y
	cwd	
	idiv	bx
	mov	dx,word ptr _drw0x
	add	dx,word ptr _iLauf
	add	dx,ax
	push	dx
	push	ds
	mov	ax,offset s@+964
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,12
	inc	word ptr _n_
@6@1826:
	inc	word ptr _iLauf
@6@1850:
	mov	ax,word ptr _x_cpos
	sub	ax,word ptr _drw0x
	mov	bx,word ptr _y_cpos
	dec	bx
	sub	bx,word ptr _drw0y
	cwd	
	idiv	bx
	cmp	ax,word ptr _iLauf
	jl	@@14
	jmp	@6@1778
@@14:
@6@1874:
   ;	
   ;					}
   ;				
   ;					if(x_cpos<drw0x)
   ;	
	mov	ax,word ptr _x_cpos
	cmp	ax,word ptr _drw0x
	jl	@@15
	jmp	@6@2018
@@15:
   ;	
   ;					for(iLauf=0;iLauf<=(drw0x-x_cpos)/(y_cpos-1-drw0y);iLauf++) 
   ;	
	mov	word ptr _iLauf,0
	jmp	@6@1994
@6@1922:
   ;	
   ;					{
   ;						gotoxy(drw0x-iLauf+(jLauf-1)*(x_cpos-drw0x)/(y_cpos-1-drw0y), drw0y+jLauf-1);cprintf(".");
   ;	
	mov	ax,word ptr _drw0y
	add	ax,word ptr _jLauf
	dec	ax
	push	ax
	mov	ax,word ptr _jLauf
	dec	ax
	mov	dx,word ptr _x_cpos
	sub	dx,word ptr _drw0x
	imul	dx
	mov	bx,word ptr _y_cpos
	dec	bx
	sub	bx,word ptr _drw0y
	cwd	
	idiv	bx
	mov	dx,word ptr _drw0x
	sub	dx,word ptr _iLauf
	add	dx,ax
	push	dx
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+973
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;	
   ;						if(drw_m==1){fprintf(Stream,"%i %i 4\n", drw0x-iLauf+(jLauf-1)*(x_cpos-drw0x)/(y_cpos-1-drw0y), drw0y+jLauf-1);n_++;}
   ;	
	cmp	word ptr _drw_m,1
	jne	short @6@1970
	mov	ax,word ptr _drw0y
	add	ax,word ptr _jLauf
	dec	ax
	push	ax
	mov	ax,word ptr _jLauf
	dec	ax
	mov	dx,word ptr _x_cpos
	sub	dx,word ptr _drw0x
	imul	dx
	mov	bx,word ptr _y_cpos
	dec	bx
	sub	bx,word ptr _drw0y
	cwd	
	idiv	bx
	mov	dx,word ptr _drw0x
	sub	dx,word ptr _iLauf
	add	dx,ax
	push	dx
	push	ds
	mov	ax,offset s@+975
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,12
	inc	word ptr _n_
@6@1970:
	inc	word ptr _iLauf
@6@1994:
	mov	ax,word ptr _drw0x
	sub	ax,word ptr _x_cpos
	mov	bx,word ptr _y_cpos
	dec	bx
	sub	bx,word ptr _drw0y
	cwd	
	idiv	bx
	cmp	ax,word ptr _iLauf
	jl	@@16
	jmp	@6@1922
@@16:
@6@2018:
	inc	word ptr _jLauf
@6@2042:
	mov	ax,word ptr _y_cpos
	dec	ax
	sub	ax,word ptr _drw0y
	cmp	ax,word ptr _jLauf
	jl	@@17
	jmp	@6@1730
@@17:
@6@2066:
   ;	
   ;					}
   ;				}
   ;	
   ;				if(drw_m==1){ fclose(Stream);  drw_m=0; drw=-1;  	cad_in=1; cadini=1;set=0;  }			
   ;	
	cmp	word ptr _drw_m,1
	jne	short @6@2114
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
	mov	word ptr _drw_m,0
	mov	word ptr _drw,65535
	mov	word ptr _cad_in,1
	mov	word ptr _cadini,1
	mov	word ptr _set,0
@6@2114:
   ;	
   ;			}
   ;			
   ;			textcolor(tx_disp2);
   ;	
	push	word ptr _tx_disp2
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;			
   ;			//------------------------------------------------------------------------------------------------------------> fenster2
   ;			if(y_2pos > 0 ){gotoxy(x_2pos-1, y_2pos);cprintf("\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xBF");}
   ;	
	cmp	word ptr _y_2pos,0
	jle	short @6@2162
	push	word ptr _y_2pos
	mov	ax,word ptr _x_2pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+984
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2162:
   ;	
   ;			if(y_2pos+1 > 0 ){gotoxy(x_2pos, y_2pos+1);cprintf("[P]Cls ");}
   ;	
	mov	ax,word ptr _y_2pos
	inc	ax
	jle	short @6@2210
	mov	ax,word ptr _y_2pos
	inc	ax
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+996
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2210:
   ;	
   ;			if(y_2pos+2 > 0 ){gotoxy(x_2pos, y_2pos+2);cprintf("[V]tx:%i", tx_disp);}
   ;	
	mov	ax,word ptr _y_2pos
	inc	ax
	inc	ax
	jle	short @6@2258
	mov	ax,word ptr _y_2pos
	inc	ax
	inc	ax
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _tx_disp
	push	ds
	mov	ax,offset s@+1004
	push	ax
	call	far ptr _cprintf
	add	sp,6
@6@2258:
   ;	
   ;			if(y_2pos+3 > 0 ){gotoxy(x_2pos, y_2pos+3);cprintf("[B]dsp:%i", disp );}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,3
	jle	short @6@2306
	mov	ax,word ptr _y_2pos
	add	ax,3
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	word ptr _disp
	push	ds
	mov	ax,offset s@+1013
	push	ax
	call	far ptr _cprintf
	add	sp,6
@6@2306:
   ;	
   ;			if(y_2pos+4 > 0 ){gotoxy(x_2pos, y_2pos+4);cprintf("[Z]Symbol");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,4
	jle	short @6@2354
	mov	ax,word ptr _y_2pos
	add	ax,4
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1023
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2354:
   ;	
   ;			if(y_2pos+5 > 0 ){gotoxy(x_2pos, y_2pos+5);cprintf("[\xB0\xB1\xB2\xDB\xDC\xFE\xDF]");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,5
	jle	short @6@2402
	mov	ax,word ptr _y_2pos
	add	ax,5
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1033
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2402:
   ;	
   ;			if(y_2pos+6 > 0 ){gotoxy(x_2pos, y_2pos+6);cprintf("[\xB4\xC1><\xC2^\xC3]");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,6
	jle	short @6@2450
	mov	ax,word ptr _y_2pos
	add	ax,6
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1043
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2450:
   ;	
   ;			if(y_2pos+7 > 0 ){gotoxy(x_2pos, y_2pos+7);cprintf("[\x16\xDA\xC0\xD9\xBF\xC5\x9E]");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,7
	jle	short @6@2498
	mov	ax,word ptr _y_2pos
	add	ax,7
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1053
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2498:
   ;	
   ;			if(y_2pos+8 > 0 ){gotoxy(x_2pos, y_2pos+8);cprintf("[/_\xC4\xEE-\\\xB3]");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,8
	jle	short @6@2546
	mov	ax,word ptr _y_2pos
	add	ax,8
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1063
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2546:
   ;	
   ;			if(y_2pos+9 > 0 ){gotoxy(x_2pos, y_2pos+9);cprintf("[\xB9\xBB\xBC\xC8\xC9\xBA\xCD]");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,9
	jle	short @6@2594
	mov	ax,word ptr _y_2pos
	add	ax,9
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1073
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2594:
   ;	
   ;			if(y_2pos+10 > 0 ){gotoxy(x_2pos, y_2pos+10);cprintf("[=\xCB\xCC\xCE\xCF\xDD\xCA]");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,10
	jle	short @6@2642
	mov	ax,word ptr _y_2pos
	add	ax,10
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1083
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2642:
   ;	
   ;			if(y_2pos+11 > 0 ){gotoxy(x_2pos, y_2pos+11);cprintf("[\x10\x11\x1E\x1F\x1A\x1B\x1C]");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,11
	jle	short @6@2690
	mov	ax,word ptr _y_2pos
	add	ax,11
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1093
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2690:
   ;	
   ;			if(y_2pos+12 > 0 ){gotoxy(x_2pos, y_2pos+12);cprintf("[\x18\x19\x17\x1D\xF9\xF7\xAA]");}
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,12
	jle	short @6@2738
	mov	ax,word ptr _y_2pos
	add	ax,12
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1103
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2738:
   ;	
   ;			gotoxy(x_2pos, y_2pos+13);cprintf("[\xA7\xA9\xAE\xAF\x0F\x0E*]");
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,13
	push	ax
	push	word ptr _x_2pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1113
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			gotoxy(x_2pos-1, y_2pos+14);cprintf("\xC0\xC4o\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xD9");
   ;	
	mov	ax,word ptr _y_2pos
	add	ax,14
	push	ax
	mov	ax,word ptr _x_2pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1123
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;	
   ;			//------------------------------------------------------------------------------------------------------------> fenster
   ;			if(y_pos   > 0 ){gotoxy(x_pos-1, y_pos);cprintf("\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xBF");}
   ;	
	cmp	word ptr _y_pos,0
	jle	short @6@2786
	push	word ptr _y_pos
	mov	ax,word ptr _x_pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1135
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2786:
   ;	
   ;			if(y_pos+1 > 0 ){gotoxy(x_pos, y_pos+1);cprintf("x:%i y:%i", x_cpos, y_cpos-1 );}
   ;	
	mov	ax,word ptr _y_pos
	inc	ax
	jle	short @6@2834
	mov	ax,word ptr _y_pos
	inc	ax
	push	ax
	push	word ptr _x_pos
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,word ptr _y_cpos
	dec	ax
	push	ax
	push	word ptr _x_cpos
	push	ds
	mov	ax,offset s@+1147
	push	ax
	call	far ptr _cprintf
	add	sp,8
@6@2834:
   ;	
   ;			if(y_pos+2 > 0 )
   ;	
	mov	ax,word ptr _y_pos
	inc	ax
	inc	ax
	jle	short @6@2954
   ;	
   ;			{
   ;				gotoxy(x_pos-1, y_pos+2);
   ;	
	mov	ax,word ptr _y_pos
	inc	ax
	inc	ax
	push	ax
	mov	ax,word ptr _x_pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;				if(grid==1)cprintf("\xFE[G]Grd#\xBA\xCD");
   ;	
	cmp	word ptr _grid,1
	jne	short @6@2906
	push	ds
	mov	ax,offset s@+1157
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2906:
   ;	
   ;				if(grid==-1)cprintf(" [G]Grd  ");
   ;	
	cmp	word ptr _grid,65535
	jne	short @6@2954
	push	ds
	mov	ax,offset s@+1168
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@2954:
   ;	
   ;			}
   ;			if(y_pos+3 > 0 )
   ;	
	mov	ax,word ptr _y_pos
	add	ax,3
	jle	short @6@3074
   ;	
   ;			{
   ;				gotoxy(x_pos-1, y_pos+3);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,3
	push	ax
	mov	ax,word ptr _x_pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;				if(lin==1)cprintf("\xFE[F]Linie ");
   ;	
	cmp	word ptr _lin,1
	jne	short @6@3026
	push	ds
	mov	ax,offset s@+1178
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3026:
   ;	
   ;				if(lin==-1)cprintf(" [F]Linie ");
   ;	
	cmp	word ptr _lin,65535
	jne	short @6@3074
	push	ds
	mov	ax,offset s@+1189
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3074:
   ;	
   ;			}
   ;			if(y_pos+4 > 0 )
   ;	
	mov	ax,word ptr _y_pos
	add	ax,4
	jle	short @6@3194
   ;	
   ;			{
   ;				gotoxy(x_pos-1, y_pos+4);
   ;	
	mov	ax,word ptr _y_pos
	add	ax,4
	push	ax
	mov	ax,word ptr _x_pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;				if(tx_disp2==8)cprintf(" [C]Wnd  ");
   ;	
	cmp	word ptr _tx_disp2,8
	jne	short @6@3146
	push	ds
	mov	ax,offset s@+1200
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3146:
   ;	
   ;				if(tx_disp2==7)cprintf("\xFE[C]Wnd  ");
   ;	
	cmp	word ptr _tx_disp2,7
	jne	short @6@3194
	push	ds
	mov	ax,offset s@+1210
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3194:
   ;	
   ;	
   ;			}
   ;			gotoxy(x_pos, y_pos+5);cprintf("[.]Ende  ");
   ;	
	mov	ax,word ptr _y_pos
	add	ax,5
	push	ax
	push	word ptr _x_pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1220
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			gotoxy(x_pos-1, y_pos+6);cprintf("\xC0\xC4o\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xD9");
   ;	
	mov	ax,word ptr _y_pos
	add	ax,6
	push	ax
	mov	ax,word ptr _x_pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1230
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;	
   ;			//------------------------------------------------------------------------------------------------------------> fenster3
   ;			if(wnd3==1)
   ;	
	cmp	word ptr _wnd3,1
	je	@@18
	jmp	@6@3530
@@18:
   ;	
   ;			{
   ;				if(y_3pos   > 0 ){ gotoxy(x_3pos-1, y_3pos);cprintf("\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4
   ;	
	cmp	word ptr _y_3pos,0
	jle	short @6@3266
	push	word ptr _y_3pos
	mov	ax,word ptr _x_3pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1242
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3266:
   ;	
   ;				if(y_3pos+1 > 0 ){gotoxy(x_3pos, y_3pos+1);cprintf("|Q||W||E| |H|. ");}
   ;	
	mov	ax,word ptr _y_3pos
	inc	ax
	jle	short @6@3314
	mov	ax,word ptr _y_3pos
	inc	ax
	push	ax
	push	word ptr _x_3pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1262
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3314:
   ;	
   ;				if(y_3pos+2 > 0 ){gotoxy(x_3pos, y_3pos+2);cprintf("|A| * |D| |U|Fix ");}
   ;	
	mov	ax,word ptr _y_3pos
	inc	ax
	inc	ax
	jle	short @6@3362
	mov	ax,word ptr _y_3pos
	inc	ax
	inc	ax
	push	ax
	push	word ptr _x_3pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1278
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3362:
   ;	
   ;				if(y_3pos+3 > 0 ){gotoxy(x_3pos, y_3pos+3);cprintf("|Y||S||X| |J|Ldrw");}
   ;	
	mov	ax,word ptr _y_3pos
	add	ax,3
	jle	short @6@3410
	mov	ax,word ptr _y_3pos
	add	ax,3
	push	ax
	push	word ptr _x_3pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1296
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3410:
   ;	
   ;				if(y_3pos+4 > 0 ){gotoxy(x_3pos, y_3pos+4);cprintf("|K|Gd\xBA    |L|Gd\xCD");}
   ;	
	mov	ax,word ptr _y_3pos
	add	ax,4
	jle	short @6@3458
	mov	ax,word ptr _y_3pos
	add	ax,4
	push	ax
	push	word ptr _x_3pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1314
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3458:
   ;	
   ;				if(y_3pos+5 > 0 ){gotoxy(x_3pos, y_3pos+5);cprintf("|M|mem    |O|opn");}
   ;	
	mov	ax,word ptr _y_3pos
	add	ax,5
	jle	short @6@3506
	mov	ax,word ptr _y_3pos
	add	ax,5
	push	ax
	push	word ptr _x_3pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1331
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3506:
   ;	
   ;				gotoxy(x_3pos, y_3pos+6);cprintf("[T]Cmnd   |+|    i");
   ;	
	mov	ax,word ptr _y_3pos
	add	ax,6
	push	ax
	push	word ptr _x_3pos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1348
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				gotoxy(x_3pos-1, y_3pos+7);cprintf("\xC0\xC4o\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xD9");//	
   ;	
	mov	ax,word ptr _y_3pos
	add	ax,7
	push	ax
	mov	ax,word ptr _x_3pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1367
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3530:
   ;	
   ;			}
   ;			
   ;			if(wnd3==-1)
   ;	
	cmp	word ptr _wnd3,65535
	jne	short @6@3578
   ;	
   ;			{
   ;				gotoxy(x_3pos-1, y_3pos+6);cprintf("\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xBF");
   ;	
	mov	ax,word ptr _y_3pos
	add	ax,6
	push	ax
	mov	ax,word ptr _x_3pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1387
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				gotoxy(x_3pos-1, y_3pos+7);cprintf("\xC0\xC4o\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4i");
   ;	
	mov	ax,word ptr _y_3pos
	add	ax,7
	push	ax
	mov	ax,word ptr _x_3pos
	dec	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1407
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3578:
   ;	
   ;			}
   ;	
   ;			//------------------------------------------------------------------------------------------------------------> cursor
   ;			textcolor(tx_disp);
   ;	
	push	word ptr _tx_disp
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;			gotoxy(x_cpos, y_cpos);cprintf("\x1E");
   ;	
	push	word ptr _y_cpos
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1427
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			if(fix==1){gotoxy(x_cpos, y_cpos+1);cprintf("\xEE");}//-------------------------------------------------------> fixierungsscha
   ;	
	cmp	word ptr _fix,1
	jne	short @6@3626
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1429
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3626:
   ;	
   ;			if(drw==1){gotoxy(x_cpos, y_cpos+1);cprintf("\x1D");}//-------------------------------------------------------> linienziehungs
   ;	
	cmp	word ptr _drw,1
	jne	short @6@3674
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1431
	push	ax
	call	far ptr _cprintf
	add	sp,4
@6@3674:
   ;	
   ;			
   ;			cursor_symbole();//-------------------------------------------------------------------------------------------> markierungssym
   ;	
	push	cs
	call	near ptr _cursor_symbole
   ;	
   ;			
   ;			//------------------------------------------------------------------------------------------------------------> zuordnung der 
   ;			
   ;			
   ;			taste=getch();
   ;	
	call	far ptr _getch
	mov	byte ptr _taste,al
   ;	
   ;			
   ;			
   ;			//------------------------------------------------------------------------------------------------------------> ereignisse
   ;			
   ;			if(taste == 'h'&& ((x_cpos == x_pos+1) && (y_cpos == y_pos+6))) //--------------------------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@3770
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@3770
	mov	ax,word ptr _y_pos
	add	ax,6
	cmp	ax,word ptr _y_cpos
	jne	short @6@3770
   ;	
   ;			{
   ;				Stream = fopen( "c000n.cad", "w" );fprintf(Stream,"%i\n",n_);fclose(Stream);			
   ;	
	push	ds
	mov	ax,offset s@+1443
	push	ax
	push	ds
	mov	ax,offset s@+1433
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	word ptr _n_
	push	ds
	mov	ax,offset s@+1445
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,10
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;				exit(1);
   ;	
	mov	ax,1
	push	ax
	call	far ptr _exit
	inc	sp
	inc	sp
@6@3770:
   ;	
   ;			}
   ;			if(taste == 'h'&& ((x_cpos == x_pos+1) && (y_cpos == y_pos+5))) //--------------------------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@3914
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@3914
	mov	ax,word ptr _y_pos
	add	ax,5
	cmp	ax,word ptr _y_cpos
	jne	short @6@3914
   ;	
   ;			{
   ;				tx_disp2--;if(tx_disp2<7)tx_disp2=8;set=0;
   ;	
	dec	word ptr _tx_disp2
	cmp	word ptr _tx_disp2,7
	jge	short @6@3890
	mov	word ptr _tx_disp2,8
@6@3890:
	mov	word ptr _set,0
@6@3914:
   ;	
   ;			}
   ;			
   ;			if(taste == 'h'&& ((x_cpos == x_pos+1) && (y_cpos == y_pos+4))) {lin*=-1;set=0;}//----------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4010
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@4010
	mov	ax,word ptr _y_pos
	add	ax,4
	cmp	ax,word ptr _y_cpos
	jne	short @6@4010
	mov	dx,65535
	mov	ax,word ptr _lin
	imul	dx
	mov	word ptr _lin,ax
	mov	word ptr _set,0
@6@4010:
   ;	
   ;			if(taste == 'h'&& ((x_cpos == x_pos+1) && (y_cpos == y_pos+3))) {grid*=-1;set=0;}//---------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4106
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@4106
	mov	ax,word ptr _y_pos
	add	ax,3
	cmp	ax,word ptr _y_cpos
	jne	short @6@4106
	mov	dx,65535
	mov	ax,word ptr _grid
	imul	dx
	mov	word ptr _grid,ax
	mov	word ptr _set,0
@6@4106:
   ;	
   ;			if(taste == 'h'&& ((x_cpos == x_pos+6) && (y_cpos == y_pos+3))) //--------------------------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4298
	mov	ax,word ptr _x_pos
	add	ax,6
	cmp	ax,word ptr _x_cpos
	jne	short @6@4298
	mov	ax,word ptr _y_pos
	add	ax,3
	cmp	ax,word ptr _y_cpos
	jne	short @6@4298
   ;	
   ;			{
   ;				grdy-=2;if(grdy<2)grdy=10;grdx-=2;if(grdx<2)grdx=10;set=0;//----------------------------------------------> gesamtgrobeinstel
   ;	
	sub	word ptr _grdy,2
	cmp	word ptr _grdy,2
	jge	short @6@4226
	mov	word ptr _grdy,10
@6@4226:
	sub	word ptr _grdx,2
	cmp	word ptr _grdx,2
	jge	short @6@4274
	mov	word ptr _grdx,10
@6@4274:
	mov	word ptr _set,0
@6@4298:
   ;	
   ;			}
   ;			if(taste == 'h'&& ((x_cpos == x_pos+7) && (y_cpos == y_pos+3))) {grdy--;if(grdy<2)grdy=10;set=0;}//-----------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4442
	mov	ax,word ptr _x_pos
	add	ax,7
	cmp	ax,word ptr _x_cpos
	jne	short @6@4442
	mov	ax,word ptr _y_pos
	add	ax,3
	cmp	ax,word ptr _y_cpos
	jne	short @6@4442
	dec	word ptr _grdy
	cmp	word ptr _grdy,2
	jge	short @6@4418
	mov	word ptr _grdy,10
@6@4418:
	mov	word ptr _set,0
@6@4442:
   ;	
   ;			if(taste == 'h'&& ((x_cpos == x_pos+8) && (y_cpos == y_pos+3))) {grdx--;if(grdx<2)grdx=10;set=0;}//-----------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4586
	mov	ax,word ptr _x_pos
	add	ax,8
	cmp	ax,word ptr _x_cpos
	jne	short @6@4586
	mov	ax,word ptr _y_pos
	add	ax,3
	cmp	ax,word ptr _y_cpos
	jne	short @6@4586
	dec	word ptr _grdx
	cmp	word ptr _grdx,2
	jge	short @6@4562
	mov	word ptr _grdx,10
@6@4562:
	mov	word ptr _set,0
@6@4586:
   ;	
   ;			
   ;			if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+5))) //------------------------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4706
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@4706
	mov	ax,word ptr _y_2pos
	add	ax,5
	cmp	ax,word ptr _y_cpos
	jne	short @6@4706
   ;	
   ;			{
   ;				symb_--;if(symb_==0)symb_=_nSYMB_;//set=0;
   ;	
	dec	word ptr _symb_
	cmp	word ptr _symb_,0
	jne	short @6@4706
	mov	word ptr _symb_,14
@6@4706:
   ;	
   ;			}
   ;			if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+4))) {disp--;set=0;}//---------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4802
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@4802
	mov	ax,word ptr _y_2pos
	add	ax,4
	cmp	ax,word ptr _y_cpos
	jne	short @6@4802
	dec	word ptr _disp
	mov	word ptr _set,0
@6@4802:
   ;	
   ;			if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+3))) {tx_disp--;set=0;}//------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4898
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@4898
	mov	ax,word ptr _y_2pos
	add	ax,3
	cmp	ax,word ptr _y_cpos
	jne	short @6@4898
	dec	word ptr _tx_disp
	mov	word ptr _set,0
@6@4898:
   ;	
   ;			if(taste == 'h'&& ((x_cpos == x_2pos+1) && (y_cpos == y_2pos+2))) //------------------------------------------> h_cursor+fenst
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@4994
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@4994
	mov	ax,word ptr _y_2pos
	inc	ax
	inc	ax
	cmp	ax,word ptr _y_cpos
	jne	short @6@4994
   ;	
   ;			{
   ;				Stream = fopen( "c000.cad", "w" );fclose(Stream);
   ;	
	push	ds
	mov	ax,offset s@+1458
	push	ax
	push	ds
	mov	ax,offset s@+1449
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;				cad_in=1;n_=0; set=0;
   ;	
	mov	word ptr _cad_in,1
	mov	word ptr _n_,0
	mov	word ptr _set,0
@6@4994:
   ;	
   ;			}
   ;			
   ;			symbol_taste();
   ;	
	push	cs
	call	near ptr _symbol_taste
   ;	
   ;	
   ;			if(taste == 'c') {tx_disp2--;if(tx_disp2<7)tx_disp2=8;}//-----------------------------------------------------> c_taste �ndert
   ;	
	cmp	byte ptr _taste,99
	jne	short @6@5066
	dec	word ptr _tx_disp2
	cmp	word ptr _tx_disp2,7
	jge	short @6@5066
	mov	word ptr _tx_disp2,8
@6@5066:
   ;	
   ;			if(taste == 'v') tx_disp--;//---------------------------------------------------------------------------------> v_taste �ndert
   ;	
	cmp	byte ptr _taste,118
	jne	short @6@5114
	dec	word ptr _tx_disp
@6@5114:
   ;	
   ;			if(taste == 'b') disp--;//------------------------------------------------------------------------------------> b_taste �ndert
   ;	
	cmp	byte ptr _taste,98
	jne	short @6@5162
	dec	word ptr _disp
@6@5162:
   ;	
   ;	
   ;			if(taste == 'w' && y_cpos  > 3) //----------------------------------------------------------------------------> w_taste versch
   ;	
	cmp	byte ptr _taste,119
	jne	short @6@5474
	cmp	word ptr _y_cpos,3
	jle	short @6@5474
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @6@5450
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))y_pos--;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@5306
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@5306
	dec	word ptr _y_pos
@6@5306:
   ;	
   ;					if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))y_2pos--;
   ;	
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@5378
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@5378
	dec	word ptr _y_2pos
@6@5378:
   ;	
   ;					if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))y_3pos--;
   ;	
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@5450
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	jne	short @6@5450
	dec	word ptr _y_3pos
@6@5450:
   ;	
   ;				}
   ;				y_cpos--;
   ;	
	dec	word ptr _y_cpos
@6@5474:
   ;	
   ;			}
   ;			
   ;			if(taste == 's' && y_cpos  < 49) //---------------------------------------------------------------------------> s_taste versch
   ;	
	cmp	byte ptr _taste,115
	jne	short @6@5786
	cmp	word ptr _y_cpos,49
	jge	short @6@5786
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @6@5762
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))y_pos++;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@5618
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@5618
	inc	word ptr _y_pos
@6@5618:
   ;	
   ;					if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))y_2pos++;
   ;	
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@5690
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@5690
	inc	word ptr _y_2pos
@6@5690:
   ;	
   ;					if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))y_3pos++;
   ;	
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@5762
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	jne	short @6@5762
	inc	word ptr _y_3pos
@6@5762:
   ;	
   ;				}
   ;				y_cpos++;
   ;	
	inc	word ptr _y_cpos
@6@5786:
   ;	
   ;			}
   ;			
   ;			if(taste == 'a' && x_cpos  > 3) //----------------------------------------------------------------------------> a_taste versch
   ;	
	cmp	byte ptr _taste,97
	jne	short @6@6098
	cmp	word ptr _x_cpos,3
	jle	short @6@6098
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @6@6074
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))x_pos--;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@5930
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@5930
	dec	word ptr _x_pos
@6@5930:
   ;	
   ;					if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))x_2pos--;
   ;	
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6002
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@6002
	dec	word ptr _x_2pos
@6@6002:
   ;	
   ;					if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))x_3pos--;
   ;	
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6074
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	jne	short @6@6074
	dec	word ptr _x_3pos
@6@6074:
   ;	
   ;				}
   ;				x_cpos--;
   ;	
	dec	word ptr _x_cpos
@6@6098:
   ;	
   ;			}
   ;			
   ;			if(taste == 'd' && x_cpos  < 78) //---------------------------------------------------------------------------> d_taste versch
   ;	
	cmp	byte ptr _taste,100
	jne	short @6@6410
	cmp	word ptr _x_cpos,78
	jge	short @6@6410
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @6@6386
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1))x_pos++;
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6242
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@6242
	inc	word ptr _x_pos
@6@6242:
   ;	
   ;					if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2))x_2pos++;
   ;	
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6314
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@6314
	inc	word ptr _x_2pos
@6@6314:
   ;	
   ;					if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3))x_3pos++;
   ;	
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6386
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	jne	short @6@6386
	inc	word ptr _x_3pos
@6@6386:
   ;	
   ;				}
   ;				x_cpos++;
   ;	
	inc	word ptr _x_cpos
@6@6410:
   ;	
   ;			}
   ;			
   ;			if(taste == 'e' && y_cpos  > 3 && x_cpos  < 78) //------------------------------------------------------------> e_taste versch
   ;	
	cmp	byte ptr _taste,101
	je	@@19
	jmp	@6@6746
@@19:
	cmp	word ptr _y_cpos,3
	jle	short @6@6746
	cmp	word ptr _x_cpos,78
	jge	short @6@6746
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @6@6722
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){x_pos++;y_pos--;}
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6578
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@6578
	inc	word ptr _x_pos
	dec	word ptr _y_pos
@6@6578:
   ;	
   ;					if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)){x_2pos++;y_2pos--;}
   ;	
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6650
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@6650
	inc	word ptr _x_2pos
	dec	word ptr _y_2pos
@6@6650:
   ;	
   ;					if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3)){x_3pos++;y_3pos--;}
   ;	
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6722
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	jne	short @6@6722
	inc	word ptr _x_3pos
	dec	word ptr _y_3pos
@6@6722:
   ;	
   ;				}
   ;				x_cpos++;y_cpos--;
   ;	
	inc	word ptr _x_cpos
	dec	word ptr _y_cpos
@6@6746:
   ;	
   ;			}
   ;			
   ;			if(taste == 'q' && y_cpos  > 3 && x_cpos  > 3) //-------------------------------------------------------------> q_taste versch
   ;	
	cmp	byte ptr _taste,113
	je	@@20
	jmp	@6@7082
@@20:
	cmp	word ptr _y_cpos,3
	jle	short @6@7082
	cmp	word ptr _x_cpos,3
	jle	short @6@7082
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @6@7058
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){x_pos--;y_pos--;}
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6914
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@6914
	dec	word ptr _x_pos
	dec	word ptr _y_pos
@6@6914:
   ;	
   ;					if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)){x_2pos--;y_2pos--;}
   ;	
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@6986
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@6986
	dec	word ptr _x_2pos
	dec	word ptr _y_2pos
@6@6986:
   ;	
   ;					if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3)){x_3pos--;y_3pos--;}
   ;	
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@7058
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	jne	short @6@7058
	dec	word ptr _x_3pos
	dec	word ptr _y_3pos
@6@7058:
   ;	
   ;				}
   ;				x_cpos--;y_cpos--;
   ;	
	dec	word ptr _x_cpos
	dec	word ptr _y_cpos
@6@7082:
   ;	
   ;			}
   ;			
   ;			if(taste == 'y' && y_cpos  < 49 && x_cpos  > 3) //------------------------------------------------------------> y_taste versch
   ;	
	cmp	byte ptr _taste,121
	je	@@21
	jmp	@6@7418
@@21:
	cmp	word ptr _y_cpos,49
	jge	short @6@7418
	cmp	word ptr _x_cpos,3
	jle	short @6@7418
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @6@7394
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){x_pos--;y_pos++;}
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@7250
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@7250
	dec	word ptr _x_pos
	inc	word ptr _y_pos
@6@7250:
   ;	
   ;					if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)){x_2pos--;y_2pos++;}
   ;	
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@7322
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@7322
	dec	word ptr _x_2pos
	inc	word ptr _y_2pos
@6@7322:
   ;	
   ;					if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3)){x_3pos--;y_3pos++;}
   ;	
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@7394
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	jne	short @6@7394
	dec	word ptr _x_3pos
	inc	word ptr _y_3pos
@6@7394:
   ;	
   ;				}
   ;				x_cpos--;y_cpos++;
   ;	
	dec	word ptr _x_cpos
	inc	word ptr _y_cpos
@6@7418:
   ;	
   ;			}
   ;			
   ;			if(taste == 'x' & y_cpos  < 49 && x_cpos  < 78) //------------------------------------------------------------> x_taste versch
   ;	
	cmp	byte ptr _taste,120
	jne	short @6@7466
	mov	ax,1
	jmp	short @6@7490
@6@7466:
	xor	ax,ax
@6@7490:
	push	ax
	cmp	word ptr _y_cpos,49
	jge	short @6@7538
	mov	ax,1
	jmp	short @6@7562
@6@7538:
	xor	ax,ax
@6@7562:
	pop	dx
	test	dx,ax
	je	short @6@7874
	cmp	word ptr _x_cpos,78
	jge	short @6@7874
   ;	
   ;			{
   ;				if(fix==1)
   ;	
	cmp	word ptr _fix,1
	jne	short @6@7850
   ;	
   ;				{
   ;					if((x_cpos == x_pos+1) && (y_cpos == y_pos+f1)){x_pos++;y_pos++;}
   ;	
	mov	ax,word ptr _x_pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@7706
	mov	ax,word ptr _y_pos
	add	ax,word ptr _f1
	cmp	ax,word ptr _y_cpos
	jne	short @6@7706
	inc	word ptr _x_pos
	inc	word ptr _y_pos
@6@7706:
   ;	
   ;					if((x_cpos == x_2pos+1) && (y_cpos == y_2pos+f2)){x_2pos++;y_2pos++;}
   ;	
	mov	ax,word ptr _x_2pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@7778
	mov	ax,word ptr _y_2pos
	add	ax,word ptr _f2
	cmp	ax,word ptr _y_cpos
	jne	short @6@7778
	inc	word ptr _x_2pos
	inc	word ptr _y_2pos
@6@7778:
   ;	
   ;					if((x_cpos == x_3pos+1) && (y_cpos == y_3pos+f3)){x_3pos++;y_3pos++;}
   ;	
	mov	ax,word ptr _x_3pos
	inc	ax
	cmp	ax,word ptr _x_cpos
	jne	short @6@7850
	mov	ax,word ptr _y_3pos
	add	ax,word ptr _f3
	cmp	ax,word ptr _y_cpos
	jne	short @6@7850
	inc	word ptr _x_3pos
	inc	word ptr _y_3pos
@6@7850:
   ;	
   ;				}
   ;				x_cpos++;y_cpos++;
   ;	
	inc	word ptr _x_cpos
	inc	word ptr _y_cpos
@6@7874:
   ;	
   ;			}
   ;	
   ;			if(taste == 'k') {grdy--;if(grdy<2)grdy=10;}//----------------------------------------------------------------> k_grid y dicht
   ;	
	cmp	byte ptr _taste,107
	jne	short @6@7946
	dec	word ptr _grdy
	cmp	word ptr _grdy,2
	jge	short @6@7946
	mov	word ptr _grdy,10
@6@7946:
   ;	
   ;			if(taste == 'l') {grdx--;if(grdx<2)grdx=10;}//----------------------------------------------------------------> l_grid x dicht
   ;	
	cmp	byte ptr _taste,108
	jne	short @6@8018
	dec	word ptr _grdx
	cmp	word ptr _grdx,2
	jge	short @6@8018
	mov	word ptr _grdx,10
@6@8018:
   ;	
   ;	
   ;			if(taste == 'g') grid*=-1;//----------------------------------------------------------------------------------> g_grid schalte
   ;	
	cmp	byte ptr _taste,103
	jne	short @6@8066
	mov	dx,65535
	mov	ax,word ptr _grid
	imul	dx
	mov	word ptr _grid,ax
@6@8066:
   ;	
   ;			if(taste == 'f') lin*=-1;//-----------------------------------------------------------------------------------> f_linien schal
   ;	
	cmp	byte ptr _taste,102
	jne	short @6@8114
	mov	dx,65535
	mov	ax,word ptr _lin
	imul	dx
	mov	word ptr _lin,ax
@6@8114:
   ;	
   ;	
   ;			if(taste == 'u') {fix*=-1;fix1=0;}//--------------------------------------------------------------------------> u_schaltet mar
   ;	
	cmp	byte ptr _taste,117
	jne	short @6@8162
	mov	dx,65535
	mov	ax,word ptr _fix
	imul	dx
	mov	word ptr _fix,ax
	mov	word ptr _fix1,0
@6@8162:
   ;	
   ;	
   ;			if(taste == 'j') {drw*=-1;drw0x=x_cpos; drw0y=y_cpos-1;}//----------------------------------------------------> j_schaltet lin
   ;	
	cmp	byte ptr _taste,106
	jne	short @6@8210
	mov	dx,65535
	mov	ax,word ptr _drw
	imul	dx
	mov	word ptr _drw,ax
	mov	ax,word ptr _x_cpos
	mov	word ptr _drw0x,ax
	mov	ax,word ptr _y_cpos
	dec	ax
	mov	word ptr _drw0y,ax
@6@8210:
   ;	
   ;			if(taste == 'h' && drw==1) {drw_m=1;set=0;}//-----------------------------------------------------------------> h_schaltet lin
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@8282
	cmp	word ptr _drw,1
	jne	short @6@8282
	mov	word ptr _drw_m,1
	mov	word ptr _set,0
@6@8282:
   ;	
   ;		
   ;			if(taste == '+') wnd3*=-1;//----------------------------------------------------------------------------------> +_schaltet fen
   ;	
	cmp	byte ptr _taste,43
	jne	short @6@8330
	mov	dx,65535
	mov	ax,word ptr _wnd3
	imul	dx
	mov	word ptr _wnd3,ax
@6@8330:
   ;	
   ;			
   ;			if(taste == 'h' && set ==1) //--------------------------------------------------------------------------------> h_setzt markie
   ;	
	cmp	byte ptr _taste,104
	jne	short @6@8402
	cmp	word ptr _set,1
	jne	short @6@8402
   ;	
   ;			{
   ;				Stream = fopen( "c000.cad", "a" );
   ;	
	push	ds
	mov	ax,offset s@+1469
	push	ax
	push	ds
	mov	ax,offset s@+1460
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
   ;	
   ;				fprintf(Stream,"%i %i %i\n", x_cpos, y_cpos-1, symb_);
   ;	
	push	word ptr _symb_
	mov	ax,word ptr _y_cpos
	dec	ax
	push	ax
	push	word ptr _x_cpos
	push	ds
	mov	ax,offset s@+1471
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,14
   ;	
   ;				fclose(Stream);
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;				cad_in=1; cadini=1;n_++;set=0;
   ;	
	mov	word ptr _cad_in,1
	mov	word ptr _cadini,1
	inc	word ptr _n_
	mov	word ptr _set,0
@6@8402:
   ;	
   ;			}
   ;			
   ;			if(taste == 'z') {symb_--;if(symb_==0)symb_=_nSYMB_;}//-------------------------------------------------------> z_�ndert marki
   ;	
	cmp	byte ptr _taste,122
	jne	short @6@8474
	dec	word ptr _symb_
	cmp	word ptr _symb_,0
	jne	short @6@8474
	mov	word ptr _symb_,14
@6@8474:
   ;	
   ;	
   ;			if(taste == 't') //-------------------------------------------------------------------------------------------> t_liest text e
   ;	
	cmp	byte ptr _taste,116
	je	@@22
	jmp	@6@8690
@@22:
   ;	
   ;			{
   ;				gotoxy(x_cpos, y_cpos+1);cprintf("|");
   ;	
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1481
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				gotoxy(x_cpos+1, y_cpos+1);scanf("%s",&string);
   ;	
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	mov	ax,word ptr _x_cpos
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset _string
	push	ax
	push	ds
	mov	ax,offset s@+1483
	push	ax
	call	far ptr _scanf
	add	sp,8
   ;	
   ;				if(strcmp(string,"end")==0) 
   ;	
	push	ds
	mov	ax,offset s@+1486
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @6@8546
   ;	
   ;				{
   ;					Stream = fopen( "c000n.cad", "w" );fprintf(Stream,"%i\n",n_);fclose(Stream);exit(1);
   ;	
	push	ds
	mov	ax,offset s@+1500
	push	ax
	push	ds
	mov	ax,offset s@+1490
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	word ptr _n_
	push	ds
	mov	ax,offset s@+1502
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,10
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
	mov	ax,1
	push	ax
	call	far ptr _exit
	inc	sp
	inc	sp
@6@8546:
   ;	
   ;				}	
   ;				
   ;				if(strlen(string)==1) symbol_inpt();
   ;	
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strlen
	add	sp,4
	cmp	ax,1
	jne	short @6@8594
	push	cs
	call	near ptr _symbol_inpt
@6@8594:
   ;	
   ;				
   ;				if( strlen(string) != 1) sprintf(tx_string,"%s", string);
   ;	
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strlen
	add	sp,4
	cmp	ax,1
	je	short @6@8642
	push	ds
	mov	ax,offset _string
	push	ax
	push	ds
	mov	ax,offset s@+1506
	push	ax
	push	ds
	mov	ax,offset _tx_string
	push	ax
	call	far ptr _sprintf
	add	sp,12
@6@8642:
   ;	
   ;				
   ;				if(strcmp(string,"neu")==0) sprintf(tx_string," ");
   ;	
	push	ds
	mov	ax,offset s@+1509
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _strcmp
	add	sp,8
	or	ax,ax
	jne	short @6@8690
	push	ds
	mov	ax,offset s@+1513
	push	ax
	push	ds
	mov	ax,offset _tx_string
	push	ax
	call	far ptr _sprintf
	add	sp,8
@6@8690:
   ;	
   ;			}
   ;			
   ;			if(taste == 'p') //-------------------------------------------------------------------------------------------> p_l�scht marki
   ;	
	cmp	byte ptr _taste,112
	jne	short @6@8738
   ;	
   ;			{
   ;				Stream = fopen( "c000.cad", "w" );fclose(Stream);
   ;	
	push	ds
	mov	ax,offset s@+1524
	push	ax
	push	ds
	mov	ax,offset s@+1515
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;				Stream = fopen( "c000n.cad", "w" );fclose(Stream);
   ;	
	push	ds
	mov	ax,offset s@+1536
	push	ax
	push	ds
	mov	ax,offset s@+1526
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;				cad_in=1;n_=0;
   ;	
	mov	word ptr _cad_in,1
	mov	word ptr _n_,0
@6@8738:
   ;	
   ;			}
   ;			if(taste == 'r') cad_(); // test //
   ;	
	cmp	byte ptr _taste,114
	jne	short @6@8786
	push	cs
	call	near ptr _cad_
@6@8786:
   ;	
   ;			if(taste == 'm') //-------------------------------------------------------------------------------------------> m_speichert gr
   ;	
	cmp	byte ptr _taste,109
	je	@@23
	jmp	@6@8954
@@23:
   ;	
   ;			{
   ;				Stream = fopen( "c000.cad", "r" ); mStream = fopen( "c000_m.cad", "w" );
   ;	
	push	ds
	mov	ax,offset s@+1547
	push	ax
	push	ds
	mov	ax,offset s@+1538
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	ds
	mov	ax,offset s@+1560
	push	ax
	push	ds
	mov	ax,offset s@+1549
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-8],ax
	mov	word ptr [bp-6],dx
@6@8834:
   ;	
   ;		
   ;				do
   ;				{
   ;					c_1 = fgetc(Stream); if (index > 2) fputc (c_3,mStream); 
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fgetc
	add	sp,4
	mov	byte ptr _c_1,al
	cmp	word ptr _index,2
	jle	short @6@8882
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	mov	al,byte ptr _c_3
	cbw	
	push	ax
	call	far ptr _fputc
	add	sp,6
@6@8882:
   ;	
   ;					c_3 = c_2; c_2 = c_1; index++;
   ;	
	mov	al,byte ptr _c_2
	mov	byte ptr _c_3,al
	mov	al,byte ptr _c_1
	mov	byte ptr _c_2,al
	inc	word ptr _index
   ;	
   ;			
   ;				}while (feof (Stream) == 0); 
   ;	
	les	bx,dword ptr [bp-4]
	test	word ptr es:[bx+2],32
	je	short @6@8834
   ;	
   ;	 
   ;				fclose( Stream  );	fclose( mStream ); index = 1;
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	call	far ptr _fclose
	add	sp,4
	mov	word ptr _index,1
   ;	
   ;			
   ;				mStream = fopen( "c000n_m.cad", "w" );
   ;	
	push	ds
	mov	ax,offset s@+1574
	push	ax
	push	ds
	mov	ax,offset s@+1562
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-8],ax
	mov	word ptr [bp-6],dx
   ;	
   ;			
   ;				fprintf(mStream,"%i", n_);	
   ;	
	push	word ptr _n_
	push	ds
	mov	ax,offset s@+1576
	push	ax
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	call	far ptr _fprintf
	add	sp,10
   ;	
   ;	 
   ;				fclose( mStream );	index = 1;
   ;	
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	call	far ptr _fclose
	add	sp,4
	mov	word ptr _index,1
@6@8954:
   ;	
   ;			}
   ;			if(taste == 'o') //-------------------------------------------------------------------------------------------> o_�ffnet graph
   ;	
	cmp	byte ptr _taste,111
	je	@@24
	jmp	@6@9170
@@24:
   ;	
   ;			{
   ;				gotoxy(x_cpos, y_cpos+1);cprintf("<");
   ;	
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1579
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				gotoxy(x_cpos+1, y_cpos+1);scanf("%s",&string);
   ;	
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	mov	ax,word ptr _x_cpos
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset _string
	push	ax
	push	ds
	mov	ax,offset s@+1581
	push	ax
	call	far ptr _scanf
	add	sp,8
   ;	
   ;				
   ;				if(fopen( string, "r" ) != NULL)
   ;	
	push	ds
	mov	ax,offset s@+1584
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _fopen
	add	sp,8
	or	ax,dx
	jne	@@25
	jmp	@6@9170
@@25:
   ;	
   ;				{
   ;					sprintf(o_string,"%s", string);
   ;	
	push	ds
	mov	ax,offset _string
	push	ax
	push	ds
	mov	ax,offset s@+1586
	push	ax
	push	ds
	mov	ax,offset _o_string
	push	ax
	call	far ptr _sprintf
	add	sp,12
   ;	
   ;	
   ;					gotoxy(x_cpos, y_cpos+1);cprintf("\xAE               ");
   ;	
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	push	word ptr _x_cpos
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+1589
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(x_cpos+1, y_cpos+1);scanf("%s",&string);
   ;	
	mov	ax,word ptr _y_cpos
	inc	ax
	push	ax
	mov	ax,word ptr _x_cpos
	inc	ax
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset _string
	push	ax
	push	ds
	mov	ax,offset s@+1606
	push	ax
	call	far ptr _scanf
	add	sp,8
   ;	
   ;					
   ;					if(fopen( string, "r" ) != NULL)
   ;	
	push	ds
	mov	ax,offset s@+1609
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _fopen
	add	sp,8
	or	ax,dx
	jne	@@26
	jmp	@6@9170
@@26:
   ;	
   ;					{
   ;						Stream = fopen( o_string, "a" );fprintf(Stream,"\n");fclose(Stream);
   ;	
	push	ds
	mov	ax,offset s@+1611
	push	ax
	push	ds
	mov	ax,offset _o_string
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	ds
	mov	ax,offset s@+1613
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,8
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;						Stream = fopen( string, "r" );fscanf(Stream,"%i",&n_);fclose(Stream);
   ;	
	push	ds
	mov	ax,offset s@+1615
	push	ax
	push	ds
	mov	ax,offset _string
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	ds
	mov	ax,offset _n_
	push	ax
	push	ds
	mov	ax,offset s@+1617
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fscanf
	add	sp,12
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;						
   ;						Stream = fopen( "c000n.cad", "w" );fclose( Stream  );
   ;	
	push	ds
	mov	ax,offset s@+1630
	push	ax
	push	ds
	mov	ax,offset s@+1620
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;						Stream = fopen( "c000n.cad", "w" );fprintf(Stream,"%i", n_);fclose(Stream);
   ;	
	push	ds
	mov	ax,offset s@+1642
	push	ax
	push	ds
	mov	ax,offset s@+1632
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	word ptr _n_
	push	ds
	mov	ax,offset s@+1644
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,10
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;						
   ;						Stream = fopen( "c000.cad", "w" );fclose( Stream  );
   ;	
	push	ds
	mov	ax,offset s@+1656
	push	ax
	push	ds
	mov	ax,offset s@+1647
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
   ;	
   ;						Stream = fopen( o_string, "r" ); mStream = fopen( "c000.cad", "w" );
   ;	
	push	ds
	mov	ax,offset s@+1658
	push	ax
	push	ds
	mov	ax,offset _o_string
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
	push	ds
	mov	ax,offset s@+1669
	push	ax
	push	ds
	mov	ax,offset s@+1660
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-8],ax
	mov	word ptr [bp-6],dx
@6@9050:
   ;	
   ;						
   ;						do
   ;						{
   ;							c_1 = fgetc(Stream); if (index > 2) fputc (c_3,mStream); 
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fgetc
	add	sp,4
	mov	byte ptr _c_1,al
	cmp	word ptr _index,2
	jle	short @6@9098
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	mov	al,byte ptr _c_3
	cbw	
	push	ax
	call	far ptr _fputc
	add	sp,6
@6@9098:
   ;	
   ;							c_3 = c_2; c_2 = c_1; index++;
   ;	
	mov	al,byte ptr _c_2
	mov	byte ptr _c_3,al
	mov	al,byte ptr _c_1
	mov	byte ptr _c_2,al
	inc	word ptr _index
   ;	
   ;				
   ;						}while (feof (Stream) == 0); 
   ;	
	les	bx,dword ptr [bp-4]
	test	word ptr es:[bx+2],32
	je	short @6@9050
   ;	
   ;						
   ;						fprintf(mStream, "\n");
   ;	
	push	ds
	mov	ax,offset s@+1671
	push	ax
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	call	far ptr _fprintf
	add	sp,8
   ;	
   ;						
   ;						fclose( Stream  );	fclose( mStream ); index = 1;
   ;	
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	call	far ptr _fclose
	add	sp,4
	mov	word ptr _index,1
   ;	
   ;					
   ;						sprintf(o_string," ");
   ;	
	push	ds
	mov	ax,offset s@+1673
	push	ax
	push	ds
	mov	ax,offset _o_string
	push	ax
	call	far ptr _sprintf
	add	sp,8
   ;	
   ;						
   ;						cad_in=1;
   ;	
	mov	word ptr _cad_in,1
@6@9170:
	jmp	@6@74
   ;	
   ;					}	
   ;				}
   ;			}
   ;		}	
   ;	}
   ;	
	pop	ds
	mov	sp,bp
	pop	bp
	ret	
_main	endp
CAD_TEXT	ends
CAD_DATA	segment word public 'DATA'
_o_string	label	byte
	db	15 dup (0)
	db	1 dup (0)
_drw0x	label	word
	db	2 dup (0)
_drw0y	label	word
	db	2 dup (0)
_iLauf	label	word
	db	2 dup (0)
_jLauf	label	word
	db	2 dup (0)
_string	label	byte
	db	200 dup (0)
_symb	label	word
	db	4000 dup (0)
_tx_string	label	byte
	db	200 dup (0)
_taste	label	byte
	db	1 dup (0)
	db	1 dup (0)
_cadx_pos	label	word
	db	4000 dup (0)
_cady_pos	label	word
	db	4000 dup (0)
_c_1	label	byte
	db	1 dup (0)
_c_2	label	byte
	db	1 dup (0)
_c_3	label	byte
	db	1 dup (0)
	?debug	C E9
s@	label	byte
	db	'txwnd.txt'
	db	0
	db	'r'
	db	0
	db	-38
	db	0
	db	-60
	db	0
	db	-62
	db	0
	db	'%c'
	db	0
	db	-64
	db	-60
	db	'o'
	db	0
	db	-60
	db	0
	db	-39
	db	0
	db	'.'
	db	0
	db	30
	db	0
	db	-18
	db	0
	db	-37
	db	0
	db	-98
	db	0
	db	'o'
	db	0
	db	'.'
	db	0
	db	' '
	db	0
	db	'+'
	db	0
	db	-38
	db	0
	db	-60
	db	0
	db	-65
	db	0
	db	-77
	db	0
	db	-39
	db	0
	db	-64
	db	0
	db	'/'
	db	0
	db	'\'
	db	0
	db	-80
	db	0
	db	-79
	db	0
	db	-78
	db	0
	db	-36
	db	0
	db	-2
	db	0
	db	-33
	db	0
	db	-76
	db	0
	db	-63
	db	0
	db	'>'
	db	0
	db	'<'
	db	0
	db	-62
	db	0
	db	'^'
	db	0
	db	-61
	db	0
	db	22
	db	0
	db	-59
	db	0
	db	'_'
	db	0
	db	-18
	db	0
	db	'-'
	db	0
	db	-71
	db	0
	db	-69
	db	0
	db	-68
	db	0
	db	-56
	db	0
	db	-55
	db	0
	db	-70
	db	0
	db	-51
	db	0
	db	'='
	db	0
	db	-53
	db	0
	db	-52
	db	0
	db	-50
	db	0
	db	-49
	db	0
	db	-35
	db	0
	db	-54
	db	0
	db	16
	db	0
	db	17
	db	0
	db	30
	db	0
	db	31
	db	0
	db	26
	db	0
	db	27
	db	0
	db	28
	db	0
	db	24
	db	0
	db	25
	db	0
	db	23
	db	0
	db	29
	db	0
	db	-7
	db	0
	db	-9
	db	0
	db	-86
	db	0
	db	-89
	db	0
	db	-87
	db	0
	db	-82
	db	0
	db	-81
	db	0
	db	15
	db	0
	db	14
	db	0
	db	'*'
	db	0
	db	'1'
	db	0
	db	'2'
	db	0
	db	'3'
	db	0
	db	'4'
	db	0
	db	'5'
	db	0
	db	'6'
	db	0
	db	'7'
	db	0
	db	'8'
	db	0
	db	'9'
	db	0
	db	'a'
	db	0
	db	'b'
	db	0
	db	'c'
	db	0
	db	'd'
	db	0
	db	'e'
	db	0
	db	'f'
	db	0
	db	'g'
	db	0
	db	'h'
	db	0
	db	'i'
	db	0
	db	'j'
	db	0
	db	'k'
	db	0
	db	'l'
	db	0
	db	'm'
	db	0
	db	'n'
	db	0
	db	'o'
	db	0
	db	'p'
	db	0
	db	'q'
	db	0
	db	'r'
	db	0
	db	's'
	db	0
	db	't'
	db	0
	db	'u'
	db	0
	db	'v'
	db	0
	db	'w'
	db	0
	db	'x'
	db	0
	db	'y'
	db	0
	db	'z'
	db	0
	db	'A'
	db	0
	db	'B'
	db	0
	db	'C'
	db	0
	db	'D'
	db	0
	db	'E'
	db	0
	db	'F'
	db	0
	db	'G'
	db	0
	db	'H'
	db	0
	db	'I'
	db	0
	db	'J'
	db	0
	db	'K'
	db	0
	db	'L'
	db	0
	db	'M'
	db	0
	db	'N'
	db	0
	db	'O'
	db	0
	db	'P'
	db	0
	db	'Q'
	db	0
	db	'R'
	db	0
	db	'S'
	db	0
	db	'T'
	db	0
	db	'U'
	db	0
	db	'V'
	db	0
	db	'W'
	db	0
	db	'X'
	db	0
	db	'Y'
	db	0
	db	'Z'
	db	0
	db	'!'
	db	0
	db	'"'
	db	0
	db	-89
	db	0
	db	'$'
	db	0
	db	'%'
	db	0
	db	'&'
	db	0
	db	'('
	db	0
	db	')'
	db	0
	db	'{'
	db	0
	db	'}'
	db	0
	db	'['
	db	0
	db	']'
	db	0
	db	'?'
	db	0
	db	-33
	db	0
	db	'~'
	db	0
	db	'#'
	db	0
	db	39
	db	0
	db	-78
	db	0
	db	-77
	db	0
	db	','
	db	0
	db	':'
	db	0
	db	';'
	db	0
	db	-80
	db	0
	db	-10
	db	0
	db	-37
	db	0
	db	-98
	db	0
	db	'o'
	db	0
	db	'.'
	db	0
	db	' '
	db	0
	db	'+'
	db	0
	db	-38
	db	0
	db	-60
	db	0
	db	-65
	db	0
	db	-77
	db	0
	db	-39
	db	0
	db	-64
	db	0
	db	'/'
	db	0
	db	'\'
	db	0
	db	-80
	db	0
	db	-79
	db	0
	db	-78
	db	0
	db	-36
	db	0
	db	-2
	db	0
	db	-33
	db	0
	db	-76
	db	0
	db	-63
	db	0
	db	'>'
	db	0
	db	'<'
	db	0
	db	-62
	db	0
	db	'^'
	db	0
	db	-61
	db	0
	db	22
	db	0
	db	-59
	db	0
	db	'_'
	db	0
	db	-18
	db	0
	db	'-'
	db	0
	db	-71
	db	0
	db	-69
	db	0
	db	-68
	db	0
	db	-56
	db	0
	db	-55
	db	0
	db	-70
	db	0
	db	-51
	db	0
	db	'='
	db	0
	db	-53
	db	0
	db	-52
	db	0
	db	-50
	db	0
	db	-49
	db	0
	db	-35
	db	0
	db	-54
	db	0
	db	16
	db	0
	db	17
	db	0
	db	30
	db	0
	db	31
	db	0
	db	26
	db	0
	db	27
	db	0
	db	28
	db	0
	db	24
	db	0
	db	25
	db	0
	db	23
	db	0
	db	29
	db	0
	db	-7
	db	0
	db	-9
	db	0
	db	-86
	db	0
	db	-89
	db	0
	db	-87
	db	0
	db	-82
	db	0
	db	-81
	db	0
	db	15
	db	0
	db	14
	db	0
	db	'*'
	db	0
	db	'1'
	db	0
	db	'2'
	db	0
	db	'3'
	db	0
	db	'4'
	db	0
	db	'5'
	db	0
	db	'6'
	db	0
	db	'7'
	db	0
	db	'8'
	db	0
	db	'9'
	db	0
	db	'a'
	db	0
	db	'b'
	db	0
	db	'c'
	db	0
	db	'd'
	db	0
	db	'e'
	db	0
	db	'f'
	db	0
	db	'g'
	db	0
	db	'h'
	db	0
	db	'i'
	db	0
	db	'j'
	db	0
	db	'k'
	db	0
	db	'l'
	db	0
	db	'm'
	db	0
	db	'n'
	db	0
	db	'o'
	db	0
	db	'p'
	db	0
	db	'q'
	db	0
	db	'r'
	db	0
	db	's'
	db	0
	db	't'
	db	0
	db	'u'
	db	0
	db	'v'
	db	0
	db	'w'
	db	0
	db	'x'
	db	0
	db	'y'
	db	0
	db	'z'
	db	0
	db	'A'
	db	0
	db	'B'
	db	0
	db	'C'
	db	0
	db	'D'
	db	0
	db	'E'
	db	0
	db	'F'
	db	0
	db	'G'
	db	0
	db	'H'
	db	0
	db	'I'
	db	0
	db	'J'
	db	0
	db	'K'
	db	0
	db	'L'
	db	0
	db	'M'
	db	0
	db	'N'
	db	0
	db	'O'
	db	0
	db	'P'
	db	0
	db	'Q'
	db	0
	db	'R'
	db	0
	db	'S'
	db	0
	db	'T'
	db	0
	db	'U'
	db	0
	db	'V'
	db	0
	db	'W'
	db	0
	db	'X'
	db	0
	db	'Y'
	db	0
	db	'Z'
	db	0
	db	'!'
	db	0
	db	'"'
	db	0
	db	-89
	db	0
	db	'$'
	db	0
	db	'%'
	db	0
	db	'&'
	db	0
	db	'('
	db	0
	db	')'
	db	0
	db	'{'
	db	0
	db	'}'
	db	0
	db	'['
	db	0
	db	']'
	db	0
	db	'?'
	db	0
	db	-33
	db	0
	db	'~'
	db	0
	db	'#'
	db	0
	db	39
	db	0
	db	-78
	db	0
	db	-77
	db	0
	db	','
	db	0
	db	':'
	db	0
	db	';'
	db	0
	db	-80
	db	0
	db	-10
	db	0
	db	'1'
	db	0
	db	'2'
	db	0
	db	'3'
	db	0
	db	'4'
	db	0
	db	'5'
	db	0
	db	'6'
	db	0
	db	'7'
	db	0
	db	'8'
	db	0
	db	'9'
	db	0
	db	'.'
	db	0
	db	'a'
	db	0
	db	'b'
	db	0
	db	'c'
	db	0
	db	'd'
	db	0
	db	'e'
	db	0
	db	'f'
	db	0
	db	'g'
	db	0
	db	'h'
	db	0
	db	'i'
	db	0
	db	'j'
	db	0
	db	'k'
	db	0
	db	'l'
	db	0
	db	'm'
	db	0
	db	'n'
	db	0
	db	'o'
	db	0
	db	'p'
	db	0
	db	'q'
	db	0
	db	'r'
	db	0
	db	's'
	db	0
	db	't'
	db	0
	db	'u'
	db	0
	db	'v'
	db	0
	db	'w'
	db	0
	db	'x'
	db	0
	db	'y'
	db	0
	db	'z'
	db	0
	db	'A'
	db	0
	db	'B'
	db	0
	db	'C'
	db	0
	db	'D'
	db	0
	db	'E'
	db	0
	db	'F'
	db	0
	db	'G'
	db	0
	db	'H'
	db	0
	db	'I'
	db	0
	db	'J'
	db	0
	db	'K'
	db	0
	db	'L'
	db	0
	db	'M'
	db	0
	db	'N'
	db	0
	db	'O'
	db	0
	db	'P'
	db	0
	db	'Q'
	db	0
	db	'R'
	db	0
	db	'S'
	db	0
	db	'T'
	db	0
	db	'U'
	db	0
	db	'V'
	db	0
	db	'W'
	db	0
	db	'X'
	db	0
	db	'Y'
	db	0
	db	'Z'
	db	0
	db	'!'
	db	0
	db	'"'
	db	0
	db	-89
	db	0
	db	'$'
	db	0
	db	'%'
	db	0
	db	'&'
	db	0
	db	'('
	db	0
	db	')'
	db	0
	db	'{'
	db	0
	db	'}'
	db	0
	db	'['
	db	0
	db	']'
	db	0
	db	'?'
	db	0
	db	-33
	db	0
	db	'~'
	db	0
	db	'#'
	db	0
	db	39
	db	0
	db	-78
	db	0
	db	-77
	db	0
	db	','
	db	0
	db	':'
	db	0
	db	';'
	db	0
	db	-80
	db	0
	db	-10
	db	0
	db	' '
	db	0
	db	' '
	db	0
	db	'CAD_(c)_SCHRAUSSER_2009'
	db	0
	db	'c000.cad'
	db	0
	db	'r'
	db	0
	db	'c000n.cad'
	db	0
	db	'r'
	db	0
	db	'%i'
	db	0
	db	'%s'
	db	0
	db	'c000.cad'
	db	0
	db	'a'
	db	0
	db	'%i %i %i'
	db	10
	db	0
	db	'.'
	db	0
	db	'y'
	db	13
	db	10
	db	'%i'
	db	0
	db	'.'
	db	0
	db	' x%i '
	db	0
	db	'.'
	db	0
	db	'c000.cad'
	db	0
	db	'r'
	db	0
	db	'%i%i%i'
	db	0
	db	'c000.cad'
	db	0
	db	'a'
	db	0
	db	'.'
	db	0
	db	'%i %i 4'
	db	10
	db	0
	db	'.'
	db	0
	db	'%i %i 4'
	db	10
	db	0
	db	'.'
	db	0
	db	'%i %i 4'
	db	10
	db	0
	db	'.'
	db	0
	db	'%i %i 4'
	db	10
	db	0
	db	-38
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-65
	db	0
	db	'[P]Cls '
	db	0
	db	'[V]tx:%i'
	db	0
	db	'[B]dsp:%i'
	db	0
	db	'[Z]Symbol'
	db	0
	db	'['
	db	-80
	db	-79
	db	-78
	db	-37
	db	-36
	db	-2
	db	-33
	db	']'
	db	0
	db	'['
	db	-76
	db	-63
	db	'><'
	db	-62
	db	'^'
	db	-61
	db	']'
	db	0
	db	'['
	db	22
	db	-38
	db	-64
	db	-39
	db	-65
	db	-59
	db	-98
	db	']'
	db	0
	db	'[/_'
	db	-60
	db	-18
	db	'-\'
	db	-77
	db	']'
	db	0
	db	'['
	db	-71
	db	-69
	db	-68
	db	-56
	db	-55
	db	-70
	db	-51
	db	']'
	db	0
	db	'[='
	db	-53
	db	-52
	db	-50
	db	-49
	db	-35
	db	-54
	db	']'
	db	0
	db	'['
	db	16
	db	17
	db	30
	db	31
	db	26
	db	27
	db	28
	db	']'
	db	0
	db	'['
	db	24
	db	25
	db	23
	db	29
	db	-7
	db	-9
	db	-86
	db	']'
	db	0
	db	'['
	db	-89
	db	-87
	db	-82
	db	-81
	db	15
	db	14
	db	'*]'
	db	0
	db	-64
	db	-60
	db	'o'
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-39
	db	0
	db	-38
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-65
	db	0
	db	'x:%i y:%i'
	db	0
	db	-2
	db	'[G]Grd#'
	db	-70
	db	-51
	db	0
	db	' [G]Grd  '
	db	0
	db	-2
	db	'[F]Linie '
	db	0
	db	' [F]Linie '
	db	0
	db	' [C]Wnd  '
	db	0
	db	-2
	db	'[C]Wnd  '
	db	0
	db	'[.]Ende  '
	db	0
	db	-64
	db	-60
	db	'o'
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-60
	db	-39
	db	0
	db	-38
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
	db	-65
	db	0
	db	'|Q||W||E| |H|. '
	db	0
	db	'|A| * |D| |U|Fix '
	db	0
	db	'|Y||S||X| |J|Ldrw'
	db	0
	db	'|K|Gd'
	db	-70
	db	'    |L|Gd'
	db	-51
	db	0
	db	'|M|mem    |O|opn'
	db	0
	db	'[T]Cmnd   |+|    i'
	db	0
	db	-64
	db	-60
	db	'o'
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
	db	-39
	db	0
	db	-38
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
	db	-65
	db	0
	db	-64
	db	-60
	db	'o'
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
	db	'i'
	db	0
	db	30
	db	0
	db	-18
	db	0
	db	29
	db	0
	db	'c000n.cad'
	db	0
	db	'w'
	db	0
	db	'%i'
	db	10
	db	0
	db	'c000.cad'
	db	0
	db	'w'
	db	0
	db	'c000.cad'
	db	0
	db	'a'
	db	0
	db	'%i %i %i'
	db	10
	db	0
	db	'|'
	db	0
	db	'%s'
	db	0
	db	'end'
	db	0
	db	'c000n.cad'
	db	0
	db	'w'
	db	0
	db	'%i'
	db	10
	db	0
	db	'%s'
	db	0
	db	'neu'
	db	0
	db	' '
	db	0
	db	'c000.cad'
	db	0
	db	'w'
	db	0
	db	'c000n.cad'
	db	0
	db	'w'
	db	0
	db	'c000.cad'
	db	0
	db	'r'
	db	0
	db	'c000_m.cad'
	db	0
	db	'w'
	db	0
	db	'c000n_m.cad'
	db	0
	db	'w'
	db	0
	db	'%i'
	db	0
	db	'<'
	db	0
	db	'%s'
	db	0
	db	'r'
	db	0
	db	'%s'
	db	0
	db	-82
	db	'               '
	db	0
	db	'%s'
	db	0
	db	'r'
	db	0
	db	'a'
	db	0
	db	10
	db	0
	db	'r'
	db	0
	db	'%i'
	db	0
	db	'c000n.cad'
	db	0
	db	'w'
	db	0
	db	'c000n.cad'
	db	0
	db	'w'
	db	0
	db	'%i'
	db	0
	db	'c000.cad'
	db	0
	db	'w'
	db	0
	db	'r'
	db	0
	db	'c000.cad'
	db	0
	db	'w'
	db	0
	db	10
	db	0
	db	' '
	db	0
CAD_DATA	ends
CAD_TEXT	segment byte public 'CODE'
CAD_TEXT	ends
	extrn	_fopen:far
	public	_symbol_inpt
	public	_n_
	extrn	_textcolor:far
	public	_c_3
	public	_c_2
	public	_c_1
	public	_f3
	public	_cady_pos
	public	_cadx_pos
	public	_index
	public	_drw
	public	_grid
	public	_drw_m
	public	_wnd3
	public	_symbole
	public	_grdx
	public	_grdy
	extrn	__setcursortype:far
	public	_taste
	public	_cadini
	public	_cad_in
	public	_fix1
	public	_tx_string
	public	_f2
	public	_disp
	public	_tx_disp2
	public	_symb
	extrn	_sprintf:far
	public	_tx_disp
	extrn	_fprintf:far
	public	_symb_
	extrn	_cprintf:far
	extrn	_getch:far
	public	_main
	public	_cad_
	public	_lin
	public	_fix
	public	_string
	extrn	_strcmp:far
	public	_set
	public	_jLauf
	public	_iLauf
	extrn	_fputc:far
	public	_drw0y
	public	_drw0x
	extrn	_strlen:far
	public	_f1
	extrn	_clrscr:far
	public	_o_string
	extrn	_exit:far
	extrn	_gotoxy:far
	extrn	_fclose:far
	public	_y_3pos
	public	_y_2pos
	public	_y_cpos
	public	_x_3pos
	public	_x_2pos
	public	_x_cpos
	extrn	_textbackground:far
	extrn	_fscanf:far
	extrn	_fgetc:far
	public	_cursor_symbole
	public	_y_pos
	public	_x_pos
	extrn	_scanf:far
	public	_symbol_taste
	end 
