% close all; clear all;
% clc;

%% Set tensegrity parameters
k_cable = 1200; % N/m
k_joint = 35; % N/rad

l_leg = 0.3; % m
radius = 0.005; % m
a_joint = 160/180*pi; % rad
density = 1900; % kg/m^3
delta = 0.15; % deviation percentage
l_cable = sqrt(6)/4*l_leg*sin(a_joint/2)*(1 - delta); % m, with 10%  rest length deviation
m_motor = 0.6; % kg
m_battery = 0.018; % kg
m_leg = density*(l_leg*pi*radius^2) + m_motor + m_battery; % kg/m^3
m_bar = m_leg/2; % kg
total_mass = m_leg*6; % kg
g = [0;0;-9.81];

F = 50;
F_motor = F;
F_511 = 0;
F_410 = 0;
F_39 = 0;
F_28 = 0;

%% Loading the predefined initial conditions from the Form Finding algorithm
% mat = matfile('Initials.mat');
% % Node positions
% N = transpose(mat.N);
% % Joint positions
% J = transpose(mat.J);

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

L = length(res.x1.data(:,1));
N = transpose([res.x1.data(L,1) res.x1.data(L,2) res.x1.data(L,3);
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
    res.x12.data(L,1) res.x12.data(L,2) res.x12.data(L,3)]);
J = [res.joint1.data(L,:) ;res.joint2.data(L,:) ;res.joint3.data(L,:) ;res.joint4.data(L,:) ;res.joint5.data(L,:) ;res.joint6.data(L,:)];
save('Initials.mat','N','J');



%% New parameters: The values are still just trials and not representative for a real life situation
C_damping = 10;
T_damping = 1;
mu_k = 0.35;
mu_s = 0.45;
nu_s = 0.2;

%% Initial conditions of velocity
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
kin = sim('Kinematic_Model_Simulink.slx');


