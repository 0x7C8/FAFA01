clear;clc;close all

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
