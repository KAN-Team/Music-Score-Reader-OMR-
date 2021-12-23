function [result1, result2, result3] = RemoveStems(stave_section, stave_height)
    % @Author: Kareem Sherif / KAN Org...

    %% Finding the stems from the vertical projection
    % figure, imshow(stave_section); title("BEFORE");
    scan_line = sum(stave_section, 1);
    scan_filtered = (scan_line > stave_height * 1/3);
    [stem_peak_idx, stem_peak_locs, stem_peak_width] = findpeaks(double(scan_filtered));
    
    displayFigures = 0;
    if (displayFigures == 1)
        figure('name', 'Vertical Projection of the stems');
        fill(1 : size(stave_section,2), sum(stave_section,1), 'k');
        hold on;
        for i=1 : size(stem_peak_locs,2)
            plot([stem_peak_locs(i); stem_peak_locs(i)], [0;100], 'r');
        end
        hold off;
    end
    clear i scan_line scan_filtered;

    %% Deleting the stem pixels from the cropped stave
    for i=1:size(stem_peak_locs,2)
        for j=1: size(stave_section,1)
            if stave_section(j,stem_peak_locs(i)-3)==0 && stave_section(j,stem_peak_locs(i)+3)==0
                stave_section(j,stem_peak_locs(i)-2)=0;
                stave_section(j,stem_peak_locs(i)-1)=0;
                stave_section(j,stem_peak_locs(i))=0;
                stave_section(j,stem_peak_locs(i)+1)=0;
                stave_section(j,stem_peak_locs(i)+2)=0;
                stave_section(j,stem_peak_locs(i)+3)=0;
            end
        end
    end

    clear i j;
    result1 = stave_section;
    result2 = stem_peak_idx;
    result3 = stem_peak_width;
    % figure, imshow(stave_section); title("AFTER");
end