%% Select Spring Type
% 1 = Proportional Spring
% 2 = Constant Force Spring
% 3 = Full revolution
springType = 3;

%% Generate DataSet
if (springType == 1)
    cd 'DataSet Generator'\
    cd 'Proportional Springs'\
elseif (springType == 2)
    cd 'DataSet Generator'\
    cd 'Costant Force Springs'\
elseif (springType == 3)
    cd 'DataSet Generator'\
    cd 'Full revolution'\
end

fprintf('Creating DataSet...\n');
Main;

%% Moving generated DataSet
fprintf('Moving Data Files...\n');
movefile('*.mat', '..\..\Data\')
fprintf('Data Files Moved\n');

cd ..
cd ..   % Back to main folder

%% Generate Graphs
fprintf('Generating Graphs...\n')
cd 'Graph Generator'\

% Complete range
clear all
load('..\Data\full-crank-principal-forces.mat')
residual_moment_infinity_loops
multiple_eq_thetas

% Residual Moment (enhanced range) & Eigenpoint
clear all
if (springType == 1)
    load('..\Data\around-zero-varying-forces-mag-ang.mat')
elseif (springType == 2)
    load('..\Data\around-zero-varying-forces-mag-ang-contant-force.mat')
end
residual_moment_var_ang_5
residual_moment_var_ang_10
residual_moment_var_mag_102
residual_moment_var_mag_108
residual_moment_var_mag_126
residual_moment_var_mag_132
residual_moment_var_mag_138
polar_plot_the_point

% Graph of path of stationary point
clear all
load('..\Data\path.mat')
stationary_trajectory

% Equilibrium thetas
clear all
if (springType == 1)
    load('..\Data\eq-thetas.mat')
elseif (springType == 2)
    load('..\Data\eq-thetas-contant-force.mat')
end
polar_plot_eq_theta_iso
polar_plot_eq_theta_top

% ADAMS Comparision
load('..\Data\adams-ang-126.mat')
adams_comparision_ang_126

fprintf('Graphs Generated\n');

%% Moving generated graphs
fprintf('Moving Graphs...\n');
if (springType == 1)
    movefile('*.eps', '..\Graphs\Proportional Spring\')
    movefile('*.png', '..\Graphs\Proportional Spring\')
elseif (springType == 2)
    movefile('*.eps', '..\Graphs\Constant Force Spring\')
    movefile('*.png', '..\Graphs\Constant Force Spring\')
end
fprintf('Graphs Moved\n');

cd ..   % Back to main folder