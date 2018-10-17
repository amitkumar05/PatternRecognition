% WORKS ONLY FOR THREE CLASSES AND TWO DIMENSIONAL DATA
% C1:r(red)   C2:g(green)   C3:b(blue)

function [ ] = plot3class( pixel, probC1, probC2, probC3, col1, col2, col3 )
    clf reset;
    hold on;
    size_t = size(pixel);
    row = size_t(1);
     a=1;b=1;c=1;
     C1x=[];C1y=[];C2x=[];C2y=[];C3x=[];C3y=[];
    for k = 1:row
        if ( (probC1(k) >= probC2(k)) && (probC1(k) >= probC3(k)) )
    %        plot( pixel(k,1), pixel(k,2), 'c.' )
             C1x(a)=pixel(k,1);C1y(a)=pixel(k,2);a=a+1;
        elseif ( probC2(k) >= probC3(k) )
     %       plot( pixel(k,1), pixel(k,2), 'g.' )   
             C2x(b)=pixel(k,1);C2y(b)=pixel(k,2);b=b+1;
     
        else
      %      plot( pixel(k,1), pixel(k,2), 'b.' )   
         C3x(c)=pixel(k,1);C3y(c)=pixel(k,2);c=c+1;
        end
    end
%     plot( C1x,C1y, 'c.' );
%     plot( C2x,C2y, 'g.' );
%     plot( C3x,C3y, 'b.' );
     scatter( C1x,C1y, [], col1, '.' );
     scatter( C2x,C2y, [], col2, '.' );
     scatter( C3x,C3y, [], col3, '.' );
     %xlabel(x_lab), ylabel(y_lab), title(t) , legend(l1,l2,l3);

end