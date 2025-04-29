clear all;
close all;
load mit200;

% Define filter parameters
fs = 360; % Sampling frequency
fc_low = 12; % Cutoff frequency for low-pass filter (in Hz)
fc_high = 14; % Cutoff frequency for high-pass filter (in Hz)
order = 4; % Filter order for Butterworth filters

% Low-pass filtering
[b_lowpass, a_lowpass] = butter(order, fc_low / (fs / 2), 'low');
filtered_signal_lowpass = filtfilt(b_lowpass, a_lowpass, ecgsig);

% High-pass filtering
[b_highpass, a_highpass] = butter(order, fc_high / (fs / 2), 'high');
filtered_signal_highpass = filtfilt(b_highpass, a_highpass, filtered_signal_lowpass);

% Moving average filter (low pass with lower order Butterworth filter)
fc_ma = 5; % Cutoff frequency for moving average filter (in Hz)
[b_ma, a_ma] = butter(1, fc_ma / (fs / 2), 'low');
filtered_signal_ma = filtfilt(b_ma, a_ma, abs(filtered_signal_highpass));

% Set parameters for peak detection
min_peak_height = max(filtered_signal_ma)*0.6;
min_peak_distance = 0.2 * fs;

% Find R peaks using the detect_peaks function
[peaks, locs_R] = detect_peak(filtered_signal_ma, min_peak_height, min_peak_distance);

% Plot signals and detected R peaks
figure;
subplot(2,1,1);
plot(tm, ecgsig, 'b');
% hold on;
% plot(tm, filtered_signal_highpass, 'g');
% xlabel('Time (s)');
% ylabel('Amplitude');
% title('ECG Signal with Low-Pass (12 Hz) and High-Pass (14 Hz) Filtering');
% legend('Original ECG', 'Filtered Signal');
% grid on;
% hold off;
% 
% % Plot signals and detected R peaks
% subplot(2,1,2);
% plot(tm, abs(filtered_signal_ma), 'm');
% hold on;
% plot(tm(locs_R), peaks, 'ro', 'MarkerSize', 5);
% xlabel('Time (s)');
% ylabel('Amplitude');
% title('Moving Average Filtered Signal with R Peak Detection');
% legend('Filtered Signal', 'Detected R Peaks');
% grid on;
% hold off;
% 
% % Set x-axis limits to span the entire signal duration
% xlim([0, tm(end)]);
% 
% % Calculate time intervals between successive R peaks
% RR_intervals = diff(locs_R) / fs;
% 
% % Convert time intervals to seconds
% RR_intervals_sec = RR_intervals;
% 
% % Calculate average RR interval
% mean_RR_interval = mean(RR_intervals_sec);
% 
% % Convert average RR interval to beats per minute (BPM)
% heart_rate = 60 / mean_RR_interval;
% 
% disp(['Heart Rate: ', num2str(heart_rate), ' BPM']);
