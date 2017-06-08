% load('around-zero-varying-forces-mag-ang-0.1-corrected.mat');
s = size(torque);
s3 = s(3);
the_Point = zeros(1,s3);
the_Point_moment = zeros(1,s3);
i = 1;
p = csape(th,torque(:,1,i));
for i = 1:s3
    pp = csape(th(31:121),torque(31:121,1,i)-torque(31:121,50,i));
    z = fnzeros(pp);
    if isempty(z)
        the_Point(i) = NaN;
%         the_Point_moment(i) = NaN;
%     elseif z(1)<0
%         the_Point(i) = NaN;
%         the_Point_moment(i) = NaN;
    else
        the_Point(i) = z(1);
        the_Point_moment(i) = fnval(p,z(1));
    end
end
the_Point_moment = the_Point_moment/norm(the_Point_moment)*max(the_Point)*180/pi;
% plot(mod(angle(F_ang),2*pi)*180/pi,the_Point*180/pi);
polar(mod(angle(F_ang),2*pi),the_Point*180/pi,'r');
hold on
polar(mod(angle(F_ang),2*pi),the_Point_moment,'b');
