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

lineSpec = {'b-','r--','k:', 'k-.'};
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
plot(y(1:length(v)),v)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$v/ms^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))
%xticks(0:.5:2)

%% 2a
b = 0.4; % kg/s

y_half = 2*m*log(2)/b;
answers = ["2a: "+num2str(y_half,'%.3f') + " s"]

damp = b/(2*m);
if damp > w
    dr = 'Overdamped';
elseif damp == 0
    dr = 'Undamped';
elseif damp == w
    dr = 'Critically damped';
else
    dr = 'Underdamped';
end
fprintf('The spring is %s\n', dr)

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
v_damp = diff(y_damp)./diff(t);

figure(3)
plot(y_damp(1:length(v)),v_damp)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$v/ms^{-1}$',labelSettings(1:2:end), labelSettings(2:2:end))


%% 4
L = 12*10^(-3); %H
C = 1.6*10^(-6); %F
f = 1000; %Hz

w_RCL = 2*pi*f;
R = 2*L*sqrt(1/(L*C)-(w_RCL)^2);
t_half = 2*log(2)*L/R;
answers = ["4a: "+num2str(R,'%.3f') + " Ohm" + newline ...
     + "4b: " + num2str(t_half*1000,'%.3f') + " ms"]








