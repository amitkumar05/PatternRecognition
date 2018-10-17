function [] = DHMM_Classifier_LtoR( pathname )
    
    profile on;
    format long g
    display('Going to read trainMat')
    %%%input for training dataset%%%
    %%%training matrix for class1%%%
    trainpath = [pathname '\train\Class1\'];
    files = dir(trainpath);
    for i = 3:length(files)
       trainmattemp1{i - 2} = dlmread([trainpath files(i).name]);
    end
    %%%training matrix for class2%%%
    trainpath = [pathname '\train\Class2\'];
    files = dir(trainpath);
    for i = 3:length(files)
       trainmattemp2{i - 2} = dlmread([trainpath files(i).name]);
    end
    %%%training matrix for class3%%%
    trainpath = [pathname '\train\Class3\'];
    files = dir(trainpath);
    for i = 3:length(files)
       trainmattemp3{i - 2} = dlmread([trainpath files(i).name]);
    end
    
    display('Going to read testMat')
    %%%input for test dataset%%%
    %%%class1%%%
    testpath = [pathname '\test\Class1\'];
    files = dir(testpath);
    for k = 3:length(files)
        testmattemp1{k - 2} = dlmread([testpath files(k).name]);       
    end
    L1 = length(files) - 2;
    %%%class2%%%
    testpath = [pathname '\test\Class2\'];
    files = dir(testpath);
    for k = 3:length(files)
        testmattemp2{k - 2} = dlmread([testpath files(k).name]);       
    end
    L2 = length(files) - 2;
    %%%class3%%%
    testpath = [pathname '\test\Class3\'];
    files = dir(testpath);
    for k = 3:length(files)
        testmattemp3{k - 2} = dlmread([testpath files(k).name]);       
    end
    L3 = length(files) - 2;
    
    for N = [4]
        for M = [32]
            display(['N is:' num2str(N) ' M is:' num2str(M)])
            display('K means called for trainMat')
            [trainmat1, trainmat2, trainmat3, means] = k_means_DHMM(trainmattemp1, trainmattemp2, trainmattemp3, M);
            display('K means finished')
            
            %%%Parameter calculation%%%
            %%%For class 1%%%
            display('DHMM parameters called for trainMat1')
            [A1, B1, pi1] = DHMM_parameters_LtoR(trainmat1, N, M);
            %A1
            
            %%%For class 2%%%
            %display('2 start')
            display('DHMM parameters called for trainMat2')
            [A2, B2, pi2] = DHMM_parameters_LtoR(trainmat2, N, M);
            %%%For class 3%%%
            %display('3rd start')
%             for k=1:size(trainmat3,2)
%                 trainmat3{k}
%             end
            display('DHMM parameters called for trainMat3')
            [A3, B3, pi3] = DHMM_parameters_LtoR(trainmat3, N, M);
            %display('3rd ends')
            %%%generating symbols for test dataset%%%
            display('assigning cluster for testMat1')
            testmat1 = assign_cluster(testmattemp1, means);
            display('assigning cluster for testMat2')
            testmat2 = assign_cluster(testmattemp2, means);
            display('assigning cluster for testMat3')
            testmat3 = assign_cluster(testmattemp3, means);
%             for k=1:size(testmat1,2)
%                 testmat1{k}
%             end
            display('parameter class1')
            %%%classification for test dataset%%%
%             
%             A1
%             B1
%             pi1
%             display('parameter class2')
%             A2
%             B2
%             pi2
%             display('parameter class3')
%             A3
%             B3
%             pi3
%             
            
          
            %%%for class 1%%%
            n1_c1 = 0;
            n2_c1 = 0;
            n3_c1 = 0;
            prob1 = Likelihood(A1, B1, pi1, testmat1);
            prob2 = Likelihood(A2, B2, pi2, testmat1);
            prob3 = Likelihood(A3, B3, pi3, testmat1);
            for l = 1:L1
                if ( (prob1(l) >= prob2(l)) && (prob1(l) >= prob3(l)) )
                    n1_c1 = n1_c1 + 1;
                elseif ( prob2(l) >= prob3(l) )
                    n2_c1 = n2_c1 + 1;
                else
                    n3_c1 = n3_c1 + 1;
                end
            end
            %%%for class 2%%%
            n1_c2 = 0;
            n2_c2 = 0;
            n3_c2 = 0;
            prob1 = Likelihood(A1, B1, pi1, testmat2);
            prob2 = Likelihood(A2, B2, pi2, testmat2);
            prob3 = Likelihood(A3, B3, pi3, testmat2);
            for l = 1:L2
                if ( (prob1(l) >= prob2(l)) && (prob1(l) >= prob3(l)) )
                    n1_c2 = n1_c2 + 1;
                elseif ( prob2(l) >= prob3(l) )
                    n2_c2 = n2_c2 + 1;
                else
                    n3_c2 = n3_c2 + 1;
                end
            end
            %%%for class 3%%%
            n1_c3 = 0;
            n2_c3 = 0;  
            n3_c3 = 0;
            prob1 = Likelihood(A1, B1, pi1, testmat3);
            prob2 = Likelihood(A2, B2, pi2, testmat3);
            prob3 = Likelihood(A3, B3, pi3, testmat3);
            for l = 1:L3
                if ( (prob1(l) >= prob2(l)) && (prob1(l) >= prob3(l)) )
                    n1_c3 = n1_c3 + 1;
                elseif ( prob2(l) >= prob3(l) )
                    n2_c3 = n2_c3 + 1;
                else
                    n3_c3 = n3_c3 + 1;
                end
            end
            
            %%%confusion matrix%%%
            con_mat = [n1_c1,n2_c1,n3_c1;n1_c2,n2_c2,n3_c2;n1_c3,n2_c3,n3_c3];
            filename = [pathname '\conMatDHMM_N' num2str(N) '_M' num2str(M) '.txt'];
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
    end
    profile viewer
end