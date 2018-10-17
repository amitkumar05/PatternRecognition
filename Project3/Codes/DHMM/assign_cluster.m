function [ cluster_no ] = assign_cluster( examples,means_arr )
    format long g
    L = size(examples, 2);
    K = size(means_arr, 1);
    for l =  1:L
        T = size(examples{l}, 1);
        for i = 1:T
            x = examples{l}(i,:);
            min_dis = Inf;
            min_in = -1;
            for j = 1:K
                dis = norm(x - means_arr(j, :));
                if (min_dis > dis)
                    min_dis = dis;
                    min_in = j;
                end
            end
            cluster_no{l}(i) = min_in;
        end
    end
end