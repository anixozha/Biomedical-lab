
f1 = 5; 
f2 = 20; 
A = 1;
duration = 2;
fs = (max(f1,f2))*20; 

t = linspace(0, duration, duration * fs);


sine_wave1 = A * sin(2 * pi * f1 * t);
sine_wave2 = A * sin(2 * pi * f2 * t);


sum_wave = sine_wave1 + sine_wave2;


ft=abs( fft(sum_wave));
ft= ft(1:length(ft)/2+1);
f=(0:length(ft)-1)*fs/(2*length(ft));


subplot(2,2,1);
plot(t, sine_wave1, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Sine Wave of frequency 5Hz');
grid on;

subplot(2,2,2);
plot(t, sine_wave2, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Sine Wave of frequency 20Hz');
grid on;

subplot(2,2,3);
plot(t, sum_wave, 'g');
xlabel('Time (s)');
ylabel('Amplitude');
title('Sum of Sine Waves');
grid on;

subplot(2,2,4);

plot(f,ft, 'm');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Fourier Transform of Sum');
grid on;


sgtitle('Anish Ojha: Sinusoids and Fourier Transform');
