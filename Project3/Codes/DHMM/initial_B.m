function [ B1 ] = initial_B( trainmat, N, M )
    %B(:,:,1),B(:,:,2),B(:,:,3)
%      X=zeros(N,M); 
%      B(:,:,1)=X;
%      B(:,:,2)=X;
%      B(:,:,3)=X;
    format long g
    examples = size(trainmat, 2);
    B1 = zeros(N, M);
    d1 = 0;
    d2 = 0;
    for i = 1:examples
        %row = size(trainmat{i}, 1);
        col = size(trainmat{i}, 2);
        A = trainmat{i};
        len = ceil(col / N);
        for j = 1:N
            for k = 1:len
                %(j - 1) * len + k;
                B1( j, A((j - 1) * len + k) ) = B1( j, A((j - 1) * len + k) ) + 1;
                if( (j - 1) * len + k == col )
                    break;
                end
            end
        end
        d1 = d1 + len;
        %B1(N, :) = B1(N, :) * len;
        d2 = d2 + ( col - ( len * (N - 1) ) );
        %B1(N, :) = B1(N, :)/( col - ( len * (N - 1) ) )
    end
    B1 = B1 / d1;
    B1(N, :) = B1(N, :) * d1;
    B1(N, :) = B1(N, :) / d2;
end