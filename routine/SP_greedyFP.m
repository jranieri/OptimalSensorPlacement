function [select]= SP_greedyFP(P,L)
%% Sensor selection worst-out greedy algorithm based the frame potential.
%% Algorithm designed by Juri Ranieri. Code optimized by Johan Vogel
% P: the matrix
% L: the number of desired sensors
% select: the index of the chosen locations. 

  N=length(P(:,1));
  select=1:N;
  
% Normalize the norm of the rows
for i=1:N
    P(i,:)=P(i,:)/norm(P(i,:),2);
end

%% Greedy algorithm

% First Step, find the best two rows
G=(P*P').^2;
G=G-eye(N);
Gsum=sum(G);

[~,ind] = max(Gsum);
Gsum=Gsum-G(select(ind),:);
select(ind)=[];

n=1;
% Find the row to eliminate one by one

while length(select)>L
    n=n+1;
    
    [~,ind] = max(Gsum(select));
    Gsum=Gsum-G(select(ind),:);
    select(ind)=[];
end
