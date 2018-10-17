function [ total_likelihood ] = total_lun( alpha_mat )
    L = size(alpha_mat, 2);
    N = size(alpha_mat{1}, 2);
    total_likelihood = 0;
    for i = 1:L
        sum = 0;
        T = size(alpha_mat{i}, 1);
        for j = 1:N
            sum = sum + alpha_mat{i}(T, j);
        end
        total_likelihood = total_likelihood + log(sum);
    end
end
