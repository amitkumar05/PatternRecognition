% This function returns a column matrix having
% distance between X and each pattern example
% from A.
% X: Input pattern example to be classified
% A: Matrix having patterns for one class

function [ distance ] = distance( A, X )
    
    sizeA = size(A);
    numExamples = sizeA(2);
    distance = zeros(numExamples, 1);
    
    for k = 1:numExamples
        distance(k) = dtw(X, A{k}); 
        %distance(k) = eucliddis(X, A{k}); 
    end
    distance=distance';
end

