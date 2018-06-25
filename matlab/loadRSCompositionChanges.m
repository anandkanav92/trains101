%% Import data from text file.
% Script for importing data from the following text file:
%
%    D:\Dropbox\Postdoc\Articles WIP\INFORMS RAS 2018 Problem Solving
%    Competition\Data\RollingStockCompositionChanges.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2018/06/12 20:12:20

%% Initialize variables.
filename = [mainFolder 'RollingStockCompositionChanges.txt'];
delimiter = '\t';
startRow = 2;

%% Format string for each line of text:
%   column1: text (%s)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
Location3 = dataArray{:, 1};
Day3 = dataArray{:, 2};
TrainIn = dataArray{:, 3};
TrainOut = dataArray{:, 4};

Nrows = length(Day3);
clear RSCompChange
tic
jj=1;
for ii = 1:Nrows   % for 5-9-2017
    RSCompChange(jj).Day = Day3(ii);
    RSCompChange(jj).ArrivingTrain = (TrainIn(ii));
    RSCompChange(jj).Location = Location3{ii};
    RSCompChange(jj).DepartingTrain = (TrainOut(ii));
    jj=jj+1;
end
toc 
save('RSCompChange','RSCompChange')

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans Location3 Day3 TrainIn TrainOut