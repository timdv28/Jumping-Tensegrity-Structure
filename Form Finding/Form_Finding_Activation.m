close all; clear all;
clc;

%% Input parameters that are varied in the analysis
k_cable = 1200; % N/m
k_joint = 35; % N/rad
l_leg = 0.30; % m
delta = 0.24; % percentage

%% Other parameters
a_joint = 160/180*pi; % rad
l_cable = sqrt(6)/4*l_leg*sin(a_joint/2)*(1 - delta); % m

%% Mass and gravity properties
density = 1900; % kg/m^3
m_motor = 0.6;
m_battery = 0.018;
m_bar = density*(l_leg*pi*0.005^2)+ m_motor + m_battery; % kg/m^3
total_mass = m_bar*6;
g = [0;0;-9.81];

% Actuation torque
F = 0;
F_motor = F;


%% Initial conditions that are sufficiently close to the final configuration
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

%% Activate Simulink file
res = sim('Form_Finding_Simulink');

% Save the final positions of the nodes as the initial conditions for a
% kinematic model
L = length(res.x1.data(:,1));
N = [res.x1.data(L,1) res.x1.data(L,2) res.x1.data(L,3);
    res.x2.data(L,1) res.x2.data(L,2) res.x2.data(L,3);
    res.x3.data(L,1) res.x3.data(L,2) res.x3.data(L,3);
    res.x4.data(L,1) res.x4.data(L,2) res.x4.data(L,3);
    res.x5.data(L,1) res.x5.data(L,2) res.x5.data(L,3);
    res.x6.data(L,1) res.x6.data(L,2) res.x6.data(L,3);
    res.x7.data(L,1) res.x7.data(L,2) res.x7.data(L,3);
    res.x8.data(L,1) res.x8.data(L,2) res.x8.data(L,3);
    res.x9.data(L,1) res.x9.data(L,2) res.x9.data(L,3);
    res.x10.data(L,1) res.x10.data(L,2) res.x10.data(L,3);
    res.x11.data(L,1) res.x11.data(L,2) res.x11.data(L,3);
    res.x12.data(L,1) res.x12.data(L,2) res.x12.data(L,3)];
J = [res.joint1.data(L,:) ;res.joint2.data(L,:) ;res.joint3.data(L,:) ;res.joint4.data(L,:) ;res.joint5.data(L,:) ;res.joint6.data(L,:)];
save('Initials.mat','N','J');