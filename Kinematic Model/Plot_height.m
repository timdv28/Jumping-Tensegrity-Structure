% % Plot height
% mat = matfile('Simscape_values.mat');
% time1 = get(kin, 'tout');
% h1 = get(kin, 'height');
% 
% h2 = mat.height;
% avg = mat.avg;
% time2 = mat.time;
% 
% height1 = zeros(length(time1),1);
% for i = 1:500
%     height1(i,1) = getdatasamples(h1,i);
% end
% 
% t = -1.05:1/100:3.95;
% plot(h1)
% grid on
% hold on
% plot(t,h2)
% 
% 
% title('Jump height as a function of time')
% xlabel('Time') 
% ylabel('Height of the lowest joint') 
% xlim([0 1])
% ylim([-0.05 0.55])
% legend('Simulink','Simscape')
% set(gcf, 'Position',  [500, 200, 700, 350])
% hold off
%% Plot jump height for varying bar length

% scatter(sweep,H)
% grid on
% title('Jump height as a function of leg length')
% xlabel('Leg length [m]') 
% ylabel('Jump Height [m]') 
% set(gcf, 'Position',  [500, 200, 700, 350])

%% Plot jump height for varying joint stiffnesses

% scatter(sweep,H)
% grid on
% title('Jump height as a function of joint stiffness')
% xlabel('Joint Stifness [N/rad]') 
% ylabel('Jump Height [m]') 
% set(gcf, 'Position',  [500, 200, 700, 350])


%% Plot jump height for varying cable rest length deviation

scatter(sweep,H)
grid on
title('Jump height as a function of delta')
xlabel('Percentage of cable rest length deviation [delta]') 
ylabel('Jump height [m]') 
set(gcf, 'Position',  [500, 200, 700, 350])

%% Plot jump height for varying cable rest length deviation
% scatter(sweep,H)
% grid on
% title('Jump height as a function of cable stiffness')
% xlabel('Cable stiffness [k]') 
% ylabel('Jump height [m]') 
% set(gcf, 'Position',  [500, 200, 700, 350])

%% Plot jump height as a function of varying k_joint and k_cable
% scatter(sweep,H)
% grid on
% title('Jump height as a function of joint stiffness')
% xlabel('joint stiffness [N/rad]') 
% ylabel('Height of the lowest joint')
% set(gcf, 'Position',  [500, 200, 700, 350])

%% Plot jump height as a function of varying C_damping
% hold on
% scatter(sweep(1:3),H(1:3))
% scatter(sweep(4),H(4))
% scatter(sweep(5:10),H(5:10))
% %set(gca,'xscale','log')
% grid on
% title('Jump height as a function of cable damping coefficient')
% xlabel('Cable damping coefficient [c_s]') 
% ylabel('Jump height [m]')
% legend('Underdamped','Critically Damped','Overdamped')
% set(gcf, 'Position',  [500, 200, 700, 350])
% hold off


%% Plot jump height as a function of varying C_damping
% hold on
% scatter(sweep(1:3),H(1:3))
% scatter(sweep(4),H(4))
% scatter(sweep(5:9),H(5:9))
% %set(gca,'xscale','log')
% grid on
% title('Jump height as a function of joint damping coefficient')
% xlabel('Joint damping coefficient [c_t]') 
% ylabel('Jump height [m]')
% legend('Underdamped','Critically Damped','Overdamped')
% set(gcf, 'Position',  [500, 200, 700, 350])
% hold off

%% Multiple scatter plots of joint clearance (lowest joint)

% hold on
% scatter(sweep1,joint_clearance(:,1))
% scatter(sweep1,joint_clearance(:,2))
% scatter(sweep1,joint_clearance(:,3))
% grid on
% title('Joint clearance as a function of cable stiffnes and delta')
% xlabel('Cable stiffness [N/m]') 
% ylabel('Height of the lowest joint')
% xlim([800 4200])
% legend({'delta = 15%','delta = 20%','delta = 25%'},'Location','northeast')
% set(gcf, 'Position',  [500, 200, 700, 350])
% hold off

%% Multiple scatter plots of jump height

% hold on
% scatter(sweep1,H(:,1))
% scatter(sweep1,H(:,2))
% scatter(sweep1,H(:,3))
% grid on
% title('Jump height as a function of joint stiffness')
% xlabel('Cable stiffness [N/m]') 
% ylabel('Jump height [m]')
% xlim([800 4200])
% legend({'delta = 15%','delta = 20%','delta = 25%'},'Location','southeast')
% set(gcf, 'Position',  [500, 200, 700, 350])
% hold off

