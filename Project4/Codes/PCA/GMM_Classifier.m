% WORKS ONLY FOR THREE CLASSES AND PLOTTING ONLY FOR l = 1 OR 2
% 
% Linear: -5 25 -15 15 0.01 0.01
% Speech: -1800 -200 -15 15 1 0.01
% Image1: 
% Image2: 

function [] = GMM_Classifier( pathname, l )

    profile on;
    
    [ pathname, ~, ~ ] = PCA( pathname, l );
    
    filename = [pathname '\Class1_train.txt'];    
    trainmat1 = dlmread( filename );
    filename = [pathname '\Class2_train.txt'];    
    trainmat2 = dlmread( filename );
    filename = [pathname '\Class3_train.txt'];    
    trainmat3 = dlmread( filename );
    
    %%%Classifing for different cluster sizes%%%
    for k = 8
        [pi_mat1, means_clusters1, sigma_clusters1] = GMM_parameters(trainmat1, k);         %Parameter estimation of clusters for different classes%
        [pi_mat2, means_clusters2, sigma_clusters2] = GMM_parameters(trainmat2, k);
        [pi_mat3, means_clusters3, sigma_clusters3] = GMM_parameters(trainmat3, k);
        
        %%%Classifying test data of class 1%%%
        filename = [pathname '\Class1_test.txt'];
        testmat = dlmread( filename );
        probT1C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class1 testdata belongs to class1%
        probT1C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class1 testdata belongs to class2%
        probT1C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class1 testdata belongs to class3%
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
        probT2C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class2 testdata belongs to class1%
        probT2C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class2 testdata belongs to class2%
        probT2C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class2 testdata belongs to class3%
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
        probT3C1 = probability(testmat, pi_mat1, means_clusters1, sigma_clusters1, k);      %Probability of class3 testdata belongs to class1%
        probT3C2 = probability(testmat, pi_mat2, means_clusters2, sigma_clusters2, k);      %Probability of class3 testdata belongs to class2%
        probT3C3 = probability(testmat, pi_mat3, means_clusters3, sigma_clusters3, k);      %Probability of class3 testdata belongs to class3%
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
        
        filename = [pathname '\probT1_GMM_k_' num2str(k) '.txt'];
        dlmwrite(filename, probT1);
        filename = [pathname '\probT2_GMM_k_' num2str(k) '.txt'];
        dlmwrite(filename, probT2);
        filename = [pathname '\probT3_GMM_k_' num2str(k) '.txt'];
        dlmwrite(filename, probT3);
        
        
        %%%plotting graph%%%
        if (l == 1 || l == 2)
            col1 = [255, 127, 127] / 255;
            col2 = [127, 255, 127] / 255;
            col3 = [127, 127, 255] / 255;
            min_x_range = 5;
            max_x_range = 35;
            min_y_range = -15;
            max_y_range = 15;
            step_x = 0.02;
            step_y = 0.02;
            t = ['\bf Bayes Classifier for k = ' num2str(k) ' and l = ' num2str(l)];
            l1 = 'Class 1';
            l2 = 'Class 2';
            l3 = 'Class 3';
            if (l == 1)
                x_lab = '\bf \color{magenta}Examples in 1 dimension';
                pixel = min_x_range : step_x : max_x_range;
                pixel = pixel';
            else
                x_lab = '\bf \color{magenta}Feature 1';
                y_lab = '\bf \color{magenta}Feature 2';
                pixel = pixel_gen(min_x_range, max_x_range, step_x, min_y_range, max_y_range, step_y);
            end
            probC1 = probability(pixel, pi_mat1, means_clusters1, sigma_clusters1, k);
            probC2 = probability(pixel, pi_mat2, means_clusters2, sigma_clusters2, k);
            probC3 = probability(pixel, pi_mat3, means_clusters3, sigma_clusters3, k);
            if (l == 1)
                pixel = add_Dimension(pixel, 0);
            end
            plot3class(pixel, probC1, probC2, probC3, col1, col2, col3);
            hold on;
            filename = [pathname '\Class1_train.txt'];
            trainmat1 = dlmread( filename );
            filename = [pathname '\Class2_train.txt'];
            trainmat2 = dlmread( filename );
            filename = [pathname '\Class3_train.txt'];
            trainmat3 = dlmread( filename );
            if (l == 1)
                trainmat1 = add_Dimension(trainmat1, 0);
                trainmat2 = add_Dimension(trainmat2, 0);
                trainmat3 = add_Dimension(trainmat3, 0);
            end
            plottrain(trainmat1, 'r^');
            plottrain(trainmat2, 'go');
            plottrain(trainmat3, 'bs');
            if (l == 1)
                xlabel(x_lab), title(t) , legend(l1, l2, l3);
            else
                xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1, l2, l3);
            end
            axis square;
            axis ([min_x_range max_x_range min_y_range max_y_range]);
            print([pathname '\bc_GMM_k_' num2str(k)], '-dpng', '-r0');
            if (l == 1)
                figure;
                t = ['\bf Bayes Classifier for k = ' num2str(k) ' and l = ' num2str(l) ' (For better visualisation)'];
                plot3class(pixel, probC1, probC2, probC3, col1, col2, col3);
                hold on;
                filename = [pathname '\Class1_train.txt'];
                trainmat1 = dlmread( filename );
                filename = [pathname '\Class2_train.txt'];
                trainmat2 = dlmread( filename );
                filename = [pathname '\Class3_train.txt'];
                trainmat3 = dlmread( filename );
                if (l == 1)
                    trainmat1 = add_Dimension(trainmat1, 0.5);
                    trainmat2 = add_Dimension(trainmat2, 1);
                    trainmat3 = add_Dimension(trainmat3, 1.5);
                end
                plottrain(trainmat1, 'r^');
                plottrain(trainmat2, 'go');
                plottrain(trainmat3, 'bs');
                if (l == 1)
                    xlabel(x_lab), title(t) , legend(l1, l2, l3);
                else
                    xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1, l2, l3);
                end
                axis square;
                axis ([min_x_range max_x_range min_y_range max_y_range]);
                print([pathname '\bc_GMM_for_better_visualisation_k_' num2str(k)], '-dpng', '-r0');
            end
        end
        
        
        %%%Confusion Matrix%%%
        con_mat = con_mat_gen( l+2, probT1, probT2, probT3 );
        filename = [pathname '\con_mat_bc_GMM_k_' num2str(k) '.txt'];
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

