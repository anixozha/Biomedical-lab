close all; 
clear all; clc;
x1=load('Subject01_1_edfm.mat');
x2=load('Subject01_2_edfm.mat');

fs=500;
band_data=zeros(500,7); %1000 rows and 7 colmumns matirix
band_data_1=zeros(500,7);
band_data_2=zeros(500,7);
fp1=x1.val(14,:); %val(2,:) for second channel
fp2=x2.val(14,:);
window_size=fs;
X=fs/2; k=1;
for i=0:360 % 360 windows (91000/500=> 182 => 182*2-1=363)
    fp1_1s=fp1(i*X+1:X*i+fs);
    fft_val=abs(fft(fp1_1s));
    fft_val=fft_val(2:fs/2+1);
    
delta_4hz=sum(fft_val(1:4).^2)/4/fs; % formula: summation (from 1 to 'N') (fft^2)/N/fs ; N= the difference between the range(samples)
theta_4_8hz=sum(fft_val(5:8).^2)/4/fs;
alpha_8_13hz=sum(fft_val(9:13).^2)/5/fs;
beta_13_30hz=sum(fft_val(14:30).^2)/17/fs;
gamma_30_60hz=sum(fft_val(31:60).^2)/30/fs;
gamma_60_90hz=sum(fft_val(61:90).^2)/30/fs;
gamma_90_128hz=sum(fft_val(91:128).^2)/38/fs;

band_data(k,:)=[delta_4hz,theta_4_8hz,alpha_8_13hz,beta_13_30hz,gamma_30_60hz,gamma_60_90hz,gamma_90_128hz];
k=k+1; %next row
end

band_names = {'Delta', 'Theta', 'Alpha', 'Beta', 'Gamma1', 'Gamma2', 'Gamma3'};
 for i =1:7
     zoom xon; 
     subplot(7,1,i); plot(band_data(:,i));
     title(['Aavash Shrestha - ',band_names{i}]);
     xlabel('Frequency (Hz)');
ylabel('PSD');
 end

 k=1;
for i=0:120  
    fp2_1s=fp2(i*X+1:X*i+fs); % 31000, for subject 2
    fft_val=abs(fft(fp2_1s));
    fft_val=fft_val(2:fs/2+1);

delta_4hz=sum(fft_val(1:4).^2)/4/fs; % formula: summation (from 1 to 'N') (fft^2)/N/fs ; N= the difference between the range(samples)
theta_4_8hz=sum(fft_val(5:8).^2)/4/fs;
alpha_8_13hz=sum(fft_val(9:13).^2)/5/fs;
beta_13_30hz=sum(fft_val(14:30).^2)/17/fs;
gamma_30_60hz=sum(fft_val(31:60).^2)/30/fs;
gamma_60_90hz=sum(fft_val(61:90).^2)/30/fs;
gamma_90_128hz=sum(fft_val(91:128).^2)/38/fs;

band_data_1(k,:)=[delta_4hz,theta_4_8hz,alpha_8_13hz,beta_13_30hz,gamma_30_60hz,gamma_60_90hz,gamma_90_128hz];
k=k+1; %next row
end
band_names = {'Delta', 'Theta', 'Alpha', 'Beta', 'Gamma1', 'Gamma2', 'Gamma3'};
figure; 
for i =1:7
     zoom xon; 
     subplot(7,1,i); plot(band_data_1(:,i));
     title(['Aavash Shrestha - ',band_names{i}]);
     xlabel('Frequency (Hz)');
ylabel('PSD');
end
 
k=1;
combi=[fp1, fp2]; % concatinate
for i=0:450 % 122000
    signal_1s=combi(i*X+1:X*i+fs);
    fft_val=abs(fft(signal_1s));
    fft_val=fft_val(2:fs/2+1);
    
delta_4hz=sum(fft_val(1:4).^2)/4/fs; % formula: summation (from 1 to 'N') (fft^2)/N/fs ; N= the difference between the range(samples)
theta_4_8hz=sum(fft_val(5:8).^2)/4/fs;
alpha_8_13hz=sum(fft_val(9:13).^2)/5/fs;
beta_13_30hz=sum(fft_val(14:30).^2)/17/fs;
gamma_30_60hz=sum(fft_val(31:60).^2)/30/fs;
gamma_60_90hz=sum(fft_val(61:90).^2)/30/fs;
gamma_90_128hz=sum(fft_val(91:128).^2)/38/fs;

band_data_2(k,:)=[delta_4hz,theta_4_8hz,alpha_8_13hz,beta_13_30hz,gamma_30_60hz,gamma_60_90hz,gamma_90_128hz];
k=k+1; %next row
end
band_names = {'Delta', 'Theta', 'Alpha', 'Beta', 'Gamma1', 'Gamma2', 'Gamma3'};
figure; 
for i =1:7
     zoom xon; 
     subplot(7,1,i); plot(band_data_2(:,i));
     title(['Aavash Shrestha - ',band_names{i}]);
     xlabel('Frequency (Hz)');
ylabel('PSD');
end