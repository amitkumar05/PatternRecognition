%function which returns array of posterior probabilities for test pattern array
function [ prob ] = posterior( x, mu, covmat )
    x = x';
    size_m = size(x);
    col = size_m(2);
    prob = zeros (col, 1);%%perform interchange
    for k = 1:col
        diff = x(:, k) - mu;
        prob(k) = ((diff')*(inv(covmat))*(diff)) - (log(det(covmat)));
        prob(k) = (-0.5)*(prob(k));
    end
    %prob = prob';
end