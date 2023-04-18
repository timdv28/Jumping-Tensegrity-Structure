% Plot Simscape Multibody

% res = sim('tensegrity_structure_adapted_2');

time = get(out, 'tout');
h = get(out, 'h');
av = get(out,'avg');
t = 0:1/100:5;

avg = zeros(501,2);
height = zeros(501,1);
for i = 1:500
    height(i,1) = getdatasamples(h,i);
    avg(i,:) = getdatasamples(av,i);
end

plot(t,height)
grid on
title('Jump height as a function of time')
xlabel('Time') 
ylabel('Height of the lowest joint') 
ylim([-0.05 0.45])
set(gcf, 'Position',  [500, 300, 1000, 500])

%% Plot general position change

% av_ini = getdatasamples(av,1);
% 
% n_av = zeros(501,1);
% length(t)
% 
% for i = 1:500
%     n_av(i,1) = norm(getdatasamples(av,i)-av_ini);
% end
% 
% plot(t,n_av)
% grid on
% title('Horizontal displacement of the center of mass')
% xlabel('Time') 
% ylabel('Magnitude of horizontal displacement') 
% set(gcf, 'Position',  [500, 300, 1000, 500])

save('Simscape_values','time','height','avg')