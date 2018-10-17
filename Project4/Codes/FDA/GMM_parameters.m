function [ pi_mat, mean_clusters, sigma_clusters ] = GMM_parameters( input_mat, num_clusters )
    %disp('In GMM Parameters')
    size_input_mat = size(input_mat);
    num_patterns = size_input_mat(1);
    [mean_clusters, Znk_mat, num_elements_clusters] = k_means(input_mat, num_clusters);
%    disp('Out Of K-means')
%     mean_clusters
%     Znk_mat
%     num_elements_clusters
    sigma_clusters = sigma_mat(Znk_mat, input_mat);
    
    pi_mat = zeros(num_clusters, 1);
    
    for k = 1:num_clusters
        pi_mat(k) = num_elements_clusters(k) / num_patterns;
    end
%     pi_mat
 %   disp('Call For Lun For Old')
    ln_theta_old = lun(input_mat, pi_mat, mean_clusters, sigma_clusters, num_clusters);
    
    
    %i = 1;
    
    
    while(1)
    %for i=1:20
        %i
        gamma_mat = response_mat(input_mat, pi_mat, mean_clusters, sigma_clusters);
        
        [pi_mat, mean_clusters, sigma_clusters] = reestimate_theta(input_mat, gamma_mat, num_clusters);
%         mean_clusters
        ln_theta_new = lun(input_mat, pi_mat, mean_clusters, sigma_clusters, num_clusters);
        
        if( abs(ln_theta_new-ln_theta_old) < 0.01 )
            break
        end
       
        ln_theta_old = ln_theta_new;
        %i = i + 1;
    end
    
end

