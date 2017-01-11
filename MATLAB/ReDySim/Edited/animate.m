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

figure('Name','Animation Window','NumberTitle','off');
for i=1:length(T)
    th=Y(i,1:n);
    dth=Y(i,n+1:2*n)';
    [so, ~, ~, ~, st, cent]=for_kine(th, dth, n, alp, a, b, bt, dx, dy, dz, angs);  
%     cent = zeros(3,1);
    B1X=[so(1,1), st(1,1)];
    B1Y=[so(2,1), st(2,1)];
%     B1Z=[so(3,1), st(3,1)];
    B2X=[so(1,2), st(1,2), st(1,1), cent(1), st(1,2)];
    B2Y=[so(2,2), st(2,2), st(2,1), cent(2), st(2,2)];
    B3X=[so(1,4), so(1,5), so(1,6), cent(1), so(1,5), so(1,6), st(1,6)];
    B3Y=[so(2,4), so(2,5), so(2,6), cent(2), so(2,5), so(2,6), st(2,6)];
    B4X=[so(1,7), so(1,8), so(1,9), cent(1), so(1,8), so(1,9), st(1,9)];
    B4Y=[so(2,7), so(2,8), so(2,9), cent(2), so(2,8), so(2,9), st(2,9)];
    
    t=T(i);
    t=num2str(t);
     plot(B1X,B1Y,B2X,B2Y,B3X,B3Y,B4X,B4Y,'linewidth',2);
    axis([ xmin xmax  ymin ymax]);
   set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','normal','fontsize',10);
    ylabel('Y (m)','fontweight','normal','fontsize',10);
    zlabel('Z (m)','fontweight','normal','fontsize',10);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    grid on;    
    drawnow;
end