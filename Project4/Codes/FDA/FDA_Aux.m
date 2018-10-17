function [tr_pos,tr_neg,te1,te2,te3] = FDA_Aux(tr_pos,tr_neg,te1,te2,te3)
% Auxilary function for FDA
% This function finds the unit vector along which projection has to be
% taken and finally projects all vectors along that and returns those 1-D
% vectors

n_pos=size(tr_pos,1);
n_neg=size(tr_neg,1);
mu_pos = (mean(tr_pos))';
s_pos = (cov(tr_pos))*n_pos;
mu_neg = (mean(tr_neg))';
s_neg = (cov(tr_neg))*n_neg;
sw=s_pos+s_neg;

%Vector along which we have to project
w=inv(sw)*(mu_pos-mu_neg); %% (d X d) * (d X 1)
%Making unit vector
w=w/norm(w);   %% (d X 1)

tr_pos = tr_pos * w;
tr_neg = tr_neg * w;
te1 = te1 * w;
te2 = te2 * w;
te3 = te3 * w;

end