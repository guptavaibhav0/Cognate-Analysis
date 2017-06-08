function [th, torque] = TorquePlotter2(cognateModel, n, F_in, min, max)
range = max - min;
spring = cognateModel.spring;

base = getPoints_distorted3_base(cognateModel);
prevOEC = 0;
prevC2FO4 = 0;

th = (-range/n):(-range/n):min;
tt = zeros(1, length(th));
prev = base;
for i = 1:length(th)    
    c = cognateModel;
    c.theta2 = th(i);
    curr = getPoints_distorted3_current(c, base, prev);
    
    currentPoints = [real(curr) ; imag(curr)]';
    prevPoints = [real(prev) ; imag(prev)]';
    [t, ~, ~, prevOEC, prevC2FO4] = ...
        getTorque2(F_in, spring, currentPoints, prevPoints, prevOEC, prevC2FO4);
    tt(length(th)+1-i) = t;
    prev = curr;
end

th = 0:range/n:max;
tt2 = zeros(1, length(th));
prevOEC = 0;
prevC2FO4 = 0;
prev = base;
for i = 1:length(th)
    c = cognateModel;
    c.theta2 = th(i);
    curr = getPoints_distorted3_current(c, base, prev);
    
    currentPoints = [real(curr) ; imag(curr)]';
    prevPoints = [real(prev) ; imag(prev)]';
    [t, ~, ~, prevOEC, prevC2FO4] = ...
        getTorque2(F_in, spring, currentPoints, prevPoints, prevOEC, prevC2FO4);
    tt2(i) = t;
    prev = curr;
end

torque = [tt tt2];
end