
f1 = 20; 
f2 = 50; 
A = 1;

fs = 20*f2; 

t = 1/fs:1/fs:1;


sine_wave1 = A * sin(2 * pi * f1 * t);
sine_wave2 = A * sin(2 * pi * f2 * t);


sum_wave = sine_wave1 + sine_wave2;
% filter design
fc= 10;
[b,a]= butter(6,fc/(fs/2));
y= filter(b,a,sum_wave);
ft =abs( fft(y));
ft= ft(1:length(ft)/2+1);
f=(0:length(ft)-1)*fs/(2*length(ft));






subplot(2,1,1);
plot(t, sum_wave, 'g');
xlabel('Time');
ylabel('z(t)');
title('Sirjan Acharya');
grid on;
subplot(2,1,2);
plot(t, y, 'm');
xlabel('Time');
ylabel('y3(t)');
title('Sirjan Acharya');
grid on;



