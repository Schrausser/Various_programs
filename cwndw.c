#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <process.h>

void main()
{
	getch();
	spawnvp(P_NOWAIT,"notepad.exe", NULL);
	getch();
	
}
