#cmos xor gate

*enables awaves processing
.options post

.include 'pmos-13u.lib'
.include 'nmos-13u.lib'

.param  vdd=5v  pulsew=10n  
.param  lmin=0.6u  wmin=0.12u


Vdd vdd 0 vdd

*Input  A and B
Va A 0 Pulse 0 5V 1010us 5nS 10nS 1mS 2ms
Vb B 0 Pulse 0 5V 500uS  5nS 10nS 500uS 1mS

*Input  A and B
Vanot ANOT  0 Pulse 5V 0  1010us 5nS 10nS 1mS 4ms
Vbnot BNOT  0 Pulse 5v 0  500uS  5nS 10nS 500uS 2mS


*nmos pull down network
 
 M1  1    B     0   0   NMOS  w=wmin  l=lmin
 M2	 out  A     1   0   NMOS  w=wmin  l=lmin
 M3  2    BNOT  0   0   NMOS  w=wmin  l=lmin
 M4  out  ANOT  2   0   NMOS  w=wmin  l=lmin
 
 

*pmos pull up network

 M5  out    B     3    vdd    PMOS    w=2*wmin l=lmin
 M6  3      ANOT  vdd  vdd    PMOS    w=2*wmin l=lmin
 M7	 out    BNOT  4    vdd    PMOS    w=2*wmin l=lmin
 M8  4      A     vdd  vdd    PMOS    w=2*wmin l=lmin
 
 
 
.op
.TRAN 5u 2m
.measure TRAN rise trig v(out) VAL=.1 rise=1 targ v(out) VAL=.9 rise=1
.measure TRAN fall trig v(out) VAL=.9 fall=1 targ v(out) VAL=.1 fall=1
.PRINT TRAN POWER V(out)

.end
 