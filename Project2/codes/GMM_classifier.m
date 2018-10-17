function [] = GMM_classifier( pathname )
    
    profile on;
    
    %%%Read training matrix from file%%%
    filename = [pathname '\Class1_train.txt'];    
    trainmat1 = dlmread( filename );
    filename = [pathname '\Class2_train.txt'];    
    trainmat2 = dlmread( filename );
    filename = [pathname '\Class3_train.txt'];    
    trainmat3 = dlmread( filename );
    
    %%%Classifing for different cluster sizes%%%
    for k = 2:8
        disp('Going to calculate parameters')
        [pi_mat1, means_clusters1, sigma_clusters1] = GMM_parameters(trainmat1, k);         %Parameter estimation of clusters for different classes%
        disp('Calculated parameter 1')
        [pi_mat2, means_clusters2, sigma_clusters2] = GMM_parameters(trainmat2, k);
        disp('Caculated paqrameter 2')
        [pi_mat3, means_clusters3, sigma_clusters3] = GMM_parameters(trainmat3, k);
        disp('Calculated parameter 3')
        
        %%%Classifying test data of class 1%%%
        filename = [pathname '\Class1_test.txt'];
        testmat = dlmread( filename );
        disp('Going to calculate probability')
        probT1C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class1 testdata belongs to class1%
        disp('Prob 1')
        probT1C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class1 testdata belongs to class2%
        disp('Prob 2')
        probT1C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class1 testdata belongs to class3%
        disp('Prob 3')
        size_m = size(testmat);
        num_patterns = size_m(1);
        num_attributes = size_m(2);
        probT1 = zeros( num_patterns, num_attributes + 3);    % Attributes... ActualClass PredictedClass Prob %
        for n = 1:num_patterns
           probT1(n, 1:num_attributes) = testmat(n, :);
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
        
        %%%Classifying test data of class 2%%%
        filename = [pathname '\Class2_test.txt'];
        testmat = dlmread( filename );
        disp('1 2 3')
        probT2C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class2 testdata belongs to class1%
        disp('1')
        probT2C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class2 testdata belongs to class2%
        disp('2')
        probT2C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class2 testdata belongs to class3%
        disp('3')
        size_m = size(testmat);
        num_patterns = size_m(1);
        num_attributes = size_m(2);
        probT2 = zeros( num_patterns, num_attributes + 3);    % Attributes... ActualClass PredictedClass Prob %
        for n = 1:num_patterns
           probT2(n, 1:num_attributes) = testmat(n, :);
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
        disp('1 2 3')
        probT3C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class3 testdata belongs to class1%
        disp('1')
        probT3C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class3 testdata belongs to class2%
        disp('2')
        probT3C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class3 testdata belongs to class3%
        disp('3')
        size_m = size(testmat);
        num_patterns = size_m(1);
        num_attributes = size_m(2);
        probT3 = zeros( num_patterns, num_attributes + 3);    % Attributes... ActualClass PredictedClass Prob %
        for n = 1:num_patterns
           probT3(n, 1:num_attributes) = testmat(n, :);
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
    
    
        %%%plotting graph%%%
        col1=[255, 209, 209]/255;
        col2=[218, 255, 145]/255;
        col3=[194, 224, 255]/255;
        x_lab='\bf \color{magenta}Feature 1';
        y_lab='\bf \color{magenta}Feature 2';
        t=['\bf GMM for cluster size: ' num2str(k)];
        l1='Class 1';
        l2='Class 2';
        l3='Class 3';

        %pixel = pixel_gen(-500, 1500, 2, 100, 1900, 12);
        pixel = pixel_gen(-20, 20, 0.1, -20, 20, 0.1);    %For Overlapping Data

        p1 = probability(pixel, pi_mat1, means_clusters1, sigma_clusters1, k);
        p2 = probability(pixel, pi_mat2, means_clusters2, sigma_clusters2, k);
        p3 = probability(pixel, pi_mat3, means_clusters3, sigma_clusters3, k);
        plot3class(pixel, p1, p2, p3, col1, col2, col3);
        axis equal;

        hold on;


        filename = [pathname '\Class1_train.txt'];
        trainmat = dlmread( filename );
        plottrain(trainmat, 'r^');
        filename = [pathname '\Class2_train.txt'];
        trainmat = dlmread( filename );
        plottrain(trainmat, 'go');
        filename = [pathname '\Class3_train.txt'];
        trainmat = dlmread( filename );
        plottrain(trainmat, 'bs');
        xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1,l2,l3,l1,l2,l3);

        %axis ([-500 1500 100 1900]);
        axis ([-20 20 -20 20]);
        print([pathname '\GMM_cluster_' num2str(k)], '-dpng', '-r0');
        
        
        %%%Output to file%%%
        filename = [pathname '\probT1_GMM_Cluster_' num2str(k) '.txt'];
        dlmwrite(filename, probT1);
        filename = [pathname '\probT2_GMM_Cluster_' num2str(k) '.txt'];
        dlmwrite(filename, probT2);
        filename = [pathname '\probT3_GMM_Cluster_' num2str(k) '.txt'];
        dlmwrite(filename, probT3);
        
        
        %%%Confusion Matrix%%%
        con_mat = con_mat_gen( probT1, probT2, probT3 );
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

