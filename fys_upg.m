%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Physics for Scientists and Engineers
%   Paul A Tipler, Gene Mosca
%   Sixth Edition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Run each section (problem) separetly 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Constants
% Run this part before solving excercise 
g = 9.81;


%% 1.74
s_1 = 1.5;
a = 15;
b = 13;
d = 7.5;

s_2 = s_1*sind(90-a)/sind(a-b); % Law of Sines

h = s_2*tand(d);


%% 1.75
T = [0.44 1.61 3.88 7.89];
r = [0.088 0.208 0.374 0.6];
p = polyfit(log(r),log(T),1);
n = p(1);
C = exp(p(2));

T_5 = 6.2;
r_5 = (T_5/C)^(1/n);

%% 2.69

v_i = 20;
s_1 = 15;

t_tot = 2*v_i/g;

t_max = t_tot/2;
s_max = v_i*(t_max) - 1/2*g*t_max^2;

t_1 = roots([g -2*v_i 2*s_1]);
t_elapsed = abs(diff(t_1));

%% 2.83

a = -7;
t_r = 0.5;
s_b = 4;

v_0 = roots([1 -2*a*t_r 2*a*s_b]);

frac = v_0(2)*t_r/s_b;

%% 3.66

f = 15000/60;
r = 0.15;

w = 2*pi*f;
a_c = r*w^2;

t = 75;
a_t = r*w/t;

answer = ["a: "+num2str(a_c,'%d'); "b: "+num2str(a_t,'%d')]

%% 3.70

T = 33.085 * 10^(-3);
r = 15 * 10^3;

w = 2*pi/T;
a_c = r*w^2;

t_0 = 0;
b = 3.5*10^(-13);
% t = 9.5*10^10;
a_t = -2*pi*r*b/(T+b*t_0)^2;
% a_t = w*r/t

answer = ["a: "+num2str(a_c,'%d'); "b: "+num2str(a_t,'%d')]


%% 3.84

h = 200;
angle = 60;
v_0 = 60;

t = roots([1 -2*v_0*sind(angle)/g -2*h/g])
x = v_0*cosd(angle)*t(1)

%% 4.38

%% 4.47 
%% 4.59
%% 4.75











