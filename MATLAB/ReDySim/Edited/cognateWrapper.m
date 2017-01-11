function [] = cognateWrapper( theta2 )
    clc;
    global cognateModel
    cognateModel.l1 = 3;
    cognateModel.l2 = 2;
    cognateModel.l3 = 2;
    cognateModel.l4 = 4;
    cognateModel.alpha = pi/2;
    cognateModel.beta = pi/3;
    cognateModel.theta2 = theta2;
    
    get_initial_thetas();
    cognateModel.dth=[0; 0;  0;    0;  0;  0;  0;  0;  0];
    cognateModel.act_en=0;

    runfor;
    %Plots the joint motion
    plot_motion;
    %Plots the joint accelerations and joint torques
    plot_acc_tor;
    %Energy Calculation
    energy;
    %Plots Energy Balance
    plot_en;
    % Animation
    animate
end

