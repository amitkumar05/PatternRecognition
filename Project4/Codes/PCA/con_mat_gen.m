function [ con_mat ] = con_mat_gen( predictedClassDimension, varargin )
    numargin = nargin - 1;
    con_mat = zeros(numargin, numargin);
    for n = 1:numargin
        mat = varargin{n};
        size_m = size(mat);
        row = size_m(1);
        count = zeros(1, numargin);
        for k = 1:row
            count(mat(k,predictedClassDimension)) = count(mat(k,predictedClassDimension)) + 1;
        end
        for k = 1:numargin
            con_mat(n, k) = count(k);
        end
    end
end

