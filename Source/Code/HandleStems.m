function [result1, result2, result3] = HandleStems(stave_section, dis_btw_2_stv_lines)
    %{
      HANDLE_STEMS Detects and Removes musical notes' stem.
        Detection is applied using Vertical Projection Profile.

        It returns the binarized image without the bar lines and
        the distance between any two consecutive staff lines 
        in the same section. 

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %% Finding the stems from the vertical projection
    scan_line = sum(stave_section, 1);
    scan_filtered = (scan_line > dis_btw_2_stv_lines * 1/3);
    [stem_peak_vals, stem_peak_locs, stem_peak_width] = findpeaks(double(scan_filtered));
    
    global display_figures stave
    if (display_figures)
        figure('name', 'VISUALIZATION');
        fill(1 : size(stave_section,2), sum(stave_section,1), 'k');
        title(char("Stave Section #" + stave + " : Vertical Projection of the Stems"));
        hold on;
        for i=1 : size(stem_peak_locs,2)
            plot([stem_peak_locs(i); stem_peak_locs(i)], [0;100], 'r');
        end
        hold off;
    end

    %% Removing the stem pixels from the stave section
    for i=1:size(stem_peak_locs,2)
        for j=1: size(stave_section,1)
            if stave_section(j,stem_peak_locs(i)-3) == 0 && stave_section(j,stem_peak_locs(i)+3) == 0
                stave_section(j,stem_peak_locs(i)-2) = 0;
                stave_section(j,stem_peak_locs(i)-1) = 0;
                stave_section(j,stem_peak_locs(i)) = 0;
                stave_section(j,stem_peak_locs(i)+1) = 0;
                stave_section(j,stem_peak_locs(i)+2) = 0;
                stave_section(j,stem_peak_locs(i)+3) = 0;
            end
        end
    end

    result1 = stave_section;
    result2 = stem_peak_vals;
    result3 = stem_peak_width;
    
    %% Visualization
    if (display_figures)
        figure_display('VISUALIZATION', stave_section, char("Stave Section #" + stave + " : After Stems Removal"));
    end
end