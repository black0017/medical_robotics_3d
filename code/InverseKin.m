function [new_parameters] = InverseKin(parameters , Desired)
th8  = parameters(1);
d9   = parameters(2);
th10 = parameters(3);
th11 = parameters(4);
th12 = parameters(5);
LearnRate = 0.04 ;
TH = 5;

Pos = Forward( parameters );
new_parameters = parameters ; %1x5
count = 0 ;


while (  sum(abs( Desired - Pos  ))>TH   )
Diff = (Desired - Pos)' ; % [Dx Dy Dz]'  3x1
Jv = MyJacobian( new_parameters  ); % 3x5
pinvJ = pinv(Jv); % 5x3
Dq = pinvJ*Diff ; % 5x1
new_parameters = new_parameters + (LearnRate*Dq)' ; %1x5
Pos = Forward( new_parameters );
count = count+1 ;
if ( count>=50000 ) % unable to compute in reasonal time
    break

end
end
fprintf('RESULTS: \n')
fprintf('-----------------------------------------------\n')
fprintf('Initial Position Of Simplified Davinci Robot\n')
Init = Forward( parameters )
fprintf('Final Position Of Simplified Davinci Robot\n')
final_pos = Forward( new_parameters )
fprintf('Iterations\n')
disp(count)
fprintf('Final Error in mm\n')
error = sum( abs(Desired-final_pos ) )
fprintf('-----------------------------------------------\n')
Check_Param( new_parameters ) ; 
end