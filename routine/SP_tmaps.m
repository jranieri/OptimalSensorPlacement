function temp  = SP_tmaps(A)

L=length(A(:,1));

%Normalize the rows to have equal norm

for i=1:length(A(:,1))
    A(i,:)=A(i,:)/norm(A(i,:));
end


% FInd the first 2 locations, by looking for the maximum in the Grammian
G_temp=abs(A*A')-eye(L);
[~,ind(1)]=max(max(G_temp));

% Find the other rows, and remove from the grammian the corresponding
% row and column
for i=1:L-1
    G_temp(:,ind)=0;
    G_temp(ind,:)=0;
    [~,ind(i+1)]=max(max(G_temp));
    disp(i)
end
    
ind=[ind,find(max(G_temp)>0)];
temp=fliplr(ind);
disp('Greedy Solution has been Found')




     