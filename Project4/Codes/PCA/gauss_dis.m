%function which returns probab according to gaussian distribution for
%single value of x ie x is a 'd' dimensional single vector
%NOTE - X here is a single row vector
%WE HAVE REMOVED EXPONENTIAL
function [ prob ] = gauss_dis( x, mu, covmat )
    %x = x';
    %mu = mu';
    %covmat = covmat * 100;
    size_m = size(x);
    %col = size_m(2);
    d = size_m(1);
    %prob = 0;
%     covmat;
%     x
%     mu
    diff = x - mu;
%     if( isnan(diff(1)) || isnan(diff(2)) )
%         stop(1);
%     end
%    prob = log(exp((-0.5)*(diff)*(inv(covmat))*(diff'))/(((2*pi)^(d/2))*sqrt((abs(det(covmat))))));
    prob = exp((-0.5)*(diff)*(inv(covmat))*(diff'))/(((2*pi)^(d/2))*sqrt((abs(det(covmat)))));
    %prob=rand;
end