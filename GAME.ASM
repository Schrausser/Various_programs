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
	?debug	S "game.c"
	?debug	C E96D2B893A0667616D652E63
	?debug	C E920105C1613433A5C54435C494E434C5544455C646F732E68
	?debug	C E920105C1615433A5C54435C494E434C5544455C737464696F2E68
	?debug	C E920105C1616433A5C54435C494E434C5544455C7374646C69622E+
	?debug	C 68
	?debug	C E920105C1614433A5C54435C494E434C5544455C74696D652E68
	?debug	C E920105C1614433A5C54435C494E434C5544455C6D6174682E68
	?debug	C E920105C1615433A5C54435C494E434C5544455C636F6E696F2E68
GAME_TEXT	segment byte public 'CODE'
GAME_TEXT	ends
	assume	cs:GAME_TEXT,ds:GAME_DATA
GAME_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
b@	label	byte
b@w	label	word
GAME_DATA	ends
GAME_TEXT	segment byte public 'CODE'
   ;	
   ;	double qzufall(double min, double max)//---------------------------------------> Quasizufallszahl 
   ;	
	assume	cs:GAME_TEXT
_qzufall	proc	far
	push	bp
	mov	bp,sp
	sub	sp,40
	push	ds
	mov	ax,GAME_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		double seed, SIGMA = 34.0/45;
   ;	
	FLD	qword ptr s@
	FSTP	qword ptr [bp-16]
   ;	
   ;		
   ;		seed=(time(0)-1234567890); 
   ;	
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	FWAIT	
	call	far ptr _time
	add	sp,4
	add	ax,64814
	adc	dx,46697
	mov	word ptr [bp-20],ax
	mov	word ptr [bp-18],dx
	FILD	dword ptr [bp-20]
	FSTP	qword ptr [bp-8]
   ;	
   ;		
   ;		fn_erg =		   10*( pow(seed,SIGMA) - floor( pow(seed,SIGMA) ) ) 
   ;	
   ;	
   ;			      - floor( 10*( pow(seed,SIGMA) - floor( pow(seed,SIGMA) ) ) );
   ;	
	FLD	qword ptr [bp-16]
	add	sp,65528
	FSTP	qword ptr [bp-50]
	FLD	qword ptr [bp-8]
	add	sp,65528
	FSTP	qword ptr [bp-58]
	FWAIT	
	call	far ptr _pow
	add	sp,16
	FSTP	tbyte ptr [bp-30]
	FLD	qword ptr [bp-16]
	add	sp,65528
	FSTP	qword ptr [bp-50]
	FLD	qword ptr [bp-8]
	add	sp,65528
	FSTP	qword ptr [bp-58]
	FWAIT	
	call	far ptr _pow
	add	sp,16
	add	sp,65528
	FSTP	qword ptr [bp-50]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FLD	tbyte ptr [bp-30]
	FSUBR	
	FMUL	dword ptr s@+8
	FSTP	tbyte ptr [bp-30]
	FLD	qword ptr [bp-16]
	add	sp,65528
	FSTP	qword ptr [bp-50]
	FLD	qword ptr [bp-8]
	add	sp,65528
	FSTP	qword ptr [bp-58]
	FWAIT	
	call	far ptr _pow
	add	sp,16
	FSTP	tbyte ptr [bp-40]
	FLD	qword ptr [bp-16]
	add	sp,65528
	FSTP	qword ptr [bp-50]
	FLD	qword ptr [bp-8]
	add	sp,65528
	FSTP	qword ptr [bp-58]
	FWAIT	
	call	far ptr _pow
	add	sp,16
	add	sp,65528
	FSTP	qword ptr [bp-50]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FLD	tbyte ptr [bp-40]
	FSUBR	
	FMUL	dword ptr s@+8
	add	sp,65528
	FSTP	qword ptr [bp-50]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FLD	tbyte ptr [bp-30]
	FSUBR	
	FSTP	qword ptr _fn_erg
   ;	
   ;		
   ;		fn_erg= min + (max-min)*fn_erg;
   ;	
	FLD	qword ptr [bp+14]
	FSUB	qword ptr [bp+6]
	FMUL	qword ptr _fn_erg
	FADD	qword ptr [bp+6]
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
   ;	void main() //-----------------------------------------------------------------> Hauptprogramm
   ;	
	assume	cs:GAME_TEXT
