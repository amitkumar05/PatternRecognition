% WORKS ONLY FOR THREE CLASSES
% This function performs Principal Component Analysis
% 
% INPUT -
% pathname: path of the directory from where input is to be taken
% l:        number of dimensions after reduction
% 
% OUTPUT -
% pathname_PCA: path for the updated data
% 

function [ pathname_PCA, lEigenVectors, lEigenValues ] = PCA( pathname, l )
    
    %%% reading matrices %%%
    trainmat1 = dlmread([pathname '\Class1_train.txt']);
    testmat1 = dlmread([pathname '\Class1_test.txt']);
    trainmat2 = dlmread([pathname '\Class2_train.txt']);
    testmat2 = dlmread([pathname '\Class2_test.txt']);
    trainmat3 = dlmread([pathname '\Class3_train.txt']);
    testmat3 = dlmread([pathname '\Class3_test.txt']);
    
    %%% combining training matrices and calculating eigenvalues and eigenvectors %%%
    trainmatCombined = [trainmat1; trainmat2; trainmat3];
    %%% [V, D] = eig(A) returns diagonal matrix D of eigenvalues and %%%
    %%% matrix V whose columns are the corresponding right eigenvectors %%%
    [eigenVectors, eigenValues] = eig(cov(trainmatCombined));
    
    %%% making eigenvalues a column vector %%%
    eigenValues = diag(eigenValues);
    %%% taking transpose to make them in row form %%%
    eigenVectors = eigenVectors';
    
    %%% I is a column matrix containing indicies of %%%
    %%% elements from the unsorted matrix %%%
    [sortedEigenValues, I] = sort(eigenValues, 'descend');
    
    lEigenValues = sortedEigenValues(1:l, 1);
    
    %%% creating a new matrix for l eigenvectors %%%
    col = size(eigenVectors, 2);
    lEigenVectors = zeros(l, col);
    
    %%% picking up l eigenvectors corresponding to %%%
    %%% l largest eigenvalues %%%
    for k = 1:l
        lEigenVectors(k,:) = -1 * eigenVectors(I(k), :);
    end
    
    %%% taking transpose for multiplication %%%
    lEigenVectors = lEigenVectors';
        
    %%% reducing dimensions of the matrices %%%
    trainmat1 = trainmat1 * lEigenVectors;
    testmat1 = testmat1 * lEigenVectors;
    trainmat2 = trainmat2 * lEigenVectors;
    testmat2 = testmat2 * lEigenVectors;
    trainmat3 = trainmat3 * lEigenVectors;
    testmat3 = testmat3 * lEigenVectors;
    
    %%% making new folder %%%
    pathname_PCA = [pathname '\PCA_' num2str(l)];
    if ( exist(pathname_PCA, 'dir') == 0 )
        mkdir(pathname_PCA);
    end
    
    %%% storing reduced dimension matrices %%%
    filename = [pathname_PCA '\Class1_train.txt'];
    dlmwrite(filename, trainmat1);
    filename = [pathname_PCA '\Class1_test.txt'];
    dlmwrite(filename, testmat1);
    filename = [pathname_PCA '\Class2_train.txt'];
    dlmwrite(filename, trainmat2);
    filename = [pathname_PCA '\Class2_test.txt'];
    dlmwrite(filename, testmat2);
    filename = [pathname_PCA '\Class3_train.txt'];
    dlmwrite(filename, trainmat3);
    filename = [pathname_PCA '\Class3_test.txt'];
    dlmwrite(filename, testmat3);
    
end

