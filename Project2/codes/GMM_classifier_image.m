function [] = GMM_classifier_image( pathname )
    
    profile on;
    
    %%%Read training matrix from file (NON-ABSTRACT!!!)%%%
    filename = [pathname '\Class1_train.txt'];    
    trainmat1 = dlmread( filename );
    filename = [pathname '\Class2_train.txt'];    
    trainmat2 = dlmread( filename );
    filename = [pathname '\Class3_train.txt'];    
    trainmat3 = dlmread( filename );
    
    
    
    %%% Normalize each value of data between 0 to 1 %%%
%     min1=min(trainmat1);
%     norm_denom1=max(trainmat1)-min1;
%     trainmat1=bsxfun(@minus,trainmat1,min1);
%     trainmat1=bsxfun(@rdivide,trainmat1,norm_denom1)
%     
%     min2=min(trainmat2);
%     norm_denom2=max(trainmat2)-min2;
%     trainmat2=bsxfun(@minus,trainmat2,min2);
%     trainmat2=bsxfun(@rdivide,trainmat2,norm_denom2)
%     
%     min3=min(trainmat3);
%     norm_denom3=max(trainmat3)-min3;
%     trainmat3=bsxfun(@minus,trainmat3,min3);
%     trainmat3=bsxfun(@rdivide,trainmat3,norm_denom3)
%     
%     
    
    %%%Classifing for different cluster sizes%%%
    for k = [32]
        [pi_mat1, means_clusters1, sigma_clusters1] = GMM_parameters(trainmat1, k);         %Parameter estimation of clusters for different classes%
        [pi_mat2, means_clusters2, sigma_clusters2] = GMM_parameters(trainmat2, k);
        [pi_mat3, means_clusters3, sigma_clusters3] = GMM_parameters(trainmat3, k);
        
        %sigma_clusters1
        
        %%%Classifying test data of class 1%%%

        disp('Classifyitest data of class 1')
        
        filename = [pathname '\Class1_test.txt'];
        testmat = dlmread( filename );
        pT1C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);     %Probability of class1 testdata belongs to class1%
       pT1C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class1 testdata belongs to class2%
       pT1C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class1 testdata belongs to class3%
        
        size_m = size(pT1C1);
        num_patterns = size_m(1);
        segment_numbers = 36;
        num_images = num_patterns/segment_numbers;
        probT1C1 = zeros(num_images, 1);
        for n = 1:(num_images)
            p = 0;
            for c = 1:segment_numbers
                p = p + log(pT1C1( ((n-1) * segment_numbers) + c ));
            end
            probT1C1(n) = p;
        end
        
        probT1C2 = zeros(num_images, 1);
        for n = 1:(num_images)
            p = 0;
            for c = 1:segment_numbers
                p = p + log(pT1C2( ((n-1) * segment_numbers) + c ));
            end
            probT1C2(n) = p;
        end
        
        probT1C3 = zeros(num_images, 1);
     
        for n = 1:(num_images)
            p = 0;
            for c = 1:segment_numbers
                p = p + log(pT1C3( ((n-1) * segment_numbers) + c ));
            end
            probT1C3(n) = p;
        end
        
        num_attributes = 1;
        probT1 = zeros(num_images, num_attributes + 3);    % Attributes... ActualClass PredictedClass Prob %
        for n = 1:num_images
           probT1(n, 1) = n;
           probT1(n, num_attributes + 1) = 1;
           if ( (probT1C1(n) >= probT1C2(n)) && (probT1C1(n) >= probT1C3(n)) )
               probT1(n, num_attributes + 2) = 1;
               probT1(n, num_attributes + 3) = probT1C1(n);
           elseif ( probT1C2(n) >= probT1C3(n) )
               probT1(n, num_attributes + 2) = 2;
               probT1(n, num_attributes + 3) = probT1C2(n);
           else
               probT1(n, num_attributes + 2) = 3;
               probT1(n, num_attributes + 3) = probT1C3(n);
           end
        end
        
        %probT1C1%probT1C2
        %pause
