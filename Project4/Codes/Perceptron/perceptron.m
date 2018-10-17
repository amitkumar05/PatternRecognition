function [ w ] = perceptron( trainmat1,trainmat2 )
trainmat1=trainmat1';
ptrainmat2=trainmat2';
trainmat2=-ptrainmat2;
%display('no')
change(trainmat1(:,1))
w=[10;1;1];
eeta=0.5;
%for j=1:10
 while 1
    flag=0;  
    dir=w;
    
    for i = 1:size(trainmat1,2)
          %dir=w
          y=change(trainmat1(:,i));
          x=w'*y;
          if(x < 0)
                w=w+eeta*y;
                flag=1;
                break;
           end
    end
    w;
    if(flag==1)
         continue;
    end
   % display('hi')
    
    for i = 1:size(trainmat2,2)
           %dir=w
           y=change(trainmat2(:,i));
           y(1)=-1;
           x=w'*y;
          if(x < 0)
                w=w+eeta*y;
                flag=1;
                break;
           end
    end
    if(flag==1)
         continue;
    else
        break;
    end
end

end

