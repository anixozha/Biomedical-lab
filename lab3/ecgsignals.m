clear all;
close all;
load mit200;
zoom xon;

%ecgsig=abs(ecgsig);
% ann=abs(ann);
n=3;
fc=12;
fs=360;
%highpass filter
[a,b] =butter(n,fc/(fs/2), 'high');
filtered_signal1=filter(a,b,ecgsig);
%lowpass filter
[a,b] =butter(n,14/(fs/2), 'low');
filtered_signal=filter(a,b,filtered_signal1);
% signal_filter=abs(filtered_signal);

%moving average filter (low pass with lower order butter filter acts as moving average filter)
[a,b]= butter(1, 1/(fs/2));
thersholding_adp = filter(a,b, filtered_signal);
threshold=thersholding_adp.*2;

% plot(ecgsig ,'b');
% hold on
plot(tm,filtered_signal, 'g');
hold on
plot(tm,threshold, 'r');