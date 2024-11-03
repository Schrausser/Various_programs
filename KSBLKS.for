      implicit double precision (a-h,o-z)
      parameter(maxobs=1000,maxm=500,maxn=500)
      character*80 timdes
      integer tiedup(maxobs)
      double precision ttime
      logical debug,timflg
      common/block1/tiedup
      common/lblock/debug
