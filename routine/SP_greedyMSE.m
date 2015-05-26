function [ indexes ] = SP_greedyMSE( P, S )

N=length(P(:,1));
    
G=abs(P*P');

[~,ind] = max(diag(G));
indexes(1)=ind(1);


for i=2:S
    comp=1:N;
    comp(indexes)=[];
    for j=1:length(comp)
        A=P([indexes,comp(j)],:);
        cost_function(j)=abs(sum(eig(A'*A).^(-1)));
    
    
    end
    cost_function(indexes)=NaN;
    
    [minA,indexes(i)]=min(cost_function);
    
end 

end

