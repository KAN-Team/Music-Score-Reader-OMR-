function [binarized_img_withoutlines, stafflines_locs] = HandleStafflines(stave_section)
    %{
      HANDLE_STAFFLINES Detects and Removes musical staff lines.
        Detection is applied using Horizontal Projection Profile.
        
        It returns the binarized image without the staff lines and
        the staff lines locations in the specified section. 

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %% Filter peaks for stave lines
    stafflines_locs = DetectStafflines(stave_section);
    
    %% Removing the stave lines
    % Drawing black lines with a specific line width could not work eficiently.
    % So, I change the binary value of the appropriate pixels of the bw image.
    binarized_img_withoutlines = stave_section;
    for i=1 : size(stafflines_locs)
        for j=1 : size(stave_section, 2)
            if(stave_section(stafflines_locs(i) - 2, j) ~= 1)
                binarized_img_withoutlines(stafflines_locs(i) - 1, j) = 0;
                binarized_img_withoutlines(stafflines_locs(i), j) = 0;
            end
            if(stave_section(stafflines_locs(i) + 2, j) ~= 1)
                binarized_img_withoutlines(stafflines_locs(i), j) = 0;
                binarized_img_withoutlines(stafflines_locs(i)+1, j) = 0;
            end
        end
    end
    
    %% Visualizing
    global display_figures stave
    if (display_figures)
        figure_display('REMOVAL', binarized_img_withoutlines, char("Stave Section #" + stave + " : After Stafflines Removal"));
    end
end