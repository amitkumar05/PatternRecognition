function [ ] = FDA_Unimodal( pathname )
% This function performs Fisher Discriminant Analysis
%
% INPUT -
% pathname: path of the directory from where input is to be taken
%

%%% reading matrices %%%
tr1 = dlmread([pathname '\Class1_train.txt']);
te1 = dlmread([pathname '\Class1_test.txt']);
tr2 = dlmread([pathname '\Class2_train.txt']);
te2 = dlmread([pathname '\Class2_test.txt']);
tr3 = dlmread([pathname '\Class3_train.txt']);
te3 = dlmread([pathname '\Class3_test.txt']);

%%% Project all testing matrices in 1-D for all pair of classes %%%
%%% te'x'_proj'a'b' -> x denotes actual class of testing data.
%%%                    a,b - represents athe 1-d fisher vector obtained from a
%%%                    and b classes.

[tr1_proj12,tr2_proj12,te1_proj12,te2_proj12,te3_proj12]=FDA_Aux(tr1,tr2,te1,te2,te3);
[probT1_C12,probT2_C12,probT3_C12]=bc_2class_3test_FDA(tr1_proj12,tr2_proj12,te1_proj12,te2_proj12,te3_proj12,1,2);


[tr1_proj13,tr3_proj13,te1_proj13,te2_proj13,te3_proj13]=FDA_Aux(tr1,tr3,te1,te2,te3);
[probT1_C13,probT2_C13,probT3_C13]=bc_2class_3test_FDA(tr1_proj13,tr3_proj13,te1_proj13,te2_proj13,te3_proj13,1,3);


[tr2_proj23,tr3_proj23,te1_proj23,te2_proj23,te3_proj23]=FDA_Aux(tr2,tr3,te1,te2,te3);
[probT1_C23,probT2_C23,probT3_C23]=bc_2class_3test_FDA(tr2_proj23,tr3_proj23,te1_proj23,te2_proj23,te3_proj23,2,3);

%%% For test matrix of class 1 %%%
for k=1:size(te1,1)
    if(probT1_C12(k,3)==1 && probT1_C13(k,3)==1)
        probT1_C12(k,3)=1;
    elseif(probT1_C12(k,3)==2 && probT1_C23(k,3)==2)
        probT1_C12(k,3)=2;
    elseif(probT1_C13(k,3)==3 && probT1_C23(k,3)==3)
        probT1_C12(k,3)=3;
    else
        probT1_C12(k,3)=randi([1,3]);
    end
end

%%% For test matrix of class 2 %%%
for k=1:size(te2,1)
    if(probT2_C12(k,3)==1 && probT2_C13(k,3)==1)
        probT2_C12(k,3)=1;
    elseif(probT2_C12(k,3)==2 && probT2_C23(k,3)==2)
        probT2_C12(k,3)=2;
    elseif(probT2_C13(k,3)==3 && probT2_C23(k,3)==3)
        probT2_C12(k,3)=3;
    else
        probT2_C12(k,3)=randi([1,3]);
    end
end

%%% For test matrix of class 3 %%%
for k=1:size(te3,1)
    if(probT3_C12(k,3)==1 && probT3_C13(k,3)==1)
        probT3_C12(k,3)=1;
    elseif(probT3_C12(k,3)==2 && probT3_C23(k,3)==2)
        probT3_C12(k,3)=2;
    elseif(probT3_C13(k,3)==3 && probT3_C23(k,3)==3)
        probT3_C12(k,3)=3;
    else
        probT3_C12(k,3)=randi([1,3]);
    end
end

%%%Confusion Matrix%%%
con_mat = con_mat_gen_FDA_Unimodal( probT1_C12, probT2_C12,probT3_C12 );
filename = [pathname '\con_mat_FDA_Unimodal.txt'];
fileID = fopen( filename, 'w' );
fprintf(fileID, '%d %d %d\n', con_mat(1,1), con_mat(1,2), con_mat(1,3));
fprintf(fileID, '%d %d %d\n', con_mat(2,1), con_mat(2,2), con_mat(2,3));
fprintf(fileID, '%d %d %d\n', con_mat(3,1), con_mat(3,2), con_mat(3,3));
[o, c1, c2, c3] = accuracy(con_mat);
fprintf(fileID, '\n\n');
fprintf(fileID, 'Overall Accuracy: %f\n', o*100);
fprintf(fileID, 'Class 1 Accuracy: %f\n', c1*100);
fprintf(fileID, 'Class 2 Accuracy: %f\n', c2*100);
fprintf(fileID, 'Class 3 Accuracy: %f\n', c3*100);

fclose('all');

end