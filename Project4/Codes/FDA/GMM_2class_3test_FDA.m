function [probT1,probT2,probT3] = GMM_2class_3test_FDA( tr_pos,tr_neg,te1,te2,te3,pos_no,neg_no,K)

%%%Classifing for different cluster sizes%%%
for k = [K]
    %for k = [4 8 12 16 20]
    [pi_mat1, means_clusters1, sigma_clusters1] = GMM_parameters(tr_pos, k);         %Parameter estimation of clusters for different classes%
    [pi_mat2, means_clusters2, sigma_clusters2] = GMM_parameters(tr_neg, k);
    
    %%%Classifying test data of class 1%%%
    probT1C1 = probability(te1, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class1 testdata belongs to class1%
    probT1C2 = probability(te1, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class1 testdata belongs to class2%
    size_m = size(te1);
    num_patterns = size_m(1);
    probT1 = zeros( num_patterns,3);    % ActualClass PredictedClass Prob %
    for n = 1:num_patterns
        probT1(n, 1) = 1;
        if ( probT1C1(n) >= probT1C2(n) )
            probT1(n, 2) = pos_no;
            probT1(n, 3) = probT1C1(n);
        else
            probT1(n, 2) = neg_no;
            probT1(n, 3) = probT1C2(n);
        end
    end
    
    %%%Classifying test data of class 2%%%
    probT2C1 = probability(te2, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class2 testdata belongs to class1%
    probT2C2 = probability(te2, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class2 testdata belongs to class2%
    size_m = size(te2);
    num_patterns = size_m(1);
    probT2 = zeros( num_patterns, 3);    % ActualClass PredictedClass Prob %
    for n = 1:num_patterns
        probT2(n, 1) = 2;
        if ( probT2C1(n) >= probT2C2(n) )
            probT2(n, 2) = pos_no;
            probT2(n, 3) = probT2C1(n);
        else
            probT2(n, 2) = neg_no;
            probT2(n, 3) = probT2C2(n);
        end
    end
    
    %%%Classifying test data of class 3%%%
    probT3C1 = probability(te3, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class3 testdata belongs to class1%
    probT3C2 = probability(te3, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class3 testdata belongs to class2%
    size_m = size(te3);
    num_patterns = size_m(1);
    probT3 = zeros( num_patterns, 3);    % ActualClass PredictedClass Prob %
    for n = 1:num_patterns
        probT3(n, 1) = 3;
        if ( probT3C1(n) >= probT3C2(n) )
            probT3(n,  2) = pos_no;
            probT3(n,  3) = probT3C1(n);
        else
            probT3(n,  2) = neg_no;
            probT3(n,  3) = probT3C2(n);
        end
    end
    
end
end