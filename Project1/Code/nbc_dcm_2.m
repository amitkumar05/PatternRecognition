%
%
function [] = nbc_dcm_2( pathname )
    
    profile on;
    
    
    filename = [pathname '\Class1_train.txt'];    
    trainmat = readmat( filename );
    mu1 = (mean(trainmat))';
    covmat1 = cov(trainmat);
    covmat1 = diag(diag(covmat1))
    
    filename = [pathname '\Class2_train.txt'];    
    trainmat = readmat( filename );
    mu2 = (mean(trainmat))';
    covmat2 = cov(trainmat);
    covmat2 = diag(diag(covmat2))
    
    
    %%%Class1 test set%%%
    filename = [pathname '\Class1_test.txt'];
    testmat = readmat( filename );
    probT1C1 = posterior(testmat, mu1, covmat1);
    probT1C2 = posterior(testmat, mu2, covmat2);
    size_m = size(probT1C1);
    row = size_m(1);
    probT1 = zeros( row, 5);    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
       probT1(k, 1) = testmat(k, 1);
       probT1(k, 2) = testmat(k, 2);
       probT1(k, 3) = 1;
       if ( probT1C1(k) >= probT1C2(k) )
           probT1(k, 4) = 1;
           probT1(k, 5) = probT1C1(k);
       else
           probT1(k, 4) = 2;
           probT1(k, 5) = probT1C2(k);
       end
    end
    
    
    %%%Class2 test set%%%
    filename = [pathname '\Class2_test.txt'];
    testmat = readmat( filename );
    probT2C1 = posterior(testmat, mu1, covmat1);
    probT2C2 = posterior(testmat, mu2, covmat2);
    size_m = size(probT2C1);
    row = size_m(1);
    probT2 = zeros( row, 5);    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
       probT2(k, 1) = testmat(k, 1);
       probT2(k, 2) = testmat(k, 2);
       probT2(k, 3) = 2;
       if ( probT2C1(k) >= probT2C2(k) )
           probT2(k, 4) = 1;
           probT2(k, 5) = probT2C1(k);
       else
           probT2(k, 4) = 2;
           probT2(k, 5) = probT2C2(k);
       end
    end
    
    
    %%%file output for probT1, probT2, probT3%%%
    filename = [pathname '\probT1_nbc_dcm.txt'];
    writemat(filename, probT1);
    filename = [pathname '\probT2_nbc_dcm.txt'];
    writemat(filename, probT2);
    
    
    col1=[255, 209, 209]/255;
    col2=[218, 255, 145]/255;
    col3=[194, 224, 255]/255;
    x_lab='\bf \color{magenta}Feature 1';
    y_lab='\bf \color{magenta}Feature 2';
    t='\bf Naive Bayes Classifier with different covariance matrices';
    l1='Class 1';
    l2='Class 2';
        
    %%%plotting graph%%%
%    pixel = pixel_gen(-30, 30, 0.1, -30, 30, 0.1);
%    pixel = pixel_gen(-4, 4, 0.01, -4, 4, 0.01);
    pixel = pixel_gen(-500, 2000, 10, -500, 2000, 10);
    p1 = posterior(pixel, mu1, covmat1);
    p2 = posterior(pixel, mu2, covmat2);
    plot2class(pixel, p1, p2,col1,col2);

    filename = [pathname '\Class1_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'r^');
    filename = [pathname '\Class2_train.txt'];
    trainmat = readmat( filename );
    plottrain(trainmat, 'go');
    xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1,l2,l1,l2);

    plot([mu1(1);mu2(1);mu1(1)],[mu1(2);mu2(2);mu1(2)],'k');
    axis equal;
%    axis ([-30 30 -30 30]);
%    axis ([-4 4 -4 4]);
    axis ([-500 2000 -500 2000]);
    print([pathname '\nbc_dcm_2_allclass'], '-dpng', '-r0');
    
    
    %%%Confusion Matrix%%%
    con_mat = con_mat_gen( probT1, probT2 );
    filename = [pathname '\con_mat_nbc_dcm.txt'];
    fileID = fopen( filename, 'w' );
    fprintf(fileID, '%d %d\n', con_mat(1,1), con_mat(1,2));
    fprintf(fileID, '%d %d\n', con_mat(2,1), con_mat(2,2));
    [o, c1, c2] = accuracy_2(con_mat);
    fprintf(fileID, '\n\n');
    fprintf(fileID, 'Overall Accuracy: %f\n', o);
    fprintf(fileID, 'Class 1 Accuracy: %f\n', c1);
    fprintf(fileID, 'Class 2 Accuracy: %f\n', c2);
    
    
    fclose('all');
    
    
    profile viewer
end

