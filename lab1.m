clear;clc;close all;

Data =[...
    0 0 0 0;...
    0.36 0.293 0.308 0.297;...
    0.50 0.363 0.348 0.360;...
    0.72 0.424 0.404 0.412;...
    0.90 0.463 0.463 0.466;...
    1.08 0.538 0.504 0.509;...
    1.44 0.601 0.592 0.605;...
    1.80 0.712 0.686 0.669;...
    2.16 0.745 0.747 0.751;...
    2.52 0.816 0.820 0.816;...
    2.88 0.888 0.889 0.893;...
    3.24 0.959 0.964 0.956;...
    3.60 1.026 1.025 1.026;...
    3.96 1.090 1.089 1.091;...
    4.32 1.161 1.158 1.161;...
    4.68 1.219 1.223 1.212;...
    5.00 1.279 1.277 1.277;...
    5.40 1.353 1.339 1.336;...
    5.80 1.398 1.386 1.382;...
    6.20 1.468 1.471 1.482;...
    6.60 1.545 1.550 1.541;...
    7.00 1.627 1.614 1.614;...
    7.40 1.689 1.695 1.702;...
    7.80 1.751 1.762 1.761;...
    8.20 1.826 1.834 1.834;...
    8.60 1.903 1.894 1.903;...
    9.00 1.967 1.965 1.945];

y = Data(:,1);

% Error in data collection that has to be added
S = -0.11;
for i=1:length(y)
    if ~(i == 1 || i == 2 || i == 3 )
        y(i) = y(i) + S;
    end
end

t_avg = mean(Data(:,2:4),2);
t_deviation = (max(Data(:,2:4),[],2) - min(Data(:,2:4),[],2)); % ms

figure(1)
plot(t_avg,y,'*')


%% Momentan 1

dy = diff(y);
dt = diff(t_avg);
v = dy./dt;

figure(2)
plot([0 t_avg(2:size(t_avg,1))'], [0 v'],'*')

%% Momentan 2 A
grad = 4;

p_s = polyfit(t_avg, y, grad);
sim_y = polyval(p_s, t_avg);

figure(1)
hold on
plot(t_avg, sim_y)

%% Momentan 2 B

p_v = polyder(p_s);
sim_v = polyval(p_v, t_avg);

figure(2)
hold on
plot(t_avg, sim_v)
grid on

%% Momentan 2 C

p_a = polyder(polyder(p_s));
sim_a = polyval(p_a,t_avg);

figure(3)
hold on
plot(t_avg, sim_a)
grid on

%% Simulering 
g = 9.81;
v(1) = 0;
s(1) = 0;
dt = 0.001;
t_i = 0;
t_f = 2;
t = linspace(t_i,t_f, (t_f-t_i)/dt);

%% F_f = 0

for i=1:length(t)
    a(i) = g;
    v(i+1) = v(i) + a(i)*dt;
    s(i+1) = s(i) + v(i)*dt;
end

figure(1)
plot(t,s(1:length(t)),'k--')
figure(2)
plot(t,v(1:length(t)),'k--')
figure(3)
plot(t,a(1:length(t)),'k--')

%% F_f = bv

for i=1:length(t)
    a(i) = g*(1-v(i)/6);
    v(i+1) = v(i) + a(i)*dt;
    s(i+1) = s(i) + v(i)*dt;
end

figure(1)
plot(t,s(1:length(t)),'k-.')
figure(2)
plot(t,v(1:length(t)),'k-.')
figure(3)
plot(t,a(1:length(t)),'k-.')

%% F_f = Bv^2

for i=1:length(t)
    a(i) = g*(1-(v(i)/6)^2);
    v(i+1) = v(i) + a(i)*dt;
    s(i+1) = s(i) + v(i)*dt;
end

figure(1)
plot(t,s(1:length(t)),'k-')

title('Stracka-tid-diagram','Interpreter','latex')
set(gca,'XGrid','on','YGrid', 'on',...
    'Fontsize', 13, 'linewidth', 1,...
    'FontName', 'AvantGarde')
xlabel('$t$/$s$','Interpreter','latex')
ylabel('$hojd$/$m$','Interpreter','latex')
legend('Experimentella värden','Anpassning','Sim. utan luftmotstånd',...
    'Sim. linjärt luftmotstånd','Sim. kvadratiskt luftmotstånd');

figure(2)
plot(t,v(1:length(t)),'k-')

title('Hastighet-tid-diagram','Interpreter','latex')
set(gca,'XGrid','on','YGrid', 'on',...
    'Fontsize', 13, 'linewidth', 1,...
    'FontName', 'AvantGarde')
xlabel('$t$/$s$','Interpreter','latex')
ylabel('$v$/$ms^{-1}$','Interpreter','latex')
legend('Beräknat från exp. värden','Anpassning','Sim. utan luftmotstånd',...
    'Sim. linjärt luftmotstånd','Sim. kvadratiskt luftmotstånd');

figure(3)
plot(t,a(1:length(t)),'k-')

title('Acceleration-tid-diagram','Interpreter','latex')
set(gca,'XGrid','on','YGrid', 'on',...
    'Fontsize', 13, 'linewidth', 1,...
    'FontName', 'AvantGarde')
xlabel('$t$/$s$','Interpreter','latex')
ylabel('$a$/$ms^{-2}$','Interpreter','latex')
legend('Beräknat från exp. värden','Sim. utan luftmotstånd',...
    'Sim. linjärt luftmotstånd','Sim. kvadratiskt luftmotstånd');






