function visualmeananalysis(data,step)
% Plot average values of a data array with steps

for i=1:floor(length(data)/step)
    avg(i) = mean(data(step*(i-1)+1:step*i));
end

figure('Name','Mean Analysis');
plot(avg)
grid on
end