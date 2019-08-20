function [Jv] = MyJacobian(parameters)
% geometric linear velocity jacobian
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

Z8  = A8(1:3, 3 );
Z9  = A9(1:3, 3 ) ;% prismatic
Z10 = A10(1:3, 3 );
Z11 = A11(1:3, 3 );
Z12 = A12( 1:3 , 3);


A8_9 = ( A8*A9 )      ;      % prismatic 
A8_10 = (A8*A9*A10 )   ;     % revolute
A8_11 = (A8*A9*A10*A11) ;    % revolute
A8_12 = (A8*A9*A10*A11*A12) ;% revolute

O   = [0 0 0]';
O8  = A8(1:3 , 4);
O9  = A8_9(1:3, 4);
O10 = A8_10(1:3,4);
O11 = A8_11(1:3,4);
O12 = A8_12(1:3, 4);
%Linear velocity jacobian
%Prismatic: Jv = zi-1
%Revolute: Jv = zi-1 x (on - oi-1)
Jv1 = cross(Z8 , (O12-O ));
Jv2 = Z9  ;
Jv3 = cross(Z10, (O12-O9 )   );
Jv4 = cross(Z11, (O12-O10 ) );
Jv5 = cross(Z12, (O12-O11 ) );
Jv = [ Jv1 Jv2 Jv3 Jv4 Jv5  ]; 


end