clear all
close all

addpath('./routine/')
addpath('./routine_external/')

%% Parameters
Nv=[50:50:200, 300, 400, 500];
K=20;
rho=0.5;

max_iter=100;

%% Parameters Algorithm
threshold=0.4;

%% Matrix
%matrix_type=0 %% random normalized matrix
matrix_type=1 %% random matrix
%matrix_type=2 %% DCT randomly selected matrix
%matrix_type=3 %% random orthogonalized matrix


%% Test
for i=1:length(Nv)
    N=Nv(i);
    L(i)=floor(rho*N);
    for j=1:max_iter
        
        %% Generation of the matrix
        switch matrix_type
            case 2
                Psi=randn(N,K);
                for i=1:N
                    Psi(i,:)=Psi(i,:)/norm(Psi(i,:));
                end
            case 1
                Psi=randn(N,K);
            case 4
                Psi=dctmtx(N);
                rand_sel=randperm(N);
                Psi=Psi(:,rand_sel(1:K));
                
                for i=1:N
                    Psi(i,:)=Psi(i,:)/norm(Psi(i,:));
                end
            case 3
                Psi=randn(N,K);
                Psi=orth(Psi);
                
        end
        
        
        
        tic
        loc_FP=SP_greedyFP(Psi,L(i));
        time_FP{matrix_type}(i,j)=toc;
        tic
        [zhat, ~, ~, ~]= sens_sel_approxnt(Psi, L(i));
        [loc_joshi, ~] = sens_sel_loc(Psi, zhat);
        loc_joshi=find(loc_joshi);
        time_JOSHI{matrix_type}(i,j)=toc;
        
        
        matrix_type
        %% Prepare the matrices
        Psi_FP=Psi(loc_FP,:);
        Psi_joshi=Psi(loc_joshi,:);
        
        
        %% Compute MSE
        MSE_FP{matrix_type}(i,j)=sum(eig(Psi_FP'*Psi_FP).^-1);
        MSE_joshi{matrix_type}(i,j)=sum(eig(Psi_joshi'*Psi_joshi).^-1);
        
    end
end


save('./data/comp_joshi.mat')
exit;
