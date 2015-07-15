function h=ellipse(a,b,x0,y0,style)
% (x0,y0) - center
% (a,b) - ellipse axes

for i=1:length(a)
    
    t = linspace(0,2*pi);
    x = x0(i) + a(i)*cos(t);
    y = y0(i) + b(i)*sin(t);
    h=patch(x,y,style)
    set(h,'edgecolor','none')
end

    
    