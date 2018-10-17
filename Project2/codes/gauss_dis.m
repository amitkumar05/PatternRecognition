%function which returns probab according to gaussian distribution for
%single value of x ie x is a 'd' dimensional single vector
%NOTE - X here is a single row vector
function [ prob ] = gauss_dis( x, mu, covmat )
    format long
    %x = x';
    %mu = mu';
   % inv(covmat*(10^15))
    %(det(covmat/(10^15))*10^15)
    %det(covmat*10^4)
    %covmat
    %det(covmat)
    size_m = size(x);
    %col = size_m(2);
    d = size_m(2);
    %prob = 0;
%     x
%     mu
%inv(covmat/(10^4))
    diff = x - mu;
  %  (diff)*(inv(covmat*(10^5)))*(diff');
%     if( isnan(diff(1)) || isnan(diff(2)) )
%         stop(1);
%     end
    %prob = log(exp((-0.5)*(diff)*(inv(covmat))*(diff'))/(((2*pi)^(d/2))*sqrt((abs(det(covmat))))));
%    disp('Line of distinction')
    prob = exp((-0.5)*(diff)*((inv(covmat)))*(diff'))/(((2*pi)^(d/2))*sqrt((abs(det(covmat)))));
%    prob = ((-0.5)*(diff)*((inv(covmat)))*(diff'))-(((d/2)*log(2*pi))+((0.5)*log(abs(det(covmat)))));
%     if(prob == Inf)
%         covmat_ = covmat
%         det_ = det(covmat)
%         abs_ = abs(det(covmat))
%         sqrt_ = sqrt((abs(det(covmat))))
%         inv_ = inv(covmat)
%         denom_ = 1/sqrt((abs(det(covmat))))
%         diff_ = diff
%         pow_ = (-0.5)*(diff)*((inv(covmat)))*(diff')
%         e_pow_ = exp((-0.5)*(diff)*((inv(covmat)))*(diff'))
%         pause
%     end
    
    %prob=rand;
end