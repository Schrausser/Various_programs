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
	?debug	S "dice.c"
	?debug	C E9EA7A8F3A06646963652E63
	?debug	C E920105C1613433A5C54435C494E434C5544455C646F732E68
	?debug	C E920105C1615433A5C54435C494E434C5544455C737464696F2E68
	?debug	C E920105C1616433A5C54435C494E434C5544455C7374646C69622E+
	?debug	C 68
	?debug	C E920105C1614433A5C54435C494E434C5544455C74696D652E68
	?debug	C E920105C1614433A5C54435C494E434C5544455C6D6174682E68
	?debug	C E920105C1615433A5C54435C494E434C5544455C636F6E696F2E68
DICE_TEXT	segment byte public 'CODE'
DICE_TEXT	ends
	assume	cs:DICE_TEXT,ds:DICE_DATA
DICE_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
b@	label	byte
b@w	label	word
DICE_DATA	ends
DICE_TEXT	segment byte public 'CODE'
   ;	
   ;	double qzufall(double seed, double min, double max)
   ;	
	assume	cs:DICE_TEXT
_qzufall	proc	far
	push	bp
	mov	bp,sp
	sub	sp,28
	push	ds
	mov	ax,DICE_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		double SIGMA = 34.0/45;
   ;	
	FLD	qword ptr s@
	FSTP	qword ptr [bp-8]
   ;	
   ;	
   ;		fn_erg =		   10*( pow(seed,SIGMA) - floor( pow(seed,SIGMA) ) ) 
   ;	
   ;	
   ;			      - floor( 10*( pow(seed,SIGMA) - floor( pow(seed,SIGMA) ) ) );
   ;	
	FLD	qword ptr [bp-8]
	add	sp,65528
	FSTP	qword ptr [bp-38]
	FLD	qword ptr [bp+6]
	add	sp,65528
	FSTP	qword ptr [bp-46]
	FWAIT	
	call	far ptr _pow
	add	sp,16
	FSTP	tbyte ptr [bp-18]
	FLD	qword ptr [bp-8]
	add	sp,65528
	FSTP	qword ptr [bp-38]
	FLD	qword ptr [bp+6]
	add	sp,65528
	FSTP	qword ptr [bp-46]
	FWAIT	
	call	far ptr _pow
	add	sp,16
	add	sp,65528
	FSTP	qword ptr [bp-38]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FLD	tbyte ptr [bp-18]
	FSUBR	
	FMUL	dword ptr s@+8
	FSTP	tbyte ptr [bp-18]
	FLD	qword ptr [bp-8]
	add	sp,65528
	FSTP	qword ptr [bp-38]
	FLD	qword ptr [bp+6]
	add	sp,65528
	FSTP	qword ptr [bp-46]
	FWAIT	
	call	far ptr _pow
	add	sp,16
	FSTP	tbyte ptr [bp-28]
	FLD	qword ptr [bp-8]
	add	sp,65528
	FSTP	qword ptr [bp-38]
	FLD	qword ptr [bp+6]
	add	sp,65528
	FSTP	qword ptr [bp-46]
	FWAIT	
	call	far ptr _pow
	add	sp,16
	add	sp,65528
	FSTP	qword ptr [bp-38]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FLD	tbyte ptr [bp-28]
	FSUBR	
	FMUL	dword ptr s@+8
	add	sp,65528
	FSTP	qword ptr [bp-38]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FLD	tbyte ptr [bp-18]
	FSUBR	
	FSTP	qword ptr _fn_erg
   ;	
   ;		
   ;		fn_erg= min + (max-min)*fn_erg;
   ;	
	FLD	qword ptr [bp+22]
	FSUB	qword ptr [bp+14]
	FMUL	qword ptr _fn_erg
	FADD	qword ptr [bp+14]
	FSTP	qword ptr _fn_erg
   ;	
   ;		
   ;		return fn_erg;
   ;	
	FLD	qword ptr _fn_erg
	jmp	short @1@50
@1@50:
   ;	
   ;	};
   ;	
	pop	ds
	mov	sp,bp
	pop	bp
	ret	
_qzufall	endp
   ;	
   ;	void main() 
   ;	
	assume	cs:DICE_TEXT
