clear;clc;close all

% Main folder has to include:
% plotsettings.m
% csvcommadecimal.m

% ------ Shared graph settings -------
labelSettings = {...
    'Interpreter','latex',...
    'Fontsize', 17};
% ------------------------------------

% Custom function for loading 'weird' CSV files
data1 = csvcommadecimal('Data1.csv');

t_1 = str2double(table2array(data1(2:end,2)));
y_1 = str2double(table2array(data1(2:end,3)));
v_1 = str2double(table2array(data1(2:end,4)));

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
set(gcf, 'Position',  [100, 100, 800, 400])
plot(t_1,y_1,'LineWidth',2)
plotsettings('plot');
xlabel('t (s)',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('x (m)',labelSettings(1:2:end), labelSettings(2:2:end))
%title('D\"{a}mpande system',labelSettings(1:2:end), labelSettings(2:2:end))
axis([0 30 -0.3 0.3])
saveas(gcf,'fig1_1','epsc')

% Finding velocity (our v is fucked up, hence the attempt.
% It is better to use v from Capstone data)
dy = diff(y_1);
dt = diff(t_1);
v = dy./dt;

figure(2)
plot(y_1(2:length(v)+1),v)
plotsettings('plot');
xlabel('x (m)',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('v ($m/s$)',labelSettings(1:2:end), labelSettings(2:2:end))
%title('Fasdiagram av d\"{a}mpande system',labelSettings(1:2:end), labelSettings(2:2:end))
axis(1.1*[min(y_1) max(y_1) min(v) max(v)])
xticks(-1:.1:1)
yticks(-1:.5:1)
saveas(gcf,'fig1_2','epsc')

% Energy
K = v.^2;   % v is not from Capstone!
U = (3.867.*y_1).^2;
E = K + U(2:end);   % K is 1 less element

figure(3)
set(gcf, 'Position',  [100, 100, 800, 400])
hold on
plot(t_1(2:end),K,'r-') 
plot(t_1,U,'b-')
plot(t_1(2:end),E,'k')
plotsettings('plot');
xlabel('t (s)',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$Q$ ($J/kg$)',labelSettings(1:2:end), labelSettings(2:2:end))
axis([0 15 0 1.5])

% Finding half life
% figure(31)
% findpeaks(E(10:400), 'MinPeakDistance',10)
% axis([0 300 0 max(E)])
[E_pk, E_loc] = findpeaks(E(10:400), 'MinPeakDistance',10);
% plot(E_loc, E_pk)
pk_select = 10;
t_half = log(E_pk(1)/E_pk(pk_select))/(t_1(E_loc(pk_select)+1)-t_1(E_loc(1)+1));
Halveringstid = "Figur 3: " + 1/t_half + " s"

chill = @(t) E_pk(1).*exp(-(t-t_1(E_loc(1))).*t_half);
% plot(t_1+t_1(E_loc(1)), chill(t_1),'r--', 'LineWidth',2)

leg = legend('$v^{2}$','$(\omega_0 y)^{2}$',...
    '$v^{2} + (\omega_0 y)^{2}$');
set(leg, 'Interpreter','latex','Fontsize', 15)
%xticks(0:2:20)
%yticks(0:.5:2)
saveas(gcf,'fig1_3','epsc')