close all;
clc;
load('chb01_03_edfm.mat');

fp1_fp7 = val(1,:);
figure, plot(fp1_fp7);

fp1_fp7_seizure = fp1_fp7(766976-1000:777216+1000);
figure,plot(fp1_fp7_seizure);


% Power Spectral Density
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(x):fs/2;

plot(freq,pow2db(psdx))
grid on
title("Periodogram Using FFT")
xlabel("Frequency (Hz)")
ylabel("Power/Frequency (dB/Hz)")

%%
% Compute Welch's estimate of the periodogram of a 200 Hz sinusoid
% in noise using default values for window, overlap and NFFT.
Fs = 1000;   t = 0:1/Fs:.296;
x = cos(2*pi*t*200)+randn(size(t));
pwelch(x,[],[],[],Fs,'onesided');

