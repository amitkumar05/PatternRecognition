% This function returns accuracies for classification based on confusion matrix
% 
% conmat: Confusion matrix
% 
% overall_acc: overall accuracy for the classification
% class1_acc: accuracy for class 1
% class2_acc: accuracy for class 2
% class3_acc: accuarcy for class 3

function [ overall_acc, class1_acc, class2_acc, class3_acc ] = accuracy( conmat )
    sum_class = sum(conmat, 2);
    sum_total = sum(sum_class);
    corr_recog = diag(conmat);
    tot_cr = sum(corr_recog);
    overall_acc = tot_cr / sum_total;
    class1_acc = corr_recog(1) / sum_class(1);
    class2_acc = corr_recog(2) / sum_class(2);
    class3_acc = corr_recog(3) / sum_class(3);
end

