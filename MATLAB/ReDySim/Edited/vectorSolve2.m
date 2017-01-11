function [B, C] = vectorSolve2(A,lenB,lenC, selector)

    syms symB symC real
    eqn1 = (real(A) + lenB*cos(symB) + lenC*cos(symC) == 0);
    eqn2 = (imag(A) + lenB*sin(symB) + lenC*sin(symC) == 0);
    
    [angB, angC] = solve([eqn1, eqn2],[symB,symC]);
    
    if (length(angB) > 1 && length(angC) > 1)
        if (selector >= 0)    
            B = lenB * exp(1i * double(vpa(angB(1))));
            C = lenC * exp(1i * double(vpa(angC(1))));
        else
            B = lenB * exp(1i * double(vpa(angB(2))));
            C = lenC * exp(1i * double(vpa(angC(2))));
        end
    elseif (length(angB) == 1 && length(angC) == 1)
        B = lenB * exp(1i * double(vpa(angB(1))));
        C = lenC * exp(1i * double(vpa(angC(1))));
    else
        error('No solution')
    end
end