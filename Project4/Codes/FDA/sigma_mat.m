function [ sigma_clusters ] = sigma_mat( Znk_mat, input_mat )
    
    size_Znk_mat = size(Znk_mat);
    size_input_mat = size(input_mat);
    
    num_clusters = size_Znk_mat(2);
    num_patterns = size_input_mat(1);
    num_attributes = size_input_mat(2);
    
    A = zeros(num_attributes, num_attributes);
    size_cluster_mat = zeros(num_clusters, 1);
    sigma_clusters = zeros(num_attributes, num_attributes, num_clusters);
    
%     for k = 1:(num_clusters - 1)
%         sigma_clusters = cat(3, sigma_clusters, A); 
%     end
    
    for k = 1:num_clusters
        A = zeros(1, num_attributes);
        for n = 1:num_patterns
            if ( Znk_mat(n, k) )
                size_cluster_mat(k) = size_cluster_mat(k) + 1;
                A(size_cluster_mat(k), :) = input_mat(n, :);
            end
        end
        sigma_clusters(:, :, k) = cov(A);
    end
    
end

