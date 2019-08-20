function [pos] = Forward(parameters)
th8  = parameters(1);
d9   = parameters(2);
th10 = parameters(3);
th11 = parameters(4);
th12 = parameters(5);
%distances in mm
a5 = 300 ;
a6 = 200 ;
a7 = 18  ;

A8  = deha2(th8,-pi/2, a5, 0  ) ;
A9  = deha2(0,0,0,d9) ;
A10 = deha2(th10,pi/2,0,0);
A11 = deha2(th11,3*pi/2,0,0);
A12 = deha2(th12,0,0,a7);

A8_12 =(A8*A9*A10*A11*A12); 

pos = A8_12( 1:3 ,4 )';
end
