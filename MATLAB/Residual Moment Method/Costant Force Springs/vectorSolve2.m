function [B, C] = vectorSolve2(A,lenB,lenC, selector)
    if (strcmp(selector, '0'))
        lenA = abs(A);
        angleA = angle(A);
        xB = (lenB ^ 2 - lenC ^ 2 + lenA ^ 2) / (2 * lenA);
        if (abs(xB) <= lenB)
            yB = [sqrt(lenB ^ 2 - xB ^ 2); -sqrt(lenB ^ 2 - xB ^ 2)];
            tempB = xB + yB * 1i;
            B = -(tempB * exp(1i * angleA));
            C = - A - B;
        end
    else
        if (strcmp(selector, '+'))
            sel = +1;
        else
            sel = -1;
        end
        syms symB symC real
        eqn1 = (real(A) + lenB*cos(symB) + lenC*cos(symC) == 0);
        eqn2 = (imag(A) + lenB*sin(symB) + lenC*sin(symC) == 0);    
%         B = lenB * exp(1i * symB);
%         C = lenC * exp(1i * symC);

        [angB, angC] = solve(eqn1, eqn2,symB,symC);
%         [angB, angC] = solve(A + B + C == 0,symB,symC);

        temp = normAngle(vpa(angB(1)));
        if (sign(sel) == sign(temp))
            B = lenB * exp(1i * double(temp));
            C = lenC * exp(1i * double(vpa(angB(1))));
        else
            B = lenB * exp(1i * double(vpa(angB(2))));
            C = lenC * exp(1i * double(vpa(angC(2))));
        end
    end
end