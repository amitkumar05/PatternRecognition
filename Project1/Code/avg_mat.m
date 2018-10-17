%function which returns average matrix of input matrices
function [ mat ] = avg_mat( varargin )
    if nargin == 1
        mat = varargin{1};
    elseif nargin == 0
        mat = [];
    else
        mat = varargin{1} + varargin{2};
        if nargin >= 3
            for i = 3:nargin
                mat = mat + varargin{i};
            end
        mat = mat/nargin; 
        end
    end
end