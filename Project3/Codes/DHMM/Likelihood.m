function [ prob ] = Likelihood( A, B, pi, testmat )
%     A
%     B
%     pi
    L = size(testmat, 2);
    prob = ones(L, 1);
    N = size(A, 1);
    alpha_mat = alpha(pi, B, A, testmat);
    for l = 1:L
        sum = 0;
        T = size(alpha_mat{l}, 1);
        for n = 1:N
            sum = sum + alpha_mat{l}(T, n);
        end
        prob(l) =  sum;
    end
end

