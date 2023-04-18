close all; clear all;
clc;
%% Set tensegrity parameters
g = [0;0;-9.81];

%% New parameters: The values are still just trials and not representative for a real life situation
C_damping = 10;
T_damping = 1;
mu_k = 0.35;
mu_s = 0.45;
nu_s = 0.2;

% Applied force on contracting legs
F = 50;
F_motor = F;
F_511 = 0;
F_410 = 0;
F_39 = 0;
F_28 = 0;


sweep1 = 1000:200:4000;
sweep2 = [0.15 0.20 0.25];

H = zeros(length(sweep1),length(sweep2));
D = zeros(length(sweep1),length(sweep2));
joint_clearance = zeros(length(sweep1),length(sweep2));

i = 0;

for k_cable = sweep1
    i = i + 1;
    j = 0;
    for delta = sweep2
        j = j + 1;
        %     k_cable = 45.82*k_joint + 395.7; % N/m
        %     k_cable = 1200;
        k_joint = 35; % N/rad

        l_leg = 0.30; % m
        %     l_bar = l_leg/2; % m
        radius = 0.005; % m
        a_joint = 160/180*pi; % rad
        density = 1900; % kg/m^3
        % delta = 0.20; % deviation percentage
        l_cable = sqrt(6)/4*l_leg*sin(a_joint/2)*(1 - delta); % m, with 10%  rest length deviation
        m_motor = 0.6; % kg
        m_battery = 0.018; % kg
        m_leg = density*(l_leg*pi*radius^2)+ m_motor + m_battery; % kg/m^3
        m_bar = m_leg/2; % kg
        total_mass = m_leg*6; % kg

        % Initial conditions form finding
        a_start = (160-F/2)/180*pi;
        sep = l_leg/2;
        bent_bar = l_leg*sin(a_start/2)/2;
        cbl = sqrt(6)/4*l_leg;
        theta = atan(2*bent_bar/sep)*180/pi;

        d6x = sqrt((sep/2)^2 + bent_bar^2);

        % Initials
        x1_ini = [0 0 0];
        x7_ini = 2*bent_bar*rotVec([1 0 0],[0 1 0],-theta) + x1_ini;

        x6_ini = [0 -sep 0];
        x12_ini = 2*bent_bar*rotVec([1 0 0],[0 1 0],-theta) + x6_ini;

        x3_ini = [d6x   -sep/2         0] ;
        x9_ini = 2*bent_bar*rotVec([1 0 0],[0 1 0],-90-theta) + x3_ini;

        x5_ini = sep*rotVec([1 0 0],[0 1 0],-theta) + x3_ini;
        x11_ini = 2*bent_bar*rotVec([1 0 0],[0 1 0],-90-theta) + x5_ini;

        x2_ini = bent_bar*rotVec([1 0 0],[0 1 0],-theta)+ 0.5*sep*rotVec([1 0 0],[0 1 0],90-theta) + [0 sep/2 0];
        x8_ini = x2_ini + [0 -2*bent_bar 0];

        x4_ini = bent_bar*rotVec([1 0 0],[0 1 0],-theta) + 0.5*sep*rotVec([1 0 0],[0 1 0],-90-theta) + [0 sep/2 0];
        x10_ini = x4_ini+[0 -2*bent_bar 0];


        res = sim('Form_Finding_Simulink');
        clearance = get(res, 'd1');
        t_end = length(tscollection(clearance));
        joint_clearance(i,j) = getdatasamples(clearance,t_end);


        L_data = length(res.x1.data(:,1));
        N = transpose([res.x1.data(L_data,1) res.x1.data(L_data,2) res.x1.data(L_data,3);
            res.x2.data(L_data,1) res.x2.data(L_data,2) res.x2.data(L_data,3);
            res.x3.data(L_data,1) res.x3.data(L_data,2) res.x3.data(L_data,3);
            res.x4.data(L_data,1) res.x4.data(L_data,2) res.x4.data(L_data,3);
            res.x5.data(L_data,1) res.x5.data(L_data,2) res.x5.data(L_data,3);
            res.x6.data(L_data,1) res.x6.data(L_data,2) res.x6.data(L_data,3);
            res.x7.data(L_data,1) res.x7.data(L_data,2) res.x7.data(L_data,3);
            res.x8.data(L_data,1) res.x8.data(L_data,2) res.x8.data(L_data,3);
            res.x9.data(L_data,1) res.x9.data(L_data,2) res.x9.data(L_data,3);
            res.x10.data(L_data,1) res.x10.data(L_data,2) res.x10.data(L_data,3);
            res.x11.data(L_data,1) res.x11.data(L_data,2) res.x11.data(L_data,3);
            res.x12.data(L_data,1) res.x12.data(L_data,2) res.x12.data(L_data,3)]);
        J = [res.joint1.data(L_data,:) ;res.joint2.data(L_data,:) ;res.joint3.data(L_data,:) ;res.joint4.data(L_data,:) ;res.joint5.data(L_data,:) ;res.joint6.data(L_data,:)];


        %% Initial conditions of position and velocity
        x1_ini = N(1:3,1); v1_ini = [0 0 0];
        x2_ini = N(1:3,2); v2_ini = [0 0 0];
        x3_ini = N(1:3,3); v3_ini = [0 0 0];
        x4_ini = N(1:3,4); v4_ini = [0 0 0];
        x5_ini = N(1:3,5); v5_ini = [0 0 0];
        x6_ini = N(1:3,6); v6_ini = [0 0 0];
        x7_ini = N(1:3,7); v7_ini = [0 0 0];
        x8_ini = N(1:3,8); v8_ini = [0 0 0];
        x9_ini = N(1:3,9); v9_ini = [0 0 0];
        x10_ini = N(1:3,10); v10_ini = [0 0 0];
        x11_ini = N(1:3,11); v11_ini = [0 0 0];
        x12_ini = N(1:3,12); v12_ini = [0 0 0];

        %% Simulation and plotting
        kin = sim('Kinematic_Model_Simulink');

        height = get(kin, 'height');
        h_max = get(kin,'h_max');
        distance = get(kin, 'distance');

        len = length(tscollection(height));

        H(i,j) = getdatasamples(h_max,len);
        D(i,j) = getdatasamples(distance,len);
    end
end

