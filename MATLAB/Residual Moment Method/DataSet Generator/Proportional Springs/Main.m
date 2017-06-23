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

fileName = 'around-zero-varying-forces-mag-ang.mat';	% .mat file where data will be saved   

angle_n = 150;      % (Number of data points - 1) for a particular force
angle_min = -pi/3;	% Minimum crank angle at which residual moment calculation is done 
angle_max = pi/2;	% Minimum crank angle at which residual moment calculation is done

Fmag_n = 51;    % (Number of data points + 1) for the magnitude of force application
Fmag_min = 0;   % Minimum force magnitude for which residual moment calculation is done
Fmag_max = 10;  % Maximum force magnitude for which residual moment calculation is done

Fang_n = 61;        % (Number of data points + 1) for the angle of force application
Fang_min = 0;       % Minimum angle of force for which residual moment calculation is done
Fang_max = 2 * pi;  % Maximum angle of force for which residual moment calculation is done

%% Main Code
% Actual Code for data generation
% *Do not change any parameters within*

range = angle_max - angle_min;

crankAngle = angle_min:range/angle_n:angle_max;
residualMoment = zeros(angle_n + 1, Fmag_n, Fang_n);
Fmag = linspace(Fmag_min, Fmag_max, Fmag_n);
Fang = 1 * exp(1i*linspace(Fang_min, Fang_max, Fang_n));

fprintf([repmat('.',1,Fang_n) '\n']);
parfor i = 1:Fang_n
    F_in = Fang(i) * Fmag;
    for j = 1:Fmag_n
        [~, tt] = TorquePlotter2(cognateModel, angle_n, F_in(j), angle_min, angle_max);
        residualMoment(:,j,i) = tt';
    end
    fprintf('|');
end
fprintf('\n');

fprintf('Data Set Generated\n');
fprintf('Saving Data Set...\n');
save(fileName,'crankAngle','residualMoment','Fmag','Fang');
fprintf('Data Set Saved\n');

%% Additional Operations
% Dataset interpretations

fprintf('Finding equilibrium thetas...');
moment2ang;
