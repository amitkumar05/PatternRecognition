function [ dist ] = eucliddis( x,y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

size_x=size(x);
row_x=size_x(1);
% col_x=size_x(2);
% size_y=size(y);
% row_y=size_y(1);
% col_y=size_y(2);

%dtw=zeros(row_x,row_y);
    dist=0;
    for i=1:(row_x)
        dist=dist+norm(x(i,:)-y(i,:));   %%% In matlab indices start from 1   
    end
end
