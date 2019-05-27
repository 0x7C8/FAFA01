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
% -------------------------------------

%% 5a
order = 1;
x = 0:0.1:20;

J = besselj(order,x);
figure(1)
plot(x,J)
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$x/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$J_1(x)$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:5:20)
yticks(-0.4:0.2:1)
saveas(gcf,'fig5_1','epsc')

%% 5b

lambda = 600 * 10^(-9); % (m) % Wavelength of the laser beam
d = 50 * 10^(-6);   % (m) Width of a single slit
D = d;  % (m) Diameter of circular aperture
L = 5;  % (m) Distance between the slit and the screen

th = 3; % (deg) Angle arctan(x/L)
theta =-th:0.01:th; % +/- Array of angles
x = L * tand(theta);    % Horisontal line along the screen
I_0 = 1;    % Light intensity at the axis of symmetry

k = 2*pi / lambda;  % Wavenumber
beta = @(angl,a) 1/2 * k * a * sind(angl); 
I_slt = @(b) I_0 * (sin(b)./b).^2 ; % Single slit
I_apt = @(b) I_0 * (2 * besselj(1,b)./b).^2 ;   % Circular aperture

figure(2)
hold on
plot(x, I_slt(beta(theta,d)), 'k-');
plot(x, I_apt(beta(theta,D)), 'k--');

% TODO change y-axis to logarithmic
axis([min(x) max(x) -I_0/5 I_0])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$x/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$I(\theta)$',labelSettings(1:2:end), labelSettings(2:2:end))
legend('Single slit','Circular aperture','Location','Best')
xticks(-0.4:0.1:0.4)
yticks(-0.4:0.2:1)
saveas(gcf,'fig5_2','epsc')

%% 5c
S = 0.5;    % (m) From center to border of plot
x = -S:0.001:S;   % x-axis
y = -S:0.001:S;   % y-axis

[X,Y] = meshgrid(x,y);  % Create meshgrid
R = sqrt(X.^2 + Y.^2);  % Set radius as a function of X and Y
theta_2 = atand(R/L);   % Angle

figure(3)
mesh(x,y,log10(I_apt(beta(theta_2,D))));   % Plot 3D plot in log10 scale
colormap(gray)  % Gray gradient plot
pbaspect([1 1 1])   % 1:1:1 plot aspect ratio
caxis([-5 0])  % Color gradient adjustment
view(2);    % View from the top
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$x/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$y/m$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(-0.5:0.25:0.5)
yticks(-0.5:0.25:0.5)
saveas(gcf,'fig5_3','epsc')
%%
view(3)
axis([-0.5 0.5 -0.5 0.5 -5 0])
caxis([-5 0.1])  % Color gradient adjustment
zlabel('log$_{10}I(\theta)$',labelSettings(1:2:end), labelSettings(2:2:end))
saveas(gcf,'fig5_4','epsc')











