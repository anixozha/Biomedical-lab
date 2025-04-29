clear all;
close all;


load mit200;
subplot(311);
plot(ecgsig);

% Clean ECG signal
cleanECG=ecgsig(3640:6197);
timecleanECG=tm(3640:6197);

subplot(312);
plot(cleanECG);

% Use custom peak detection function

[maxima, maxima_locs] = detect_peaks(cleanECG);
threshold= 0.39*max(maxima);

potential_r_peak=maxima_locs(maxima>threshold);
refined_r_peaks =[];

for i=1:length(potential_r_peak)
    refined_r_peaks=[refined_r_peaks;
        potential_r_peak(i)];
end
RR_intervals= diff(maxima_locs);
fs = 360; % Sampling frequency (Hz)
RR_intervals_seconds = RR_intervals / fs;
avg_RR_interval = mean(RR_intervals_seconds);
heart_rate_BPM = 60 / avg_RR_interval;
disp(['Heart rate: ', num2str(heart_rate_BPM), ' BPM']);

subplot(313);
plot(timecleanECG, cleanECG);
hold on;
plot(timecleanECG(maxima_locs), maxima, 'r*');
hold off;

% Adjust x-axis limits
xlim([timecleanECG(1), timecleanECG(end)]);

% Define the custom peak detection function
% function [peaks, peak_locs] = detect_peaks(signal, threshold)
%     peaks = [];
%     peak_locs = [];
%     N = length(signal);
% 
%     % Find peaks
%     for i = 2:N-1
%         if signal(i) > signal(i-1) && signal(i) > signal(i+1) && signal(i) > threshold
%             peaks = [peaks signal(i)];
%             peak_locs = [peak_locs i];
%         end
%     end
% end

