% 
% 

function [ addedDimensionArray ] = add_Dimension( inputArray, addedDimensionDefaultValue )
    inputArray = inputArray';
    cols = size(inputArray, 2);
    e = addedDimensionDefaultValue * ones(1, cols);
    inputArray = [inputArray; e];
    addedDimensionArray = inputArray';
end

