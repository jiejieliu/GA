function yc=meanShift(input,hs,hr,X)
[M N P]=size(X);
yi=input;
cnt=0;
while(cnt<=5)
horiPre=max(1,yi(1,1)-hs);
horiPost=min(M,yi(1,1)+hs);
vertPre=max(1,yi(1,2)-hs);
vertPost=min(N,yi(1,2)+hs);
tmp=X(horiPre:horiPost,vertPre:vertPost,:);
% numerator=sum(sum(tmp));
% denominator=(2*hs+1)^2;
Gtmp=G(tmp,hs,hr,yi);
tmpnu=tmp.*Gtmp;
numerator=sum(sum(tmpnu));
denominator=sum(sum(Gtmp(:)))/P;
% for i=horiPre:1:horiPost
%     for j=vertPre:1:vertPost
%         numerator=X(i,j,:)+numerator;
%         denominator=denominator+1;
%     end
% end
% yi0=yi;
if denominator~=0
    yi=round(numerator./denominator);
else
    break;
end
cnt=cnt+1;
% if cnt>=5
%     break;
% end
end
yc=yi;