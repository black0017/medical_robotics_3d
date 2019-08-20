function [new_parameters, error] = InverseKin2(parameters , Desired)
    LearnRate = 0.03 ;
    TH = 5;
    MAX_REP = 20000 ;

    Pos = Forward( parameters );
    new_parameters = parameters ; %1x5
    count = 0 ;
    error = sum(abs( Desired - Pos  ));

    while ( error >TH   )
        Diff = (Desired - Pos)' ; % [Dx Dy Dz]'  3x1
        Jv = MyJacobian( new_parameters  ); % 3x5
        pinvJ = pinv(Jv); % 5x3
        Dq = pinvJ*Diff ; % 5x1
        new_parameters = new_parameters + (LearnRate*Dq)' ; %1x5
        Pos = Forward( new_parameters );
        error = sum(abs( Desired - Pos  ));
        count = count+1 ;

        if ( count>=MAX_REP )
           break;
        end
    end
   
end