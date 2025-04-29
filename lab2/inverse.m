
f1 = 5; 
f2 = 20; 
A = 1;
duration = 2;
fs = (max(f1,f2))*20; 
%defining N point fft
N=512;

t = linspace(0, duration, duration * fs);


sine_wave1 = A * sin(2 * pi * f1 * t);
sine_wave2 = A * sin(2 * pi * f2 * t);


sum_wave = sine_wave1 + sine_wave2;


ft=abs( fft(sum_wave,N));
% ft= ft(1:length(ft)/2+1);
f=(0:length(ft)-1)*fs/N;

ft(1:10)=0;
ft(380:end)=0;
ift=abs(ifft(ft,N));
fn=(0:length(ift)/2)*fs/N;
% ift=ift(1:length(ift)/2+1);




subplot(2,2,1);
plot(t, sum_wave, 'g');
xlabel('Time (s)');
ylabel('Amplitude');
title('Sum of Sine Waves');
grid on;

subplot(2,2,2);

plot(f,ft, 'm');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Fourier Transform of Sum');
grid on;
subplot(2,2,3);
plot( ift(1:N/2), 'g');
xlabel('Time (s)');
ylabel('Amplitude');
title('Sum of Sine Waves');
grid on;



sgtitle('Anish Ojha: Sinusoids and Fourier Transform');
