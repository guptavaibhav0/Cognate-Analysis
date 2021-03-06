%%
epsFile = 'polar-plot-eq-theta-top.eps';
xLabel = {'Component of Applied Force' , 'in X-direction (in N)'};
yLabel = {'Component of Applied Force' , 'in Y-direction (in N)'};
zLabel = 'Equilibrium $\theta_2$ (in deg)';
Title = 'Equilibrium position of crank under varying applied forces';
Axis = [-10 10 -10 10];
xTicks = -10:2:10;
yTicks = -10:2:10;
zTicks = -35:5:30;

width = 150;
height = 100;
fontSize = 22;

%%
figure('Units','centimeters',...
    'Position',[0 0 width height],...
    'PaperPositionMode','auto');

%% Polar Plotter
n = size(zeroTheta);
[x,y,z] = cylinder(1,n(2)-1);
hold on
colormap 'jet'
prevxx = 0 * x(1,:);
prevyy = 0 * y(1,:);
prevzz = repmat(zeroTheta(1,:),2,1);
zz = z;
zz(1,:) = min(min(zeroTheta)) * 180/pi();
for i = 1:n(1)
    zz(2,:) = zeroTheta(i,:);
    xx = Fmag(i) * x;
    yy = Fmag(i) * y;
    X = [prevxx(1,1:end-1);
        prevxx(1,2:end);
        xx(1,2:end);
        xx(1,1:end-1)];

    Y = [prevyy(1,1:end-1);
        prevyy(1,2:end);
        yy(1,2:end);
        yy(1,1:end-1)];
    
    Z = [prevzz(2,1:end-1);
        prevzz(2,2:end);
        zz(2,2:end);
        zz(2,1:end-1)] * 180 / pi;
    
    if all(Z(:) ~= 0) % Solution exists for all angles
        fill3(X,Y,Z,Z,'EdgeAlpha',0.5,'FaceColor','interp');
    else 
        [row,col] = find(Z==0);
        for k = 1:n(2)-1
            if all(col~=k)
                fill3(X(:,k),Y(:,k),Z(:,k),Z(:,k),...
                    'EdgeAlpha',0.5,...
                    'FaceColor','interp');
            end
        end
    end
    prevxx = xx;
    prevyy = yy;
    prevzz = zz;
end
line([0 11],[0 0],[zz(1,1) zz(1,1)]);
line([0 0],[0 11],[zz(1,1) zz(1,1)]);

%%

axis equal;
axis(Axis);

view(2);

set(gca,...
    'Units','normalized',...
    'XTick',xTicks,...
    'YTick',yTicks,...
    'ZTick',zTicks,...
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

zlabel(zLabel,...
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

c = colorbar('TickLabelInterpreter','latex',...
    'FontSize',fontSize,...
    'FontName','Times');
c.Label.Interpreter = 'latex';
c.Label.String = zLabel;

%%
print( gcf, '-depsc2', epsFile );
close(gcf);