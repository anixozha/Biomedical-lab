close all;
clear all;
clc;

% Load the data
load('chb01_03_edfm.mat');
x = val(1,:);
fs = 256;  % Sampling frequency
window_size = fs;  % Window size of 1 second
window_shift = fs / 2;  % Shift of 0.5 seconds
num_windows = floor((length(x) - window_size) / window_shift) + 1;

% Annotation range for seizure (sample indices)
start_n = 766976;
end_n = 777216;

% Initialize band data and seizure detection results
band_data = zeros(num_windows, 7);
seizure_flags = zeros(num_windows, 1);
k = 1;

% Threshold for seizure detection (adjust based on dataset)
beta_threshold = 0.5;  % Placeholder threshold, to be refined based on data analysis

% Create figure for real-time plotting
figure;
band_plot = subplot(8, 1, 1:7);
hold on;
band_lines = gobjects(7, 1);
colors = lines(7);
for i = 1:7
    band_lines(i) = plot(nan(1, num_windows), 'Color', colors(i, :));  % Band power plot handles
end
title('Band Powers');
legend('Delta', 'Alpha', 'Theta', 'Beta', 'Gamma 31-60Hz', 'Gamma 60-90Hz', 'Gamma 90-120Hz');

seizure_plot = subplot(8, 1, 8);
seizure_line = plot(nan(1, num_windows));  % Seizure detection plot handle
title('Seizure Detection');
xlabel('Time (s)');
ylabel('Seizure Detected (1: Yes, 0: No)');
ylim([-0.1 1.1]);

% Real-time simulation loop
for i = 0:num_windows-1
    % Simulate real-time data chunk
    start_idx = i * window_shift + 1;
    end_idx = start_idx + window_size - 1;
    if end_idx > length(x)
        break;
    end
    fp1_fp7_1s = x(start_idx:end_idx);
    
    % Compute FFT and band powers
    fft_val_1s = abs(fft(fp1_fp7_1s));
    fft_val = fft_val_1s(2:fs/2 + 1);
    delta_4Hz = sum(fft_val(1:4).^2 / 4);
    alpha4_8Hz = sum(fft_val(5:8).^2 / 4);
    theta8_13Hz = sum(fft_val(9:13).^2 / 5);
    beta13_30Hz = sum(fft_val(14:30).^2 / 17);
    gamma31_60Hz = sum(fft_val(31:60).^2 / 30);
    gamma60_90Hz = sum(fft_val(61:90).^2 / 30);
    gamma90_120Hz = sum(fft_val(91:120).^2 / 30);
    band_data(k, :) = [delta_4Hz, alpha4_8Hz, theta8_13Hz, beta13_30Hz, gamma31_60Hz, gamma60_90Hz, gamma90_120Hz];
    
    % Seizure detection logic
    sample_position = start_idx;
    if beta13_30Hz > beta_threshold && sample_position >= start_n && sample_position <= end_n
        seizure_flags(k) = 1;
    else
        seizure_flags(k) = 0;
    end
    
    % Update plots
    for j = 1:7
        set(band_lines(j), 'YData', band_data(1:k, j)');
    end
    set(seizure_line, 'YData', seizure_flags(1:k));
    drawnow;
    
    k = k + 1;
    pause(0.01);  % Simulate real-time processing delay (adjust as needed)
end

% Apply moving average filter to smooth the detection signal
seizure_flags = movmean(seizure_flags, 5);  % Adjust window size as needed
seizure_flags(seizure_flags > 0) = 1;  % Binarize the signal again
set(seizure_line, 'YData', seizure_flags);
drawnow;
