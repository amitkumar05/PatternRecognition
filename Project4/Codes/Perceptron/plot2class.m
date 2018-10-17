%
% 
function [ ] = plot2class( pixel, w12, w13 ,w23, col1, col2,col3)
   % clf reset;
    hold on;
    size_t = size(pixel);
    row = size_t(1);
     a=1;b=1;c=1;
     C1x=[];C1y=[];C2x=[];C2y=[];C3x=[];C3y=[];
     for k = 1:row
        y=change(pixel(k,:)');
        %w12
        x1=w12'*y;
        x2=w13'*y;
        x3=w23'*y;
        if (( x1>0 && x2>0))
    %        plot( pixel(k,1), pixel(k,2), 'c.' )
             C1x(a)=pixel(k,1);C1y(a)=pixel(k,2);a=a+1;
        elseif ((x1<0 && x3>0))
     %       plot( pixel(k,1), pixel(k,2), 'g.' )   
             C2x(b)=pixel(k,1);C2y(b)=pixel(k,2);b=b+1;
     
       % elseif(x2<0 && x3<0)
        else
      %      plot( pixel(k,1), pixel(k,2), 'b.' )   
         C3x(c)=pixel(k,1);C3y(c)=pixel(k,2);c=c+1;
        end
    end
    %plot( C1x,C1y, formatspec1 );
    %plot( C2x,C2y, formatspec2 );
    scatter( C1x,C1y,[],col1,'.' );
    scatter( C2x,C2y,[], col2,'.' );
     scatter( C3x,C3y, [],col3,'.' );
 end