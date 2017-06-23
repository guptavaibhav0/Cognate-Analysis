function pointsXY = getPoints_distorted2(cognateModel)

%points = [x, y]    { 1,  2 , 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
%                   { O2, O4, A, B, C, D, E, F, G, O , I1, I2, I3, c1, c2}

points(1) = 0;

points(2) = cognateModel.l1;

points(3) = cognateModel.l2 * exp(1i * cognateModel.theta2);

AO4 = points(3) - points(2);
[AB, BO4] = vectorSolve2(AO4,...
    cognateModel.l3, cognateModel.l4, +1);

points(4) = points(3) + AB;

[AC, CB] = vectorSolve1(-AB,...
    angle(AB) + cognateModel.alpha,...
    angle(AB) - cognateModel.beta);

points(5) = points(3) + AC;

points(6)= AC;

CD = points(6) - points(5);

[DE, ~] = vectorSolve1(CD,...
    angle(-CD) + cognateModel.alpha,...
    angle(-CD) - cognateModel.beta);

points(7) = points(6) + DE;

points(8) = points(2) - CB;

CF = points(8) - points(5);

[~, GF] = vectorSolve1(-CF,...
    angle(CF) + cognateModel.alpha,...
    angle(CF) - cognateModel.beta);

points(9) = points(8) - GF;

points(10) = points(7) + points(9) - points(5);

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

[OI_1, ~] = vectorSolve1(-points(2),...
    cognateModel.theta2,...
    angle(BO4));

points(11) = OI_1;

points(14) = points(5) + cognateModel.r * exp(1i * (cognateModel.gamma + angle(points(4)-points(3))));
points(15) = points(5) - cognateModel.r * exp(1i * (cognateModel.gamma + angle(points(4)-points(3))));

pointsXY = [real(points) ; imag(points)]'; 