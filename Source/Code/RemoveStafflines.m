function [result, stave_locs] = RemoveStafflines(stave_section)
    %% Filter peaks for stave lines
    stave_locs = DetectStafflines(stave_section);
    
    %% Removing the stave lines;
    % Drawing white lines with a specific line width could not work eficiently.
    % So, I change the binary value of the appropriate pixels of the bw image.
    binarized_img_withoutlines = stave_section;
    for i=1 : size(stave_locs)
        for j=1 : size(stave_section, 2)
            if(stave_section(stave_locs(i) - 2, j) ~= 1)
                binarized_img_withoutlines(stave_locs(i) - 1, j) = 0;
                binarized_img_withoutlines(stave_locs(i), j) = 0;
            end
            if(stave_section(stave_locs(i) + 2, j) ~= 1)
                binarized_img_withoutlines(stave_locs(i), j) = 0;
                binarized_img_withoutlines(stave_locs(i)+1, j) = 0;
            end
        end
    end

    clear i j tmp;
    displayFigures = 0;
    if (displayFigures == 1)
        figure('name', 'After Stafflines Removal');
        imshow(binarized_img_withoutlines);
    end
    result = binarized_img_withoutlines;
end