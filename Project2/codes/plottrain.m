%
%
function [ ] = plottrain( trainmat, formatspec )
%     size_m = size(trainmat);
%     row = size_m(1);
%     for k = 1:row
%             plot( trainmat(k,1), trainmat(k,2), formatspec )
%     end
      p=plot( trainmat(: , 1), trainmat(: , 2), formatspec );
      %legend(p,l);
end