clear;clc;close all
% ------ Shared graph settings -------
gcaSettings = {...
    'XGrid','on',...
    'YGrid', 'on',...
    'Fontsize', 13,...
    'linewidth', 1,...
    'FontName', 'Arial'};

labelSettings = {...
    'Interpreter','latex',...
    'Fontsize', 17};

lineSpec = {'b','r','g','k','k--','k-.'};
% -------------------------------------

%% Part 1

% Custom function for loading 'weird' CSV files
data1 = readcsvwithcomma('Data1.csv');

t_1 = str2double(table2array(data1(2:end,2)));
y_1 = str2double(table2array(data1(2:end,3)));
v_1 = str2double(table2array(data1(2:end,4)));

% Use for labels
col = table2array(data1(1,:));

% Repair data set
% In our experiment we had abnormal spikes, hence removal of 
% values y < 0.56 and abs(v) > 2
for i=1:length(t_1)
    if isnan(y_1(i)) || isnan(v_1(i)) || y_1(i) < 0.56 || abs(v_1(i)) > 2
        t_1(i) = NaN;
        y_1(i) = NaN;
        v_1(i) = NaN;
    end
end
t_1 = rmmissing(t_1);
y_1 = rmmissing(y_1);
v_1 = rmmissing(v_1);

% Normalise 
y_1 = y_1 - mean(y_1(500:end));

% Finding angular velocity through finding peaks
i_1 = 500;  % first index of searching
[pks, loc] = findpeaks(y_1(i_1:end));
w_1 = 2*pi * numel(pks)/ (t_1(i_1 + loc(end)) - t_1(i_1 + loc(1)));
% w_1 = 3.867;  % Counted manually =O

figure(1)
plot(t_1,y_1,'LineWidth',2)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t/s$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
axis([0 30 -0.3 0.3])
saveas(gcf,'fig1_1','epsc')

% Finding velocity
dy = diff(y_1);
dt = diff(t_1);
v = dy./dt; % FIX THIS!

figure(2)
plot(y_1(2:end),v)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$v/ms^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))
axis(1.1*[min(y_1) max(y_1) min(v) max(v)])
xticks(-1:.1:1)
yticks(-1:.5:1)
saveas(gcf,'fig1_2','epsc')

% Energy
K = v.^2;
U = (3.867.*y_1).^2;
E = K + U(2:end);

figure(3)
hold on
plot(t_1(2:end),K,'r-')
plot(t_1,U,'b-')
plot(t_1(2:end),E,lineSpec{4})
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t/s$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$v^{2}$ $/m^{2}s^{-2}$',labelSettings(1:2:end), labelSettings(2:2:end))
axis([0 15 0 1.5])

% Finding half life
% figure(31)
% findpeaks(E(10:400), 'MinPeakDistance',10)
% axis([0 300 0 max(E)])
[E_pk, E_loc] = findpeaks(E(10:400), 'MinPeakDistance',10);
% plot(E_loc, E_pk)
pk_select = 10;
t_half = log(E_pk(1)/E_pk(pk_select))/(t_1(E_loc(pk_select)+1)-t_1(E_loc(1)+1));
Halveringstid = "Figur 3: " + 1/t_half + " s"

chill = @(t) E_pk(1).*exp(-(t-t_1(E_loc(1))).*t_half);
plot(t_1+t_1(E_loc(1)), chill(t_1),'r--', 'LineWidth',2)

leg = legend('$v^{2}$','$(\omega y)^{2}$',...
    '$v^{2} + (\omega y)^{2}$',['Halveringstids' newline 'approximation']);
set(leg, 'Interpreter','latex','Fontsize', 15)
%xticks(0:2:20)
%yticks(0:.5:2)
saveas(gcf,'fig1_3','epsc')

%% Part 2

% Custom function for loading 'weird' CSV files
data2 = readcsvwithcomma('Data2.csv');

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
y_2s = y_2s - mean(y_2s(8000:end));
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
plot(w_2m./w_2s_max,top_i,'ro')
hold on; 
ax = axis;
plot([1  1],[0 0.5],'k-')
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
axis(ax)
xlabel('$\omega \cdot \omega_0^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:.2:3)
yticks(0:.1:1)
saveas(gcf,'fig2_1','epsc')

% Finding angle between 2 curves
[m_pks, m_loc] = findpeaks(y_2m(pos-100:pos+100));
w_2m = 2*pi * numel(m_pks)/ (t_2(m_loc(end)) - t_2(m_loc(1)));
i = -100:5:100;
index = pos+i;
deg_s = mod((t_2(index) - t_2(s_loc(1)))*w_2s_max*180/pi,360);
deg_m = mod((t_2(index) - t_2(m_loc(1)))*w_2m*180/pi,360);

% Making plot of sine of angle difference
for i=1:length(deg_s)
    alpha(i) = deg_s(i) - deg_m(i);
    if deg_s(i) < deg_m(i)
        alpha(i) = alpha(i) + 360;
    end
end
figure(5)
plot(t_2(index), sind(alpha))
hold on
plot([t_2(pos), t_2(pos)],[-1.5 1.5],'k-')
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t/s$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$sin\alpha$',labelSettings(1:2:end), labelSettings(2:2:end))
axis([322 331 0.8 1.02])
xticks(320:2:350)
yticks(0.5:.05:1.5)


%% Part 3
L = 9*10^(-3); %H
C = 0.471*10^(-6); %F
R_L = 3; %Ohm Measured with multimeter
R = 0;  
%f = 1000; %Hz

%w_RCL = 2*pi*f;
w_0 = sqrt(1/(L*C));
f_0 = w_0/(2*pi);
w = sqrt(1/(L*C)-((R_L+R)/(2*L))^2);
f = w/(2*pi);
%R = 2*L*sqrt(1/(L*C)-(w_RCL)^2);
%t_half = 2*log(2)*L/R;

V_0 = 65;
V_1 = 169;
V_2 = 87;
R_t = 10;
dt = 2.170*10^(-3); %

tau = -dt/(log((V_2-V_0)/(V_1-V_0)));
tau_teor = 2*L/R_t;

V_x = (V_1-V_0)*exp((-(dt)/((2*L)/R_t))) + V_0;

% 2300 Hz <- Resonans frekvens
