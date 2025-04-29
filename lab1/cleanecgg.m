clear all;
close all;
load mit200;
subplot(311);
plot(ecgsig);
cleanECG=ecgsig(3640:6197);
timecleanECG=tm(3640:6197);
subplot(312);
plot(cleanECG)
[maxima, maxima_locs]= findpeaks(cleanECG);

threshold= 0.5;
potential_r_peak=maxima_locs(maxima>threshold);
refined_r_peaks =[];
for i=1:length(potential_r_peak)
    refined_r_peaks=[refined_r_peaks;
        potential_r_peak(i)];
end
subplot(313);
plot(refined_r_peaks, ecgsig(refined_r_peaks), 'b*');

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

% Define the original range of cleanECG
cleanECG_range = [1, length(cleanECG)];

% Define the new range of ecgsig
ecgsig_range = [3640, 6197];

% Map the values of cleanECG to match the range of ecgsig using linear interpolation
mapped_cleanECG = interp1(cleanECG_range, ecgsig_range, 1:length(cleanECG));

% Plot the original and mapped cleanECG and ecgsig
subplot(311);
plot(ecgsig);
hold on;
plot(ecgsig_range(1):ecgsig_range(2), mapped_cleanECG, 'r--');
hold off;
legend('ecgsig', 'mapped cleanECG');

% Plot the R-peaks on the mapped cleanECG
subplot(313);
plot(refined_r_peaks, mapped_cleanECG(round(refined_r_peaks)), 'b*');
