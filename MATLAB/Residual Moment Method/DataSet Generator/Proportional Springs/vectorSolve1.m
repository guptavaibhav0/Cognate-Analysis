% function [B, C] = vectorSolve1(A,angB,angC)
% 
%     angB = normAngle(angB);
%     angC = normAngle(angC);
% 
%     syms symB symC real
%     B = symB * exp(1i * angB);
%     C = symC * exp(1i * angC);
% 
%     [magB, magC] = solve(A+B+C==0,[symB,symC]);
%     
%     B = double(vpa(magB)) * exp(1i * angB);
%     C = double(vpa(magC)) * exp(1i * angC);
% end
function [B, C] = vectorSolve1(A,angB,angC)

    angB_m = mod(angB - angle(-A), 2*pi);
    angC_m = mod(-angC + angle(-A), 2*pi);
    
    temp = pi - angB_m - angC_m;
    
    magB = (abs(A) / sin(temp)) * sin(angC_m);
    magC = (abs(A) / sin(temp)) * sin(angB_m);
    
    B = double((magB)) * exp(1i * angB);
    C = double((magC)) * exp(1i * angC);
end