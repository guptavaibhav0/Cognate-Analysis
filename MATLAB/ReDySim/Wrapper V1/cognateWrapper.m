function [] = cognateWrapper(theta2, varargin)
    p = inputParser;
    
    defaults.l1 = 3;
    defaults.l2 = 1;
    defaults.l3 = 2;
    defaults.l4 = 3;
    defaults.alpha = pi/2;
    defaults.beta = pi/3;
    defaults.displayGraphics = true;
    
    addRequired(p,'theta2',@isnumeric);
    addOptional(p,'l1',defaults.l1,@isnumeric);
    addOptional(p,'l2',defaults.l2,@isnumeric);
    addOptional(p,'l3',defaults.l3,@isnumeric);
    addOptional(p,'l4',defaults.l4,@isnumeric);
    addOptional(p,'alpha',defaults.alpha,@isnumeric);
    addOptional(p,'beta',defaults.beta,@isnumeric);
    
    addParameter(p,'displayGraphics',defaults.displayGraphics,...
                 @islogical);
    
    
    parse(p,theta2,varargin{:});

    clc;
    global cognateModel
    cognateModel.l1 = p.Results.l1;
    cognateModel.l2 = p.Results.l2;
    cognateModel.l3 = p.Results.l3;
    cognateModel.l4 = p.Results.l4;
    cognateModel.alpha = p.Results.alpha;
    cognateModel.beta = p.Results.beta;
    cognateModel.theta2 = p.Results.theta2;
    
    get_initial_thetas();
    cognateModel.dth=[0; 0;  0;    0;  0;  0;  0;  0;  0];
    cognateModel.act_en=0;

    runfor;
    
    if (p.Results.displayGraphics)
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
end

