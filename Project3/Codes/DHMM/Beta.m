function [ beta_mat ] = Beta( b, a, trainmat )
    format long g
%    a,b,pi
    N = size(a, 1);
    examples = size(trainmat, 2);
    for l = 1:examples
        T = size(trainmat{l}, 2);
        o = trainmat{l};
        for j = 1:N
            beta_mat{l}(T, j) = 1;
        end
        for t = T-1:-1:1
            for j = 1:N
                sum = 0;
                for i = 1:N
                    sum = sum + beta_mat{l}(t+1, i) * a(i, j) * b(j, o(t));
                end
                beta_mat{l}(t, j) = sum;    
            end
        end
    end
end