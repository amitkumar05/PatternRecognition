% % % %  structure of folder
% % % %  pathname -> test,train
% % % %  test->Class1,Class2,Class3
% % % %  train->Class1,Class2,Class3
% % % %  Class1->files with name


function [] = KNN( pathname )
    
    profile on;
    K=681;
    trainpath=[pathname '\train\Class1\'];
    files = dir(trainpath);
    %% training mat for class1
    for i = 3:length(files)
       trainmat1{i-2}=dlmread([trainpath files(i).name]);
    end
    %% training mat for class2
    trainpath=[pathname '\train\Class2\'];
    files = dir(trainpath);
    for i = 3:length(files)
       trainmat2{i-2}=dlmread([trainpath files(i).name]);
    end
    
    %% training mat for class3
    trainpath=[pathname '\train\Class3\'];
    files = dir(trainpath);
    for i = 3:length(files)
       trainmat3{i-2}=dlmread([trainpath files(i).name]);
    end
    
 %% classification of test samples
  %% test matrix of class1
    n1_c1=zeros(K,1);n2_c1=zeros(K,1);n3_c1=zeros(K,1);
    testpath = [pathname '\test\Class1\']  
    files = dir(testpath);
    for i = 3:length(files)
        i
        X=dlmread([testpath files(i).name]);       
       distance1 = distance(trainmat1,X);      
       distance2 = distance(trainmat2,X);       
       distance3 = distance(trainmat3,X);    
        
        distance1=sort(distance1);
        distance2=sort(distance2);
        distance3=sort(distance3);
        app_distance=[distance1,distance2,distance3];
        app_distance=sort(app_distance);
        %leng=length(app_distance)
        for k=2:K   
            cutoff=app_distance(k);
            if(distance1(length(distance1)) <= cutoff )
                prob1=length(distance1);
            else
                prob1=find(distance1>cutoff,1)-1;
            end

            if(distance2(length(distance2)) <= cutoff )
                prob2=length(distance2);
            else
                prob2=find(distance2>cutoff,1)-1;
            end

            if(distance3(length(distance3)) <= cutoff )
                prob3=length(distance3);
            else
                prob3=find(distance3>cutoff,1)-1;
            end

            if ( (prob1 >= prob2) && (prob1 >= prob3) )
                    n1_c1(k)=n1_c1(k)+1;
            elseif ( prob2 >= prob3 )
                    n2_c1(k)=n2_c1(k)+1;
            else
                    n3_c1(k)=n3_c1(k)+1;
            end
        end   
    end
    % for class2 testing
   
    n1_c2=zeros(K,1);n2_c2=zeros(K,1);n3_c2=zeros(K,1);
    testpath = [pathname '\test\Class2\']  
    files = dir(testpath);
    for i = 3:length(files)
        i
        X=dlmread([testpath files(i).name]);       
       distance1 = distance(trainmat1,X);       
       distance2 = distance(trainmat2,X);       
       distance3 = distance(trainmat3,X);       
        
        distance1=sort(distance1);
        distance2=sort(distance2);
        distance3=sort(distance3);
        app_distance=[distance1,distance2,distance3];
        app_distance=sort(app_distance);
      
        for k=2:K
            cutoff=app_distance(k);        
            if(distance1(length(distance1)) <= cutoff )
                prob1=length(distance1);
            else
                prob1=find(distance1>cutoff,1)-1;
            end

            if(distance2(length(distance2)) <= cutoff )
                prob2=length(distance2);
            else
                prob2=find(distance2>cutoff,1)-1;
            end

            if(distance3(length(distance3)) <= cutoff )
                prob3=length(distance3);
            else
                prob3=find(distance3>cutoff,1)-1;
            end

            if ( (prob1 >= prob2) && (prob1 >= prob3) )
                    n1_c2(k)=n1_c2(k)+1;
            elseif ( prob2 >= prob3 )
                    n2_c2(k)=n2_c2(k)+1;
            else
                    n3_c2(k)=n3_c2(k)+1;
            end
       end   
    end
    %%% for class3
    
    n1_c3=zeros(K,1);n2_c3=zeros(K,1);n3_c3=zeros(K,1);
    testpath = [pathname '\test\Class3\']
    files = dir(testpath);
    for i = 3:length(files)
        i
       X=dlmread([testpath files(i).name]);       
       distance1 = distance(trainmat1,X);       
       distance2 = distance(trainmat2,X);       
       distance3 = distance(trainmat3,X);       
        
        distance1=sort(distance1);
        distance2=sort(distance2);
        distance3=sort(distance3);
        app_distance=[distance1,distance2,distance3];
        app_distance=sort(app_distance);
        
        
      for k=2:K
            
        cutoff=app_distance(k);
        
        if(distance1(length(distance1)) <= cutoff )
            prob1=length(distance1);
        else
            prob1=find(distance1>cutoff,1)-1;
        end
        
        if(distance2(length(distance2)) <= cutoff )
            prob2=length(distance2);
        else
            prob2=find(distance2>cutoff,1)-1;
        end
        
        if(distance3(length(distance3)) <= cutoff )
            prob3=length(distance3);
        else
            prob3=find(distance3>cutoff,1)-1;
        end

        if ( (prob1 >= prob2) && (prob1 >= prob3) )
                n1_c3(k)=n1_c3(k)+1;
        elseif ( prob2 >= prob3 )
                n2_c3(k)=n2_c3(k)+1;
        else
                n3_c3(k)=n3_c3(k)+1;
        end
      end
    end
    
    
     
    %%%Confusion Matrix%%%
     for k=2:K 
        con_mat=[n1_c1(k),n2_c1(k),n3_c1(k);n1_c2(k),n2_c2(k),n3_c2(k);n1_c3(k),n2_c3(k),n3_c3(k)];
        filename = [pathname '\con_mat_KNN_' num2str(k) '.txt'];
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