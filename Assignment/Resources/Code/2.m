clear;clc;close all
% ------ Shared graph settings -------
gcaSettings = {...
    'XGrid','on',...
    'YGrid', 'on',...
    'Fontsize', 13,...
    'linewidth', 1,...
    'FontName', 'Arial'};

labelSettings = {...
    'Interpreter','latex'...
    'Fontsize', 17};

lineSpec = {'k-','k--','k:'};
% -------------------------------------

%% 2a

g = 9.81;   % m/s^2
v_0 = 10;   % m/s
deg = [20 40 60]; % degrees
x = linspace(0,10,100);

y = @(x, th) x.*(tand(th)-g.*x./(2.*v_0.^2.*(cosd(th)).^2));

figure(1)
hold on
% Plots 3 lines for each deg
for i=1:length(deg)
    plot(x, y(x,(deg(i))), lineSpec{i})
end
axis([0 11 0 4])
legend(['20' char(176)], ['40' char(176)], ['60' char(176)]);
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$x/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:2:15)
yticks(0:1:5)

%% 2b

k = 1;
t = linspace(0,1.5,100);

x_drag = @(t,th) v_0.*cosd(th)./k.*(1-exp(-k.*t));
y_drag = @(t,th) 1./k.* ((v_0.*sind(th) + g./k).*(1-exp(-k.*t)) - g.*t);

% Plots 3 lines for each deg
for i=1:length(deg)
    plot(x_drag(t,deg(i)), y_drag(t,(deg(i))), lineSpec{i}, 'LineWidth', 3)
end

legend(['20' char(176)], ['40' char(176)], ['60' char(176)]);
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$x/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
saveas(gcf,'fig2','epsc')

