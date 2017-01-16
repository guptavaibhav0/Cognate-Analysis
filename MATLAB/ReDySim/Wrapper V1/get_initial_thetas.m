function [] = get_initial_thetas()
    global cognateModel
    %points = [x, y]    { 1,  2 , 3, 4, 5,   6, 7, 8, 9, 10, 11, 12, 13, 14}
    %                   { O2, O4, A, B, C_1, D, E, F, G, O , I1, I2, I3, C_2}

    points(1) = 0;

    points(2) = cognateModel.l1;

    points(3) = cognateModel.l2 * exp(1i * cognateModel.theta2);

    AO4 = points(3) - points(2);
    [AB, ~] = vectorSolve2(AO4,...
        cognateModel.l3, cognateModel.l4, -1);

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
    [DE, ~] = vectorSolve1(CF,...
        angle(CF) - cognateModel.beta,...
        angle(CF) + cognateModel.alpha);

    points(9) = points(8) + DE;

    points(10) = points(7) + points(9) - points(5);
    
    [AC_1, ~] = vectorSolve1(-AB,...
        angle(AB) + cognateModel.alpha + cognateModel.d_alpha1,...
        angle(AB) - cognateModel.beta - cognateModel.d_beta1);

    points(5) = points(3) + AC_1;
    points(6)= AC_1;
    
    [AC_2, C_2B] = vectorSolve1(-AB,...
        angle(AB) + cognateModel.alpha + cognateModel.d_alpha2,...
        angle(AB) - cognateModel.beta - cognateModel.d_beta2);

    points(14) = points(3) + AC_2;
    points(8) = points(2) - C_2B;

%points = [x, y]    { 1,  2 , 3, 4, 5,   6, 7, 8, 9, 10, 11, 12, 13, 14}
%                   { O2, O4, A, B, C_1, D, E, F, G, O , I1, I2, I3, C_2}
    cognateModel.points = points;
    cognateModel.th = [...
        normAngle(angle(points(3)-points(1)));
        normAngle(angle(points(4)-points(2)));
        normAngle(angle(points(3)-points(4)) - normAngle(angle(points(4)-points(2))));
        normAngle(angle(points(6)-points(1)));
        normAngle(angle(points(7)-points(6)) - normAngle(angle(points(6)-points(1))));
        normAngle(angle(points(10)-points(7)) - normAngle(angle(points(7)-points(6))));
        normAngle(angle(points(8)-points(2)));
        normAngle(angle(points(9)-points(8)) - normAngle(angle(points(8)-points(2))));
        normAngle(angle(points(10)-points(9)) - normAngle(angle(points(9)-points(8))))];
end