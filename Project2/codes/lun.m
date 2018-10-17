function [ ln_theta ] = lun( input_mat, pi_mat, means_clusters, sigma_clusters, num_clusters )
    disp('Inside lun function')
    size_input_mat = size(input_mat);
    num_patterns = size_input_mat(1);
    
    ln_theta = 0;
    for n = 1:num_patterns
        x = 0;
        for k = 1:num_clusters
            x = x + pi_mat(k) * gauss_dis(input_mat(n,:), means_clusters(k, :), sigma_clusters(:, :, k));
        end
        ln_theta = ln_theta + log(x);
    end
    disp('lun function completed')
end

