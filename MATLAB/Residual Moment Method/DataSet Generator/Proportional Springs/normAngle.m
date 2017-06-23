function [ang] = normAngle(ang)
    ang = double(vpa(ang));
    ang = mod(ang, 2*pi);
    if (ang > pi)
        ang = ang - 2*pi;
    end
end