function [probT1,probT2,probT3] = bc_2class_3test_FDA( tr_pos,tr_neg,te1,te2,te3,pos_no,neg_no)

mu_pos = (mean(tr_pos))';
covmat_pos = cov(tr_pos);

mu_neg = (mean(tr_neg))';
covmat_neg = cov(tr_neg);

%%%Class1 test set%%%
probT1C_pos = posterior(te1, mu_pos, covmat_pos);
probT1C_neg = posterior(te1, mu_neg, covmat_neg);
size_m = size(probT1C_pos);
row = size_m(1);
probT1 = zeros( row, 4);    % Att1 ActualClass PredictedClass Prob %
for k = 1:row
    probT1(k, 1) = te1(k, 1);
    probT1(k, 2) = 1;
    if ( probT1C_pos(k) >= probT1C_neg(k) )
        probT1(k, 3) = pos_no;
        probT1(k, 4) = probT1C_pos(k);
    else
        probT1(k, 3) = neg_no;
        probT1(k, 4) = probT1C_neg(k);
    end
end

%%%Class2 test set%%%
probT2C_pos = posterior(te2, mu_pos, covmat_pos);
probT2C_neg = posterior(te2, mu_neg, covmat_neg);
size_m = size(probT2C_pos);
row = size_m(1);
probT2 = zeros( row, 4);    % Att1 ActualClass PredictedClass Prob %
for k = 1:row
    probT2(k, 1) = te2(k, 1);
    probT2(k, 2) = 2;
    if ( probT2C_pos(k) >= probT2C_neg(k) )
        probT2(k, 3) = pos_no;
        probT2(k, 4) = probT2C_pos(k);
    else
        probT2(k, 3) = neg_no;
        probT2(k, 4) = probT2C_neg(k);
    end
end

%%%Class3 test set%%%
probT3C_pos = posterior(te3, mu_pos, covmat_pos);
probT3C_neg = posterior(te3, mu_neg, covmat_neg);
size_m = size(probT3C_pos);
row = size_m(1);
probT3 = zeros( row, 4);    % Att1 ActualClass PredictedClass Prob %
for k = 1:row
    probT3(k, 1) = te3(k, 1);
    probT3(k, 2) = 3;
    if ( probT3C_pos(k) >= probT3C_neg(k) )
        probT3(k, 3) = pos_no;
        probT3(k, 4) = probT3C_pos(k);
    else
        probT3(k, 3) = neg_no;
        probT3(k, 4) = probT3C_neg(k);
    end
end

end