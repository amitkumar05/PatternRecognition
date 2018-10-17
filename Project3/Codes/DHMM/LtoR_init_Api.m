% This function returns A and pi matrix for the Left to Right HMM
% 
% N: Number of states
% 
% A(N x N): State transition probability matrix
% piMat(N x 1): Intial state probability


function [ A, pi_mat ] = LtoR_init_Api( N )
    A = zeros(N, N);
    pi_mat = zeros(N, 1);
    pi_mat(1) = 1;
    for k = 1:N
        for l = 1:N
            if (k <= l)
                A(k, l) = 1 / (N + 1 - k);
            end
        end
    end
end

