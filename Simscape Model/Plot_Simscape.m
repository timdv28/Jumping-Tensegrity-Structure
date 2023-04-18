time = get(res, 'tout');
h = get(res, 'h');

plot(h)
grid on
title('Jump height as a function of time (Simscape)')
xlabel('Time') 
ylabel('Height of the lowest joint') 
ylim([-0.05 0.45])
xlim([0 15])
set(gcf, 'Position',  [500, 500, 1000, 500])

% Plot general position change

% av = get(res, 'avg');
% AVG = getdatasamples(av,:);
% av_ini = getdatasamples(av,1);
 
% n_av = zeros(length(time),1);
% for i = 1:length(time)
%     n_av(i,1) = norm(getdatasamples(av,i)-av_ini);
% end
% 
% plot(time,n_av)
% grid on
% title('Jump height as a function of time')
% xlabel('Time') 
% ylabel('Height of the lowest joint') 
% xlim([0 5])
% set(gcf, 'Position',  [500, 500, 1000, 500])