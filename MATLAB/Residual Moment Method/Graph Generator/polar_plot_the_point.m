%%
epsFile = 'polar-plot-the-point.eps';
Title = 'Polar Plot of the Eigenpoint';

width = 150;
height = 100;
fontSize = 22;

%%
figure('Units','centimeters',...
    'Position',[0 0 width height],...
    'PaperPositionMode','auto');

%% Plotting
s = size(residualMoment);
s3 = s(3);
the_Point = zeros(1, s3);
the_Point_moment = zeros(1, s3);
i = 1;
p = csape(crankAngle, residualMoment(:,1,i));
for i = 1:s3
    pp = csape(crankAngle(31:121),...
        residualMoment(31:121,1,i) - residualMoment(31:121,50,i));
    z = fnzeros(pp);
    if isempty(z)
        the_Point(i) = NaN;
        the_Point_moment(i) = NaN;
    else
        the_Point(i) = z(1);
        the_Point_moment(i) = fnval(p,z(1));
    end
end
the_Point_moment = the_Point_moment / norm(the_Point_moment) * ...
    max(the_Point) * 180 / pi;

polarplot(mod(angle(Fang), 2*pi), the_Point * 180 / pi, 'b');

%%

thetaTicks = 0:45:315;
rLim =[-20 60];
rTicks = -30:10:60;

set(gca,...
    'Units','normalized',...
    'ThetaTick',thetaTicks,...
    'RTick',rTicks,...
    'RLim',rLim,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',fontSize,...
    'FontName','Times',...
    'ThetaColor','k',...
    'RColor','k')

title(Title,...
    'FontUnits','points',...
    'interpreter','latex',...
    'FontWeight','normal',...
    'FontSize',fontSize,...
    'FontName','Times')

%%
print( gcf, '-depsc2', epsFile );
close(gcf);