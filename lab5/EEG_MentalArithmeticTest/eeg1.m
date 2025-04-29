% Load data for each subject
Y2 = load('Subject01_2_edfm.mat');
Y1 = load('Subject01_1_edfm.mat');

% Call the function to process and plot the data
eegperformance(Y1, Y2, 1); % For Subject 00
% Load data for each subject
Y3 = load('Subject00_2_edfm.mat');
Y4 = load('Subject00_1_edfm.mat');

% Call the function to process and plot the data
eegperformance(Y3, Y4, 0); % For Subject 00