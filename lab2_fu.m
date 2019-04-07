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
    'Fontsize', 18};

lineSpec = {'k-','k--','k:', 'k-.'};
% -------------------------------------

%% 1a
m = 0.1; %kg
k = 40; %N/m

x_0 = 0.014; %m
v_0 = 0;

t = linspace(0,2,500);
w = sqrt(k/m);
y = -x_0*cos(w*t);

figure(1)
plot(t,y,lineSpec{4})
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t/s$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:.5:2)

%% 1b
v = diff(y)./diff(t);

figure(2)
plot(t(1:length(v)),v)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t/s$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$v/ms^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:.5:2)

%% 2a
b = 0.4; % kg/s

y_half = 2*m*log(2)/b;
answer = ["2a: "+num2str(y_half,'%.3f') + " s"]

%% 2b
w_d = sqrt(w^2-(b/(2*m))^2);
y_exp = -x_0.*exp(-b./(2*m).*t);
y_damp = -x_0.*exp(-b./(2*m).*t).*cos(w_d.*t);
figure(1)
hold on
plot(t,y_exp,lineSpec{2})
plot(t,-y_exp,lineSpec{2})
plot(t,y_damp,lineSpec{1})

%% 2c

%% 3

%% 4
