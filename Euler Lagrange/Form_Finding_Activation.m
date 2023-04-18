close all; clear all;
clc;

k_cable = 1200; % N/m
k_joint = 35; % N/rad
l_bar = 0.30; % m
a_joint = 160/180*pi;
density = 1900; % kg/m^3
delta = 0.24;
l_cable = sqrt(6)/4*l_bar*sin(a_joint/2)*(1 - delta); % m, with 10%  rest length deviation


m_motor = 0.6;
m_battery = 0.018;
m_bar = density*(l_bar*pi*0.005^2)+ m_motor + m_battery; % kg/m^3
total_mass = m_bar*6;
g = [0;0;0];

F = 0;
F_motor = F;
F_511 = 0;
F_410 = 0;
F_39 = 0;
F_28 = 0;


a_start = (160-F/2)/180*pi;
sep = l_bar/2;
bent_bar = l_bar*sin(a_start/2)/2;
cbl = sqrt(6)/4*l_bar;
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


% Constants
% a_start1 = 160/180*pi;
% a_start2 = 90/180*pi;
% sep = 0.5*l_bar;
% bent_bar1 = l_bar*sin(a_start1/2)/2;
% bent_bar2 = l_bar*sin(a_start2/2)/2;
% cbl = l_cable;
% theta1 = atan(2*bent_bar2/sep)*180/pi;
% 
% 
% d6x = sqrt((sep/2)^2 + bent_bar1^2);
% 
% % Initials
% x1_ini = [0 0 0];
% x7_ini = 2*bent_bar2*rotVec([1 0 0],[0 1 0],-theta1) + x1_ini;
% 
% x6_ini = [0 -sep 0];
% x12_ini = 2*bent_bar2*rotVec([1 0 0],[0 1 0],-theta1) + x6_ini;
% 
% x3_ini = [d6x   -sep/2         0] ;
% x9_ini = 2*bent_bar1*rotVec([1 0 0],[0 1 0],-90-theta1) + x3_ini;
% 
% x5_ini = sep/2*rotVec([1 0 0],[0 1 0],-theta1) + x3_ini;
% x11_ini = 2*bent_bar1*rotVec([1 0 0],[0 1 0],-90-theta1) + x5_ini;
% 
% x2_ini = bent_bar2*rotVec([1 0 0],[0 1 0],-theta1)+ 0.5*sep/2*rotVec([1 0 0],[0 1 0],90-theta1) + [0 sep/2 0];
% x8_ini = x2_ini + [0 -2*bent_bar1 0];
% 
% x4_ini = bent_bar2*rotVec([1 0 0],[0 1 0],-theta1) + 0.5*sep/2*rotVec([1 0 0],[0 1 0],-90-theta1) + [0 sep/2 0];
% x10_ini = x4_ini+[0 -2*bent_bar1 0];
% 
% % norm(x4_ini-x10_ini)



res = sim('Form_Finding_Simulink');


% j1 = get(res, 'joint1');
% x1 = get(res, 'x1');
% len = length(tscollection(j1));
% x_1 = getdatasamples(x1,len);
% joint1 = getdatasamples(j1,len);
% norm(x_1-joint1)
% Plotting the tensegrity structure

figure(1);
set(figure(1),'Position',[200,100,800,500]);
p = plot3(1,1,1,'o');
norm_plot1 = zeros(length(res.x1.data),1);
xs=[];ys=[];zs=[];
view(20, -10)

for i = 1:100:length(res.x1.data)
    axis(l_bar*[-0.5 1 -1 0.5 -0.01 1.5]);
