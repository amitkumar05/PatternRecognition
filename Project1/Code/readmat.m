%function to calculate covariance matrix for bivariate classes
function [ A ] = readmat( filename )
    fileID1 = fopen(filename,'r');
    formatspec1 = '%f %f';
    sizeA = [2 Inf];
    A = fscanf(fileID1, formatspec1, sizeA);
    A = A';
end