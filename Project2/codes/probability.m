function [ prob ] = probability( input_mat, pi_mat, means_clusters, sigma_clusters, num_clusters )
    disp('Inside probability')
    size_input_mat = size(input_mat);
    num_patterns = size_input_mat(1);
    prob = zeros(num_patterns, 1);
    
%     means_clusters
%     sigma_clusters
    
    for n = 1:num_patterns
        for k = 1:num_clusters
            %size_d=size(input_mat(n,:))
            %size_m=size(means_clusters(k,:))
            %gauss_dis(input_mat(n,:), means_clusters(k, :), sigma_clusters(:, :, k))
            p = pi_mat(k) * gauss_dis(input_mat(n,:), means_clusters(k, :), sigma_clusters(:, :, k));
            prob(n) = prob(n) + p;
        end
    end
    disp('Probability finished')
end

