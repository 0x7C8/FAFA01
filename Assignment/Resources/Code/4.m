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

%% 4a
n_air = 1;
n_glass = 1.4;
R = 0.2;    % (m)
d = 0.1;    % (m)

a = @(h) sqrt(R.^2-(h./2).^2);  % Distance that lense protrudes
theta = @(h) asin(h./(2.*R)); % Angle of ray's entering point
angle_max = linspace(pi-theta(d),pi+theta(d),100);  

%% Problem set up plot 1
figure(1)
hold on

lens_plot(R,a(d),d,angle_max)  % Function for plotting lens

% Significant lines
plot([R+R*cos(angle_max(1)) R],[R.*sin(angle_max(1)) 0],'k--')  % Line from C to top left edge
plot([R+R*cos(angle_max(1)) R+R*cos(angle_max(1))],...
    [R.*sin(angle_max(1)) 0],'k--')  % Half of diameter line
plot([R+R*cos(angle_max(1)) R],[0 0],'k--')  % from horisontal line from h-line to R

% Plot points of interests
plot(R,0,'k*')

% Text inside plot
text_x = 1.1 *[R-a(d) R/2 R 0.7*R 0.3*R];   % Text x position
text_y = [d/4 d/4 0 d/25 -d/20];   % Text y position
text(text_x, text_y, {'$h$' '$R$' '$C$' '$\theta$' '$a$'},...
    'Interpreter','latex','Fontsize', 17);

axis([-R/4 R*1.3 0.7*-d 0.7*d])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$x/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$h/m$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:0.1:0.3)
yticks(-0.09:0.03:0.09)
saveas(gcf,'fig4_1','epsc')

%% Problem set up plot 2
figure(2)
hold on

lens_plot(R,a(d),d,angle_max)  % Function for plotting lens

% Significant lines
plot([-R R+R*cos(angle_max(1)) 1.5*R],[d/2 d/2 0],...
    'k-', 'LineWidth',2)  % Ray
plot([R+2*R*cos(angle_max(1)) R],...
    [2*R.*sin(angle_max(1)) 0],'k--')  % Line from C to top left edge
plot([1.5*R 1.5*R],...
    [R.*sin(angle_max(1)) 0],'k--')  % Half of diameter line
plot([-R 1.5*R],...
    [0 0],'k--') % x-axis

% Plot points of interests
plot(R,0,'k*')  % C
plot(1.5*R,0,'k*')  % f
plot(R+R*cos(angle_max(1)), d/2,'k*')   % Ray entering point

% Text inside plot
text_x = 1.1 *[1.4*R R/2 R -0.2*R 0.35*R ...
    1.4*R 0.35*R 0.7*R];   % Text x position
text_y = [d/4 d/4 -d/20 0.55*d d/3 ...
    0 0.45*d 0.55*d];   % Text y position
text(text_x, text_y, {'$d/2$' '$R$' '$C$' '$\theta_1$' '$\theta_2$'...
    '$f$' '$\alpha$', '$L$'},...
    'Interpreter','latex','Fontsize', 17);


axis([-R/2 R*1.7 0.7*-d 0.7*d])
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$x/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$h/m$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(-0.2:0.1:0.3)
yticks(-0.09:0.03:0.09)
saveas(gcf,'fig4_2','epsc')

%% Rays plot

x = @(h,theta_1) h./(2.*tan(theta_1-asin(n_air./n_glass .* sin(theta_1))));
f = @(x, a) x + (R-a);
N_rays = 10;    % Number of rays
rays = linspace(-d/2,d/2,N_rays);

figure(31)
hold on

axis([0.68 0.71 15*-d 15*d])

% Plots rays
for i = 1:length(rays)
H = rays(i);    % Select ray
A = a(H);
F = f(x(H, theta(H)), A);    % Focal point for the selected ray
% Debugging
F_debug(i) = F;
Ra_debug(i) = R - A;
theta_debug(i) = theta(H);
%----------
ray_x = [-R R-a(H) F 2*F];   % Ray's x position
ray_y = [H H 0 H*F/(R-F-a(H))];    % Ray's y position
plot(ray_x,1000*ray_y,'k-')
end

set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$x/m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$h/mm$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(-1:0.01:1)
yticks(-2:.5:2)
saveas(gcf,'fig4_3_2','epsc')

%% 4a
N_points = 200;
ray_h = linspace(-d/2,d/2,N_points);

figure(30)
plot(100*ray_h,f(x(ray_h, theta(ray_h)), A),'k-')

set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$h/cm$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$f/m$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(-10:2:10)
yticks(.5:.001:.8)
saveas(gcf,'fig4_3','epsc')

%% 4b

a = [2.271176 -9.700709*10^(-3) 0.0110971...
    4.622809*10^(-5) 1.616105*10^(-5) -8.285043*10^(-7)];

n = @(X) sqrt(a(1) + a(2).*X.^2 + a(3).*X.^(-2)...
    + a(4).*X.^(-4) + a(5).*X.^(-6) + a(6).*X.^(-8));

lam = linspace(0.4,0.7,100);

figure(4)
plot(lam, n(lam),'k-')

set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$\lambda/\mu m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$n$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:0.1:1)
yticks(1.5:0.005:1.55)
saveas(gcf,'fig4_4','epsc')

%% 4c

f_b = @(L) R .* n(L) ./ (n(L) - n_air); 

figure(5)
plot(lam, f_b(lam),'k-')

set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$\lambda/\mu m$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$f/m$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:0.1:1)
yticks(0.5:0.003:0.6)
saveas(gcf,'fig4_5','epsc')


