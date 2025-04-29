close all;
clear all;
clc;

load('chb01_03_edfm.mat');
x = val(1,:);
start_n = 766976;
end_n = 777216;
fs = 256;
band_data = zeros(7001, 7);
window_size = fs;
window_shift = fs / 2;
k = 1;
X = 128;

% Compute band powers
for i = 0:7000
    fp1_fp7_1s = x(i*X + 1 : i*X + fs);
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
    k = k + 1;
end

% Plot band powers
figure;
for i = 1:7
    subplot(7, 1, i);
    plot(band_data(:, i));
    title(['Band Power ' num2str(i)]);
end

% Function to detect seizures


% Set a threshold for seizure detection
beta_threshold = 0.5 * max(band_data(:, 4)); % Example threshold, adjust as needed
seizure_flags = detect_seizures(band_data, beta_threshold, start_n, end_n, fs, window_shift);

% Plot seizure detection
figure;
plot(seizure_flags);
title('Seizure Detection');
xlabel('Time');
ylabel('Seizure Detected (1: Yes, 0: No)');
function seizures = detect_seizures(band_data, threshold, start_sample, end_sample, fs, window_shift)
    num_windows = size(band_data, 1);
    seizures = zeros(num_windows, 1);
    for i = 1:num_windows
        if band_data(i, 4) > threshold % Using beta band power as a marker
            sample_position = (i - 1) * window_shift + fs;
            if sample_position >= start_sample && sample_position <= end_sample
                seizures(i) = 1;
            end
        end
    end
    
    % Apply a moving average filter to smooth the detection signal
    window_size = 5; % Adjust window size as needed
    seizures = movmean(seizures, window_size);
    seizures(seizures > 0) = 1; % Binarize the signal again
end
