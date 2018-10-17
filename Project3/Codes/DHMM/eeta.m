% This function returns the 'eeta' matrix for a class
% 
% alpha_mat(L x T x N): Foreward variable matrix
% beta_mat(L x T x N): Backward variable matrix
% A(N x N): State transition probability matrix
% piMat(N x 1): Intial state probability
% O(L x T x 1): Matrix containing symbols for each sequence for each observation
% 
% eeta_mat(L x T x N x N): Eeta matrix


function [ eeta_mat ] = eeta( alpha_mat, beta_mat, A, B, O )
    format long g
    L = size(alpha_mat, 2);
    T = zeros(L, 1);
    for l = 1:L
        s = size(alpha_mat{l}); 
        T(l) = s(1);
    end
    
    N = size(alpha_mat{1}, 2);
    %%initializing eeta matrix%%
    %%%TODO: use 'cell'(if possible)%%%
    for l = 1:L
        eeta_mat{l} = zeros(N, N, T(l));
    end
    
%
%     alpha_mat{1}(T(1)-1, :)
%     A
%     B
%     O{1}(T(1))
%     B(:, O{1}(T(1)))
%     beta_mat{1}(T(1), :)
%     
    
    %%calculation for eeta%%
    for l = 1:L
        for t = 1:( T(l)-1 )
            %calculating denominator%
            denominator = 0;
            for i = 1:N
                for j = 1:N
                    denominator = denominator + ( (alpha_mat{l}(t, i)) * (A(i, j)) * (B(j, O{l}(t+1))) * (beta_mat{l}(t+1, j)) );
                end
            end
            %calculating individual terms for eeta%
            for i = 1:N
                for j = 1:N
                    eeta_mat{l}(i, j, t) = ( (alpha_mat{l}(t, i)) * (A(i, j)) * (B(j, O{l}(t+1))) * (beta_mat{l}(t+1, j)) ) / denominator;
                end
            end
%         eeta_mat{l}(:,:,t)    
        end
        
        
        %%calculation for T%%
        %calculating denominator%
        denominator = 0;
        for i = 1:N
            denominator = denominator + ( alpha_mat{l}(T(l), i) );
        end
        %calculating individual terms%
        %each column is same%
%         for i = 1:N
%             eeta_mat{l}(i, 1, T(l)) = ( alpha_mat{l}(T(l), i) ) / denominator;
%         end
%         for j = 2:N
%             eeta_mat{l}(:, j, T(l)) = eeta_mat{l}(:, 1, t);
%         end
        for i = 1:N
            for j = 1:N
                eeta_mat{l}(i, j, T(l)) = ( alpha_mat{l}(T(l), i) ) / denominator;
            end
        end
    end
end

