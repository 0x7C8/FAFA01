% Reads .cvs files that have ',' instead of '.' as decimal separator

function y = readcsvwithcomma(filename)

Data = fileread(filename);
Data = strrep(Data, ',', '.');
FID = fopen('temp.csv', 'w');
fwrite(FID, Data, 'char');
fclose(FID);

y = readtable('temp.csv');
delete('temp.csv')
end