function stave_locs = DetectStafflines(binarized_image)

    %% Filter peaks for stave lines
    % This piece of code was used from Andy Zeng, but it is edited in order to
    % identify more accurately the stave lines.
    scan_line = mean(binarized_image, 2);
    scan_peak_thresh = mean(scan_line) + 3/2 * std(scan_line);
    scan_filtered = (scan_line > scan_peak_thresh);
    [stave_idx, stave_locs] = findpeaks(double(scan_filtered));
    clear scan_line scan_peak_thresh scan_filtered;
    
    %% Visualizing the stave lines
    displayFigures = 0;
    if (displayFigures == 1)
        figure('name', 'Visualizing the stave lines');
        imshow((binarized_image), 'InitialMagnification','fit');
        hold on;
        for i=1 : size(stave_idx)
           plot([1; size(binarized_image, 2)], [stave_locs(i); stave_locs(i)], 'r');
        end
        clear i;
        hold off;
    end
end