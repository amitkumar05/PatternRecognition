function [] = GMM_classifier_2( pathname )
    
    profile on;
    
    %%%Read training matrix from file%%%
    filename = [pathname '\Class1_train.txt'];    
    trainmat1 = dlmread( filename );
    filename = [pathname '\Class2_train.txt'];    
    trainmat2 = dlmread( filename );
    
    %%%Classifing for different cluster sizes%%%
    for k = 2:8
    %for k = [4 8 12 16 20]
        [pi_mat1, means_clusters1, sigma_clusters1] = GMM_parameters(trainmat1, k);         %Parameter estimation of clusters for different classes%
        [pi_mat2, means_clusters2, sigma_clusters2] = GMM_parameters(trainmat2, k);
        
        %%%Classifying test data of class 1%%%
        filename = [pathname '\Class1_test.txt'];
        testmat = dlmread( filename );
        probT1C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class1 testdata belongs to class1%
        probT1C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class1 testdata belongs to class2%
        size_m = size(testmat);
        num_patterns = size_m(1);
        num_attributes = size_m(2);
        probT1 = zeros( num_patterns, num_attributes + 3);    % Attributes... ActualClass PredictedClass Prob %
        for n = 1:num_patterns
           probT1(n, 1:num_attributes) = testmat(n, :);
           probT1(n, num_attributes + 1) = 1;
           if ( probT1C1(n) >= probT1C2(n) )
               probT1(n, num_attributes + 2) = 1;
               probT1(n, num_attributes + 3) = probT1C1(n);
           else
               probT1(n, num_attributes + 2) = 2;
               probT1(n, num_attributes + 3) = probT1C2(n);
           end
        end
        
        %%%Classifying test data of class 2%%%
        filename = [pathname '\Class2_test.txt'];
        testmat = dlmread( filename );
        probT2C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class2 testdata belongs to class1%
        probT2C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class2 testdata belongs to class2%
        size_m = size(testmat);
        num_patterns = size_m(1);
        num_attributes = size_m(2);
        probT2 = zeros( num_patterns, num_attributes + 3);    % Attributes... ActualClass PredictedClass Prob %
        for n = 1:num_patterns
           probT2(n, 1:num_attributes) = testmat(n, :);
           probT2(n, num_attributes + 1) = 2;
           if ( probT2C1(n) >= probT2C2(n) )
               probT2(n, num_attributes + 2) = 1;
               probT2(n, num_attributes + 3) = probT2C1(n);
           else
               probT2(n, num_attributes + 2) = 2;
               probT2(n, num_attributes + 3) = probT2C2(n);
           end
        end
        
         
         %%%plotting graph%%%
         col1=[255, 209, 209]/255;
         col2=[218, 255, 145]/255;
         x_lab='\bf \color{magenta}Feature 1';
         y_lab='\bf \color{magenta}Feature 2';
         t=['\bf GMM for cluster size: ' num2str(k)];
         l1='Class 1';
         l2='Class 2';
 
 
         %pixel = pixel_gen(-4, 4, 0.01, -4, 4, 0.01);
         pixel = pixel_gen(-30, 30, 0.1, -30, 30, 0.1);    %For Spiral data
         p1 = probability(pixel, pi_mat1, means_clusters1, sigma_clusters1, k);
         p2 = probability(pixel, pi_mat2, means_clusters2, sigma_clusters2, k);
         plot2class(pixel, p1, p2, col1, col2);
 
         filename = [pathname '\Class1_train.txt'];
         trainmat = dlmread( filename );
         plottrain(trainmat, 'r^');
         filename = [pathname '\Class2_train.txt'];
         trainmat = dlmread( filename );
         plottrain(trainmat, 'go');
         xlabel(x_lab), ylabel(y_lab), title(t), legend(l1,l2,l1,l2);
 
         axis equal;
         %axis ([-4 4 -4 4]);
         axis ([-30 30 -30 30]);
         print([pathname '\GMM_cluster_' num2str(k)], '-dpng', '-r0');
         
         
         %%%Output to file%%%
         filename = [pathname '\probT1_GMM_Cluster_' num2str(k) '.txt'];
         dlmwrite(filename, probT1);
         filename = [pathname '\probT2_GMM_Cluster_' num2str(k) '.txt'];
         dlmwrite(filename, probT2);
         
         
         %%%Confusion Matrix%%%
         con_mat = con_mat_gen( probT1, probT2 );
         filename = [pathname '\con_mat_GMM_cluster_' num2str(k) '.txt'];
         fileID = fopen( filename, 'w' );
         fprintf(fileID, '%d %d\n', con_mat(1,1), con_mat(1,2));
         fprintf(fileID, '%d %d\n', con_mat(2,1), con_mat(2,2));
         [o, c1, c2] = accuracy_2(con_mat);
         fprintf(fileID, '\n\n');
         fprintf(fileID, 'Overall Accuracy: %f\n', o);
         fprintf(fileID, 'Class 1 Accuracy: %f\n', c1);
         fprintf(fileID, 'Class 2 Accuracy: %f\n', c2);
         fclose('all');
   end
    
    profile viewer
    
end

