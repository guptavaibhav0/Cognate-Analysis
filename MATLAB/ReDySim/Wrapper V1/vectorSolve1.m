function [B, C] = vectorSolve1(A,angB,angC)

    angB = normAngle(angB);
    angC = normAngle(angC);

    syms symB symC real
    B = symB * exp(1i * angB);
    C = symC * exp(1i * angC);

    [magB, magC] = solve(A+B+C==0,[symB,symC]);
    
    B = double(vpa(magB)) * exp(1i * angB);
    C = double(vpa(magC)) * exp(1i * angC);
end