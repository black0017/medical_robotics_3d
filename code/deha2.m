%% Den - Hath parameters
function [dh] = deha2( th, a, r,d)

A1 = [
    cos(th) -sin(th) 0 0 ;
    sin(th)  cos(th) 0 0 ;
    0         0      1 0 ;
    0         0      0 1 ;
    ];


A2 = [
    1 0 0 0
    0 1 0 0
    0 0 1 d 
    0 0 0 1
];

A3 = [
    1 0 0 r 
    0 1 0 0
    0 0 1 0
    0 0 0 1
];

A4 = [
1 0 0 0
0 cos(a)  -1*sin(a)  0
0 sin(a)  cos(a)   0
0 0 0 1 
];


A4(A4<0.00001 & A4>-0.0001)=int16(0);

dh = (A1 * A2 * A3 * A4);
end
%R = D_H(1:3,1:3)
%T = D_H( 1:3 , 4 )

