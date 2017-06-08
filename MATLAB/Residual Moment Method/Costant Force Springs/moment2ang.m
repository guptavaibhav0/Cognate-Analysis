% load('around-zero-varying-forces-mag-ang.mat');

s = size(torque);
s2 = s(2);
s3 = s(3);
zeroTheta = zeros(s2,s3);
prevz = zeros(1,s3);
fprintf([repmat('.',1,s3) '\n\n'])
for i = 1:s2%angle
%     prevz = 0;
    for j = 1:s3%mag
        pp = csape(th, torque(:,i,j));
        z = fnzeros(pp);
        if isempty(z)   %no zero crossing solution exists in range
            zeroTheta(i,j) = 0;
        else
            t = z(1,:) - prevz(j);
            [~,k] = min(abs(t));
            prevz(j) = 0;%z(1,k);
            zeroTheta(i,j) = z(1,k);
        end
    end
    fprintf('\b|\n')
end

% save('eq-thetas-0.2.mat','th','torque','F_mag','F_ang', 'zeroTheta');