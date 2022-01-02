function peak_locs = DetectStafflines(binarized_image)
    %{
      DETECT_STAFFLINES Gets the locations of the stave_lines.
        
        @Author Nada Anies
        @Copyright 12-2021 The KAN, Org.
    %}
    
    %% Filtering peaks for stave lines
    % This piece of code was extracted from Professor Andy Zeng OMR Report, 
    % but it is edited in order to identify more accurately the stave lines.
    scan_line = mean(binarized_image, 2);
    scan_peak_thresh = mean(scan_line) + 3/2 * std(scan_line);
    scan_filtered = (scan_line > scan_peak_thresh);
    [peak_val, peak_locs] = findpeaks(double(scan_filtered));
    
    %% Visualizing the stave lines
    global display_figures
    if (display_figures)
        figure_display('DETECTION', binarized_image, char("Detected Staff Lines"));
        hold on;
        for i=1 : size(peak_val)
           plot([1; size(binarized_image, 2)], [peak_locs(i); peak_locs(i)], 'r');
        end
        hold off;
    end
end