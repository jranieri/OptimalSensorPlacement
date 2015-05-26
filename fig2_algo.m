clear all
close all

addpath('./routine/')
addpath('./routine_external/')



%% Parameters
N=100;
K=30;
L=30:5:60;
max_iter=100;



%% Matrix
%matrix_type=0 %% random normalized matrix
%matrix_type=1 %% random matrix
%matrix_type=2 %% DCT randomly selected matrix
%matrix_type=3 %% random orthogonalized matrix
%matrix_type=4 %% Bernoulli 0.5
%matrix_type=5 %% Thermal maps


%% Test
for matrix_type=0:4
    

    
    for j=1:max_iter
        
        %% Generation of the matrix
        switch matrix_type
            case 0
                Psi=randn(N,K);
                
                tit='Gaussian Random Matrices with Normalized Rows';
                fn='rnd_gauss_norm';
                for i=1:N
                    Psi(i,:)=Psi(i,:)/norm(Psi(i,:));
                end
            case 1
                Psi=randn(N,K);
                tit='Gaussian Random Matrices';
                fn='rnd_gauss';
            case 2
                Psi=dctmtx(N);
                rand_sel=randperm(N);
                Psi=Psi(:,rand_sel(1:K));
                
                tit='Randomly Subsampled DCT Matrix';
                fn='rnd_DCT_matrix';
            case 3
                Psi=randn(N,K);
                Psi=orth(Psi);
                tit='Random Tight Frame';
                fn='rnd_tight_frame';
            case 5
                load Psi_tmaps_red.mat;
                Psi=Psi(1:64:6400,1:K);
                N=length(Psi(:,1));
            case 4
                Psi=randn(N,K);
                Psi=double(Psi>0)/K;
                tit='Bernoulli Random Matrix';
                fn='rnd_bernoulli';
                
        end
        disp(tit)
        
        for i=1:length(L)
            
            tic
            loc_FP=SP_greedyFP(Psi,L(i));
            time_FP(i,j)=toc;
            
            tic
            loc_det=SP_vikalo2010(Psi,L(i));
            time_det(i,j)=toc;
            
            tic
            loc_MSE=SP_greedyMSE(Psi,L(i));
            time_MSE(i,j)=toc;
            
            tic
            loc_mutual_inf=SP_greedyMI(Psi*Psi',L(i));
            time_mutual_inf(i,j)=toc;
            
            tic
            loc_entropy=SP_greedyEntropy(Psi*Psi',L(i));
            time_entropy(i,j)=toc;
            
            tic
            [zhat, ~, ~, ~]= sens_sel_approxnt(Psi, L(i));
            [loc_joshi, ~] = sens_sel_loc(Psi, zhat);
            loc_joshi=find(loc_joshi);
            time_joshi(i,j)=toc;
            
            tic
            loc_rnd=randperm(N);
            loc_rnd=loc_rnd(1:L(i));
            time_rnd(i,j)=toc;
            
            
            %% Prepare the matrices
            Psi_FP=Psi(loc_FP,:);
            Psi_det=Psi(loc_det,:);
            Psi_MSE=Psi(loc_MSE,:);
            Psi_mutual_inf=Psi(loc_mutual_inf,:);
            Psi_entropy=Psi(loc_entropy,:);
            Psi_joshi=Psi(loc_joshi,:);
            Psi_rnd=Psi(loc_rnd,:);
            
            
            %% Compute MSE
            MSE_FP(i,j)=sum(eig(Psi_FP'*Psi_FP).^-1);
            MSE_det(i,j)=sum(eig(Psi_det'*Psi_det).^-1);
            MSE_MSE(i,j)=sum(eig(Psi_MSE'*Psi_MSE).^-1);
            MSE_mutual_inf(i,j)=sum(eig(Psi_mutual_inf'*Psi_mutual_inf).^-1);
            MSE_entropy(i,j)=sum(eig(Psi_entropy'*Psi_entropy).^-1);
            MSE_joshi(i,j)=sum(eig(Psi_joshi'*Psi_joshi).^-1);
            MSE_rnd(i,j)=sum(eig(Psi_rnd'*Psi_rnd).^-1);
            
            
        end
    end
    
    
    
    
    
    %% Save DATA
    save(['./data/',fn,'.mat'])
end

exit;