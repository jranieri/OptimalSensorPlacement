clear all;
close all;

%% Plot the figure!
addpath('./export_fig/')


load('./data/tmaps_DCT_comp')

%%
gcf=figure(1);
set(gcf,'Color',[1 1 1]);
hold on
h(1)=perc_plot( 10*log10(MSE_FP'),L,1)
h(2)=perc_plot( 10*log10(MSE_det),L,7)
h(3)=perc_plot( 10*log10(MSE_mutual_inf),L,5)
h(4)=perc_plot( 10*log10(MSE_MSE'),L,3)
    h(5)=perc_plot( 10*log10(MSE_rnd'),L,2)
h(6)=perc_plot( 10*log10(MSE_cohe'),L,4)
hold off
hLegend=legend(h,'FrameSense','Determinant','Mutual Information','MSE','Random','Coherence')
axx=axis;
axis([L(1),L(end),20,120]);
legend('boxoff')

hTitle  = title ('Sensor placement for thermal maps with DCT');
hXLabel = xlabel('Number of Sensors'                     );
hYLabel = ylabel('MSE [dB]'                      );

set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
set([hLegend, gca]             , ...
    'FontSize'   , 14           );
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 14          );
set( hTitle                    , ...
    'FontSize'   , 16);
pbaspect([16,9, 14])
