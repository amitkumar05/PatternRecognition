function [ pi_mat, mean_clusters, sigma_clusters ] = reestimate_theta( input_mat, gamma_mat, num_clusters )
    %disp('inside reestimate')
    size_input_mat = size(input_mat);
    num_patterns = size_input_mat(1);
    num_attributes = size_input_mat(2);
    
    mean_clusters = zeros(num_clusters, num_attributes);
    sigma_clusters = zeros(num_attributes, num_attributes, num_clusters);
    
    Nk = sum(gamma_mat);
    Nk = Nk';

    %%%reestimate for pi(s)%%%
    pi_mat = Nk / num_patterns;

    %%%reestimate for means%%%
    for k = 1:num_clusters
        mat_temp = zeros(num_patterns, num_attributes);
        for n = 1:num_patterns
            mat_temp(n, :) = gamma_mat(n, k) * input_mat(n, :);
        end
        sum_temp = sum(mat_temp);
%         if(Nk(k) == 0)
%            disp('lajisdhawihdowaihdwaodiwahiwhfwahfwahfaofchaohfcwao')
%            sum_temp
%         end
        mean_clusters(k, :) = sum_temp / Nk(k);
    end

    %%%reestimate for sigmas%%%
    for k = 1:num_clusters
        mat_temp = zeros(num_attributes, num_attributes);
        for n = 1:num_patterns
            sig_temp = ( input_mat(n, :) - mean_clusters(k, :) );
            mat_temp = mat_temp + ( gamma_mat(n, k) * (sig_temp') * sig_temp );
        end
        sigma_clusters(:, :, k) = mat_temp / Nk(k);
    end
end

