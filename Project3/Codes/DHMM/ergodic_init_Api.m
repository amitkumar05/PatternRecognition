% This function returns A and pi matrix for the ergodic HMM
% 
% N: Number of states
% 
% A(N x N): State transition probability matrix
% piMat(N x 1): Intial state probability


function [ A, pi_mat ] = ergodic_init_Api( N )
    format long g
    A = zeros(N, N);
    pi_mat = zeros(N,1);
    for k = 1:N
        pi_mat(k) = 1/N;
        for l = 1:N
            A(k, l) = 1/N; 
        end
    end
end

