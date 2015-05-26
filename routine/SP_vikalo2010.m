function [ ind ] = SP_vikalo2010( P,S )

[N,~]=size(P);

for j=1:N
    cf(j)=log10(det(P(j,:)'*P(j,:)));
end

[~,ind]=max(cf);
clear cf;
P_temp=P(ind,:)'*P(ind,:);
for i=2:S
    
    for j=1:N
        cf(j)=log(det(P([ind, j],:)'*P([ind, j],:)));
        
    end
    cf=abs(cf);
    cf(ind)=0;
    [~,ind(i)]=max(cf);
    clear cf;
    P_temp=P(ind,:)'*P(ind,:);
end
    
