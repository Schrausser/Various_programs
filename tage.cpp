/* Zahl für DOS */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//char dbuffer [9],tbuffer [9];

main(void){


	int _jahr=0, _monat=0, _tag=0, jahr_=0, monat_=0, tag_=0;
	int _jahr_=0, _monat_=0, _tag_=0;
	int dodl, _tage=0, count1 = 0, m=0, t=0;


	printf("\nJahr/Monat/Tag/Tage -> ");
	scanf("%i/%i/%i/%i",&_jahr,&_monat,&_tag,&_tage );
	//printf("\nMonat-> ");
	//scanf("%i\n",_monat );
	//printf("\nTag-> ");
	//scanf("%i\n",_tag );
	//printf("\nTage-> ");
	//scanf("%i\n",_tage );


printf("%i: jahr=%i monat=%i tag=%i\n",_tage, _jahr, _monat, _tag);

	switch(_monat)
   	{	
		case 1:
   			_monat_ = 0;
   		break;
		case 2:
   			_monat_ = 31;
   		break; 
		case 3:
   			_monat_ = 59;
   		break; 
		case 4:
   			_monat_ = 90;
   		break; 
		case 5:
   			_monat_ = 120;
   		break; 
		case 6:
   			_monat_ = 151;
   		break; 
		case 7:
   			_monat_ = 181;
   		break; 
		case 8:
   			_monat_ = 212;
   		break; 
		case 9:
   			_monat_ = 243;
   		break; 
		case 10:
   			_monat_ = 273;
   		break; 
		case 11:
   			_monat_ = 304;
   		break; 
		case 12:
   			_monat_ = 334;
   		break; 
	

	}
	
	printf("%i\n",_monat_);
	
	

for (dodl = 1; dodl <100000000; dodl++)
//while (_tage != 0)
{


	//for (monat_ = 1; monat_ < 13-_monat ; monat_=monat_+1)
	//{

		//m= (m+1)+(_monat_+_monat);
		
		for (tag_ = 1; tag_ < 366-(_monat_+_tag); tag_=tag_+1)
		{
			t=(t+1)+(_tag+_monat_);




			_tage =_tage - 1;
			if (_tage < 1) break;

		}

	if (_tage < 1) break;

	//}
	//if (_tage = 0) {break; goto aus;}
	
	_jahr=_jahr+1;
	_monat = 0, _monat_ = 0, _tag = 0, tag_=0;
	//m=0;
	t=0;



}
//while (_tage !=0);
//aus:

printf("%i: jahr=%i monat=%i tag=%i\n",_tage, _jahr, m, t);

return (0);

} 