_main	proc	far
	push	bp
	mov	bp,sp
	sub	sp,60
	push	si
	push	di
	push	ds
	mov	ax,GAME_DATA
	mov	ds,ax
   ;	
   ;	{
   ;		FILE *outStream;
   ;	
   ;		int iLauf, mode, y1=0,
   ;	
	mov	word ptr [bp-10],0
   ;	
   ;	  
   ;				x_pos, fre_x_pos, fre_x2_pos, x1_pos, x2_pos,  //------------------> x koordinaten            
   ;				y_pos, fre_y_pos, fre_y2_pos, y1_pos, y2_pos,  //------------------> y koordinaten 
   ;				       fre1=0,    fre2=0,     re=0,   re1=0,   //------------------> inikatoren
   ;	
	mov	word ptr [bp-28],0
	mov	word ptr [bp-30],0
	mov	word ptr [bp-32],0
	mov	word ptr [bp-34],0
   ;	
   ;				       ind1=0,    ind3=0,     ind=0,  ind2=0,
   ;	
	mov	word ptr [bp-36],0
	mov	word ptr [bp-38],0
	mov	word ptr [bp-40],0
	mov	word ptr [bp-42],0
   ;	
   ;				                              v1=0,   v11=0,
   ;	
	mov	word ptr [bp-44],0
	mov	word ptr [bp-46],0
   ;	
   ;				                              weg=1,  weg1=-1;
   ;	
	mov	word ptr [bp-48],1
	mov	word ptr [bp-50],65535
   ;	
   ;		double zf_pos;         		       
   ;		
   ;		char taste, mode_;
   ;		
   ;		x_pos = 40;  x1_pos = 5;  x2_pos = 72; //----------------------------------> x koordinaten initialisierung     	
   ;	
	mov	word ptr [bp-12],40
	mov	word ptr [bp-18],5
	mov	word ptr [bp-20],72
   ;	
   ;		y_pos = 41;  y1_pos = 7;  y2_pos = 8;  //----------------------------------> y koordinaten initialisierung
   ;	
	mov	word ptr [bp-22],41
	mov	di,7
	mov	si,8
   ;	
   ;		
   ;	
   ;		clrscr();
   ;	
	call	far ptr _clrscr
   ;	
   ;		_setcursortype(_NOCURSOR);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr __setcursortype
	inc	sp
	inc	sp
   ;	
   ;		
   ;		//-------------------------------------------------------------------------> intro
   ;		delay (2000);textcolor(DARKGRAY);printf(" -  ");clrscr();
   ;	
	mov	ax,2000
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
	mov	ax,8
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	push	ds
	mov	ax,offset s@+12
	push	ax
	call	far ptr _printf
	add	sp,4
	call	far ptr _clrscr
   ;	
   ;	
   ;		gotoxy(1, 1);
   ;	
	mov	ax,1
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;		printf("GAME by Dietmar Schrausser, (c) SCHRAUSSER 2009\ncompiled %s @ %s\n\n[0]BEGIN\n[1]DEMO", __DATE__, __TIME__);
   ;	
	push	ds
	mov	ax,offset s@+112
	push	ax
	push	ds
	mov	ax,offset s@+100
	push	ax
	push	ds
	mov	ax,offset s@+17
	push	ax
	call	far ptr _printf
	add	sp,12
   ;	
   ;	
   ;		mode_=getch();//-----------------------------------------------------------> modusdefinition
   ;	
	call	far ptr _getch
	mov	byte ptr [bp-60],al
   ;	
   ;	
   ;		if (mode_ != '0' && mode_ != '1') exit(1);
   ;	
	cmp	byte ptr [bp-60],48
	je	short @2@98
	cmp	byte ptr [bp-60],49
	je	short @2@98
	mov	ax,1
	push	ax
	call	far ptr _exit
	inc	sp
	inc	sp
@2@98:
   ;	
   ;		if (mode_ == '0' ) mode= 0;if (mode_ == '1' ) mode= 1;
   ;	
	cmp	byte ptr [bp-60],48
	jne	short @2@146
	mov	word ptr [bp-8],0
@2@146:
	cmp	byte ptr [bp-60],49
	jne	short @2@194
	mov	word ptr [bp-8],1
@2@194:
   ;	
   ;		
   ;		delay (1000);clrscr();
   ;	
	mov	ax,1000
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
	call	far ptr _clrscr
   ;	
   ;		
   ;		gotoxy(x_pos, y_pos);
   ;	
	push	word ptr [bp-22]
	push	word ptr [bp-12]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;		printf(" \x1E ");delay (1000);
   ;	
	push	ds
	mov	ax,offset s@+121
	push	ax
	call	far ptr _printf
	add	sp,4
	mov	ax,1000
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
   ;	
   ;		
   ;		gotoxy(8, 38);
   ;	
	mov	ax,38
	push	ax
	mov	ax,8
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;		for(iLauf=1; iLauf<=65; iLauf++) {cprintf("_");delay(30);} delay(1000);
   ;	
	mov	word ptr [bp-6],1
	jmp	short @2@266
@2@218:
	push	ds
	mov	ax,offset s@+125
	push	ax
	call	far ptr _cprintf
	add	sp,4
	mov	ax,30
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
	inc	word ptr [bp-6]
@2@266:
	cmp	word ptr [bp-6],65
	jle	short @2@218
	mov	ax,1000
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
   ;	
   ;		
   ;		gotoxy(70, 45);//----------------------------------------------------------> modusabh�ngige datenstrom initialisierung 
   ;	
	mov	ax,45
	push	ax
	mov	ax,70
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;		if(mode == 0 ){cprintf("BEGIN");getch();clrscr();outStream = fopen( "game_mat.rix", "w" );}
   ;	
	cmp	word ptr [bp-8],0
	jne	short @2@338
	push	ds
	mov	ax,offset s@+127
	push	ax
	call	far ptr _cprintf
	add	sp,4
	call	far ptr _getch
	call	far ptr _clrscr
	push	ds
	mov	ax,offset s@+146
	push	ax
	push	ds
	mov	ax,offset s@+133
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
@2@338:
   ;	
   ;		if(mode == 1 ){cprintf("DEMO");delay (2000);clrscr();outStream = fopen( "game_mat.rix", "r" );}
   ;	
	cmp	word ptr [bp-8],1
	jne	short @2@386
	push	ds
	mov	ax,offset s@+148
	push	ax
	call	far ptr _cprintf
	add	sp,4
	mov	ax,2000
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
	call	far ptr _clrscr
	push	ds
	mov	ax,offset s@+166
	push	ax
	push	ds
	mov	ax,offset s@+153
	push	ax
	call	far ptr _fopen
	add	sp,8
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],dx
@2@386:
	jmp	@2@2234
