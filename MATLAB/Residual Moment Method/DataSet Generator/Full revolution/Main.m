%% Model Parameters
% Cognate parameters and variable initializers for the code

scale = 10;                             % crank length in mm

cognateModel.spring = [1, 1] * 15.763;  % Spring constant in N-mm/rad
cognateModel.l1 = 4 * scale;            % Scaled Base Length
cognateModel.l2 = 1 * scale;            % Scaled Crank Length
cognateModel.l3 = 4 * scale;            % Scaled Coupler Length
cognateModel.l4 = 3 * scale;            % Scaled Driven Link Length
cognateModel.alpha = pi/3;              % Coupler Angle $\alpha$ in radians
cognateModel.beta = pi/3;               % Coupler Angle $\beta$ in radians

cognateModel.r = 0.1;                   % Distortion Radius
cognateModel.gamma1 = 0;                % Distortion Angle $\gamma_1$
cognateModel.gamma2 = 0;                % Distortion Angle $\gamma_2$

cognateModel.theta2 = 0;                % Starting Crank Angle

%% Variable for Data Generation
% Variables for the dataset to be generated

fileName = 'full-crank-principal-forces.mat';	% .mat file where data will be saved   

angle_n = 720;      % (Number of data points - 1) for a particular force
angle_min = -pi;	% Minimum crank angle at which residual moment calculation is done 
angle_max = pi;     % Minimum crank angle at which residual moment calculation is done

%% Main Code
% Actual Code for data generation
% *Do not change any parameters within*
F_n = 2;
range = angle_max - angle_min;

crankAngle = angle_min:range/angle_n:angle_max;
residualMoment = zeros(angle_n + 1, F_n);
F = 10 * [
    1;
    exp(1i * pi/2)];

fprintf([repmat('.',1,F_n) '\n']);
parfor i = 1:F_n
    [~, tt] = TorquePlotter2(cognateModel, angle_n, F(i), angle_min, angle_max);
    residualMoment(:,i) = tt';
    fprintf('|');
end
fprintf('\n');

fprintf('Data Set Generated\n');
fprintf('Saving Data Set...\n');
save(fileName,'crankAngle','residualMoment','F');
fprintf('Data Set Saved\n');