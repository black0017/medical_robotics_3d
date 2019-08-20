%% Den - Hath parameters
function [dh] = deha(th,a,r,d)

dh = [
    cos(th), -cos(a)*sin(th),  sin(a)*sin(th), r*cos(th)
    sin(th),  cos(a)*cos(th), -sin(a)*cos(th), r*sin(th)
      0,          sin(a),          cos(a),         d
       0,               0,               0,         1      
    ] ;

end

