%
function [ pixel ] = pixel_gen( xmin, xmax, xres, ymin, ymax, yres )
    %p = 1;
    pixel=[];
    for k = xmin:xres:xmax
%       for l = ymin:yres:ymax
%             pixel(p,1) = k;
%             pixel(p,2) = l;
%             p = p + 1;
        B=ones((floor((ymax-ymin)/yres))+1 , 2) * k;
        B(:,2) = [ymin:yres:ymax];
        pixel=[pixel;B];
    end
end


%%X = [1:1:100000]