function [new_parameters] = Check_Param(parameters )
th8  = parameters(1);
d9   = parameters(2);
th10 = parameters(3);
th11 = parameters(4);
th12 = parameters(5);

% assume(th8> 0 & th8< 60)
% assume(d9> 0 & d9< 200)
% assume(th10> -90 & th10< -30)
% assume(th11>+90 & th11< 135)
% assume(th12>0 & th12< 30)
min_val = [ 0   0  270 90 0  ] ;
max_val = [ 60 200 330 135 30 ] ;
th8  =  radtodeg( mod(th8,2*pi) ) ;
th10  = radtodeg( mod(th10,2*pi)) ;
th11 = radtodeg( mod(th11,2*pi) ) ;
th12 = radtodeg( mod(th12,2*pi)) ;
parameters = [ th8 d9 th10 th11 th12  ];
for i=1:5
    if ( ( parameters(i) >min_val(i)) & (parameters(i)<max_val(i) ) )
        fprintf('Parameter %d in Range\n' , i  );
    else 
         fprintf('Parameter %d NOT in Range\n' , i  );
    end
    
end
    

end