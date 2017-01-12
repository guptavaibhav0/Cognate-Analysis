% ReDySim animate module. This module animates the system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
function [] = animate()
disp('------------------------------------------------------------------');
disp('Animating the simulation data');

load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;

[n, ~, ~, alp, a, b, bt, dx, dy, dz, ~, ~,  ~, ~, ~, ~, ~, ~, ~, al, angs]=inputs();
len_sum=sum(al)*.2;
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;

animationFig = figure('Name','Animation Window','NumberTitle','off', 'MenuBar', 'none');
animationAxes = axes('Parent',animationFig);
axis(animationAxes,[xmin xmax  ymin ymax]);
set(animationAxes,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,...
    'Box', 'off', 'TickDir','out' );
xlabel(animationAxes,'X (m)','fontweight','normal','fontsize',10);
ylabel(animationAxes,'Y (m)','fontweight','normal','fontsize',10);
grid(animationAxes, 'on')
for i=1:length(T)
    if (isgraphics(animationAxes,'axes'))
        [graphicHandles] = getFigure(i, Y, T, n, alp, a, b, bt, dx, dy, dz, angs, animationAxes, ymax);
        if (i<length(T))
            pause(0.01)
            delete(graphicHandles)
        end
    end
end
end

function [graphicHandles] = getFigure(i, Y, T, n, alp, a, b, bt, dx, dy, dz, angs, animationAxes, ymax)
    th=Y(i,1:n);
    dth=Y(i,n+1:2*n)';
    [so, ~, ~, ~, st, cent]=for_kine(th, dth, n, alp, a, b, bt, dx, dy, dz, angs);  
    B1X=[so(1,1), st(1,1)];
    B1Y=[so(2,1), st(2,1)];

    B2X=[so(1,2), st(1,2), st(1,1), cent(1), st(1,2)];
    B2Y=[so(2,2), st(2,2), st(2,1), cent(2), st(2,2)];
    
    B3X=[so(1,4), so(1,5), so(1,6), cent(1), so(1,5), so(1,6), st(1,6)];
    B3Y=[so(2,4), so(2,5), so(2,6), cent(2), so(2,5), so(2,6), st(2,6)];
    
    B4X=[so(1,7), so(1,8), so(1,9), cent(1), so(1,8), so(1,9), st(1,9)];
    B4Y=[so(2,7), so(2,8), so(2,9), cent(2), so(2,8), so(2,9), st(2,9)];
    
    tree(1) = line(B1X, B1Y, 'Parent', animationAxes, 'Color', [0,0,0]);
    tree(2) = line(B2X, B2Y, 'Parent', animationAxes, 'Color', [1,0,0]);
    tree(3) = line(B3X, B3Y, 'Parent', animationAxes, 'Color', [0,1,0]);
    tree(4) = line(B4X, B4Y, 'Parent', animationAxes, 'Color', [0,0,1]);
    points = viscircles(animationAxes, [B1X, B2X, B3X, B4X; B1Y, B2Y, B3Y, B4Y]', ymax * 0.01 * ones(21,1),...
        'EdgeColor', [0,0,0]);
    timeDisplay = text(0,ymax,['Elapsed Time = ' num2str(T(i), '%5.2f') 's'],...
        'FontSize', 12, 'HorizontalAlignment', 'center', 'Parent', animationAxes,...
        'fontname','times new romans');
    graphicHandles  = [tree, timeDisplay, points];
end