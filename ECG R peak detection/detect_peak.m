function [peaks, peak_locs] = detect_peak(signal, varargin)
    % Default values
    defaultMinPeakHeight = 0;
    defaultMinPeakDistance = 1;
    
    % Parse optional input arguments
    parser = inputParser;
    addOptional(parser, 'MinPeakHeight', defaultMinPeakHeight);
    addOptional(parser, 'MinPeakDistance', defaultMinPeakDistance);
    parse(parser, varargin{:});
    
    % Extract values
    min_peak_height = parser.Results.MinPeakHeight;
    min_peak_distance = parser.Results.MinPeakDistance;
    
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
