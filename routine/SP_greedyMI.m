function [ select ] = SP_greedyMI( cova,S )
%% Sensor selection worst-out greedy algorithm based the Mutual Information.
%% Algorithm designed by Juri Ranieri. 
% P: the matrix
% L: the number of desired sensors
% select: the index of the chosen locations. 


[N,~]=size(cova);
if S>N;
    S=N;
end

[~,select]=max(diag(cova));

for i=2:S
    comp=1:N;
    comp(select)=[];
    for j=1:N
        
        [U,S,V]=svd(cova(select,select));
        S(S~=0)=S(S~=0).^-1;
        A=V*S*U';
        
        [U,S,V]=svd(cova(comp,comp));
        S(S~=0)=S(S~=0).^-1;
        B=V*S*U';
        
        cost_function(j)=(cova(j,j)-cova(j,select)*A*cova(select,j))/(cova(j,j)-cova(j,comp)*B*cova(comp,j));
        
    end
    cost_function(select)=NaN;
    
    
    [~,select(i)] = max(cost_function);
    
end



end