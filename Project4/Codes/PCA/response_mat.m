function [gamma_znk] = response_mat(data,pi,means,covmats)
size_data=size(data);
N=size_data(1);
d=size_data(2);
size_pi=size(pi);
K=size_pi(1);
%syms a;
for i=1:N
    denom = 0;
    %denom=symsum(pi(a,1)*gauss_dis( data(i,:),means(a,:),covmats(:,:,a)),a,1,K);
    for a=1:K
        
        denom=denom+(pi(a,1)*gauss_dis( data(i,:),means(a,:),covmats(:,:,a)));
        %denom=(pi(a,1)*0.4);
    end
    for j=1:K
        gamma_znk(i,j)=(pi(j,1)*gauss_dis( data(i,:),means(j,:),covmats(:,:,j))/denom);
        %gamma_znk(i,j)=(pi(j,1)*0.6)/denom;
    end
end
end

        
    