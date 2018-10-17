function [ output_args ] = perceptron_classifier( pathname )
    profile on;
    
    
    filename = [pathname '\Class1_train.txt'];    
    trainmat1 = dlmread( filename );
    
    filename = [pathname '\Class2_train.txt'];    
    trainmat2 = dlmread( filename );
    
    filename = [pathname '\Class3_train.txt'];    
    trainmat3 = dlmread( filename );
    
    w12=perceptron(trainmat1,trainmat2)    
    
    w13=perceptron(trainmat1,trainmat3);
    
    w23=perceptron(trainmat2,trainmat3);
    
%     %%%Class1 test set%%%
    filename = [pathname '\Class1_test.txt'];
    testmat = dlmread( filename );
    size_m = size(testmat);
    row = size_m(1);
    probT1 = zeros( row, 4);    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
       probT1(k, 1) = testmat(k, 1);
       probT1(k, 2) = testmat(k, 2);
       probT1(k, 3) = 1;

        y=change(testmat(k,:)');
        %w12
        x1=w12'*y;
        x2=w13'*y;
        x3=w23'*y;
      
        if ( x1>0 && x2>0)
           probT1(k, 4) = 1;
        elseif ( x1<0 && x2>0 )
           probT1(k, 4) = 2;
       else
           probT1(k, 4) = 3;
       end
    end
    
%     
%     %%%Class2 test set%%%
    filename = [pathname '\Class2_test.txt'];
    testmat = dlmread( filename );
    size_m = size(testmat);
    row = size_m(1);
    probT2 = zeros( row, 5);    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
       probT2(k, 1) = testmat(k, 1);
       probT2(k, 2) = testmat(k, 2);
       probT2(k, 3) = 2;

        y=change(testmat(k,:)');
        %w12
        x1=w12'*y;
        x2=w13'*y;
        x3=w23'*y;
      
        if ( x1>0 && x2>0)
           probT2(k, 4) = 1;
        elseif ( x1<0 && x2>0 )
           probT2(k, 4) = 2;
       else
           probT2(k, 4) = 3;
       end
    end
     
%     
%     %%%Class3 test set%%%
    filename = [pathname '\Class3_test.txt'];
    testmat = dlmread( filename );
    size_m = size(testmat);
    row = size_m(1);
    probT3 = zeros( row, 5);    % Att1 Att2 ActualClass PredictedClass Prob %
    for k = 1:row
       probT3(k, 1) = testmat(k, 1);
       probT3(k, 2) = testmat(k, 2);
       probT3(k, 3) = 3;

               y=change(testmat(k,:)');
        %w12
        x1=w12'*y;
        x2=w13'*y;
        x3=w23'*y;
      
        if ( x1>0 && x2>0)
            probT3(k, 4) = 1;
        elseif ( x1<0 && x3>0 )
           probT3(k, 4) = 2;
        else
           probT3(k, 4) = 3;
       end
    end
%     
    %%%file output for probT1, probT2, probT3%%%
    
%     filename = [pathname '\probT1_perceptron.txt'];
%     writemat(filename, probT1);
%     filename = [pathname '\probT2_perceptron.txt'];
%     writemat(filename, probT2);
%     filename = [pathname '\probT3_perceptron.txt'];
%     writemat(filename, probT3);
%     
    col1=[255, 209, 209]/255;
    col2=[218, 255, 145]/255;
    col3=[194, 224, 255]/255;

    x_lab='\bf \color{magenta}Feature 1';
    y_lab='\bf \color{magenta}Feature 2';
    t='\bf Perceptron based classifier';
    l1='Class 1';
    l2='Class 2';
    l3='Class 3';
%     
%     %%%plotting graph%%%
%     %%% FOR OD
%     
%    pixel = pixel_gen(-30, 30, 0.1, -30, 30, 0.1);
    pixel = pixel_gen(-30, 30, 0.1, -30, 30, 0.1);

%     pixel = pixel_gen(-500, 2000, 10, -500, 2000, 10);
% %for rd data 
% %    pixel = pixel_gen(-1500, 1500, 2.5, -1500, 1500, 25);
% 
%     %pixel = pixel_gen(-50, 50, 0.09, -50, 50, 0.9);

%     p1 = posterior(pixel, mu1, covmat);

%     p2 = posterior(pixel, mu2, covmat);
%     p3 = posterior(pixel, mu3, covmat);
%     %plot3class(pixel, p1, p2, p3);
%     plot3class(pixel, p1, p2, p3,col1,col2,col3);
%     axis equal;
% 
     figure;
      plot2class(pixel,w12,w13,w23,col1,col2,col3);
  %   plot2class(pixel,w13,col1,col3);
  %   plot2class(pixel,w23,col2,col3);
     
     hold on;
%     
%     
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
%     
%     plot([mu1(1);mu2(1);mu3(1);mu1(1)],[mu1(2);mu2(2);mu3(2);mu1(2)],'k');
%     %    axis ([-30 30 -30 30]);
%     axis ([-500 2000 -500 2000]);
%     print([pathname '\bc_scm_avg_allclass'], '-dpng', '-r0');
%     
%     
%     %%%Plot for two classes%%%
%     figure;
%     plot2class(pixel, p1, p2, col1,col2);
%     filename = [pathname '\Class1_train.txt'];
%     trainmat = readmat( filename );
%     plottrain(trainmat, 'r^');
%     filename = [pathname '\Class2_train.txt'];
%     trainmat = readmat( filename );
%     plottrain(trainmat, 'go');
%     xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1,l2,l1,l2);
%     
%     plot([mu1(1);mu2(1);mu1(1)],[mu1(2);mu2(2);mu1(2)],'k');
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     axis equal;
% %    axis ([-30 30 -30 30]);
%     axis ([-500 2000 -500 2000]);
%     print([pathname '\bc_scm_avg_class12'], '-dpng', '-r0');
%     
%     figure;
%     plot2class(pixel, p2, p3,col2,col3);
%     filename = [pathname '\Class2_train.txt'];
%     trainmat = readmat( filename );
%     plottrain(trainmat, 'go');
%     filename = [pathname '\Class3_train.txt'];
%     trainmat = readmat( filename );
%     plottrain(trainmat, 'bs');
%     xlabel(x_lab), ylabel(y_lab), title(t) , legend(l2,l3,l2,l3);
% 
%     plot([mu2(1);mu3(1);mu2(1)],[mu2(2);mu3(2);mu2(2)],'k');
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     axis equal;
% %    axis ([-30 30 -30 30]);
%     axis ([-500 2000 -500 2000]);
%     print([pathname '\bc_scm_avg_class23'], '-dpng', '-r0');
% 
%     
%     figure;
%     plot2class(pixel, p1, p3,col1,col3);
%     filename = [pathname '\Class1_train.txt'];
%     trainmat = readmat( filename );
%     plottrain(trainmat, 'r^');
%     filename = [pathname '\Class3_train.txt'];
%     trainmat = readmat( filename );
%     plottrain(trainmat, 'bs');
%     xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1,l3,l1,l3);
%     
%     plot([mu1(1);mu3(1);mu1(1)],[mu1(2);mu3(2);mu1(2)],'k');
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     axis equal;
    axis ([-30 30 -30 30]);
%     axis ([-500 2000 -500 2000]);
%     print([pathname '\perceptron'], '-dpng', '-r0');
% 
%     
    %%%Confusion Matrix%%%
    con_mat = con_mat_gen( probT1, probT2, probT3 );
    filename = [pathname '\con_mat_perceptron.txt'];
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

