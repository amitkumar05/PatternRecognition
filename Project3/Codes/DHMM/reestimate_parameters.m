function [ pi, a, b ] = reestimate_parameters( alpha, gamma, eeta_mat, obs_seq, M )
    %REESTIMATE_PARAMETERS

    L = size(alpha, 2);
    %size_alpha1=size(aplha{1});
    %N=size_alpha1(2);
    N = size(alpha{1}, 2);
    pi = zeros(N, 1);
    a = zeros(N, N);


    for i = 1:N
        for l = 1:L
            pi(i) = pi(i) + (gamma{l}(1, i)) / L;
        end
    end
    for i = 1:N
        for j = 1:N
            num_sum_l = 0;
            den_sum_l = 0;
            for l = 1:L
                Tl = size(alpha{l}, 1);
                num_sum_t = zeros(L, 1);
                den_sum_t = zeros(L, 1);
                for t = 1:Tl-1 % Summation upto Tl-1
                    num_sum_t(l) = num_sum_t(l) + eeta_mat{l}(i, j, t);
                    den_sum_t(l) = den_sum_t(l) + gamma{l}(t, i);
                end
                num_sum_l = num_sum_l + num_sum_t(l);
                den_sum_l = den_sum_l + den_sum_t(l);
            end
            a(i, j) = num_sum_l / den_sum_l;
        end
    end

    for i = 1:N
        for j = 1:M
            num_sum_l = 0;
            den_sum_l = 0;
            for l = 1:L
                Tl = size(alpha{l}, 1);
                num_sum_t = zeros(L, 1);
                den_sum_t = zeros(L, 1);
                for t = 1:Tl % Summation upto Tl
                    if (obs_seq{l}(t) == j)
                        num_sum_t(l) = num_sum_t(l) + gamma{l}(t, i);
                    end
                    den_sum_t(l) = den_sum_t(l) + gamma{l}(t, i);
                end
                num_sum_l = num_sum_l + num_sum_t(l);
                den_sum_l = den_sum_l + den_sum_t(l);
            end
            b(i, j) = num_sum_l / den_sum_l;
        end
    end
end