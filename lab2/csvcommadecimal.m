function y = csvcommadecimal(filename)
% Reads .csv files that have ',' instead of '.' as decimal separator

Data = fileread(filename);
Data = strrep(Data, ',', '.');
FID = fopen('temp.csv', 'w');
fwrite(FID, Data, 'char');
fclose(FID);

y = readtable('temp.csv');
delete('temp.csv')
end