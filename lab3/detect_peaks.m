function [peaks, peak_locs] = detect_peaks(signal)
    peaks = [];
    peak_locs = [];
    N = length(signal);

    % Find peaks
    for i = 2:N-1
        if signal(i) > signal(i-1) && signal(i) > signal(i+1)
            peaks = [peaks signal(i)];
            peak_locs = [peak_locs i];
        end
    end
end