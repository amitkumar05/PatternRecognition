%%%CHANGELOG: Changed the threshold(increased)%%%

function [ a, b, pi ] = DHMM_parameters_LtoR( obs_seq, N, M )
    format long g
    display('Inside DHMM parameters')
    [a, pi] = LtoR_init_Api(N);
    [b] = initial_B(obs_seq, N, M);
    
    lun_old = Inf;
    iter = 1;
    while(1)
%         if(iter == 4)
%             break;
%         end
        iter
        iter = iter + 1;
        display('Entered while')
%         b
%         pi
%         b
%         a
%         obs_seq
         [alpha_mat] = alpha(pi, b, a, obs_seq);
         %alpha_mat{1}
        %for k = 1:size(alpha_mat, 2)
         %   alpha_mat{k}
        %end
        lun_new = total_lun(alpha_mat);
        lun_new
%         lun_old
        abs(lun_old - lun_new)
%         if( abs(lun_old - lun_new) < 0.001 )
%         if( abs(lun_old - lun_new) < 100 )
        if( abs(lun_old - lun_new) < 80 )
            break;
        end
        display('calculating beta')
        [beta] = Beta(b, a, obs_seq);
        display('calculating eeta')
        [eeta_mat] = eeta(alpha_mat, beta, a, b, obs_seq);
        display('calculating gamma')
        [gamma] = gamma_mat(eeta_mat);
        %pi
%         eeta_mat{1}
        %gamma{1}
        
        display('going to calculate reestimate parameters')
        [ pi, a, b ] = reestimate_parameters( alpha_mat, gamma,eeta_mat, obs_seq, M );
        display('reestimated parameters')
        lun_old = lun_new;
    end
    display('Finished DHMM parameters')
end

