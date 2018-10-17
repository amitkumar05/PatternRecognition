% This function returns the 'gamma' matrix for a class
% 
% eeta_mat(L x T x N x N): Eeta matrix
% 
% gamma_mat(L x T x N): Gamma matrix
function [ gama_mat ] = gamma_mat( eeta_mat )
    format long g
    L = size(eeta_mat, 2);
    %L
    T = zeros(L, 1);
    %display('amit')
    for l = 1:L
        T(l) = size(eeta_mat{l}, 3);
    end
    N = size(eeta_mat{1}, 1);
    %%initializing gamma matrix%%
    %%%TODO: use 'cell'(if possible)%%%
    for l = 1:L
        gama_mat{l} = zeros(T(l), N);
    end
    %%calculation for gamma%%
    for l = 1:L
        for t = 1:T(l)
            for i = 1:N
                for j = 1:N
                    %may be calculated faster using transpose and 'sum'%
                    gama_mat{l}(t, i) = gama_mat{l}(t, i) + eeta_mat{l}(i, j, t);
                end
            end
        end
    end
    
end

