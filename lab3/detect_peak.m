function [peaks, peak_locs] = detect_peak(signal, min_peak_height, min_peak_distance)
    peaks = [];
    peak_locs = [];
    N = length(signal);

    % Find peaks
    for i = 2:N-1
        if signal(i) > signal(i-1) && signal(i) > signal(i+1) && signal(i) >= min_peak_height
            % Check minimum peak distance
            if isempty(peak_locs) || i - peak_locs(end) >= min_peak_distance
                peaks = [peaks signal(i)];
                peak_locs = [peak_locs i];
            end
        end
    end
end
