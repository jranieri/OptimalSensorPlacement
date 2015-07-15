close all
clear all

addpath('../routine/')
addpath('../data/')
addpath('../routine_joshi/')
addpath('../export_fig/')





%% Matrix
%matrix_type=0 %% random normalized matrix
%matrix_type=1 %% random matrix
%matrix_type=2 %% DCT randomly selected matrix
%matrix_type=3 %% random orthogonalized matrix
%matrix_type=4 %% Bernoulli 0.5
%matrix_type=5 %% Thermal maps


matrix_type=4;
%% Generation of the title
switch matrix_type
    case 0
        
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
    case 5
        load Psi_tmaps_red.mat;
    case 4
        tit2='Bernoulli random matrix';
        fn='rnd_bernoulli';
        
end

%% Load DATA
load(['./data/',fn,'.mat'])


%% Plot MSE
ind=3;
gcf=figure(1);
set(gcf,'Color',[1 1 1]);
hold on
h(1)=perc_scatter( log10(time_FP(ind,:)'), 10*log10(MSE_FP(ind,:)'),1);
h(2)=perc_scatter( log10(time_det(ind,:)'), 10*log10(MSE_det(ind,:)'),7);
h(3)=perc_scatter( log10(time_mutual_inf(ind,:)'), 10*log10(MSE_mutual_inf(ind,:)'),5);
h(4)=perc_scatter( log10(time_MSE(ind,:)'), 10*log10(MSE_MSE(ind,:)'),3);
h(5)=perc_scatter( log10(time_rnd(ind,:)'), 10*log10(MSE_rnd(ind,:)'),2);
h(6)=perc_scatter( log10(time_joshi(ind,:)'), 10*log10(MSE_joshi(ind,:)'),13);

%%
hLegend=legend(h,'FrameSense','Determinant','Mutual Information','MSE','Random','Convex Opt. Method [6]')

switch matrix_type
    case 4
        axis([-5,1,35,65])
        set(hLegend,'Location','NorthWest');
    case 1
        axis([-5,1,-0,6])
        set(hLegend,'Location','SouthWest');
    case 3
        set(hLegend,'Location','NorthWest');
        
    case 0
        set(hLegend,'Location','NorthWest')
    
    case 2
        axis([-5,5,10,40])
        %set(hLegend,'Location','SouthWest');
end
%%

legend('boxoff')

hTitle  = title (tit2);
hXLabel = xlabel('Computational time [log s]'                     );
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