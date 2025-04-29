close all;
clear all;
clc;

load('chb01_03_edfm.mat');
x=val(1,:);
% start_n=0;
% end_n=7000;
fs= 256;
band_data= zeros(7001,7);
window_size=fs;
window_shift= fs/2;
k=1;
X=128;
for i = 0:7000
    
    fp1_fp7_1s = x(i*X+1:i*X+fs);
    fft_val_1s=abs(fft(fp1_fp7_1s));
    fft_val=fft_val_1s(2:fs/2+1);
    delta_4Hz= sum(fft_val(1:4).^2/4);
    alpha4_8Hz= sum(fft_val(5:8).^2/4);
    theta8_13Hz= sum(fft_val(9:13).^2/5);
    beta13_30Hz= sum(fft_val(14:30).^2/17);
    gamma31_60Hz= sum(fft_val(31:60).^2/30);
    gamma60_90Hz=sum(fft_val(61:90).^2/30);
    gamma90_120Hz=sum(fft_val(91:120).^2/30);
    band_data(k,:)=[delta_4Hz,alpha4_8Hz, theta8_13Hz,beta13_30Hz, gamma31_60Hz,gamma60_90Hz,gamma90_120Hz];
    k=k+1;
end
figure;
for i= 1:7
    subplot(7,1,i);
    plot(band_data(:,i))
end
    
