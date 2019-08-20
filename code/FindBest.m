function [new_parameters, min] = FindBest(D)
x0  = D(1);
y0  = D(2);
z0  = D(3);
min = 1000000;
a5 = 300 ;
a6 = 200 ;
a7 = 18  ;
syms t;
xc = 230 ;
yc = 200 ;
r2 = 20  ;
r1 = r2-2  ;
r3 = r2+2  ;
zc = -14.5 ; 
d = 0.75 ;
  for i= 0: 0.15 : pi/3
    for k= 0 : 10 : 200
        for j= -pi/2 : 0.12 : -pi/6
            for q = pi/2: 0.15 : 3*pi/4 
                for w= 0: 0.1 : pi/6
                  C =Forward( [ i k j q w ]  );
                                if ( ((C(1)-xc)*(C(1)-xc)) + (C(2)-yc)*(C(2)-yc) > r1*r1    )
                                    if ( ((C(1)-xc)*(C(1)-xc)) + (C(2)-yc)*(C(2)-yc) < r3*r3    )
                                        if ( abs( C(3)-D(3)) < 0.6  )
                                            error = sum(abs(C-D)) ;
                                            if ( error < min)
                                                new_parameters =  [i k (j) (q) (w) ] ;
                                                min = error ;
                                            end
                                        end
                                    end
                                end
                  
                end
            end 
        end
    end   
end















end