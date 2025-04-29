
function eegperformance(Y1, Y2, subject_number)
    % Extract relevant data
    fp1_1 = Y1.val(13,:);
    fp1_2 = Y2.val(13,:);
    fs = 500; % Sampling frequency
    X = 250; % Step size

    % Combine the data
    combi = [fp1_1, fp1_2];



    % Calculate band powers for both datasets
    band_data = calculate_band_powers(combi, fs, X);


    % Plot the combined band data
    figure;
    band_names = {'Delta (0-4 Hz)', 'Alpha (4-8 Hz)', 'Theta (8-13 Hz)', 'Beta (13-30 Hz)', 'Gamma1 (31-60 Hz)', 'Gamma2 (60-90 Hz)', 'Gamma3 (90-120 Hz)'};
    for i = 1:7
        subplot(7, 1, i);
        plot(band_data(:, i));
        title([band_names{i}, ' for Subject ', num2str(subject_number)]);
        xlabel('Segments');
        ylabel('Power');
    end

    % Compare specific bands by plotting concatenated data
    figure;
    subplot(211);
    plot(band_data(:, 3));
    title(['Concatenated Theta Band Data for Subject ', num2str(subject_number)]);
    xlabel('Segments');
    ylabel('Power');

    subplot(212);
    plot(band_data(:, 5));
    title(['Concatenated Gamma Band Data for Subject ', num2str(subject_number)]);
    xlabel('Segments');
    ylabel('Power');
end

function band_data = calculate_band_powers(fp1, fs, X)
    % Determine the number of segments
    num_segments = floor((length(fp1) - fs) / X) + 1;

    % Preallocate band data array
    band_data = zeros(num_segments, 7);

    for k = 1:num_segments
        start_idx = (k - 1) * X + 1;
        end_idx = start_idx + fs - 1;
        fp1_segment = fp1(start_idx:end_idx);

        fft_val_1s = abs(fft(fp1_segment));
        fft_val = fft_val_1s(2:fs/2+1);

        delta_4Hz = sum(fft_val(1:4).^2 / 4);
        alpha4_8Hz = sum(fft_val(5:8).^2 / 4);
        theta8_13Hz = sum(fft_val(9:13).^2 / 5);
        beta13_30Hz = sum(fft_val(14:30).^2 / 17);
        gamma31_60Hz = sum(fft_val(31:60).^2 / 30);
        gamma60_90Hz = sum(fft_val(61:90).^2 / 30);
        gamma90_120Hz = sum(fft_val(91:120).^2 / 30);

        band_data(k, :) = [delta_4Hz, alpha4_8Hz, theta8_13Hz, beta13_30Hz, gamma31_60Hz, gamma60_90Hz, gamma90_120Hz];
    end
end


