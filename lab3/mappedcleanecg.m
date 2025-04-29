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
threshold = 0.5;
[maxima, maxima_locs] = detect_peaks(cleanECG, threshold);

subplot(313);
plot(timecleanECG, cleanECG);
hold on;
plot(timecleanECG(maxima_locs), maxima, 'r*');
hold off;
% Define custom peak detection function
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
