%%
epsFile = 'adams_comparision_ang_126.eps';
tiffFile = 'adams_comparision_ang_126.png';
xLabel = 'Magnitude of applied force at $126^{\circ}$ angle (in N)';
yLabel = 'Equilibrium crank angle ($\theta_{2,eq}$) (in deg)';
Title = {'Comparision between residual moment method and ADAMS simulation'};
Legend = {'Residual Moment Method','ADAMS simulation'};
Axis = [0 10 0 3];
xTicks = 0:1:10;
yTicks = 0:0.5:3;

width = 150;
height = 100;
fontSize = 22;

x1 = Fmag;
y1 = zeroTheta(:,22)*180/pi;

x2 = adams_F_mag;
y2 = adams_zeroTheta*180/pi;

%%
figure('Units','centimeters',...
    'Position',[0 0 width height],...
    'PaperPositionMode','auto');

plot(x1, y1,...
    'LineWidth',1.5);

hold on;
plot(x2, y2,...
    'LineWidth',1.5);

axis(Axis);

set(gca,...
    'Units','normalized',...
    'YTick',yTicks,...
    'XTick',xTicks,...
    'Position',[.15 .2 .75 .7],...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',fontSize,...
    'FontName','Times',...
    'XColor','k',...
    'YColor','k',...
    'ZColor','k')

xlabel(xLabel,...
    'FontUnits','points',...
    'interpreter','latex',...
    'FontSize',fontSize,...
    'FontName','Times');

ylabel(yLabel,...
    'FontUnits','points',...
    'interpreter','latex',...
    'FontSize',fontSize,...
    'FontName','Times');

title(Title,...
    'FontUnits','points',...
    'interpreter','latex',...
    'FontWeight','normal',...
    'FontSize',fontSize,...
    'FontName','Times')

legend(Legend,...
    'Location', 'SouthEast')
    

%%
print( gcf, '-depsc2', epsFile );
print( gcf, '-dpng', tiffFile );
close(gcf);