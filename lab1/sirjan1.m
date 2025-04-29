% Define parameters
f1 = 10; % Frequency of the first sine wave in Hertz
f2 = 30; % Frequency of the second sine wave in Hertz
A = 1; % Amplitude of both sine waves
duration = 1; % Duration of the sine waves in seconds
fs = 400; % Sampling rate in samples per second

% Generate time vector
t = linspace(0, duration, duration * fs);

% Generate two sine waves
sine_wave1 = A * sin(2 * pi * f1 * t);
sine_wave2 = A * sin(2 * pi * f2 * t);

% Add the two sine waves
sum_wave = sine_wave1 + sine_wave2;

% Compute the Fourier transform of the summed wave
fourier_transform = fft(sum_wave);

% Plot the graphs in subplots
subplot(2,2,1);
plot(t, sine_wave1, 'b');
xlabel('Time ');
ylabel('Amplitude');
title('Sirjan acharya');
grid on;

subplot(2,2,2);
plot(t, sine_wave2, 'r');
xlabel('Time');
ylabel('Amplitude');
title('Sirjan acharya');
grid on;

subplot(2,2,3);
plot(t, sum_wave, 'g');
xlabel('Time ');
ylabel('Amplitude');
title('Sirjan acharya');
grid on;

subplot(2,2,4);
plot(abs(fourier_transform), 'm');
xlabel('Frequency');
ylabel('Magnitude');
title('sirjan acharya');
grid on;

