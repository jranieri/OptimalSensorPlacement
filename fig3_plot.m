clear all


addpath('./data/')
addpath('./routine/')
addpath('./export_fig/')




%% Load DATA
load('./data/comp_time_algo.mat')
N=N(1:end-1);

%% Plot MSE

%%
gcf=figure(1);
set(gcf,'Color',[1 1 1]);
hold on
h(1)=perc_plot( log10(time_FP'),N,1)
h(2)=perc_plot( log10(time_det'),N,7)
h(3)=perc_plot( log10(time_mutual_inf'),N,5)
h(4)=perc_plot( log10(time_MSE'),N,3)
h(5)=perc_plot( log10(time_rnd'),N,2)
axis([N(1),N(end), -5, 5])
hLegend=legend(h,'FrameSense','Determinant','Mutual Information','MSE','Random')
set(hLegend,'Location','NorthWest');
legend('boxoff')

hTitle  = title ('Comparison of computational time');
hXLabel = xlabel('Number of available sensor locations'                     );
hYLabel = ylabel('Computational time [log s]'                      );

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