%        probT1C3
        %pause
        
        
        %%%Classifying test data of class 2%%%
        filename = [pathname '\Class2_test.txt'];
        testmat = dlmread( filename );
        pT2C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class2 testdata belongs to class1%
        pT2C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class2 testdata belongs to class2%
        pT2C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class2 testdata belongs to class3%
        
        size_m = size(pT2C1);
        num_patterns = size_m(1);
        segment_numbers = 36;
        num_images = num_patterns/segment_numbers;
        probT2C1 = zeros(num_images, 1);
       
        for n = 1:(num_images)
             p = 0;
		for c = 1:segment_numbers
                p = p + log(pT2C1( ((n-1) * segment_numbers) + c ));
            end
            probT2C1(n) = p;
        end
        
        probT2C2 = zeros(num_images, 1);
        
        for n = 1:(num_images)
        p = 0;
            for c = 1:segment_numbers
                p = p + log(pT2C2( ((n-1) * segment_numbers) + c ));
            end
            probT2C2(n) = p;
        end
        
        probT2C3 = zeros(num_images, 1);
        for n = 1:(num_images)
            p = 0;
            for c = 1:segment_numbers
                p = p + log(pT2C3( ((n-1) * segment_numbers) + c ));
            end
            probT2C3(n) = p;
        end
        
        num_attributes = 1;
        probT2 = zeros( num_images, num_attributes + 3);    % Attributes... ActualClass PredictedClass Prob %
        for n = 1:num_images
           probT2(n, 1) = n;
           probT2(n, num_attributes + 1) = 2;
           if ( (probT2C1(n) >= probT2C2(n)) && (probT2C1(n) >= probT2C3(n)) )
               probT2(n, num_attributes + 2) = 1;
               probT2(n, num_attributes + 3) = probT2C1(n);
           elseif ( probT2C2(n) >= probT2C3(n) )
               probT2(n, num_attributes + 2) = 2;
               probT2(n, num_attributes + 3) = probT2C2(n);
           else
               probT2(n, num_attributes + 2) = 3;
               probT2(n, num_attributes + 3) = probT2C3(n);
           end
        end
        
        %%%Classifying test data of class 3%%%
        filename = [pathname '\Class3_test.txt'];
        testmat = dlmread( filename );
        pT3C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class3 testdata belongs to class1%
        pT3C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class3 testdata belongs to class2%
        pT3C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class3 testdata belongs to class3%
        
        size_m = size(pT3C1);
        num_patterns = size_m(1);
        segment_numbers = 36;
        num_images = num_patterns/segment_numbers;
        probT3C1 = zeros(num_images, 1);
        
        for n = 1:(num_images)
        p = 0;
            for c = 1:segment_numbers
                p = p + log(pT3C1( ((n-1) * segment_numbers) + c ));
            end
            probT3C1(n) = p;
        end
        
        probT3C2 = zeros(num_images, 1);
        
        for n = 1:(num_images)
        p = 0;
            for c = 1:segment_numbers
                p = p + log(pT3C2( ((n-1) * segment_numbers) + c ));
            end
            probT3C2(n) = p;
        end
        
        probT3C3 = zeros(num_images, 1);
        
        for n = 1:(num_images)
        p = 0;
            for c = 1:segment_numbers
                p = p +log( pT3C3( ((n-1) * segment_numbers) + c ));
            end
            probT3C3(n) = p;
        end
        
        num_attributes = 1;
        probT3 = zeros( num_images, num_attributes + 3);    % Attributes... ActualClass PredictedClass Prob %
        for n = 1:num_images
           probT3(n, 1) = n;
           probT3(n, num_attributes + 1) = 3;
           if ( (probT3C1(n) >= probT3C2(n)) && (probT3C1(n) >= probT3C3(n)) )
               probT3(n, num_attributes + 2) = 1;
               probT3(n, num_attributes + 3) = probT3C1(n);
           elseif ( probT3C2(n) >= probT3C3(n) )
               probT3(n, num_attributes + 2) = 2;
               probT3(n, num_attributes + 3) = probT3C2(n);
           else
               probT3(n, num_attributes + 2) = 3;
               probT3(n, num_attributes + 3) = probT3C3(n);
           end
        end
        
        
        %%%Output to file%%%
        filename = [pathname '\probT1_GMM_Cluster_' num2str(k) '.txt'];
        dlmwrite(filename, probT1);
        filename = [pathname '\probT2_GMM_Cluster_' num2str(k) '.txt'];
        dlmwrite(filename, probT2);
        filename = [pathname '\probT3_GMM_Cluster_' num2str(k) '.txt'];
        dlmwrite(filename, probT3);
        
        
        %%%Confusion Matrix%%%
        con_mat = con_mat_gen_image( probT1, probT2, probT3 );
        filename = [pathname '\con_mat_GMM_cluster_' num2str(k) '.txt'];
        fileID = fopen( filename, 'w' );
        fprintf(fileID, '%d %d %d\n', con_mat(1,1), con_mat(1,2), con_mat(1,3));
        fprintf(fileID, '%d %d %d\n', con_mat(2,1), con_mat(2,2), con_mat(2,3));
        fprintf(fileID, '%d %d %d\n', con_mat(3,1), con_mat(3,2), con_mat(3,3));
        [o, c1, c2, c3] = accuracy(con_mat);
        fprintf(fileID, '\n\n');
        fprintf(fileID, 'Overall Accuracy: %f\n', o);
        fprintf(fileID, 'Class 1 Accuracy: %f\n', c1);
        fprintf(fileID, 'Class 2 Accuracy: %f\n', c2);
        fprintf(fileID, 'Class 3 Accuracy: %f\n', c3);
        fclose('all');
    end
    
    profile viewer
    
end

