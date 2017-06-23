%% Variables
fileName = 'eq-thetas-constant-force.mat'; % .mat file where data will be saved

%% Main Method
% *Do not change*
s = size(residualMoment);
s2 = s(2);
s3 = s(3);
zeroTheta = zeros(s2, s3);
prevz = zeros(1, s3);

fprintf([repmat('.',1,s2) '\n\n'])
for i = 1:s2    % Loop over magnitude of force
    for j = 1:s3    % Loop over angle of force application
        pp = csape(crankAngle, residualMoment(:, i, j));
        z = fnzeros(pp);
        if isempty(z)   % No zero crossing solution exists in range
            zeroTheta(i,j) = 0;
        else
            t = z(1,:) - prevz(j);
            [~,k] = min(abs(t));
            prevz(j) = 0;   % Change to z(1,k) for another heurestic
            zeroTheta(i,j) = z(1,k);
        end
    end
    fprintf('\b|\n')
end

fprintf('Saving equilibrium thetas...');
save(fileName,'crankAngle','residualMoment','Fmag','Fang', 'zeroTheta');
fprintf('Equilibrium thetas saved');