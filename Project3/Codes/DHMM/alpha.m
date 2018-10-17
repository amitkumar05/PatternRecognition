% This function returns the alpha in a matrix form
% 
% 
% 
% 

function [ alpha_mat ] = alpha( pi, b, a, trainmat )
%    a,b,pi
    format long g
    N = size(a, 1);
    examples = size(trainmat, 2);
    for l = 1:examples
        T = size(trainmat{l}, 2);
        o = trainmat{l};
        for j = 1:N
            alpha_mat{l}(1,j) = pi(j) * b(j, o(1));
        end
%        display('amit')
        for t = 2:T
            for j = 1:N
                sum = 0;
                for i = 1:N
                    sum = sum + alpha_mat{l}(t-1, i) * a(i, j);
                end
                alpha_mat{l}(t, j) = sum * b(j, o(t));    
            end
        end
    end
end