_main	proc	far
	push	bp
	mov	bp,sp
	sub	sp,16
	push	si
	push	di
	push	ds
	mov	ax,DICE_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		int iLauf, jLauf, kLauf;
   ;		char taste;
   ;	
   ;		double in_seed;
   ;		
   ;		in_seed=(time(0)-1234567890); 
   ;	
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	call	far ptr _time
	add	sp,4
	add	ax,64814
	adc	dx,46697
	mov	word ptr [bp-16],ax
	mov	word ptr [bp-14],dx
	FILD	dword ptr [bp-16]
	FSTP	qword ptr [bp-12]
   ;	
   ;	
   ;		_setcursortype(_NOCURSOR);
   ;	
	xor	ax,ax
	push	ax
	FWAIT	
	call	far ptr __setcursortype
	inc	sp
	inc	sp
@2@50:
   ;	
   ;		
   ;		while(1)
   ;		{
   ;			for (iLauf=0; iLauf<=65; iLauf+=5)
   ;	
	xor	si,si
	jmp	@2@914
@2@74:
   ;	
   ;			{
   ;				if(iLauf==65) iLauf=54;
   ;	
	cmp	si,65
	jne	short @2@122
	mov	si,54
@2@122:
   ;	
   ;				
   ;				qzufall(in_seed,1,7); in_seed = fn_erg;
   ;	
	FLD	dword ptr s@+12
	add	sp,65528
	FSTP	qword ptr [bp-30]
	FLD1	
	FWAIT	
	add	sp,65528
	FSTP	qword ptr [bp-38]
	FLD	qword ptr [bp-12]
	add	sp,65528
	FSTP	qword ptr [bp-46]
	FWAIT	
	push	cs
	call	near ptr _qzufall
	FSTP	st(0)	
	add	sp,24
	FLD	qword ptr _fn_erg
	FSTP	qword ptr [bp-12]
   ;	
   ;				
   ;				textcolor(7);textbackground(6);
   ;	
	mov	ax,7
	push	ax
	FWAIT	
	call	far ptr _textcolor
	inc	sp
	inc	sp
	mov	ax,6
	push	ax
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;				clrscr();
   ;	
	call	far ptr _clrscr
   ;	
   ;				gotoxy(1, 1);cprintf("%f", fn_erg);
   ;	
	mov	ax,1
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	FLD	qword ptr _fn_erg
	add	sp,65528
	FSTP	qword ptr [bp-30]
	push	ds
	mov	ax,offset s@+16
	push	ax
	FWAIT	
	call	far ptr _cprintf
	add	sp,12
   ;	
   ;				textcolor(0);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;				gotoxy(66-iLauf, 6);
   ;	
	mov	ax,6
	push	ax
	mov	ax,66
	sub	ax,si
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;				for(jLauf=1; jLauf<=9; jLauf++)cprintf("\xB0");
   ;	
	mov	di,1
	jmp	short @2@194
@2@146:
	push	ds
	mov	ax,offset s@+19
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	di
@2@194:
	cmp	di,9
	jle	short @2@146
   ;	
   ;				
   ;				for(kLauf=1; kLauf<=9; kLauf++)
   ;	
	mov	word ptr [bp-2],1
	jmp	@2@506
@2@242:
   ;	
   ;				{	
   ;					textcolor(0);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;					gotoxy(64-iLauf, 6+kLauf);
   ;	
	mov	ax,word ptr [bp-2]
	add	ax,6
	push	ax
	mov	ax,64
	sub	ax,si
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					
   ;					for(jLauf=1; jLauf<=11; jLauf++)cprintf("\xDB");
   ;	
	mov	di,1
	jmp	short @2@314
@2@266:
	push	ds
	mov	ax,offset s@+21
	push	ax
	call	far ptr _cprintf
	add	sp,4
	inc	di
@2@314:
	cmp	di,11
	jle	short @2@266
   ;	
   ;					if(kLauf==1){gotoxy(64-iLauf, 6+1);cprintf("\xDC");gotoxy(64-iLauf+10, 6+1);cprintf("\xDC");}
   ;	
	cmp	word ptr [bp-2],1
	jne	short @2@386
	mov	ax,7
	push	ax
	mov	ax,64
	sub	ax,si
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+23
	push	ax
	call	far ptr _cprintf
	add	sp,4
	mov	ax,7
	push	ax
	mov	ax,64
	sub	ax,si
	add	ax,10
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+25
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@386:
   ;	
   ;					if(kLauf==9){gotoxy(64-iLauf, 6+9);cprintf("\xDF");gotoxy(64-iLauf+10, 6+9);cprintf("\xDF");}
   ;	
	cmp	word ptr [bp-2],9
	jne	short @2@434
	mov	ax,15
	push	ax
	mov	ax,64
	sub	ax,si
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+27
	push	ax
	call	far ptr _cprintf
	add	sp,4
	mov	ax,15
	push	ax
	mov	ax,64
	sub	ax,si
	add	ax,10
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+29
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@434:
   ;	
   ;					if(kLauf<9){cprintf("\xB1\xB0");}
   ;	
	cmp	word ptr [bp-2],9
	jge	short @2@482
	push	ds
	mov	ax,offset s@+31
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@482:
	inc	word ptr [bp-2]
@2@506:
	cmp	word ptr [bp-2],9
	jg	@@0
	jmp	@2@242
@@0:
   ;	
   ;				
   ;				}
   ;				gotoxy(64-iLauf+12, 6+8); cprintf(" ");
   ;	
	mov	ax,14
	push	ax
	mov	ax,64
	sub	ax,si
	add	ax,12
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+34
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;	
   ;				textcolor(7);
   ;	
	mov	ax,7
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;				
   ;				if(floor(fn_erg) == 1)
   ;	
	FLD	qword ptr _fn_erg
	add	sp,65528
	FSTP	qword ptr [bp-30]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FLD1	
	FCOMPP
	FSTSW	word ptr [bp-16]
	FWAIT	
	mov	ax,word ptr [bp-16]
	sahf	
	jne	short @2@578
   ;	
   ;				{
   ;					gotoxy((63-iLauf)+6, 11); cprintf("\xDB");
   ;	
	mov	ax,11
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,6
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+36
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@578:
   ;	
   ;				}
   ;				if(floor(fn_erg) == 2)
   ;	
	FLD	qword ptr _fn_erg
	add	sp,65528
	FSTP	qword ptr [bp-30]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FCOMP	dword ptr s@+38
	FSTSW	word ptr [bp-16]
	FWAIT	
	mov	ax,word ptr [bp-16]
	sahf	
	jne	short @2@626
   ;	
   ;				{	
   ;					gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
   ;	
	mov	ax,8
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+42
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 14); cprintf("\xDB");
   ;	
	mov	ax,14
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+44
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@626:
   ;	
   ;				}
   ;				if(floor(fn_erg) == 3)
   ;	
	FLD	qword ptr _fn_erg
	add	sp,65528
	FSTP	qword ptr [bp-30]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FCOMP	dword ptr s@+46
	FSTSW	word ptr [bp-16]
	FWAIT	
	mov	ax,word ptr [bp-16]
	sahf	
	jne	short @2@674
   ;	
   ;				{	
   ;					gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
   ;	
	mov	ax,8
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+50
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+6, 11); cprintf("\xDB");
   ;	
	mov	ax,11
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,6
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+52
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 14); cprintf("\xDB");	
   ;	
	mov	ax,14
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+54
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@674:
   ;	
   ;				}
   ;				if(floor(fn_erg) == 4)
   ;	
	FLD	qword ptr _fn_erg
	add	sp,65528
	FSTP	qword ptr [bp-30]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FCOMP	dword ptr s@+56
	FSTSW	word ptr [bp-16]
	FWAIT	
	mov	ax,word ptr [bp-16]
	sahf	
	je	@@1
	jmp	@2@722
