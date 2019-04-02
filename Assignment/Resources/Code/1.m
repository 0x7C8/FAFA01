% ------ Shared graph settings -------
gcaSettings = {...
    'XGrid','on',...
    'YGrid', 'on',...
    'Fontsize', 13,...
    'linewidth', 1,...
    'FontName', 'AvantGarde'};

labelSettings = {...
    'Interpreter','latex'...
    'Fontsize', 17};
% -------------------------------------

%% 1a
t = [0 1.87 3.74 5.62 7.5 9.37 11.25 13.12]; % ns
I = [1001 841 723 641 505 426 386 374]; 
err = sqrt(I);

figure(1)
errorbar(t,I,err,'k--');    % Plot with errorbars

set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$/$ns$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('Antal emitterade fotoner',...
    labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:2:15)
yticks(0:200:1200)
saveas(gcf,'fig1_1','epsc')
hold on

%% 1b

time = linspace(0,15,1000);
p = polyfit(t,log(I),1);
T = -1/p(1);
I_0 = exp(p(2));

figure(2)
plot(t,log(I), 'k*')
hold on
plot(time, -1/T*time + log(I_0), 'k--')

legend(['Logaritmerat' char(10) 'experimentella varden'], 'Anpassning');
set(gca,gcaSettings(1:2:end),gcaSettings(2:2:end))
xlabel('$t$/$ns$',labelSettings(1:2:end), labelSettings(2:2:end))
ylabel('$log I(t)$',labelSettings(1:2:end), labelSettings(2:2:end))
xticks(0:2:15)
yticks(5.7:.3:8)
eq = sprintf('y = %.2fx + %.2f', p(1), p(2));   % Equation for line
text(9, 6.7, eq,... % Prints equation in a plot
    labelSettings(1:2:end), labelSettings(2:2:end));

figure(1)
plot(time, I_0.*exp(-time./T),'k-')
legend(['Experimentella varden' char(10) 'med errorbars'], 'Modell');
saveas(gcf,'fig1_3','epsc')
