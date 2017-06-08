% load('eq-thetas.mat');
n = size(zeroTheta);
[x,y,z] = cylinder(1,n(2)-1);
figure(1);
clf
hold on
colormap 'jet'
prevxx = 0*x(1,:);
prevyy = 0*y(1,:);
prevzz = repmat(zeroTheta(1,:),2,1);
zz = z;
zz(1,:) = min(min(zeroTheta))*180/pi();
for i = 1:n(1)
    zz(2,:) = zeroTheta(i,:);
    xx = F_mag(i)*x;
    yy = F_mag(i)*y;
    X = [prevxx(1,1:end-1);prevxx(1,2:end);xx(1,2:end);xx(1,1:end-1)];
    Y = [prevyy(1,1:end-1);prevyy(1,2:end);yy(1,2:end);yy(1,1:end-1)];
    Z = [prevzz(2,1:end-1);prevzz(2,2:end);zz(2,2:end);zz(2,1:end-1)]*180/pi();
    if all(Z(:)~=0) %soln exists for all angles
        fill3(X,Y,Z,Z/60+0.5,'EdgeAlpha',0.5,'FaceColor','interp');
    else 
        [row,col] = find(Z==0);
        for k = 1:n(2)-1
            if all(col~=k)
                fill3(X(:,k),Y(:,k),Z(:,k),Z(:,k)/60+0.5,'EdgeAlpha',0.5,'FaceColor','interp');
            end
        end
    end
    prevxx = xx;
    prevyy = yy;
    prevzz = zz;
end
view(3)
line([0 11],[0 0],[zz(1,1) zz(1,1)]);
line([0 0],[0 11],[zz(1,1) zz(1,1)]);
title('Equilibrium angle vs Force');
hold off