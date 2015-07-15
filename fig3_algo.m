clear all
close all

addpath('./routine/')
addpath('./routine_external/')


%% Parameters
N=20:30:200;
K=10;
p=0.5;
max_iter=50;

% Name of the file to save
fn='comp_time_algo'


%%


for i=1:length(N)
    N(i)
    L=floor(p*N(i));
    for j=1:max_iter
        
        Psi=randn(N(i),K);

        
        tic
        loc_FP=SP_greedyFP(Psi,L);
        time_FP(i,j)=toc;
        
        tic
        loc_det=SP_vikalo2010(Psi,L);
        time_det(i,j)=toc;
        
        tic
        loc_MSE=SP_greedyMSE(Psi,L);
        time_MSE(i,j)=toc;
        
        tic
        loc_mutual_inf=SP_greedyMI(Psi*Psi',L);
        time_mutual_inf(i,j)=toc;
        
        tic
        loc_entropy=SP_greedyEntropy(Psi*Psi',L);
        time_entropy(i,j)=toc;
        
        tic
        [zhat, ~, ~, ~]= sens_sel_approxnt(Psi, L);
        [loc_joshi, ~] = sens_sel_loc(Psi, zhat);
        loc_joshi=find(loc_joshi);
        time_joshi(i,j)=toc;
        
        tic
        loc_rnd=randperm(N(i));
        loc_rnd=loc_rnd(1:L);
        time_rnd(i,j)=toc;
        
    end
end





%% Save DATA
save(['./data/',fn,'.mat'])

exit;

