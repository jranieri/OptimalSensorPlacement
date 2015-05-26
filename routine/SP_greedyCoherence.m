function indexes  = SP_greedyCoherence(P,S)
    

% Normalize the norm of the rows

for i=1:length(P(:,1))
    P(i,:)=P(i,:)/norm(P(i,:));
end

% Initialize the algorithm 
    
G=abs(P*P');
[minA,ind] = min(G(:));
[indexes(1),indexes(2)] = ind2sub(size(G),ind);



for i=3:S
    t=sum(G(indexes,:));
    [minA,indexes(i)]=min(t);
end 






     