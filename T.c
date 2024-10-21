#include "math.h"
#include "stdio.h"
#include "float.h"


void sub(double qqq);
double qfq;

void main()
{
  double q5,p5;
  double qx,qmd,qw4,qw1,qw2,qxq,qzq,qyq,qnd,qif,qwq;
  double qw3,qjfu,p6,pi=3.1415926535897932385;

do
{
  printf("\nt und n bitte\n");
  scanf("%lf%lf",&qx,&q5);
  
 
  p5=q5;
  q5=1;
  qw4=qx;
  qx=sqrt(qx);
  qw1=p5/(q5+p5+qx);
  qw2=sqrt(1-qw1);

  qmd=(2*floor(q5/2))-q5+2;

  qnd=(2*floor(p5/2))-p5+2;

  if((qmd*2-qnd)>1)
    {
    if((qmd*2-qnd)==3)       
     {
      goto c;
     }
    goto b;
   }
  else
   {
    goto a;
   }

  p6=1-qw2;
  qw3=qw1*qw2/2;
  goto d;

  a:
  p6=1-2/pi * atan(qw2/sqrt(qw1));
  qw3=qw2*sqrt(qw1/pi);
  goto d;

  c:
  p6=sqrt(qw1),qw3=(1-qw1)*p6/2;
  goto d;

  b:
  p6=qw1;
  qw3=(1-qw1)*p6;

  d:
  for(qif=qnd;qif<p5;qif=qif+ 2)
   {
    qjfu=qif;

    if(p5<=qif || fabs(2/qif*qw3)<(0.00001*pi))
     {
      goto e;
     }

    p6=p6-2/qif*qw3,qw3=qw3*qw1*(qmd/qif+1);
   }

  e:
  for(qif=qmd;qif<q5;qif=qif+2)
   {

    if(q5<=qif || fabs(2/qif*qw3)<(0.00001*pi))
     {
      goto f;
     }

    p6=p6+2/qif*qw3;
    qw3=qw3*(1-qw1)*(qjfu/qif+1);
   }

  f:
  p6=p6/2,q5=p5,qx=qw4;

  if(qx<0)
   {
    p6=1-p6;
   }

  qxq=p6,qyq=-5;

  if(qxq ==0)
   {
    goto g;
   }

  qfq=(fabs(qxq));
  qfq=log10(qfq);
  qyq=qfq+qyq;

  sub(qfq);

  qzq=qfq;
  qfq=qyq;

  sub(qfq);

  if(qyq>=19)
   {
    goto g;
   }

  if(qyq<0)
   {
    qxq=0;
    goto g;
   }
  if(qzq>=90)
   {
    qxq=qxq*pow(10,-20);
    qfq=qzq,qzq=qzq-20;
    qwq=fabs(qxq*pow(10,qzq * -1));
    qwq=floor(qwq*pow(10,qyq)+0.5);
    qwq=qwq*(pow(10,qzq))*(pow(10,(qyq*-1)));
   }

  if(qfq>= 90)
   {
    qwq=qwq*pow(10,20);
   }

  if(qxq>=0)
   {
    qxq = qwq;
   }
  else
   {
    qxq= qwq * -1;
   }

  g:
  p6=qxq;

  printf("\np= %lf",p6);
}

while (q5 != 0);
}

void
 sub(double qqq)
{
  if(qqq>=0)
   {
    qqq=floor(qqq);
   }
  else
   {
   qqq=-1*(floor(fabs(qqq)));
   }

  qfq=qqq;
}
