function [result, stave_locs] = RemoveStafflines(binarized_imgage)
    %% Filter peaks for stave lines
    % This piece of code was used from Andy Zeng, but it is edited in order to
    % identify more accurately the stave lines.
    scan_line = mean(binarized_imgage, 2);
    scan_peak_thresh = mean(scan_line) + 3/2 * std(scan_line);
    scan_filtered = (scan_line > scan_peak_thresh);
    [stave_idx, stave_locs] = findpeaks(double(scan_filtered));
    clear scan_line scan_peak_thresh scan_filtered;
    
    %% Visualizing the stave lines
    displayFigures = 0;
    if (displayFigures == 1)
        figure('name', 'Visualizing the stave lines');
        imshow((binarized_imgage), 'InitialMagnification','fit');
        hold on;
        for i=1 : size(stave_idx)
           plot([1; size(binarized_imgage, 2)], [stave_locs(i); stave_locs(i)], 'r');
        end
        clear i;
        hold off;
    end
    
    %% Removing the stave lines;
    % Drawing white lines with a specific line width could not work eficiently.
    % So, I change the binary value of the appropriate pixels of the bw image.
    binarized_img_withoutlines = binarized_imgage;
    for i=1 : size(stave_locs)
        for j=1 : size(binarized_imgage, 2)
            if(binarized_imgage(stave_locs(i) - 2, j) ~= 1)
                binarized_img_withoutlines(stave_locs(i) - 1, j) = 0;
                binarized_img_withoutlines(stave_locs(i), j) = 0;
            end
            if(binarized_imgage(stave_locs(i) + 2, j) ~= 1)
                binarized_img_withoutlines(stave_locs(i), j) = 0;
                binarized_img_withoutlines(stave_locs(i)+1, j) = 0;
            end
        end
    end

    clear i j tmp;
    
    if (displayFigures == 1)
        figure('name', 'After Stafflines Removal');
        imshow(binarized_img_withoutlines);
    end
    result = binarized_img_withoutlines;
end