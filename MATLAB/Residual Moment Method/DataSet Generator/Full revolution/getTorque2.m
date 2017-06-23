function [moment, M1, M2, currOEC, currC2FO4] = ...
    getTorque2(F_in, spring, currentPoints, prevPoints, prevOEC, prevC2FO4)
    %%
    findSlope = @(x) mod(atan2(x(:,2), x(:,1)),2*pi);
    findLength = @(i, j, points) norm(points(i,:)-points(j,:));
    %getAngleBetween = @(i,j,k,points) mod(findSlope(points(i,:)-points(j,:)) - findSlope(points(j,:)-points(k,:)), 2*pi);
    
    function [del] = getDeltaAngle(i,j,k, currPoints, prevPoints)
        curr = currPoints([i,j,k],:);
        prev = prevPoints([i,j,k],:);
        curr = curr-repmat(curr(2,:)-prev(2,:),3,1);
        
        t1 = normAngle(findSlope(curr(1,:)-curr(2,:)) - findSlope(prev(1,:)-prev(2,:)));
        t2 = normAngle(findSlope(curr(3,:)-curr(2,:)) - findSlope(prev(3,:)-prev(2,:)));
        del = t2 - t1;
    end
    %%
    delOEC = getDeltaAngle(10,7,14, currentPoints, prevPoints);
    delC2FO4 = getDeltaAngle(15,8,2, currentPoints, prevPoints);
    
    currOEC = delOEC + prevOEC;
    currC2FO4 = delC2FO4 + prevC2FO4;
    
    %[delOEC delC2FO4 prevOEC prevC2FO4 currOEC currC2FO4]
    M1 = - spring(1) * (currOEC); % moment on coupler
    M2 = - spring(2) * (currC2FO4); % moment on coupler
    
%     current_OEC1 = getAngleBetween(10,7,14,currentPoints);
%     base_OEC1 = getAngleBetween(10,7,14,basePoints);
%     
%     current_C2FO4 = getAngleBetween(15,8,2,currentPoints);
%     base_C2FO4 = getAngleBetween(15,8,2,basePoints);
%     
%     M1 = spring(1) * (current_OEC1 - base_OEC1); % moment on coupler normAngle
%     M2 = spring(2) * (current_C2FO4 - base_C2FO4); % moment on coupler
    
    %%
    angFO4 = findSlope(currentPoints(2,:)-currentPoints(8,:));
    magFO4_p = - M2 / findLength(2,8,currentPoints);

    angEO = findSlope(currentPoints(10,:)-currentPoints(7,:));
    magEO_p = - M1 / findLength(10,7,currentPoints);

    FO4_p = magFO4_p * 1i * exp(1i * angFO4);        
    EO_p = magEO_p * 1i * exp(1i * angEO);           

    %%
    magC1I_2_p = (M1 + magEO_p * findLength(7,12,currentPoints)) / findLength(14,12,currentPoints);
    angC1I_2 = findSlope(currentPoints(14,:)-currentPoints(12,:));

    magC2I_3_p = (M2 - magFO4_p * findLength(8,13,currentPoints)) / findLength(15,13,currentPoints);
    angC2I_3 = findSlope(currentPoints(15,:)-currentPoints(13,:));

    C1I_2_p = magC1I_2_p * 1i * exp(1i * angC1I_2);

    C2I_3_p = magC2I_3_p * 1i * exp(1i * angC2I_3);

    %%
    F_eff = F_in + EO_p; 

    %%
    angOE = findSlope(currentPoints(10,:)-currentPoints(7,:));
    angOG = findSlope(currentPoints(10,:)-currentPoints(9,:));

    [OE,OG] = vectorSolve1(F_eff, angOE,angOG);

    %%fO
    EI_2 = OE;

    angDI_2 = findSlope(currentPoints(6,:)-currentPoints(12,:));

    temp = EI_2 + C1I_2_p + EO_p;
    [C1I_2, ~] = vectorSolve1(temp, angC1I_2, angDI_2);

    %%
    GI_3 = OG;

    angFI_3 = findSlope(currentPoints(8,:)-currentPoints(13,:));

    temp = GI_3 + C2I_3_p + FO4_p;
    [C2I_3, ~] = vectorSolve1(temp, angC2I_3, angFI_3);

    %%
    mC1I_2 = cross([currentPoints(14,:)-currentPoints(11,:),0],[real(C1I_2 + C1I_2_p), imag(C1I_2 + C1I_2_p),0]);
    mC2I_3 = cross([currentPoints(15,:)-currentPoints(11,:),0],[real(C2I_3 + C2I_3_p), imag(C2I_3 + C2I_3_p),0]);
    
    moment = mC1I_2(3) + mC2I_3(3);
end