%     axis equal

    hold on;
    x_plot =  [res.x1.data(i,1),res.x2.data(i,1), res.x3.data(i,1), res.x4.data(i,1) , res.x5.data(i,1), res.x6.data(i,1), res.x7.data(i,1), res.x8.data(i,1), res.x9.data(i,1), res.x10.data(i,1), res.x11.data(i,1), res.x12.data(i,1)];
    y_plot =  [res.x1.data(i,2),res.x2.data(i,2), res.x3.data(i,2), res.x4.data(i,2) , res.x5.data(i,2), res.x6.data(i,2), res.x7.data(i,2), res.x8.data(i,2), res.x9.data(i,2), res.x10.data(i,2), res.x11.data(i,2), res.x12.data(i,2)];
    z_plot =  [res.x1.data(i,3),res.x2.data(i,3), res.x3.data(i,3), res.x4.data(i,3) , res.x5.data(i,3), res.x6.data(i,3), res.x7.data(i,3), res.x8.data(i,3), res.x9.data(i,3), res.x10.data(i,3), res.x11.data(i,3), res.x12.data(i,3)];
    set (p, 'XData', x_plot, 'YData', y_plot,'ZData', z_plot );
    xs=[xs;x_plot];ys=[ys;y_plot];zs=[zs;z_plot];
    
    norm_plot1(i) = norm([res.joint1.data(i,1) res.joint1.data(i,2) res.joint1.data(i,3)]);

    bar_17_1 = line([res.x1.data(i,1) res.joint1.data(i,1)],[res.x1.data(i,2) res.joint1.data(i,2)],[res.x1.data(i,3) res.joint1.data(i,3)],'linestyle','-','color','b','LineWidth',3);
    bar_17_2 = line([res.x7.data(i,1) res.joint1.data(i,1)],[res.x7.data(i,2) res.joint1.data(i,2)],[res.x7.data(i,3) res.joint1.data(i,3)],'linestyle','-','color','b','LineWidth',3);
    bar_28_1 = line([res.x2.data(i,1) res.joint2.data(i,1)],[res.x2.data(i,2) res.joint2.data(i,2)],[res.x2.data(i,3) res.joint2.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_28_2 = line([res.x8.data(i,1) res.joint2.data(i,1)],[res.x8.data(i,2) res.joint2.data(i,2)],[res.x8.data(i,3) res.joint2.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_39_1 = line([res.x3.data(i,1) res.joint3.data(i,1)],[res.x3.data(i,2) res.joint3.data(i,2)],[res.x3.data(i,3) res.joint3.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_39_2 = line([res.joint3.data(i,1) res.x9.data(i,1)],[res.joint3.data(i,2) res.x9.data(i,2)],[res.joint3.data(i,3) res.x9.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_410_1 = line([res.x4.data(i,1) res.joint4.data(i,1)],[res.x4.data(i,2) res.joint4.data(i,2)],[res.x4.data(i,3) res.joint4.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_410_2 = line([res.joint4.data(i,1) res.x10.data(i,1)],[res.joint4.data(i,2) res.x10.data(i,2)],[res.joint4.data(i,3) res.x10.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_511_1 = line([res.x5.data(i,1) res.joint5.data(i,1)],[res.x5.data(i,2) res.joint5.data(i,2)],[res.x5.data(i,3) res.joint5.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_511_2 = line([res.joint5.data(i,1) res.x11.data(i,1)],[res.joint5.data(i,2) res.x11.data(i,2)],[res.joint5.data(i,3) res.x11.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_612_1 = line([res.x6.data(i,1) res.joint6.data(i,1)],[res.x6.data(i,2) res.joint6.data(i,2)],[res.x6.data(i,3) res.joint6.data(i,3)],'linestyle','-','color','b','LineWidth',3);
    bar_612_2 = line([res.joint6.data(i,1) res.x12.data(i,1)],[res.joint6.data(i,2) res.x12.data(i,2)],[res.joint6.data(i,3) res.x12.data(i,3)],'linestyle','-','color','b','LineWidth',3);
    
    str_12 = line([res.x1.data(i,1) res.x2.data(i,1)],[res.x1.data(i,2) res.x2.data(i,2)],[res.x1.data(i,3) res.x2.data(i,3)]);
    str_13 = line([res.x1.data(i,1) res.x3.data(i,1)],[res.x1.data(i,2) res.x3.data(i,2)],[res.x1.data(i,3) res.x3.data(i,3)]);
    str_14 = line([res.x1.data(i,1) res.x4.data(i,1)],[res.x1.data(i,2) res.x4.data(i,2)],[res.x1.data(i,3) res.x4.data(i,3)]);
    str_19 = line([res.x1.data(i,1) res.x9.data(i,1)],[res.x1.data(i,2) res.x9.data(i,2)],[res.x1.data(i,3) res.x9.data(i,3)]);
    
    str_23 = line([res.x2.data(i,1) res.x3.data(i,1)],[res.x2.data(i,2) res.x3.data(i,2)],[res.x2.data(i,3) res.x3.data(i,3)]);
    str_25 = line([res.x2.data(i,1) res.x5.data(i,1)],[res.x2.data(i,2) res.x5.data(i,2)],[res.x2.data(i,3) res.x5.data(i,3)]);
    str_27 = line([res.x2.data(i,1) res.x7.data(i,1)],[res.x2.data(i,2) res.x7.data(i,2)],[res.x2.data(i,3) res.x7.data(i,3)]);
    
    str_36 = line([res.x3.data(i,1) res.x6.data(i,1)],[res.x3.data(i,2) res.x6.data(i,2)],[res.x3.data(i,3) res.x6.data(i,3)]);
    str_38 = line([res.x3.data(i,1) res.x8.data(i,1)],[res.x3.data(i,2) res.x8.data(i,2)],[res.x3.data(i,3) res.x8.data(i,3)]);
    
    str_47 = line([res.x4.data(i,1) res.x7.data(i,1)],[res.x4.data(i,2) res.x7.data(i,2)],[res.x4.data(i,3) res.x7.data(i,3)]);
    str_49 = line([res.x4.data(i,1) res.x9.data(i,1)],[res.x4.data(i,2) res.x9.data(i,2)],[res.x4.data(i,3) res.x9.data(i,3)]);
    str_411 = line([res.x4.data(i,1) res.x11.data(i,1)],[res.x4.data(i,2) res.x11.data(i,2)],[res.x4.data(i,3) res.x11.data(i,3)]);
    
    str_57 = line([res.x5.data(i,1) res.x7.data(i,1)],[res.x5.data(i,2) res.x7.data(i,2)],[res.x5.data(i,3) res.x7.data(i,3)]);
    str_58 = line([res.x5.data(i,1) res.x8.data(i,1)],[res.x5.data(i,2) res.x8.data(i,2)],[res.x5.data(i,3) res.x8.data(i,3)]);
    str_512 = line([res.x5.data(i,1) res.x12.data(i,1)],[res.x5.data(i,2) res.x12.data(i,2)],[res.x5.data(i,3) res.x12.data(i,3)]);
    
    str_68 = line([res.x6.data(i,1) res.x8.data(i,1)],[res.x6.data(i,2) res.x8.data(i,2)],[res.x6.data(i,3) res.x8.data(i,3)]);
    str_69 = line([res.x6.data(i,1) res.x9.data(i,1)],[res.x6.data(i,2) res.x9.data(i,2)],[res.x6.data(i,3) res.x9.data(i,3)]);
    str_610 = line([res.x6.data(i,1) res.x10.data(i,1)],[res.x6.data(i,2) res.x10.data(i,2)],[res.x6.data(i,3) res.x10.data(i,3)]);
    
    str_711 = line([res.x7.data(i,1) res.x11.data(i,1)],[res.x7.data(i,2) res.x11.data(i,2)],[res.x7.data(i,3) res.x11.data(i,3)]);
    
    str_812 = line([res.x8.data(i,1) res.x12.data(i,1)],[res.x8.data(i,2) res.x12.data(i,2)],[res.x8.data(i,3) res.x12.data(i,3)]);
    
    str_910 = line([res.x9.data(i,1) res.x10.data(i,1)],[res.x9.data(i,2) res.x10.data(i,2)],[res.x9.data(i,3) res.x10.data(i,3)]);
    
    str_1011 = line([res.x10.data(i,1) res.x11.data(i,1)],[res.x10.data(i,2) res.x11.data(i,2)],[res.x10.data(i,3) res.x11.data(i,3)]);
    str_1012 = line([res.x10.data(i,1) res.x12.data(i,1)],[res.x10.data(i,2) res.x12.data(i,2)],[res.x10.data(i,3) res.x12.data(i,3)]);
    
    str_1112 = line([res.x11.data(i,1) res.x12.data(i,1)],[res.x11.data(i,2) res.x12.data(i,2)],[res.x11.data(i,3) res.x12.data(i,3)]);
       
    drawnow;
    
    delete(bar_17_1);delete(bar_17_2);delete(bar_28_1);delete(bar_28_2);delete(bar_39_1);delete(bar_39_2);delete(bar_410_1);delete(bar_410_2);delete(bar_511_1);delete(bar_511_2);delete(bar_612_1);delete(bar_612_2);
    
    delete(str_12);delete(str_13);delete(str_14);delete(str_19);delete(str_23);delete(str_25);
    delete(str_27);delete(str_36);delete(str_38);delete(str_47);delete(str_49);delete(str_411);
    delete(str_57);delete(str_58);delete(str_512);delete(str_68);delete(str_69);delete(str_610);
    delete(str_711);delete(str_812);delete(str_910);delete(str_1011);delete(str_1012);delete(str_1112);
    
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    hold off;
end

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