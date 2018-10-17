function [means_arr,znk_arr,ele_in_clus] = k_means(data,K)
    size_data = size(data);
    N = size_data(1);
    c = randperm(N,K); % pick random 'k' numbers from 1 to number of dataum
%    c = [1:K];
    means_arr = data(c,:); %set sample data at k position to be initial means
    znk_arr=zeros(N,K);
    j_new=0;
    j_old=0;
    while 1
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
            znk_arr(i,min_in)=1;
            j_old=j_old+norm(data(i,:)-means_arr(min_in,:)); %find distance with respect to old parameters
        end
        means_arr=zeros(size(means_arr));
        ele_in_clus=zeros(K,1);
        for q=1:K
            for p=1:N 
                %means_arr(q,:)=(symsum(znk_arr(n,q)*data(n,:),n,1,N)/symsum(znk_arr(n,q),n,1,N));
                if(znk_arr(p,q)==1)
                    means_arr(q,:)=means_arr(q,:)+data(p,:); %compute new means
                    ele_in_clus(q,1)=ele_in_clus(q,1)+1;
                end
            end
            means_arr(q,:)=means_arr(q,:)/ele_in_clus(q,1);
        end
        j_new=0;
        for i=1:N
            for j=1:K
                if(znk_arr(i,j)==1)
                    j_new=j_new+norm(data(i,:)-means_arr(j,:)); %set distance with respect to new parameters
                end
            end
        end
        if(j_new-j_old < 1) %check if difference is less than threshold
            break;
        end
    end
end
    