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
plot(t_1,y_1)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel(col(2),labelSettings(1:2:end), labelSettings(2:2:end))
ylabel(col(3),labelSettings(1:2:end), labelSettings(2:2:end))

% Finding velocity
dy = diff(y_1);
dt = diff(t_1);
v = dy./dt;

figure(2)
plot(y_1(2:end),v)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel(col(3),labelSettings(1:2:end), labelSettings(2:2:end))
ylabel(col(4),labelSettings(1:2:end), labelSettings(2:2:end))

% Energy
K = v.^2;
U = (w_1.*y_1).^2;
E = K + U(2:end);

figure(3)
hold on
plot(t_1(2:end),K,lineSpec{2})
plot(t_1,U,lineSpec{1})
plot(t_1(2:end),E,lineSpec{4})
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel(col(2),labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('Energy (ummm)',labelSettings(1:2:end), labelSettings(2:2:end))
axis([0 15 0 1.5])

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

% Finding angular velocity through finding peaks
[mx, pos] = max(y_2s);
[pks, loc] = findpeaks(y_2s(pos-100:pos+200));
w_2 = 2*pi * numel(pks)/ (t_2(pos+200) - t_2(pos-100));

% Finding angle between 2 curves



%% Part 3
L = 9*10^(-3); %H
C = 0.471*10^(-6); %F
%f = 1000; %Hz
R_L = 2.5; %Ohm
R = 0;

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
