function [ prob ] = probability( input_mat, pi_mat, means_clusters, sigma_clusters, num_clusters )
    size_input_mat = size(input_mat);
    num_patterns = size_input_mat(1);
    prob = zeros(num_patterns, 1);
    for n = 1:num_patterns
        for k = 1:num_clusters
            p = log(pi_mat(k) * gauss_dis(input_mat(n,:), means_clusters(k, :), sigma_clusters(:, :, k)));
            prob(n) = prob(n) + p;
        end
    end
end

