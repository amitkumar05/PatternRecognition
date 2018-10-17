function [norm_dtw] = dtw (x , y)
size_x=size(x);
row_x=size_x(1);
%col_x=size_x(2);
size_y=size(y);
row_y=size_y(1);
%col_y=size_y(2);

dtw=zeros(row_x,row_y);

for i=1:(row_x)
    dtw(i,1)=norm(x(i,:)-y(1,:));   %%% In matlab indices start from 1
    if(i>1)
        dtw(i,1)=dtw(i,1)+dtw(i-1,1);
    end
end

for j=1:(row_y)
    dtw(1,j)=norm(y(j,:)-x(1,:));   %%% In matlab indices start from 1
    if(j>1)
        dtw(1,j)=dtw(1,j)+dtw(1,j-1);
    end
end

for i=2:row_x
    for j=2:row_y
        dtw(i,j)=norm(x(i,:)-y(j,:))+min([dtw(i,j-1),dtw(i-1,j),dtw(i-1,j-1)]);
    end
end

norm_dtw=dtw(row_x,row_y)/(row_x*row_y);



