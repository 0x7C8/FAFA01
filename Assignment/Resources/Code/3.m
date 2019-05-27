clear;clc;close all

r_a = 25.1*10^6; % m
r_p = 8.37*10^6; % m
v_max = 8450; % m/s
r_earth = 6.371 * 10^6; % m 

v_min = r_p/r_a*v_max;  % Lowest speed

rad = linspace(0,2*pi,100);
x_sat = (r_a + r_p)/2*cos(rad)-((r_a+r_p)/2-r_p);   % Orbit's X-coordinates
y_sat = sqrt(r_a*r_p)*sin(rad); % Orbit's Y-coordinates
x_earth = r_earth*cos(rad); % Earth's contour X-coordinates
y_earth = r_earth*sin(rad); % Earth's contour Y-coordinates

figure(1)
hold on
p(1) = plot(x_sat, y_sat, 'k-.');  % Satellite's orbit
p(2) = plot(x_earth, y_earth, 'k-');   % Earth
p(3) = plot(x_sat(34), y_sat(34),'kd');   % Satellite
dots = [0 x_sat(1) (r_a + r_p)/2*cos(pi)-((r_a+r_p)/2-r_p);...
    0 y_sat(1) sqrt(r_a*r_p)*sin(pi)];  % Reference point, Perigee, Apogee  
plot(dots(1,:), dots(2,:), 'k*');
plot([x_sat(34) 0],[y_sat(34) 0],'k--');  % Radius

axis(10^7*[-3 1 -2 2])
pbaspect([1 1 1])   % 1:1 aspect ratio for plot
legend([p(3) p(1)], 'Satellit', 'Satellitbana');
set(gca,...
    'XTickLabel',-30:5:10,...   % X-axis ruler numbers
    'YTickLabel',-20:5:20,...   % Y-axis ruler numbers
    'XGrid','on',...
    'YGrid', 'on',...
    'Fontsize', 13,...
    'linewidth', 1,...
    'FontName', 'Arial')
xlabel('$x/10^6m$','Interpreter','latex','Fontsize', 17)
ylabel('$y/10^6m$','Interpreter','latex','Fontsize', 17)
text([-8.8*10^6 dots(1,2)-2*10^6 dots(1,3)-2*10^6],...
    [7.8*10^6 dots(2,2)+10^6 dots(2,3)+10^6], {'$r$' '$r_p$' '$r_a$'},...
    'Interpreter','latex','Fontsize', 17);
saveas(gcf,'fig3_1','epsc')
