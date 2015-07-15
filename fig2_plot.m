close all
clear all

addpath('./routine/')
addpath('./data/')
addpath('./export_fig/')


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



matrix_type=4;

%% Generation of the title
switch matrix_type
    case 0
        Psi=randn(N,K);
        
        tit2='Gaussian tandom matrices with normalized rows';
        fn='rnd_gauss_norm';
    case 1
        tit2='Gaussian random matrices';
        fn='rnd_gauss';
    case 2
        
        tit2='Randomly subsampled DCT matrix';
        fn='rnd_DCT_matrix';
    case 3
        tit2='Random tight frame';
        fn='rnd_tight_frame';
    case 4
        tit2='Bernoulli random matrix';
        fn='rnd_bernoulli';
        
end

%% Load DATA
load(['./data/',fn,'.mat'])


%% Plot MSE

%%
gcf=figure(1);
set(gcf,'Color',[1 1 1]);
hold on
h(1)=perc_plot( 10*log10(MSE_FP(2:end,:)'),L(2:end),1)
h(2)=perc_plot( 10*log10(MSE_det(2:end,:)'),L(2:end),7)
h(3)=perc_plot( 10*log10(MSE_mutual_inf(2:end,:)'),L(2:end),5)
h(4)=perc_plot( 10*log10(MSE_MSE(2:end,:)'),L(2:end),3)
h(5)=perc_plot( 10*log10(MSE_rnd(2:end,:)'),L(2:end),2)
if matrix_type==4
axis([L(2),L(end),35,75])
end
hLegend=legend(h,'FrameSense','Determinant','Mutual Information','MSE','Random')

legend('boxoff')

hTitle  = title (tit2);
hXLabel = xlabel('Number of Sensors'                     );
hYLabel = ylabel('Normalized MSE [dB]'                      );

set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
set([hLegend, gca]             , ...
    'FontSize'   , 14           );
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 14          );
set( hTitle                    , ...
    'FontSize'   , 16          );
pbaspect([16,9, 14])

%% 