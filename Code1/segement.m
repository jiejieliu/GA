function [result,edge] = segement(A,threshold)
A = double(A);
[m,n,dim] = size(A);
A1 = A(:,:,1);
A2 = A(:,:,2);
A3 = A(:,:,3);
edge = zeros(m,n);
result = zeros(m,n);
flag = zeros(m,n);
number = 0;
sumvalue = zeros(1,m*n);
R = zeros(1,m*n);
G = zeros(1,m*n);
B = zeros(1,m*n);

queue1 = zeros(1,m*n);
queue2 = zeros(1,m*n);
xadd = [-1,0,1,0,-1,-1,1,1];
yadd = [0,-1,0,1,-1,1,-1,1];
for i=1:m
    for j=1:n
        if(flag(i,j)==0)
            number = number + 1;
            flag(i,j) = number;
            sumvalue(number)=sumvalue(number)+1;
            R(number)=R(number) +A1(i,j);
            G(number)=G(number) +A2(i,j);
            B(number)=B(number) +A3(i,j);
            Start = 1;
            End = 1;
            queue1(End) = i;
            queue2(End) = j;
            while Start<=End
                CurrX = queue1(Start);
                CurrY = queue2(Start);
                for k=1:8
                    xx = CurrX + xadd(k);
                    yy = CurrY + yadd(k);
                    if((yy<=n)&&(yy>=1)&&(xx<=m)&&(xx>=1)&&(flag(xx,yy)==0))  
                        temp = (A1(xx,yy)-A1(CurrX,CurrY))^2+(A2(xx,yy)-A2(CurrX,CurrY))^2+(A3(xx,yy)-A3(CurrX,CurrY))^2;
                        if ((temp<3*threshold^2))
                            End=End + 1;
                            queue1(End) = xx;
                            queue2(End) = yy;
                            flag(xx,yy) = number;
                            sumvalue(number)=sumvalue(number)+1;
                            R(number)=R(number) +A1(xx,yy);
                            G(number)=G(number) +A2(xx,yy);
                            B(number)=B(number) +A3(xx,yy);
                        end
                    end
                end
                Start=Start+1;
            end
        end
    end
end
      
for i=1:1:m
    for j=1:1:n
          temp = flag(i,j);
          result(i,j,1) = round(R(temp)/sumvalue(temp));
          result(i,j,2) = round(G(temp)/sumvalue(temp));
          result(i,j,3) = round(B(temp)/sumvalue(temp));
    end
end

for i=2:1:m
    for j=2:1:n
        if (((flag(i,j)~=flag(i,j-1))||(flag(i,j)~=flag(i-1,j)))&&(sumvalue(flag(i,j))>=10))
            edge(i,j) = 255;
        end
    end
end
edge = uint8(edge);
result = uint8(result);

