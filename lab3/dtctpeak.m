% Define own peak detection algorithm
function [peaks, peak_locs] = detect_peaks(signal, threshold)
    peaks = [];
    peak_locs = [];
    N = length(signal);
    
    % Find peaks
    for i = 2:N-1
        if signal(i) > signal(i-1) && signal(i) > signal(i+1) && signal(i) > threshold
            peaks = [peaks signal(i)];
            peak_locs = [peak_locs i];
        end
    end
end

% Sample ECG signal 
ecg_signal = load('ecg_signal.mat'); % Load  ECG signal data
ecg_data = ecg_signal.ecg_data; % Assuming ecg_data is your ECG signal

% Set threshold (adjust as needed)
threshold = 0.6 * max(ecg_data); % Set threshold as a percentage of max amplitude

% Detect peaks using your custom algorithm
[detected_peaks, detected_peak_locs] = detect_peaks(ecg_data, threshold);

% Plotting
figure;
plot(ecg_data); hold on;
plot(detected_peak_locs, detected_peaks, 'ro'); % Plot detected peaks
legend('ECG Signal', 'Detected Peaks');
xlabel('Sample Number');
ylabel('Amplitude');
title('ECG Signal with Detected Peaks');
