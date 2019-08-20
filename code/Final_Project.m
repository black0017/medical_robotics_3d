%% --- Q1 ---
clc ;
clear all;
syms th8 d9 th10 th11 th12
%distances in mm
a5 = 300 ;
a6 = 200 ;
a7 = 18  ;
%{
    Angles				Dist				Parameter
    theta		a		r		d		
8   0		-pi/2		a5		0		?8
9   0		0           0		a6		d9
10  -pi/2	+pi/2		0		0		?10
11  +pi/2	-pi/2		0		0		?11
12  0		0           0		a7		?12
%}
% function [dh] = deha(th,a,r,d)
format short g
A8  = deha2(th8,-pi/2, a5, 0  ) ;
A9  = deha2(0,0,0,d9) ;
A10 = deha2(th10,pi/2,0,0);
A11 = deha2(th11,3*pi/2,0,0);
A12 = deha2(th12,0,0,a7);
A8_12 = simplify(A8*A9*A10*A11*A12)

%% --- Q2 ---
% Compute 3D Working Space
xx=0 ;
yy=0 ;
zz=0 ;
for i= 0: 0.2 : pi/3
    for k= 0 : 5 : 200
        for j= -pi/2 : 0.3 : -pi/6
            for q = pi/2: 0.3 : 3*pi/4 
                for w= 0: 0.3 : pi/6
                  C = Forward( [ i k j q w ] ) 
                  xx= [xx,C(1)];
                  yy= [yy,C(2)];
                  zz= [zz,C(3)];
                  fprintf('\n')
                end
            end 
        end
    end 
end
% 3d plot
scatter3(xx,yy,zz,'b')
% 2d plot xy
scatter(xx,yy,'b')
hold on ;

%% --- Q3 ---
% Jacobian for inverse kinematics
LearnRate = 0.05 ;
Desired = [33.354    335.1   -16.579] ; % xo , yo , z0 
init_parameters = [ 1 180  -0.2  2.1  0];   % 1x5

th8  = init_parameters(1);
d9   = init_parameters(2);
th10 = init_parameters(3);
th11 = init_parameters(4);
th12 = init_parameters(5);

Pos = Forward( init_parameters );
new_parameters = init_parameters ; %1x5
count = 0 ;
while (  sum(abs( Desired - Pos  ))>5   )
Diff = (Desired - Pos)' ; % [Dx Dy Dz]'  3x1
Jv = MyJacobian( new_parameters  ); % 3x5
pinvJ = pinv(Jv); % 5x3
Dq = pinvJ*Diff ; % 5x1
new_parameters = new_parameters + (LearnRate*Dq)' ; %1x5
Pos = Forward( new_parameters );
count = count+1 ; 
end
fprintf('RESULTS: \n')
fprintf('-----------------------------------------------\n')
fprintf('Initial Position Of Simplified Davinci Robot\n')
Init = Forward( init_parameters )
fprintf('Final Position Of Simplified Davinci Robot\n')
Final = Forward( new_parameters )
fprintf('Desired Position Of 3D-Workspace \n')
Desired = [33.354    335.1   -16.579] 
fprintf('Iterations\n')
disp(count)
fprintf('Final Error in mm\n')
error = sum( abs(Desired-Final ) )
fprintf('-----------------------------------------------\n')
%% --- Q4 ---
%% Q4 Solve Inverse kin problem for spiral trajectory
clc
clear all ; 
xc = 230 ;
yc = 200 ;
r2 = 20  ;
r1 = r2-2.8  ;
r3 = r2+2.8  ;
zc = -14.5 ; 
d = 0.75 ;
points = 148 ;
t = linspace(-0.8,1.3,points) ;
xt = xc + r2*cos(2*pi*t);
yt = yc + r2*sin(2*pi*t);
zt = zc + d*( 2*pi*t );

init_param = [0.4   126   -1.3708   2.3208     0 ] ;
new_param = init_param ; 
error_vec = 0;
param_vec = [0 0 0 0 0] ;
param_vec2 = [0 0 0 0 0] ;

xxx = 0 ;
yyy = 0 ;
zzz = 0 ;

for i= 1:length(xt)
    desired = [ xt(i) yt(i) zt(i) ];
    % [new_param, error] = InverseKin2( new_param , desired  ) ; % JACOBIAN INVERSE KINEMATICS METHOD 
    %if error>9
    [new_param, error]= FindBest( desired); % PRUNED 3D SPACE INTUITIVE SEARCH !!!
    % end
    pos =  Forward((new_param))  ;
    error_vec = [error_vec,error];
    
    xxx = [xxx , pos(1) ];
    yyy = [yyy , pos(2) ];
    zzz = [zzz , pos(3) ];
    
    new_param = [ radtodeg(new_param(1)) , (new_param(2)) , radtodeg(new_param(3)) ,radtodeg(new_param(4)) ,radtodeg(new_param(5))  ];
    param_vec = [param_vec; new_param ];
    
    new_param = [ (new_param(1)) , (new_param(2)) , (new_param(3)) ,(new_param(4)) ,(new_param(5))  ];
    param_vec2 = [param_vec2; new_param ];
end
% measuring error
avg_error = sum(error_vec)/length(error_vec) 
max_error = max(error_vec) 
min_error = min(error_vec)
% visuilizing final trajectory
% 2d plot xz
figure()
scatter(xxx,zzz,'b')
hold on ;
scatter(xt,zt,'r')
% 2d plot xy
figure()
scatter(xxx,yyy,'b')
hold on ;
scatter(xt,yt,'r')

%% Q5 plot each DOF value with polynomial approximation
for j=1:5 % for each DOF
    figure()
    for i=2:(points) 
        t_start = t(i-1) ;
        t_end   = t(i) ;
        p_start = param_vec(i,j) ;
        p_end   = param_vec(i+1,j) ;
        pol = Third_order_solver( t_start,t_end ,p_start , p_end    );
    end   
end

%% Q5 - b - plot trajectory
trajectory = [0 0 0] ;
for i=2:(points) 
    move = zeros(5,20);
    for j=1:5 % for each DOF
        t_start = t(i-1) ;
        t_end   = t(i) ;
        p_start = param_vec2(i,j) ;
        p_end   = param_vec2(i+1,j) ;
        pol = Third_order_solver( t_start,t_end ,p_start , p_end    );
        move(j,:) = pol ;
    end
    
    
    for k=1:20
        pos_new = Forward(  move(:,k)'  ) ;
        trajectory = [ trajectory ; pos_new ] ;
    end
    
end

% 2d plot xz
figure()
scatter(trajectory(:,1) ,trajectory( :,3 ) ,'b')
hold on ;
scatter(xt,zt,'r')

% 2d plot xy
figure()
scatter(trajectory(:,1) ,trajectory( :,2 ) ,'b')
hold on ;
scatter(xt,yt,'r')



