%%
scale = 10; % crank length in mm

cognateModel.spring = [1, 1] * 15.763;
cognateModel.l1 = 4 * scale;
cognateModel.l2 = 1 * scale;
cognateModel.l3 = 4 * scale;
cognateModel.l4 = 3 * scale;
cognateModel.alpha = pi/3;
cognateModel.beta = pi/3;

cognateModel.r = 0.1;
cognateModel.gamma1 = 0;
cognateModel.gamma2 = 0;

cognateModel.theta2 = 0;

%%
n = 150;
fn = 61;%61;
fmagn = 51;%51; 

min = -pi/3;
max = pi/2;
range = max - min;

th = min:range/n:max;
torque = zeros(n,fmagn, fn);
F_mag = linspace(0,10,fmagn);
F_ang = 1 * exp(1i*linspace(0,2*pi,fn));

fprintf([repmat('.',1,fn) '\n']);

for i = 1:fn
    F_in = F_ang(i) * F_mag;
    for j = 1:fmagn
        [~, tt] = TorquePlotter2(cognateModel, n, F_in(j), min, max);
        torque(:,j,i) = tt';
    end
    fprintf('|');
end
fprintf('\n');

save('around-zero-varying-forces-mag-ang.mat','th','torque','F_mag','F_ang');
