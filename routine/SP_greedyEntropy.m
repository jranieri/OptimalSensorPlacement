function [ ind ] = SP_greedyEntropy( cov,S )

[N,~]=size(cov);

ind=[];

for i=1:S
    for j=1:N
        cost_function(j)=det(cov([ind,j],[ind,j]));
    end
    
    cost_function(ind)=NaN;
    [~,ind(i)] = max(cost_function);
end

end