@2@410:
   ;	
   ;		
   ;		
   ;		while(1)//------------------------------------------------------------------| hauptschleife
   ;		{
   ;			while (!kbhit())//-----------------------------------------------------> spielschleife
   ;			{ 			
   ;				if(mode == 1 )//---------------------------------------------------> DEMO modus
   ;	
	cmp	word ptr [bp-8],1
	jne	short @2@458
   ;	
   ;				fscanf(outStream,"%i %i %i %i %i %i %i %lf\n", //------------------> koordinaten�bernahme aus game_mat.rix
   ;	
   ;	
   ;				
   ;				&x_pos, &fre1, &fre_y_pos, &fre_x_pos, &fre2, &fre_y2_pos, &fre_x2_pos, &zf_pos);
   ;	
	push	ss
	lea	ax,word ptr [bp-58]
	push	ax
	push	ss
	lea	ax,word ptr [bp-16]
	push	ax
	push	ss
	lea	ax,word ptr [bp-26]
	push	ax
	push	ss
	lea	ax,word ptr [bp-30]
	push	ax
	push	ss
	lea	ax,word ptr [bp-14]
	push	ax
	push	ss
	lea	ax,word ptr [bp-24]
	push	ax
	push	ss
	lea	ax,word ptr [bp-28]
	push	ax
	push	ss
	lea	ax,word ptr [bp-12]
	push	ax
	push	ds
	mov	ax,offset s@+168
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fscanf
	add	sp,40
@2@458:
   ;	
   ;				
   ;				gotoxy(70, 45);//--------------------------------------------------> trefferz�hler
   ;	
	mov	ax,45
	push	ax
	mov	ax,70
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;				textcolor(DARKGRAY);textbackground(BLACK);cprintf("%i", y1);
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
	push	word ptr [bp-10]
	push	ds
	mov	ax,offset s@+194
	push	ax
	call	far ptr _cprintf
	add	sp,6
   ;	
   ;				
   ;				gotoxy(8, 38);
   ;	
	mov	ax,38
	push	ax
	mov	ax,8
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;				cprintf("_________________________________________________________________");
   ;	
	push	ds
	mov	ax,offset s@+197
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;	
   ;				//-----------------------------------------------------------------> basis
   ;				textcolor(LIGHTGRAY);textbackground(BLACK);
   ;	
	mov	ax,7
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
   ;				gotoxy(x_pos, y_pos); cprintf(" \x1E ");
   ;	
	push	word ptr [bp-22]
	push	word ptr [bp-12]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+263
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				
   ;				
   ;				//-----------------------------------------------------------------> feuer1
   ;				if(fre1==1)
   ;	
	cmp	word ptr [bp-28],1
	jne	short @2@626
   ;	
   ;				{
   ;					textcolor(YELLOW);
   ;	
	mov	ax,14
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;					gotoxy(fre_x_pos, fre_y_pos);	cprintf("\xB3");
   ;	
	push	word ptr [bp-24]
	push	word ptr [bp-14]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+267
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(fre_x_pos, fre_y_pos+1);	cprintf(" ");
   ;	
	mov	ax,word ptr [bp-24]
	inc	ax
	push	ax
	push	word ptr [bp-14]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+269
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					 
   ;					ind1++;
   ;	
	inc	word ptr [bp-36]
   ;	
   ;					if(ind1==100) //-----------------------------------------------> feuergeschwindigkeit1
   ;	
	cmp	word ptr [bp-36],100
	jne	short @2@626
   ;	
   ;					{	
   ;						if(mode == 0 )fre_y_pos--;
   ;	
	cmp	word ptr [bp-8],0
	jne	short @2@554
	dec	word ptr [bp-24]
@2@554:
   ;	
   ;						if (fre_y_pos==0) fre1 =0;
   ;	
	cmp	word ptr [bp-24],0
	jne	short @2@602
	mov	word ptr [bp-28],0
@2@602:
   ;	
   ;					
   ;						ind1=0;
   ;	
	mov	word ptr [bp-36],0
@2@626:
   ;	
   ;					}	
   ;				}
   ;				gotoxy(fre_x_pos, fre_y_pos+1);	cprintf(" ");
   ;	
	mov	ax,word ptr [bp-24]
	inc	ax
	push	ax
	push	word ptr [bp-14]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+271
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				
   ;				//-----------------------------------------------------------------> feuer2
   ;				if(fre2==1)
   ;	
	cmp	word ptr [bp-30],1
	je	@@0
	jmp	@2@866
@@0:
   ;	
   ;				{	
   ;					if(mode == 1 && fre_y2_pos ==39)//-----------------------------> DEMO modus graphikfluss optimierung 
   ;	
	cmp	word ptr [bp-8],1
	jne	short @2@722
	cmp	word ptr [bp-26],39
	jne	short @2@722
   ;	
   ;					{
   ;						clrscr();textcolor(DARKGRAY);gotoxy(8, 38);					
   ;	
	call	far ptr _clrscr
	mov	ax,8
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	mov	ax,38
	push	ax
	mov	ax,8
	push	ax
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;						cprintf("_________________________________________________________________");
   ;	
	push	ds
	mov	ax,offset s@+273
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@722:
   ;	
   ;					}	
   ;					
   ;					textcolor(BROWN);
   ;	
	mov	ax,6
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;					gotoxy(fre_x2_pos, fre_y2_pos);	cprintf("\xB3");
   ;	
	push	word ptr [bp-26]
	push	word ptr [bp-16]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+339
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					gotoxy(fre_x2_pos, fre_y2_pos+1);	cprintf(" ");
   ;	
	mov	ax,word ptr [bp-26]
	inc	ax
	push	ax
	push	word ptr [bp-16]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+341
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;					 
   ;					ind3++;
   ;	
	inc	word ptr [bp-38]
   ;	
   ;					if(ind3==100) //-----------------------------------------------> feuergeschwindigkeit2
   ;	
	cmp	word ptr [bp-38],100
	jne	short @2@866
   ;	
   ;					{			
   ;						if(mode == 0 )fre_y2_pos--;
   ;	
	cmp	word ptr [bp-8],0
	jne	short @2@794
	dec	word ptr [bp-26]
@2@794:
   ;	
   ;						if (fre_y2_pos==0) fre2 =0;
   ;	
	cmp	word ptr [bp-26],0
	jne	short @2@842
	mov	word ptr [bp-30],0
@2@842:
   ;	
   ;						
   ;						ind3=0;
   ;	
	mov	word ptr [bp-38],0
@2@866:
   ;	
   ;					}	
   ;				}
   ;				gotoxy(fre_x2_pos, fre_y2_pos+1);	cprintf(" ");
   ;	
	mov	ax,word ptr [bp-26]
	inc	ax
	push	ax
	push	word ptr [bp-16]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+343
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;				
   ;		
   ;				//-----------------------------------------------------------------> target1
   ;				textcolor(GREEN);
   ;	
	mov	ax,2
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;				gotoxy(x1_pos, y1_pos);
   ;	
	push	di
	push	word ptr [bp-18]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;				if(re==0) cprintf(" \x0F ");
   ;	
	cmp	word ptr [bp-32],0
	jne	short @2@914
	push	ds
	mov	ax,offset s@+345
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@914:
   ;	
   ;				
   ;				if(re == 0) ind++; 
   ;	
	cmp	word ptr [bp-32],0
	jne	short @2@962
	inc	word ptr [bp-40]
@2@962:
   ;	
   ;				if(ind==3000-v1) //------------------------------------------------> target1 geschwindigkeit
   ;	
	mov	ax,3000
	sub	ax,word ptr [bp-44]
	cmp	ax,word ptr [bp-40]
	jne	short @2@1130
   ;	
   ;				{
   ;					if (x1_pos > 72 || x1_pos < 5)
   ;	
	cmp	word ptr [bp-18],72
	jg	short @2@1034
	cmp	word ptr [bp-18],5
	jge	short @2@1106
@2@1034:
   ;	
   ;					{
   ;						gotoxy(x1_pos, y1_pos);
   ;	
	push	di
	push	word ptr [bp-18]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;						cprintf("   ");
   ;	
	push	ds
	mov	ax,offset s@+349
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;						if(v1 < 2500) v1+=100;//-----------------------------------> target1 beschleunigung
   ;	
	cmp	word ptr [bp-44],2500
	jge	short @2@1082
	add	word ptr [bp-44],100
@2@1082:
   ;	
   ;						y1_pos++; weg=weg*-1;
   ;	
	inc	di
	mov	ax,word ptr [bp-48]
	mov	dx,65535
	imul	dx
	mov	word ptr [bp-48],ax
@2@1106:
   ;	
   ;					}
   ;					ind=0; x1_pos+=weg;	
   ;	
	mov	word ptr [bp-40],0
	mov	ax,word ptr [bp-48]
	add	word ptr [bp-18],ax
@2@1130:
   ;	
   ;				}
   ;				if(y1_pos > 42) {  x1_pos = 5; y1_pos = 7; v1=0; }
   ;	
	cmp	di,42
	jle	short @2@1178
	mov	word ptr [bp-18],5
	mov	di,7
	mov	word ptr [bp-44],0
@2@1178:
   ;	
   ;					
   ;				if((x1_pos == fre_x_pos-1) && (y1_pos == fre_y_pos)||
   ;	
   ;	
   ;				   (x1_pos == fre_x2_pos-1) && (y1_pos == fre_y2_pos)) //----------> target1 kollisionsabfrage feuer1,2
   ;	
	mov	ax,word ptr [bp-14]
	dec	ax
	cmp	ax,word ptr [bp-18]
	jne	short @2@1226
	cmp	di,word ptr [bp-24]
	je	short @2@1274
@2@1226:
	mov	ax,word ptr [bp-16]
	dec	ax
	cmp	ax,word ptr [bp-18]
	je	@@1
	jmp	@2@1346
@@1:
	cmp	di,word ptr [bp-26]
	je	@@2
	jmp	@2@1346
@@2:
@2@1274:
   ;	
   ;				{
   ;					y1++;//--------------------------------------------------------> trefferz�hler
   ;	
	inc	word ptr [bp-10]
   ;	
   ;					
   ;					gotoxy(x1_pos, y1_pos);
   ;	
	push	di
	push	word ptr [bp-18]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					textbackground(BLACK);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;					cprintf(" \xB0 ");delay(100);//--------------------------------> explosion
   ;	
	push	ds
	mov	ax,offset s@+353
	push	ax
	call	far ptr _cprintf
	add	sp,4
	mov	ax,100
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
   ;	
   ;					
   ;					if(mode == 0 )zf_pos=floor(qzufall(2,75)); //------------------> quasizuf�llige x positionierung nach treffer
   ;	
	cmp	word ptr [bp-8],0
	jne	short @2@1322
	FLD	dword ptr s@+357
	add	sp,65528
	FSTP	qword ptr [bp-74]
	FLD	dword ptr s@+361
	add	sp,65528
	FSTP	qword ptr [bp-82]
	FWAIT	
	push	cs
	call	near ptr _qzufall
	add	sp,16
	add	sp,65528
	FSTP	qword ptr [bp-74]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FSTP	qword ptr [bp-58]
	FWAIT	
@2@1322:
   ;	
   ;					
   ;					re=5000; x1_pos = zf_pos; y1_pos += 1;//-----------------------> target1 ann�herung	
   ;	
	mov	word ptr [bp-32],5000
	FLD	qword ptr [bp-58]
	call	far ptr F_FTOL@
	mov	word ptr [bp-18],ax
	inc	di
@2@1346:
   ;	
   ;				}
   ;	
   ;				if (re > 0) re--;//------------------------------------------------> target1 wiedereintrittsverz�gerung
   ;	
	cmp	word ptr [bp-32],0
	jle	short @2@1394
	dec	word ptr [bp-32]
@2@1394:
   ;	
   ;				if (re > 0 && re < 1000) {textcolor(GREEN); gotoxy(x1_pos, y1_pos);cprintf(" \xDB ");}
   ;	
	cmp	word ptr [bp-32],0
	jle	short @2@1466
	cmp	word ptr [bp-32],1000
	jge	short @2@1466
	mov	ax,2
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	push	di
	push	word ptr [bp-18]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+365
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1466:
   ;	
   ;	
   ;				//-----------------------------------------------------------------> target2
   ;				textcolor(GREEN);
   ;	
	mov	ax,2
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;				gotoxy(x2_pos, y2_pos);
   ;	
	push	si
	push	word ptr [bp-20]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;				if(re1==0) cprintf(" \xCF ");
   ;	
	cmp	word ptr [bp-34],0
	jne	short @2@1514
	push	ds
	mov	ax,offset s@+369
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@1514:
   ;	
   ;				
   ;				if(re1 == 0) ind2++; 
   ;	
	cmp	word ptr [bp-34],0
	jne	short @2@1562
	inc	word ptr [bp-42]
@2@1562:
   ;	
   ;				if(ind2==2000-v11) //----------------------------------------------> target2 geschwindigkeit
   ;	
	mov	ax,2000
	sub	ax,word ptr [bp-46]
	cmp	ax,word ptr [bp-42]
	jne	short @2@1730
   ;	
   ;				{
   ;					if (x2_pos > 72 || x2_pos < 5)
   ;	
	cmp	word ptr [bp-20],72
	jg	short @2@1634
	cmp	word ptr [bp-20],5
	jge	short @2@1706
@2@1634:
   ;	
   ;					{
   ;						gotoxy(x2_pos, y2_pos);
   ;	
	push	si
	push	word ptr [bp-20]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;						cprintf("   ");
   ;	
	push	ds
	mov	ax,offset s@+373
	push	ax
	call	far ptr _cprintf
	add	sp,4
   ;	
   ;						if(v11 < 1500) v11+=100;//---------------------------------> target2 beschleunigung
   ;	
	cmp	word ptr [bp-46],1500
	jge	short @2@1682
	add	word ptr [bp-46],100
@2@1682:
   ;	
   ;						y2_pos++; weg1=weg1*-1;
   ;	
	inc	si
	mov	ax,word ptr [bp-50]
	mov	dx,65535
	imul	dx
	mov	word ptr [bp-50],ax
@2@1706:
   ;	
   ;					}
   ;					ind2=0; x2_pos+=weg1;	
   ;	
	mov	word ptr [bp-42],0
	mov	ax,word ptr [bp-50]
	add	word ptr [bp-20],ax
@2@1730:
   ;	
   ;				}
   ;				if(y2_pos > 42){   x2_pos = 72; y2_pos = 7; v11=0;  }
   ;	
	cmp	si,42
	jle	short @2@1778
	mov	word ptr [bp-20],72
	mov	si,7
	mov	word ptr [bp-46],0
@2@1778:
   ;	
   ;				
   ;	
   ;				if((x2_pos == fre_x_pos-1) && (y2_pos == fre_y_pos)||
   ;	
   ;	
   ;				   (x2_pos == fre_x2_pos-1) && (y2_pos == fre_y2_pos)) //----------> target2 kollisionsabfrage feuer1,2
   ;	
	mov	ax,word ptr [bp-14]
	dec	ax
	cmp	ax,word ptr [bp-20]
	jne	short @2@1826
	cmp	si,word ptr [bp-24]
	je	short @2@1874
@2@1826:
	mov	ax,word ptr [bp-16]
	dec	ax
	cmp	ax,word ptr [bp-20]
	je	@@3
	jmp	@2@1946
@@3:
	cmp	si,word ptr [bp-26]
	je	@@4
	jmp	@2@1946
@@4:
@2@1874:
   ;	
   ;				{
   ;					y1++;//--------------------------------------------------------> trefferz�hler
   ;	
	inc	word ptr [bp-10]
   ;	
   ;					
   ;					gotoxy(x2_pos, y2_pos);
   ;	
	push	si
	push	word ptr [bp-20]
	call	far ptr _gotoxy
	add	sp,4
   ;	
   ;					textbackground(BLACK);
   ;	
	xor	ax,ax
	push	ax
	call	far ptr _textbackground
	inc	sp
	inc	sp
   ;	
   ;					cprintf(" \xB1 ");delay(100);//--------------------------------> explosion
   ;	
	push	ds
	mov	ax,offset s@+377
	push	ax
	call	far ptr _cprintf
	add	sp,4
	mov	ax,100
	push	ax
	call	far ptr _delay
	inc	sp
	inc	sp
   ;	
   ;					
   ;					if(mode == 0 )zf_pos=floor(qzufall(2,75));//-------------------> quasizuf�llige x positionierung nach treffer
   ;	
	cmp	word ptr [bp-8],0
	jne	short @2@1922
	FLD	dword ptr s@+357
	add	sp,65528
	FSTP	qword ptr [bp-74]
	FLD	dword ptr s@+361
	add	sp,65528
	FSTP	qword ptr [bp-82]
	FWAIT	
	push	cs
	call	near ptr _qzufall
	add	sp,16
	add	sp,65528
	FSTP	qword ptr [bp-74]
	FWAIT	
	call	far ptr _floor
	add	sp,8
	FSTP	qword ptr [bp-58]
	FWAIT	
@2@1922:
   ;	
   ;					
   ;					re1=5000; x2_pos = zf_pos; y2_pos += 1;//----------------------> target2 ann�herung	
   ;	
	mov	word ptr [bp-34],5000
	FLD	qword ptr [bp-58]
	call	far ptr F_FTOL@
	mov	word ptr [bp-20],ax
	inc	si
@2@1946:
   ;	
   ;				}
   ;	
   ;				if (re1 > 0) re1--;//----------------------------------------------> target2 wiedereintrittsverz�gerung
   ;	
	cmp	word ptr [bp-34],0
	jle	short @2@1994
	dec	word ptr [bp-34]
@2@1994:
   ;	
   ;				if (re1 > 0 && re1 < 1000) {textcolor(GREEN); gotoxy(x2_pos, y2_pos);cprintf(" \xCE ");}
   ;	
	cmp	word ptr [bp-34],0
	jle	short @2@2066
	cmp	word ptr [bp-34],1000
	jge	short @2@2066
	mov	ax,2
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	push	si
	push	word ptr [bp-20]
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+381
	push	ax
	call	far ptr _cprintf
	add	sp,4
@2@2066:
   ;	
   ;	
   ;				
   ;				//-----------------------------------------------------------------> basis kollisionsabfrage 
   ;				if((x1_pos == x_pos-1) && (y1_pos == y_pos)||
   ;	
   ;	
   ;				   (x2_pos == x_pos-1) && (y2_pos == y_pos)) 
   ;	
	mov	ax,word ptr [bp-12]
	dec	ax
	cmp	ax,word ptr [bp-18]
	jne	short @2@2114
	cmp	di,word ptr [bp-22]
	je	short @2@2162
@2@2114:
	mov	ax,word ptr [bp-12]
	dec	ax
	cmp	ax,word ptr [bp-20]
	jne	short @2@2186
	cmp	si,word ptr [bp-22]
	jne	short @2@2186
@2@2162:
   ;	
   ;				{
   ;					clrscr();textcolor(DARKGRAY);
   ;	
	call	far ptr _clrscr
	mov	ax,8
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
   ;	
   ;					gotoxy(70, 45);cprintf("END");getch();
   ;	
	mov	ax,45
	push	ax
	mov	ax,70
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	push	ds
	mov	ax,offset s@+385
	push	ax
	call	far ptr _cprintf
	add	sp,4
	call	far ptr _getch
   ;	
   ;					exit(1);//-----------------------------------------------------> spielende
   ;	
	mov	ax,1
	push	ax
	call	far ptr _exit
	inc	sp
	inc	sp
@2@2186:
   ;	
   ;				}
   ;				
   ;				if(mode == 0 )//---------------------------------------------------> modus SPIEL
   ;	
	cmp	word ptr [bp-8],0
	jne	short @2@2234
   ;	
   ;				fprintf(outStream,"%i %i %i %i %i %i %i %lf\n", //-----------------> koordinatenausgabe in game_mat.rix
   ;	
   ;	
   ;				
   ;				x_pos, fre1, fre_y_pos, fre_x_pos, fre2, fre_y2_pos, fre_x2_pos, zf_pos );
   ;	
	FLD	qword ptr [bp-58]
	add	sp,65528
	FSTP	qword ptr [bp-74]
	FWAIT	
	push	word ptr [bp-16]
	push	word ptr [bp-26]
	push	word ptr [bp-30]
	push	word ptr [bp-14]
	push	word ptr [bp-24]
	push	word ptr [bp-28]
	push	word ptr [bp-12]
	push	ds
	mov	ax,offset s@+389
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fprintf
	add	sp,30
@2@2234:
	call	far ptr _kbhit
	or	ax,ax
	jne	@@5
	jmp	@2@410
@@5:
	jmp	@2@2642
@2@2282:
   ;	
   ;			}
   ;			
   ;			while (kbhit())//------------------------------------------------------> Tastendruckschleife
   ;			{
   ;				taste=getch();//---------------------------------------------------> zuordnung der aktivierten taste
   ;	
	call	far ptr _getch
	mov	byte ptr [bp-59],al
   ;	
   ;				
   ;				//-----------------------------------------------------------------> ereignisse
   ;				if(taste == 'd') if(x_pos < 75) x_pos++;//-------------------------> d_taste schiebt cursor nach rechts
   ;	
	cmp	byte ptr [bp-59],100
	jne	short @2@2354
	cmp	word ptr [bp-12],75
	jge	short @2@2354
	inc	word ptr [bp-12]
@2@2354:
   ;	
   ;				if(taste == 'a') if(x_pos > 2)  x_pos--;//-------------------------> a_taste schiebt cursor nach links
   ;	
	cmp	byte ptr [bp-59],97
	jne	short @2@2426
	cmp	word ptr [bp-12],2
	jle	short @2@2426
	dec	word ptr [bp-12]
@2@2426:
   ;	
   ;				if(taste == 'h')//-------------------------------------------------> h_taste spielpause 
   ;	
	cmp	byte ptr [bp-59],104
	jne	short @2@2474
   ;	
   ;				{
   ;					gotoxy(1, 1);textcolor(DARKGRAY);printf("GAME paused"); 
   ;	
	mov	ax,1
	push	ax
	mov	ax,1
	push	ax
	call	far ptr _gotoxy
	add	sp,4
	mov	ax,8
	push	ax
	call	far ptr _textcolor
	inc	sp
	inc	sp
	push	ds
	mov	ax,offset s@+415
	push	ax
	call	far ptr _printf
	add	sp,4
   ;	
   ;					getch();clrscr();
   ;	
	call	far ptr _getch
	call	far ptr _clrscr
@2@2474:
   ;	
   ;				}
   ;				if(taste == 'p')//-------------------------------------------------> p_taste feuer
   ;	
	cmp	byte ptr [bp-59],112
	jne	short @2@2594
   ;	
   ;				{
   ;					if (ind1==0){fre1=1; fre_y_pos = 39; fre_x_pos=x_pos+1;clrscr();}
   ;	
	cmp	word ptr [bp-36],0
	jne	short @2@2546
	mov	word ptr [bp-28],1
	mov	word ptr [bp-24],39
	mov	ax,word ptr [bp-12]
	inc	ax
	mov	word ptr [bp-14],ax
	call	far ptr _clrscr
@2@2546:
   ;	
   ;					if (ind1>10){fre2=1; fre_y2_pos = 39;fre_x2_pos=x_pos+1;clrscr();}
   ;	
	cmp	word ptr [bp-36],10
	jle	short @2@2594
	mov	word ptr [bp-30],1
	mov	word ptr [bp-26],39
	mov	ax,word ptr [bp-12]
	inc	ax
	mov	word ptr [bp-16],ax
	call	far ptr _clrscr
@2@2594:
   ;	
   ;				}
   ;				if(taste == 'q') {fclose(outStream);clrscr();exit(1);}//-----------> q_taste spielabbruch
   ;	
	cmp	byte ptr [bp-59],113
	jne	short @2@2642
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	far ptr _fclose
	add	sp,4
	call	far ptr _clrscr
	mov	ax,1
	push	ax
	call	far ptr _exit
	inc	sp
	inc	sp
@2@2642:
	call	far ptr _kbhit
	or	ax,ax
	je	@@6
	jmp	@2@2282
@@6:
	jmp	@2@386
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
GAME_TEXT	ends
GAME_DATA	segment word public 'DATA'
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
	db	' A -  '
	db	0
	db	'GAME by Dietmar Schrausser, (c) SCHRAUSSER 2009'
	db	10
	db	'compiled %s @ %s'
	db	10
	db	10
	db	'[0]BEGIN'
	db	10
	db	'[1]DEMO'
	db	0
	db	'Apr 09 2009'
	db	0
	db	'05:27:27'
	db	0
	db	' '
	db	30
	db	' '
	db	0
	db	'_'
	db	0
	db	'BEGIN'
	db	0
	db	'game_mat.rix'
	db	0
	db	'w'
	db	0
	db	'DEMO'
	db	0
	db	'game_mat.rix'
	db	0
	db	'r'
	db	0
	db	'%i %i %i %i %i %i %i %lf'
	db	10
	db	0
	db	'%i'
	db	0
	db	'_____________________________________________________________'
	db	'____'
	db	0
	db	' '
	db	30
	db	' '
	db	0
	db	-77
	db	0
	db	' '
	db	0
	db	' '
	db	0
	db	'_____________________________________________________________'
	db	'____'
	db	0
	db	-77
	db	0
	db	' '
	db	0
	db	' '
	db	0
	db	' '
	db	15
	db	' '
	db	0
	db	'   '
	db	0
	db	' '
	db	-80
	db	' '
	db	0
	db	0
	db	0
	db	-106
	db	'B'
	db	0
	db	0
	db	0
	db	'@ '
	db	-37
	db	' '
	db	0
	db	' '
	db	-49
	db	' '
	db	0
	db	'   '
	db	0
	db	' '
	db	-79
	db	' '
	db	0
	db	' '
	db	-50
	db	' '
	db	0
	db	'END'
	db	0
	db	'%i %i %i %i %i %i %i %lf'
	db	10
	db	0
	db	'GAME paused'
	db	0
GAME_DATA	ends
GAME_TEXT	segment byte public 'CODE'
GAME_TEXT	ends
	extrn	__turboFloat:word
	extrn	_fopen:far
	extrn	_pow:far
	public	_qzufall
	extrn	_printf:far
	public	_fn_erg
	extrn	_textcolor:far
	extrn	_kbhit:far
	extrn	__setcursortype:far
	extrn	_time:far
	extrn	_fprintf:far
	extrn	_cprintf:far
	extrn	_getch:far
	public	_main
	extrn	_delay:far
	extrn	_floor:far
	extrn	_clrscr:far
	extrn	_exit:far
	extrn	_gotoxy:far
	extrn	_fclose:far
	extrn	F_FTOL@:far
	extrn	_textbackground:far
	extrn	_fscanf:far
	end
