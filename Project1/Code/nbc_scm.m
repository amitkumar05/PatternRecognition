%
%
function [] = nbc_scm( pathname )
    
    profile on;
    
    
    filename = [pathname '\Class1_train.txt'];    
    trainmat = readmat( filename );
    mu1 = (mean(trainmat))';
    covmat1 = cov(trainmat);
    
    filename = [pathname '\Class2_train.txt'];    
    trainmat = readmat( filename );
    mu2 = (mean(trainmat))';
    covmat2 = cov(trainmat);
    
    filename = [pathname '\Class3_train.txt'];    
    trainmat = readmat( filename );
    mu3 = (mean(trainmat))';
    covmat3 = cov(trainmat);
    
    v1 = diag(covmat1);
    v2 = diag(covmat2);
    v3 = diag(covmat3);
    vmean = avg_mat(v1, v2, v3);
    covmat = diag(vmean);
    
    
    %%%Class1 test set%%%
    filename = [pathname '\Class1_test.txt'];
    testmat = readmat( filename );
    probT1C1 = posterior(testmat, mu1, covmat);
    probT1C2 = posterior(testmat, mu2, covmat);
    probT1C3 = posterior(testmat, mu3, covmat);
    size_m = size(probT1C1);
    row = size_m(1);
    probT1 = zeros( row, 5);    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
       probT1(k, 1) = testmat(k, 1);
       probT1(k, 2) = testmat(k, 2);
       probT1(k, 3) = 1;
       if ( (probT1C1(k) >= probT1C2(k)) && (probT1C1(k) >= probT1C3(k)) )
           probT1(k, 4) = 1;
           probT1(k, 5) = probT1C1(k);
       elseif ( probT1C2(k) >= probT1C3(k) )
           probT1(k, 4) = 2;
           probT1(k, 5) = probT1C2(k);
       else
           probT1(k, 4) = 3;
           probT1(k, 5) = probT1C3(k);
       end
    end
    
    
    %%%Class2 test set%%%
    filename = [pathname '\Class2_test.txt'];
    testmat = readmat( filename );
    probT2C1 = posterior(testmat, mu1, covmat);
    probT2C2 = posterior(testmat, mu2, covmat);
    probT2C3 = posterior(testmat, mu3, covmat);
    size_m = size(probT2C1);
    row = size_m(1);
    probT2 = zeros( row, 5);    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
       probT2(k, 1) = testmat(k, 1);
       probT2(k, 2) = testmat(k, 2);
       probT2(k, 3) = 2;
       if ( (probT2C1(k) >= probT2C2(k)) && (probT2C1(k) >= probT2C3(k)) )
           probT2(k, 4) = 1;
           probT2(k, 5) = probT2C1(k);
       elseif ( probT2C2(k) >= probT2C3(k) )
           probT2(k, 4) = 2;
           probT2(k, 5) = probT2C2(k);
       else
           probT2(k, 4) = 3;
           probT2(k, 5) = probT2C3(k);
       end
    end
    
    
    %%%Class3 test set%%%
    filename = [pathname '\Class3_test.txt'];
    testmat = readmat( filename );
    probT3C1 = posterior(testmat, mu1, covmat);
    probT3C2 = posterior(testmat, mu2, covmat);
    probT3C3 = posterior(testmat, mu3, covmat);
    size_m = size(probT3C1);
    row = size_m(1);
    probT3 = zeros( row, 5);    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
       probT3(k, 1) = testmat(k, 1);
       probT3(k, 2) = testmat(k, 2);
       probT3(k, 3) = 3;
       if ( (probT3C1(k) >= probT3C2(k)) && (probT3C1(k) >= probT3C3(k)) )
           probT3(k, 4) = 1;
           probT3(k, 5) = probT3C1(k);
       elseif ( probT3C2(k) >= probT3C3(k) )
           probT3(k, 4) = 2;
           probT3(k, 5) = probT3C2(k);
       else
           probT3(k, 4) = 3;
           probT3(k, 5) = probT3C3(k);
       end
    end
    
    
    %%%file output for probT1, probT2, probT3%%%
    filename = [pathname '\probT1_nbc_scm.txt'];
    writemat(filename, probT1);
    filename = [pathname '\probT2_nbc_scm.txt'];
    writemat(filename, probT2);
    filename = [pathname '\probT3_nbc_scm.txt'];
    writemat(filename, probT3);
    
    
    col1=[255, 209, 209]/255;
    col2=[218, 255, 145]/255;
    col3=[194, 224, 255]/255;
    x_lab='\bf \color{magenta}Feature 1';
    y_lab='\bf \color{magenta}Feature 2';
    t='\bf Naive Bayes Classifier with same covariance matrices';
    l1='Class 1';
    l2='Class 2';
    l3='Class 3';
    
    %%%plotting graph%%%
%    pixel = pixel_gen(-30, 30, 0.1, -30, 30, 0.1);
    pixel = pixel_gen(-500, 2000, 10, -500, 2000, 10);
    p1 = posterior(pixel, mu1, covmat);
    p2 = posterior(pixel, mu2, covmat);
    p3 = posterior(pixel, mu3, covmat);
    %plot3class(pixel, p1, p2, p3);
    plot3class(pixel, p1, p2, p3,col1,col2,col3);
    hold on;
    
    
    filename = [pathname '\Class1_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'r^');
    filename = [pathname '\Class2_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'go');
    filename = [pathname '\Class3_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'bs');
    xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1,l2,l3,l1,l2,l3);

      plot([mu1(1);mu2(1);mu3(1);mu1(1)],[mu1(2);mu2(2);mu3(2);mu1(2)],'k');
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis equal;
%    axis ([-30 30 -30 30]);
    axis ([-500 2000 -500 2000]);
    print([pathname '\nbc_scm_allclass'], '-dpng', '-r0');
    
    %%%Plot for two classes%%%
    figure;
    plot2class(pixel, p1, p2, col1,col2);
    filename = [pathname '\Class1_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'r^');
    filename = [pathname '\Class2_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'go');
    xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1,l2,l1,l2);

         plot([mu1(1);mu2(1);mu1(1)],[mu1(2);mu2(2);mu1(2)],'k');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis equal;
%    axis ([-30 30 -30 30]);
    axis ([-500 2000 -500 2000]);
    print([pathname '\nbc_scm_class12'], '-dpng', '-r0');

    
    figure;
    plot2class(pixel, p2, p3,col2,col3);
    filename = [pathname '\Class2_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'go');
    filename = [pathname '\Class3_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'bs');
    xlabel(x_lab), ylabel(y_lab), title(t) , legend(l2,l3,l2,l3);

        plot([mu2(1);mu3(1);mu2(1)],[mu2(2);mu3(2);mu2(2)],'k');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis equal;
%    axis ([-30 30 -30 30]);
    axis ([-500 2000 -500 2000]);
    print([pathname '\nbc_scm_class23'], '-dpng', '-r0');
    
    figure;
    plot2class(pixel, p1, p3,col1,col3);
    filename = [pathname '\Class1_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'r^');
    filename = [pathname '\Class3_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'bs');
    xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1,l3,l1,l3);
    
        plot([mu1(1);mu3(1);mu1(1)],[mu1(2);mu3(2);mu1(2)],'k');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis equal;
%    axis ([-30 30 -30 30]);
    axis ([-500 2000 -500 2000]);
    print([pathname '\nbc_scm_class13'], '-dpng', '-r0');

    %%%Confusion Matrix%%%
    con_mat = con_mat_gen( probT1, probT2, probT3 );
    filename = [pathname '\con_mat_nbc_scm.txt'];
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
