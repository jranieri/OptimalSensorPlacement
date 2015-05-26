% This script loads the tmaps of the niagara datasets stored in
% data_niagara.mat and compute the PCA decomposition, saving only K
% components.

clear all
close all

addpath('../routine/k-LSE/')
addpath('../routine/')

load ('../data/data_niagara')


[N,M]=size(X); % N: length of the tmaps, M: number of tmaps

L1=60;
L2=56;

S=30;


for i1=1:length(S)
    
    
    %% Setup Brown
    % Use the bisection technique, find the location of the sensors and plot them.
    [sens_locations, ~, ~] =bisect_sens_loc(S(i1),L1,L2,N,M,X);
    
    % Choose the coefficients we estimate with LSE, such that A is full rank
    A=[1,1];
    k=0;
    i=-1;
    while rank(A)~=k || cond(A)>10 || i==-1
        i=i+1;
        k=S(i1)-i;
        
        [A_approx, coeff_loc] = inv_operator(L1,L2,k);
        A=A_approx(reshape(sens_locations,[L1*L2,1])==1,:);
        
        if i>S(i1)+1
            coeff_loc=zeros(L1,L2);
            coeff_loc(1,1)=1;
            k=1;
            disp('fail to find a good matrix');
            break;
        end
    end
    
end


%%
K=16;
Psi= A_approx(:,1:K);

for i=1:K
    temp=imresize(reshape(Psi(:,i),[60,56]),0.35);
    [L1,L2]=size(temp);
    Psi_s(:,i)=temp(:);
end
Psi=Psi_s;

%%
L=16:4:50;

loc_cohe=greedy_tmaps(Psi);
for i=1:length(L)
    
    loc_FP=SP_greedyFP(Psi,L(i));
    loc_det=SP_vikalo2010(Psi,L(i));
    loc_MSE=SP_greedyMSE(Psi,L(i));
    loc_mutual_inf=SP_greedyMI(Psi*Psi',L(i));
    loc_entropy=SP_greedyEntropy(Psi*Psi',L(i));
    
    
    MSE_FP(i)=mse_loc(Psi,loc_FP);
    MSE_cohe(i)=mse_loc(Psi,loc_cohe(1:L(i)));
    MSE_det(i)=mse_loc(Psi,loc_det);
    MSE_MSE(i)=mse_loc(Psi,loc_MSE);
    MSE_mutual_inf(i)=mse_loc(Psi,loc_mutual_inf);
    MSE_entropy(i)=mse_loc(Psi,loc_entropy);
end

for i=1:length(L)
    for j=1:100
        loc_rnd=randperm(L1*L2);
        loc_rnd=loc_rnd(1:L(i));
        MSE_rnd(i,j)=mse_loc(Psi,loc_rnd);
    end
end


%% Save DATA

fn='tmaps_DCT_comp';
save(['./data/',fn,'.mat'])

exit;


