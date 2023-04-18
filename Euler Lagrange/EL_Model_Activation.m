close all; clear all;
clc;

%% Loading the predefined initial conditions from the Form Finding algorithm
%  The form finding has to be done for every new set of parameters
mat = matfile('Initials.mat');
% Node positions
N = transpose(mat.N);
% Joint positions
J = transpose(mat.J);

% Leg connectivity matrix: 6x12 matrix
C_l = [-1 0 0 0 0 0 1 0 0 0 0 0;
       0 -1 0 0 0 0 0 1 0 0 0 0;
       0 0 -1 0 0 0 0 0 1 0 0 0;
       0 0 0 -1 0 0 0 0 0 1 0 0;
       0 0 0 0 -1 0 0 0 0 0 1 0;
       0 0 0 0 0 -1 0 0 0 0 0 1];

% String connectivity matrix: 24x12 matrix
C_s = [-1 1 0 0 0 0 0 0 0 0 0 0;
       -1 0 1 0 0 0 0 0 0 0 0 0;
       -1 0 0 1 0 0 0 0 0 0 0 0;
       -1 0 0 0 0 0 0 0 1 0 0 0;
       0 -1 1 0 0 0 0 0 0 0 0 0;
       0 -1 0 0 1 0 0 0 0 0 0 0;
       0 -1 0 0 0 0 1 0 0 0 0 0;
       0 0 -1 0 0 1 0 0 0 0 0 0;
       0 0 -1 0 0 0 0 1 0 0 0 0;
       0 0 0 -1 0 0 1 0 0 0 0 0;
       0 0 0 -1 0 0 0 0 1 0 0 0;
       0 0 0 -1 0 0 0 0 0 0 1 0;
       0 0 0 0 -1 0 1 0 0 0 0 0;
       0 0 0 0 -1 0 0 1 0 0 0 0;
       0 0 0 0 -1 0 0 0 0 0 0 1;
       0 0 0 0 0 -1 0 1 0 0 0 0;
       0 0 0 0 0 -1 0 0 1 0 0 0;
       0 0 0 0 0 -1 0 0 0 1 0 0;
       0 0 0 0 0 0 -1 0 0 0 1 0;
       0 0 0 0 0 0 0 -1 0 0 0 1;
       0 0 0 0 0 0 0 0 -1 1 0 0;
       0 0 0 0 0 0 0 0 0 -1 1 0;
       0 0 0 0 0 0 0 0 0 -1 0 1;
       0 0 0 0 0 0 0 0 0 0 -1 1;];
% Combining to make one big connectivity matrix
C_inc = zeros(30,12);
C_inc(1:6,:) = C_l;
C_inc(7:30,:) = C_s;

% Point masses assigned to bars
L_pm = eye(12);

% Definition of bars strings and point masses respectively
B = N*transpose(C_l);
S = N*transpose(C_s);
P = N*L_pm;

% Vector for selection of bars, strings and point masses
theta = eye(6);
eta = eye(24);
phi = eye(12);

Xk = zeros(3,36,6);
Xbark = zeros(3,36,6);
Yk = zeros(3,36,24);

X = zeros(36,36,6);
XB = zeros(36,36,6);
Y = zeros(36,36,24);

Pk = zeros(3,36,12);

for k = 1:24
    Yk(:,:,k) = kron(eta(k,:)*C_s,eye(3));
    Y(:,:,k) = Yk(:,:,k)'*Yk(:,:,k);
    if ~mod(k,2) == 1
        Pk(:,:,k/2) = kron(phi(k/2,:)*L_pm,eye(3));
        if ~mod(k,4) == 1
            Xk(:,:,k/4) = kron(theta(k/4,:)*C_l,eye(3));
            Xbark(:,:,k/4) = 1/2 * kron(theta(k/4,:)*abs(C_l),eye(3));
            X(:,:,k/4) = Xk(:,:,k/4)'*Xk(:,:,k/4);
            XB(:,:,k/4) = Xbark(:,:,k/4)'*Xbark(:,:,k/4);
        end
    end
end

q = [N(:,1);N(:,2);N(:,3);N(:,4);N(:,5);N(:,6);N(:,7);N(:,8);N(:,9);N(:,10);N(:,11);N(:,12)];


%% Set tensegrity parameters
k_cable = 1200; % N/m
k_joint = 35; % N/rad
l_leg = 0.30; % m
L = l_leg/2; % m
radius = 0.005; % m
a_joint = 160/180*pi; % rad
density = 1900; % kg/m^3
delta = 0.24; % deviation percentage
l_cable = sqrt(6)/4*l_leg*sin(a_joint/2)*(1 - delta); % m, with 10%  rest length deviation
m_motor = 0.6; % kg
m_battery = 0.018; % kg
m_leg = density*(l_leg*pi*radius^2)+ m_motor + m_battery; % kg/m^3
% lambda = m_leg/l_leg; % mass per unit length of the bar: M/L
% m_bar = m_leg/2; % kg
total_mass = m_leg*6; % kg

%% New parameters: The values are still just trials and not representative for a real life situation
C_damping = 150;
T_damping = 10;
mu_k = 0.4;
mu_s = 0.45;
nu_s = 0.25;

g = [0;0;-9.81];
G = zeros(3,36);
% Vg_ini = zeros(6,1);
for i = 1:6
    G = G + m_leg*Xbark(:,:,i);
%     Vg_ini = -g'*G(:,:,i)*q;
end
Gt = g'*G;
Vg_ini = -Gt*q;



%% Moment of inertia from the end of a bar section
% Ix_bar = (m_bar*radius^2)/4 + (m_bar*L^2)/3;

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
res = sim('EL_Model_Simulink');
