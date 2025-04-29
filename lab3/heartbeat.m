clear all;
close all;
load mit200;
subplot(311);
plot(ecgsig);
cleanECG=ecgsig(3640:6197);
timecleanECG=tm(3640:6197);
xlabel('time');
ylabel('amplitude');

[maxima, maxima_locs]= findpeaks(cleanECG);

threshold= 0.4*max(maxima);
potential_r_peak=maxima_locs(maxima>threshold);
refined_r_peaks =[];
for i=1:length(potential_r_peak)
    refined_r_peaks=[refined_r_peaks;
        potential_r_peak(i)];
end
subplot(312);
plot(cleanECG);
hold on
plot(refined_r_peaks, cleanECG(refined_r_peaks), 'b*');

hold off
xlabel('time');
ylabel('amplitude');
title('anish ojha CleanECG with R-peak')

% Calculate time intervals between successive R-peaks
RR_intervals = diff(refined_r_peaks);

% Convert time intervals to seconds
fs = 360; % Sampling frequency (Hz)
RR_intervals_seconds = RR_intervals / fs;

% Calculate the average RR interval
avg_RR_interval = mean(RR_intervals_seconds);

% Calculate heart rate in beats per minute (BPM)
heart_rate_BPM = 60 / avg_RR_interval;

disp(['Heart rate: ', num2str(heart_rate_BPM), ' BPM']);
