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

% Initialize seizure detection results
seizure_flags = zeros(num_windows, 1);
k = 1;

% Threshold for seizure detection (adjust based on dataset)
beta_threshold = 0.5;  % Placeholder threshold, to be refined based on data analysis

% Create figure for real-time plotting
figure;
eeg_plot = subplot(2, 1, 1);
eeg_line = plot(nan(1, window_size));  % EEG signal plot handle
title('EEG Signal');
xlabel('Time (s)');
ylabel('Amplitude');

seizure_plot = subplot(2, 1, 2);
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
    eeg_chunk = x(start_idx:end_idx);
    
    % Update EEG plot
    set(eeg_line, 'YData', eeg_chunk);
    set(eeg_line, 'XData', (start_idx:end_idx) / fs);
    drawnow;
    
    % Seizure detection logic
    sample_position = start_idx;
    if any(eeg_chunk > beta_threshold) && sample_position >= start_n && sample_position <= end_n
        seizure_flags(k) = 1;
    else
        seizure_flags(k) = 0;
    end
    
    % Update seizure detection plot
    set(seizure_line, 'YData', seizure_flags(1:k));
    set(seizure_line, 'XData', (1:k) * window_shift / fs);
    drawnow;
    
    k = k + 1;
    pause(0.01);  % Simulate real-time processing delay (adjust as needed)
end

% Apply moving average filter to smooth the detection signal
seizure_flags = movmean(seizure_flags, 5);  % Adjust window size as needed
seizure_flags(seizure_flags > 0) = 1;  % Binarize the signal again
set(seizure_line, 'YData', seizure_flags);
drawnow;
