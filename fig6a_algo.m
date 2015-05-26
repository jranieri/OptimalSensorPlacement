%% Test TMaps


clear all
close all


addpath('./routine/')
addpath('./data/')
addpath('./routine_external/')


load PCA_niagara

fn='tmaps_comp';


K=16;

Psi=eigen_maps(:,1:K);

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
    loc_det=SPy_vikalo2010(Psi,L(i));
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
save(['./data/',fn,'.mat'])

exit;


