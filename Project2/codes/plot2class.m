%
% 
function [ ] = plot2class( pixel, probC1, probC2, col1, col2)
    clf reset;
    hold on;
    size_t = size(pixel);
    row = size_t(1);
    a=1;b=1;
    C1x=[];C1y=[];C2x=[];C2y=[];
    for k = 1:row
        if ( probC1(k) >= probC2(k) )
      %      plot( pixel(k,1), pixel(k,2), formatspec1 )
         C1x(a)=pixel(k,1);C1y(a)=pixel(k,2);a=a+1;
        else
       %     plot( pixel(k,1), pixel(k,2), formatspec2 ) 
            y=7;
            C2x(b)=pixel(k,1);C2y(b)=pixel(k,2);b=b+1;
        end
    end
    %plot( C1x,C1y, formatspec1 );
    %plot( C2x,C2y, formatspec2 );
    scatter( C1x,C1y,[],col1,'.' );
    scatter( C2x,C2y,[], col2,'.' );
 end