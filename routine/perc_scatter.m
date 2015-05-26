function [ h1,h2] = perc_scatter( data_x,data_y,i)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

linestyles = cellstr(char('-',':','-.','--','-',':','-.','--','-',':','-',':',...
    '-.','--','-',':','-.','--','-',':','-.'));

Markers=['o','x','+','*','s','d','v','^','<','>','p','h','h',...
    '+','*','o','x','^','<','h','.','>','p','s','d','v',...
    'o','x','+','*','s','d','v','^','<','>','p','h','.'];


cc = [
    0.00  0.00  1.00
    0.00  0.50  0.00
    1.00  0.00  0.00
    0.00  0.75  0.75
    0.75  0.00  0.75
    0.75  0.75  0.00
    0.25  0.25  0.25
    0.75  0.25  0.25
    0.95  0.95  0.00
    0.25  0.25  0.75
    0.75  0.75  0.75
    0.00  1.00  0.00
    0.76  0.57  0.17
    0.54  0.63  0.22
    0.34  0.57  0.92
    1.00  0.10  0.60
    0.88  0.75  0.73
    0.10  0.49  0.47
    0.66  0.34  0.65
    0.99  0.41  0.23
    ];

    hold on
    
    h2=ellipse(std(data_x),std(data_y),mean(data_x),mean(data_y),min(1.3*cc(i,:),1));
    h1=scatter(mean(data_x),mean(data_y),120,0.8*cc(i,:),Markers(i),'MarkerFaceColor',0.8*cc(i,:),'LineWidth',1.5');
    set(h1,'markeredgecolor',0.8*cc(i,:))
    
    hold off

end

