clear all;
% close all;

Y2=  load('Subject01_2_edfm.mat')
Y1=load('Subject01_1_edfm.mat')
 
fp1_1=Y1. val(13,:);
fp1_2=Y2. val(13,:);
fs= 500;
plot(fp1_1);
band_data_1=zeros(351, 7);
band_data_2=zeros(121,7);
X=250;
k=1;

for i = 0:350
    
    fp1_fp7_1s = fp1_1(i*X+1:i*X+fs);
    fft_val_1s=abs(fft(fp1_fp7_1s));
    fft_val=fft_val_1s(2:fs/2+1);
    delta_4Hz= sum(fft_val(1:4).^2/4);
    alpha4_8Hz= sum(fft_val(5:8).^2/4);
    theta8_13Hz= sum(fft_val(9:13).^2/5);
    beta13_30Hz= sum(fft_val(14:30).^2/17);
    gamma31_60Hz= sum(fft_val(31:60).^2/30);
    gamma60_90Hz=sum(fft_val(61:90).^2/30);
    gamma90_120Hz=sum(fft_val(91:120).^2/30);
    band_data_1(k,:)=[delta_4Hz,alpha4_8Hz, theta8_13Hz,beta13_30Hz, gamma31_60Hz,gamma60_90Hz,gamma90_120Hz];
    k=k+1;
end
figure;
for i= 1:7
    subplot(7,1,i);
    plot(band_data_1(:,i))
end
 k=1;
for i = 0:120
    
    fp1_fp7_2s = fp1_2(i*X+1:i*X+fs);
    fft_val_1s=abs(fft(fp1_fp7_2s));
    fft_val=fft_val_1s(2:fs/2+1);
    delta_4Hz= sum(fft_val(1:4).^2/4);
    alpha4_8Hz= sum(fft_val(5:8).^2/4);
    theta8_13Hz= sum(fft_val(9:13).^2/5);
    beta13_30Hz= sum(fft_val(14:30).^2/17);
    gamma31_60Hz= sum(fft_val(31:60).^2/30);
    gamma60_90Hz=sum(fft_val(61:90).^2/30);
    gamma90_120Hz=sum(fft_val(91:120).^2/30);
    band_data_2(k,:)=[delta_4Hz,alpha4_8Hz, theta8_13Hz,beta13_30Hz, gamma31_60Hz,gamma60_90Hz,gamma90_120Hz];
    k=k+1;
end
figure;
for i= 1:7
    subplot(7,1,i);
    plot(band_data_2(:,i))
end

figure;
subplot(211);
plot(band_data_2(:,3));
hold on;
plot(band_data_1(:,3));
legend('band2_beta', 'band1_beta');
subplot(212);
plot(band_data_2(:,5));
hold on;
plot(band_data_1(:,5));
legend('band2_gamma', 'band1_gamma');

