function points = getPoints_distorted3_current(cognateModel, base, prev)

%points = [x, y]    { 1,  2 , 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
%                   { O2, O4, A, B, C, D, E, F, G, O , I1, I2, I3, c1, c2}

points(1) = 0;

points(2) = cognateModel.l1;

points(3) = cognateModel.l2 * exp(1i * cognateModel.theta2);

AO4 = points(3) - points(2);
[AB, BO4] = vectorSolve2(AO4,...
    cognateModel.l3, cognateModel.l4, '+');

points(4) = points(3) + AB;

[AC, CB] = vectorSolve1(-AB,...
    angle(AB) + cognateModel.alpha,...
    angle(AB) - cognateModel.beta);

points(5) = points(3) + AC;

points(14) = points(5) + cognateModel.r * exp(1i * (cognateModel.gamma1 + angle(points(4)-points(3))));
points(15) = points(5) - cognateModel.r * exp(1i * (cognateModel.gamma2 + angle(points(4)-points(3))));

O2C1 = points(14) - points(1);
[~, DO2] = vectorSolve2(O2C1,...
    abs(base(6) - base(14)),...
    abs(base(1) - base(6)),...
    '0');

temp = -DO2;
if (abs(temp(1) - prev(6)) < abs(temp(2) - prev(6)))
    points(6) = temp(1);
else
    points(6) = temp(2);
end

magDE = abs(base(7) - base(6));
angDE = angle(base(7) - base(6)) - angle(base(14) - base(6)) + angle(points(14) - points(6));
DE = magDE * exp(1i * angDE);

points(7) = points(6) + DE;

O4C2 = points(15) - points(2);
[~, FO4] = vectorSolve2(O4C2,...
    abs(base(8) - base(15)),...
    abs(base(2) - base(8)),...
    '0');

temp = points(2) - FO4;
if (abs(temp(1) - prev(8)) < abs(temp(2) - prev(8)))
    points(8) = temp(1);
else
    points(8) = temp(2);
end

magFG = abs(base(9) - base(8));
angFG = angle(base(9) - base(8)) - angle(base(8) - base(15)) + angle(points(8) - points(15));
FG = magFG * exp(1i * angFG);

points(9) = points(8) + FG;

GE = points(7) - points(9);
[EO, ~] = vectorSolve2(GE,...
    abs(base(10) - base(7)),...
    abs(base(9) - base(10)),...
    '0');

temp = points(7) + EO;
if (abs(temp(1) - prev(10)) < abs(temp(2) - prev(10)))
    points(10) = temp(1);
else
    points(10) = temp(2);
end

EO = points(10) - points(7);
[O2I_2, ~] = vectorSolve1(-points(10),...
    angle(points(6)),...
    angle(EO));

points(12) = O2I_2;

GO = points(10) - points(9);
O4F = -CB;
OO4 = points(2) - points(10);
[O4I_3, ~] = vectorSolve1(OO4,...
    angle(O4F),...
    angle(GO));

points(13) = points(2) + O4I_3;

[O2I_1, ~] = vectorSolve1(-points(2),...
    cognateModel.theta2,...
    angle(BO4));

points(11) = O2I_1;

