function [ pol] = Third_order_solver( t_start , t_end , start_point , end_point )
M = [ 1     t_start     t_start^2   t_start^3   ; 
      0     1           2*t_start   3*t_start^2 ; 
      1     t_end       t_end^2     t_end^3     ; 
      0     1           2*t_end     3*t_end^2 
];

Q = [ start_point , 0 , end_point , 0 ]' ;

coef = pinv(M)*Q ;
t = linspace( t_start ,t_end, 20 );
pol = coef(1)*1 + coef(2)*t + coef(3)*t.^2 +coef(4)*t.^3 ;

%plot result
% scatter( t, pol , 5 );
% hold on;
end