function output=G(input,hs,hr,yi)
[M,N,P]=size(input);
output=zeros(M,N,P);
for i=1:M
    for j=1:N
        space=(input(i,j,1)-yi(1))^2+(input(i,j,2)-yi(1))^2;
        if space <= hs^2
            range=(input(i,j,3)-yi(3))^2+(input(i,j,4)-yi(4))^2+(input(i,j,5)-yi(5))^2;
            if range <= hr^2
                output(i,j,:)=1;
            end
        end
    end
end
    
        
