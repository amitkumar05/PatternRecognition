function [ con_mat ] = con_mat_gen( varargin )
    con_mat = zeros(nargin, nargin);
    for n = 1:nargin
        mat = varargin{n};
        size_m = size(mat);
        row = size_m(1);
        count = zeros(1, nargin);
        for k = 1:row
            count(mat(k,4)) = count(mat(k,4)) + 1;
        end
        for k = 1:nargin
            con_mat(n, k) = count(k);
        end
    end
end

