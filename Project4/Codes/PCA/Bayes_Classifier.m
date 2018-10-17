% WORKS ONLY FOR THREE CLASSES AND PLOTTING ONLY FOR l = 1 OR 2
% This function classifies using bayes classifier
% for same covariance matrix
% after reducing the data dimension to 'l'
% pixel = pixel_gen(-30, 30, 0.1, -30, 30, 0.1);
% pixel = pixel_gen(-500, 2000, 10, -500, 2000, 10);
% 
% Linear: -5 25 -15 15 0.01 0.01
% Speech: -1800 -200 -15 15 1 0.01
% Images: 5 35 -15 15 0.01 0.01 

function [  ] = Bayes_Classifier( pathname, l )
    
    profile on;
    
    [ pathname, ~, lEigenValues ] = PCA( pathname, l );
    
    file = '\Class1_train.txt';
    filename = [pathname file];
    trainmat = dlmread( filename );
    mu1 = (mean(trainmat))';
    
    file = '\Class2_train.txt';
    filename = [pathname file];
    trainmat = dlmread( filename );
    mu2 = (mean(trainmat))';
    
    file = '\Class3_train.txt';
    filename = [pathname file];
    trainmat = dlmread( filename );
    mu3 = (mean(trainmat))';
    
    covmat = lEigenValues(1:l);
    
    covmat = diag(covmat);
    
    %%%Class1 test set%%%
    filename = [pathname '\Class1_test.txt'];
    testmat = dlmread( filename );
    probT1C1 = posterior(testmat, mu1, covmat);
    probT1C2 = posterior(testmat, mu2, covmat);
    probT1C3 = posterior(testmat, mu3, covmat);
    size_m = size(probT1C1);
    row = size_m(1);
    probT1 = zeros( row, l+3 );    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
        probT1(k, 1:l) = testmat(k, :);
        probT1(k, l+1) = 1;
        if ( (probT1C1(k) >= probT1C2(k)) && (probT1C1(k) >= probT1C3(k)) )
           probT1(k, l+2) = 1;
           probT1(k, l+3) = probT1C1(k);
        elseif ( probT1C2(k) >= probT1C3(k) )
           probT1(k, l+2) = 2;
           probT1(k, l+3) = probT1C2(k);
        else
           probT1(k, l+2) = 3;
           probT1(k, l+3) = probT1C3(k);
        end
    end
    
    
    %%%Class2 test set%%%
    filename = [pathname '\Class2_test.txt'];
    testmat = dlmread( filename );
    probT2C1 = posterior(testmat, mu1, covmat);
    probT2C2 = posterior(testmat, mu2, covmat);
    probT2C3 = posterior(testmat, mu3, covmat);
    size_m = size(probT2C1);
    row = size_m(1);
    probT2 = zeros( row, l+3 );    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
        probT2(k, 1:l) = testmat(k, :);
        probT2(k, l+1) = 2;
        if ( (probT2C1(k) >= probT2C2(k)) && (probT2C1(k) >= probT2C3(k)) )
           probT2(k, l+2) = 1;
           probT2(k, l+3) = probT2C1(k);
        elseif ( probT2C2(k) >= probT2C3(k) )
           probT2(k, l+2) = 2;
           probT2(k, l+3) = probT2C2(k);
        else
           probT2(k, l+2) = 3;
           probT2(k, l+3) = probT2C3(k);
        end
    end
    
    
    %%%Class3 test set%%%
    filename = [pathname '\Class3_test.txt'];
    testmat = dlmread( filename );
    probT3C1 = posterior(testmat, mu1, covmat);
    probT3C2 = posterior(testmat, mu2, covmat);
    probT3C3 = posterior(testmat, mu3, covmat);
    size_m = size(probT3C1);
    row = size_m(1);
    probT3 = zeros( row, l+3 );    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
        probT3(k, 1:l) = testmat(k, :);
        probT3(k, l+1) = 3;
        if ( (probT3C1(k) >= probT3C2(k)) && (probT3C1(k) >= probT3C3(k)) )
           probT3(k, l+2) = 1;
           probT3(k, l+3) = probT3C1(k);
        elseif ( probT3C2(k) >= probT3C3(k) )
           probT3(k, l+2) = 2;
           probT3(k, l+3) = probT3C2(k);
        else
           probT3(k, l+2) = 3;
           probT3(k, l+3) = probT3C3(k);
        end
    end
    
    
    %%%file output for probT1, probT2, probT3%%%
    filename = [pathname '\probT1_bc_unimodal.txt'];
    dlmwrite(filename, probT1);
    filename = [pathname '\probT2_bc_unimodal.txt'];
    dlmwrite(filename, probT2);
    filename = [pathname '\probT3_bc_unimodal.txt'];
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
        step_x = 0.01;
        step_y = 0.01;
        t = ['\bf Bayes Classifier for l = ' num2str(l)];
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
        probC1 = posterior(pixel, mu1, covmat);
        probC2 = posterior(pixel, mu2, covmat);
        probC3 = posterior(pixel, mu3, covmat);
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
            plot(mu1,0,'kx');
            plot(mu2,0,'kx');
            plot(mu3,0,'kx');
        else
            xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1, l2, l3);
            plot([mu1(1);mu2(1);mu3(1);mu1(1)],[mu1(2);mu2(2);mu3(2);mu1(2)],'kx');
        end
        axis square;
        axis ([min_x_range max_x_range min_y_range max_y_range]);
        print([pathname '\bc_unimodal'], '-dpng', '-r0');
        if (l == 1)
            figure;
            t = ['\bf Bayes Classifier for l = ' num2str(l) ' (For better visualisation)'];
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
                plot(mu1,0,'kx');
                plot(mu2,0,'kx');
                plot(mu3,0,'kx');
            else
                xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1, l2, l3);
                plot([mu1(1);mu2(1);mu3(1);mu1(1)],[mu1(2);mu2(2);mu3(2);mu1(2)],'kx');
            end
            axis square;
            axis ([min_x_range max_x_range min_y_range max_y_range]);
            print([pathname '\bc_unimodal_for_better_visualisation'], '-dpng', '-r0');
        end
    end
    
    
    %%%Confusion Matrix%%%
    con_mat = con_mat_gen( l+2, probT1, probT2, probT3 );
    filename = [pathname '\con_mat_bc_unimodal.txt'];
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
    
    
    profile viewer
end