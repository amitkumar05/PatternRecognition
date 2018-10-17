%%%CHANGELOG: Changed the threshold(increased)%%%

function [ a, b, pi ] = DHMM_parameters_ergodic( obs_seq, N, M )
 %   display('Inside DHMM parameters')
    [a, pi] = ergodic_init_Api(N);
    [b] = initial_B(obs_seq, N, M);

    lun_old = Inf;
    iter = 1;
    while(1)
%         iter
%         iter = iter + 1;
%        display('Entered while')
%         b
        [alpha_mat] = alpha(pi, b, a, obs_seq);
%         for k = 1:size(alpha_mat, 2)
%             alpha_mat{k}
%         end
        lun_new = total_lun(alpha_mat);
%         lun_old
%        abs(lun_old - lun_new)
%         if( abs(lun_old - lun_new) < 0.001 )
         if( abs(lun_old - lun_new) < 0.1 )

%        if( abs(lun_old - lun_new) < 50 )
%         if( abs(lun_old - lun_new) < 0.01 )
            break;
        end
%        display('calculating beta')
        [beta] = Beta(b, a, obs_seq);
%        display('calculating eeta')
        [eeta_mat] = eeta(alpha_mat, beta, a, b, obs_seq);
%        display('calculating gamma')
        [gamma] = gamma_mat(eeta_mat);
%        display('going to calculate reestimate parameters')
        [ pi, a, b ] = reestimate_parameters( alpha_mat, gamma,eeta_mat, obs_seq, M );
%        display('reestimated parameters')
        lun_old = lun_new;
    end
%    display('Finished DHMM parameters')
end

