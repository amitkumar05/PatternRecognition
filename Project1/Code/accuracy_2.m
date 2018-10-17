%
%
function [ overall_acc, class1_acc, class2_acc] = accuracy_2( conmat )
    sum_class = sum(conmat, 2);
    sum_total = sum(sum_class);
    corr_recog = diag(conmat);
    tot_cr = sum(corr_recog);
    overall_acc = tot_cr / sum_total;
    class1_acc = corr_recog(1) / sum_class(1);
    class2_acc = corr_recog(2) / sum_class(2);
end

