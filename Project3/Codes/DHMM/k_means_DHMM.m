%%%CHANGELOG: Changed the threshold(increased)%%%
function [ to1, to2, to3, means_arr ] = k_means_DHMM( t1, t2, t3, K )
    % to1,to2,to3 
    format long g
    size_t1 = size(t1);
    size_t2 = size(t2);
    size_t3 = size(t3);
    index = 1;
    for i = 1:size_t1(2)
        row_t1_i = size(t1{i}, 1);
        for j = 1:row_t1_i
            data(index, :) = t1{i}(j, :);
            index = index + 1;
        end
    end
    for i = 1:size_t2(2)
        row_t2_i = size(t2{i}, 1);
        for j = 1:row_t2_i
            data(index, :) = t2{i}(j, :);
            index = index + 1;
        end
    end
    %%%%%%%%%%%%%%%
    for i = 1:size_t3(2)
        size_t3_i = size(t3{i});
        row_t3_i=size_t3_i(1);
        for j=1:row_t3_i
            data(index,:)=t3{i}(j,:);
            index=index+1;
        end
    end
    size_data = size(data);
    N = size_data(1);
    c = randperm(N,K); % pick random 'k' numbers from 1 to number of dataum
    means_arr = data(1:K,:); %set sample data at k position to be initial means

%    iter = 1;
    while (1)
%         iter
%         iter = iter + 1;
        zn_arr=zeros(N,1);
        j_old=0;
        for i = 1:N
            min_dis=inf;
            min_in=-1;
            for j = 1:K
                dis=norm(data(i,:)-means_arr(j,:));
                if (min_dis>dis)
                    min_dis=dis;
                    min_in=j; %set the index for which euclidean distance is minimum
                end
            end
            zn_arr(i)=min_in;
            j_old=j_old+norm(data(i,:)-means_arr(min_in,:)); %find distance with respect to old parameters
        end

        means_arr=zeros(size(means_arr));
        ele_in_clus=zeros(K,1);
        for p=1:N
            q=zn_arr(p);
            means_arr(q,:)=means_arr(q,:)+data(p,:); %compute new means
            ele_in_clus(q,1)=ele_in_clus(q,1)+1;
        end
        for q=1:K
            means_arr(q,:)=means_arr(q,:)/ele_in_clus(q,1);
        end

        j_new=0;
        for i=1:N
            j=zn_arr(i);
            j_new=j_new+norm(data(i,:)-means_arr(j,:)); %set distance with respect to new parameters
        end
%        abs(j_new-j_old)
 %        if(abs(j_new-j_old) < 0.001) %check if difference is less than threshold
%         if(abs(j_new-j_old) < 5000)
%        if(abs(j_new-j_old) < 500)
        if(abs(j_new-j_old) < 0.01)

            break;
        end
    end

    %to1=zeros(size_t1);
    %to2=zeros(size_t2);
    %to3=zeros(size_t3);

    index=1;
    for i=1:size_t1(2)
        size_t1_i=size(t1{i});
        row_t1_i=size_t1_i(1);
        for j=1:row_t1_i
            to1{i}(j)=zn_arr(index);
            index=index+1;
        end
    end

    for i=1:size_t2(2)
        size_t2_i=size(t2{i});
        row_t2_i=size_t2_i(1);
        for j=1:row_t2_i
            to2{i}(j)=zn_arr(index);
            index=index+1;
        end
    end

    for i=1:size_t3(2)
        size_t3_i=size(t3{i});
        row_t3_i=size_t3_i(1);
        for j=1:row_t3_i
            to3{i}(j)=zn_arr(index);
            index=index+1;
        end
    end

end
