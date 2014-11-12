#ptr xor gate

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


*nmos pull down network
 
 M1  out  B  Anot   0   NMOS  w=wmin  l=lmin

 

*pmos pull up network

 M5  out    B     A    vdd    PMOS    w=2*wmin l=lmin

 
 
 
.op
.TRAN 5u 2m
.measure TRAN rise trig v(out) VAL=.1 rise=1 targ v(out) VAL=.9 rise=1
.measure TRAN fall trig v(out) VAL=.9 fall=1 targ v(out) VAL=.1 fall=1
.PRINT TRAN POWER V(out)

.end
 