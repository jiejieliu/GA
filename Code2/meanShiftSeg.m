function [newImage, edge]=meanshiftSeg(input, hs, hr)
Origin=input;
Origin=colorspace('Luv<-RGB', Origin);
[M N P]=size(Origin);
segNum=0;
sum=zeros(3,M*N);
sumIndex=zeros(1,M*N);
queue=zeros(2,M*N);
modeFlag=zeros(M,N);
tmp=zeros(M,N,5);
mode=zeros(M,N,5);
newImage=zeros(M,N,3);
edge=zeros(M,N);
delx=[-1,0,1,0,-1,-1,1,1];
dely=[0,-1,0,1,-1,1,-1,1];
for i=1:1:M
    for j=1:1:N
        tmp(i,j,1)=i;
        tmp(i,j,2)=j;
        tmp(i,j,3)=Origin(i,j,1);
        tmp(i,j,4)=Origin(i,j,2);
        tmp(i,j,5)=Origin(i,j,3);
    end
end
for i=1:1:M
    for j=1:1:N
        mode(i,j,:)=meanShift(tmp(i,j,:),hs,hr,tmp);
    end
end
for i=1:1:M
    for j=1:1:N
        if(modeFlag(i,j)==0)
            segNum=segNum+1;
            sumIndex(1,segNum)=sumIndex(1,segNum)+1;
            sum(1,segNum)=sum(1,segNum)+mode(i,j,3);
            sum(2,segNum)=sum(2,segNum)+mode(i,j,4);
            sum(3,segNum)=sum(3,segNum)+mode(i,j,5);
            modeFlag(i,j)=segNum;
            head=1;
            tail=1;
            queue(1,tail)=i;
            queue(2,tail)=j;
            while(head<=tail)
                tmpx=queue(1,head);
                tmpy=queue(2,head);
                for k=1:8
                    u=tmpx+delx(k);
                    v=tmpy+dely(k);
                    if(u>0&&u<=M&&v>0&&v<=N&&modeFlag(u,v)==0)
                        range=(mode(u,v,3)-mode(tmpx,tmpy,3))^2+(mode(u,v,4)-mode(tmpx,tmpy,4))^2+(mode(u,v,5)-mode(tmpx,tmpy,5))^2;
                        if (range<hr^2)
                            tail=tail+1;
                            queue(1,tail)=u;
                            queue(2,tail)=v;
                            modeFlag(u,v)=segNum;
                            sum(1,segNum)=sum(1,segNum)+mode(i,j,3);
                            sum(2,segNum)=sum(2,segNum)+mode(i,j,4);
                            sum(3,segNum)=sum(3,segNum)+mode(i,j,5);
                            sumIndex(1,segNum)=sumIndex(1,segNum)+1;
                        end
                    end
                end
                head=head+1;
            end
        end
    end
end
for i=1:1:M
    for j=1:1:N
        tmpn=modeFlag(i,j);
        newImage(i,j,1)=sum(1,tmpn)/sumIndex(tmpn);
        newImage(i,j,2)=sum(2,tmpn)/sumIndex(tmpn);
        newImage(i,j,3)=sum(3,tmpn)/sumIndex(tmpn);
    end
end
for i=2:1:M
    for j=2:1:N
        if (((modeFlag(i,j)~=modeFlag(i,j-1))||(modeFlag(i,j)~=modeFlag(i-1,j)))&&(sumIndex(modeFlag(i,j))>=12))
            edge(i,j) = 255;
        end
    end
end       
newImage=colorspace('RGB<-Luv',newImage);        
        
        
        