@@1:
   ;	
   ;				{
   ;					gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
   ;	
	mov	ax,8
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+60
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 8); cprintf("\xDB");
   ;	
	mov	ax,8
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+62
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+3, 14); cprintf("\xDB");
   ;	
	mov	ax,14
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+64
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 14); cprintf("\xDB");		
   ;	
	mov	ax,14
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+66
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@722:
   ;	
   ;				}
   ;				if(floor(fn_erg) == 5)
   ;	
	FLD	qword ptr _fn_erg
	add	sp,65528
	FSTP	qword ptr [bp-30]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FCOMP	dword ptr s@+68
	FSTSW	word ptr [bp-16]
	FWAIT	
	mov	ax,word ptr [bp-16]
	sahf	
	je	@@2
	jmp	@2@770
@@2:
   ;	
   ;				{
   ;					gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
   ;	
	mov	ax,8
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+72
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 8); cprintf("\xDB");
   ;	
	mov	ax,8
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+74
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+6, 11); cprintf("\xDB");
   ;	
	mov	ax,11
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,6
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+76
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+3, 14); cprintf("\xDB");
   ;	
	mov	ax,14
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+78
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 14); cprintf("\xDB");
   ;	
	mov	ax,14
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+80
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@770:
   ;	
   ;				}
   ;				if(floor(fn_erg) == 6)
   ;	
	FLD	qword ptr _fn_erg
	add	sp,65528
	FSTP	qword ptr [bp-30]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FCOMP	dword ptr s@+82
	FSTSW	word ptr [bp-16]
	FWAIT	
	mov	ax,word ptr [bp-16]
	sahf	
	je	@@3
	jmp	@2@818
