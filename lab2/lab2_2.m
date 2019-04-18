clear;clc;close all

% Main folder has to include:
% plotsettings.m
% csvcommadecimal.m

% ------ Shared graph settings -------
labelSettings = {...
    'Interpreter','latex',...
    'Fontsize', 17};
% ------------------------------------

% Custom function for loading 'weird' CSV files
data2 = csvcommadecimal('Data2.csv');

t_2 = str2double(table2array(data2(2:end,2)));
y_2s = str2double(table2array(data2(2:end,3)));
y_2m = str2double(table2array(data2(2:end,9)));

% Repair data set
% In our experiment we had abnormal spikes, hence removal of 
% values y > 1.4
for i=1:length(t_2)
    if isnan(y_2s(i)) || y_2s(i) > 1.4
        t_2(i) = NaN;
        y_2s(i) = NaN;
        y_2m(i) = NaN;
    end
end
t_2 = rmmissing(t_2);
y_2s = rmmissing(y_2s);
y_2m = rmmissing(y_2m);

% Normalise 
y_2s = y_2s - mean(y_2s(8000:end)); % Specified where it looks like normal
y_2m = y_2m - mean(y_2m(8000:9000));

% Testing normalisation
% visualmeananalysis(y_2m,100)

% Finding angular velocity for max amplitude through finding peaks
[mx, pos] = max(y_2s);
[s_pks, s_loc] = findpeaks(y_2s(pos-100:pos+100));
w_2s_max = 2*pi * numel(s_pks)/ (t_2(s_loc(end)) - t_2(s_loc(1)));

% Finding angular velocity for motor through finding peaks
% from 0 to end
steps = 300;
for j = 1:(floor(numel(y_2m)/steps)-1)
    m_i(j) = (j)*steps;
    top_i(j) = max(y_2s(m_i(j)-steps/2:m_i(j)+steps/2));
    [mm_pks, mm_loc] = findpeaks(y_2m(m_i(j)-steps/2:m_i(j)+steps/2));
    w_2m(j) = 2*pi * numel(mm_pks)/ (t_2(mm_loc(end)) - t_2(mm_loc(1)));
end

% Plotting resonance
figure(4)
set(gcf, 'Position',  [100, 100, 800, 350])
plot(w_2m./w_2s_max,top_i,'ro')
hold on;
ax = axis;
plot([1  1],[0 0.5],'k-')
plotsettings('plot');
axis(ax)
xlabel('$\omega \cdot \omega_0^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('A (m)',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:.2:3)
yticks(0:.1:1)
saveas(gcf,'fig2_1','epsc')


% Just a basic overview of some

clock = 20; % 20 values per second

figure(6)
time = [20 55];
set(gcf, 'Position',  [100, 100, 800, 400])
hold on
i = (time(1)*clock:time(2)*clock);
plot(t_2(i),y_2s(i),'b','LineWidth',2)
plot(t_2(i),-y_2m(i),'r','LineWidth',2)
plotsettings('plot');
xlabel('t (s)',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('x (m)',labelSettings(1:2:end), labelSettings(2:2:end))
axis([time(1) time(2) 1.5*[min(y_2m(i)) max(y_2m(i))]])
xticks(20:10:60)
yticks(-0.1:.05:0.1)
leg = legend('Objekt','Motor');
set(leg, 'Interpreter','latex','Fontsize', 18)
saveas(gcf,'fig2_3','epsc')

figure(7)
time = [319 335];
set(gcf, 'Position',  [100, 100, 800, 400])
hold on
i = (time(1)*clock:time(2)*clock);
plot(t_2(i),y_2s(i),'b','LineWidth',2)
plot(t_2(i),-y_2m(i),'r','LineWidth',2)
plotsettings('plot');
xlabel('t (s)',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('x (m)',labelSettings(1:2:end), labelSettings(2:2:end))
axis([time(1)+1 time(2) 1.5*[min(y_2s(i)) max(y_2s(i))]])
xticks(320:5:360)
leg = legend('Objekt','Motor');
set(leg, 'Interpreter','latex','Fontsize', 18)
saveas(gcf,'fig2_4','epsc')

figure(8)
time = [460 475];
set(gcf, 'Position',  [100, 100, 800, 400])
hold on
i = (time(1)*clock:time(2)*clock);
plot(t_2(i),y_2s(i),'b','LineWidth',2)
plot(t_2(i),-y_2m(i),'r','LineWidth',2)
plotsettings('plot');
xlabel('t (s)',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('x (m)',labelSettings(1:2:end), labelSettings(2:2:end))
axis([time(1)+1 time(2) 1.5*[min(y_2m(i)) max(y_2m(i))]])
xticks(460:3:480)
yticks(-0.1:0.05:0.1)
leg = legend('Objekt','Motor');
set(leg, 'Interpreter','latex','Fontsize', 18)
saveas(gcf,'fig2_5','epsc')

%% Not used: 
% Finding angle between 2 curves
[m_pks, m_loc] = findpeaks(y_2m(pos-100:pos+100));
w_2m = 2*pi * numel(m_pks)/ (t_2(m_loc(end)) - t_2(m_loc(1)));
i = -100:5:100;
index = pos+i;
deg_s = mod((t_2(index) - t_2(s_loc(1)))*w_2s_max*180/pi,360);
deg_m = mod((t_2(index) - t_2(m_loc(1)))*w_2m*180/pi,360);

% Difference between two angles
for i=1:length(deg_s)
    alpha(i) = deg_s(i) - deg_m(i);
    if deg_s(i) < deg_m(i)
        alpha(i) = alpha(i) + 360;
    end
end