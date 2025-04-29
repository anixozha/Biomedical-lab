% Define parameters
f = 10; % Frequency of the sine wave in Hertz
A = 1; % Amplitude of the sine wave
duration = 1; % Duration of the sine wave in seconds
fs = 1000; % Sampling rate in samples per second

% Generate time vector
t = linspace(0, duration, duration * fs);

% Generate sine wave
y = A * sin(2 * pi * f * t);

% Plot the sine wave
plot(t, y, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Anish Ojha');
grid on;