@@3:
   ;	
   ;				{
   ;					gotoxy((63-iLauf)+3, 8); cprintf("\xDB");
   ;	
	mov	ax,8
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+86
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 8); cprintf("\xDB");
   ;	
	mov	ax,8
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+88
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+3, 11); cprintf("\xDB");
   ;	
	mov	ax,11
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+90
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 11); cprintf("\xDB");
   ;	
	mov	ax,11
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+92
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+3, 14); cprintf("\xDB");
   ;	
	mov	ax,14
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,3
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+94
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy((63-iLauf)+9, 14); cprintf("\xDB");
   ;	
	mov	ax,14
	push	ax
	mov	ax,63
	sub	ax,si
	add	ax,9
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+96
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@818:
   ;	
   ;				}
   ;				
   ;				if(iLauf==54) iLauf=65;
   ;	
	cmp	si,54
	jne	short @2@866
	mov	si,65
@2@866:
   ;	
   ;				delay(100);
   ;	
	mov	ax,100
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
	add	si,5
@2@914:
	cmp	si,65
	jg	@@4
	jmp	@2@74
@@4:
   ;	
   ;	
   ;			}
   ;			gotoxy(1, 1);printf("%f", fn_erg);
   ;	
	mov	ax,1
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	FLD	qword ptr _fn_erg
	add	sp,65528
	FSTP	qword ptr [bp-30]
	push	ds
	mov	ax,offset s@+98
	push	ax
	FWAIT	
	call	far ptr _printf
	add	sp,12
   ;	
   ;			taste=getch();
   ;	
	call	far ptr _getch
	mov	byte ptr [bp-3],al
   ;	
   ;			if (taste == 'q') exit(1);
   ;	
	cmp	byte ptr [bp-3],113
	jne	short @2@986
	mov	ax,1
	push	ax
	call	far ptr _exit
	inc	sp
	inc	sp
@2@986:
   ;	
   ;			textcolor(7);clrscr();
   ;	
	mov	ax,7
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	call	far ptr _clrscr
   ;	
   ;			gotoxy(1, 1);cprintf("DICE ...");
   ;	
	mov	ax,1
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+101
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;			delay(450);
   ;	
	mov	ax,450
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
	jmp	@2@50
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
_main	endp
DICE_TEXT	ends
DICE_DATA	segment word public 'DATA'
_fn_erg	label	qword
	db	8 dup (?)
	?debug	C E9
s@	label	byte
	db	-40
	db	-126
	db	'-'
	db	-40
	db	-126
	db	'-'
	db	-24
	db	'?'
	db	0
	db	0
	db	' A'
	db	0
	db	0
	db	-32
	db	'@%f'
	db	0
	db	-80
	db	0
	db	-37
	db	0
	db	-36
	db	0
	db	-36
	db	0
	db	-33
	db	0
	db	-33
	db	0
	db	-79
	db	-80
	db	0
	db	' '
	db	0
	db	-37
	db	0
	db	0
	db	0
	db	0
	db	'@'
	db	-37
	db	0
	db	-37
	db	0
	db	0
	db	0
	db	'@@'
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	0
	db	0
	db	-128
	db	'@'
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	0
	db	0
	db	-96
	db	'@'
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	0
	db	0
	db	-64
	db	'@'
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	-37
	db	0
	db	'%f'
	db	0
	db	'DICE ...'
	db	0
DICE_DATA	ends
DICE_TEXT	segment byte public 'CODE'
DICE_TEXT	ends
	extrn	_pow:far
	public	_qzufall
	extrn	_printf:far
	public	_fn_erg
	extrn	_textcolor:far
	extrn	__setcursortype:far
	extrn	_time:far
	extrn	_cprintf:far
	extrn	_getch:far
	public	_main
	extrn	_delay:far
	extrn	_floor:far
	extrn	_clrscr:far
	extrn	_exit:far
	extrn	_gotoxy:far
	extrn	_textbackground:far
	end
