close all
clear all


addpath('./data/')
addpath('./export_fig/')


%% Parameters
load('./data/comp_joshi.mat')




%% Plot MSE

%%
gcf=figure(1);
set(gcf,'Color',[1 1 1]);
hold on
h(1)=perc_scatter( log10(time_FP{1}'),10*log10(MSE_FP{1}'),1)
h(2)=perc_scatter( log10(time_JOSHI{1}'),10*log10(MSE_joshi{1}'),13)

hLegend=legend(h,'FrameSense','Convex Opt. Method [6]')

legend('boxoff')

hTitle  = title ('Gaussian random matrices');
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

export_fig('format','pdf','width',3.33, 'fontmode','fixed', 'fontsize',8,'color','cmyk',['./figures/joshi_vs_FP.pdf']);

%% 