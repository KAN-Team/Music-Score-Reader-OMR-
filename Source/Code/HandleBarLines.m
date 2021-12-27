function [result1, result2] = HandleBarLines(stave_section)
    %{
      HANDLE_BARLINES Detects and Removes musical bar lines.
        Detection is applied using Vertical Projection Profile.

        It returns the binarized image without the bar lines and
        the distance between any two consecutive staff lines 
        in the same section. 

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %% Finding the bar positions
    global display_figures stave
    vertical_projection = sum(stave_section, 1);
    if display_figures
        figure('name', 'VISUALIZATION');
        bar(vertical_projection); 
        title(char("Stave Section #" + stave + " : Vertical Projection of the Stave WITH the Bar Lines"))
    end
    
    if size(stave_section, 2) < 600 % image width must be suitable
        dis_btw_2_stv_lines = vertical_projection(find(vertical_projection, 1, 'last'));
        bar_pos = find(vertical_projection==dis_btw_2_stv_lines);
        % Excluding the bars from the vertical projection
        vertical_projection(vertical_projection==dis_btw_2_stv_lines) = 0;
    else
        dis_btw_2_stv_lines = vertical_projection(find(vertical_projection, 1, 'last'));
        bar_pos = find(vertical_projection>dis_btw_2_stv_lines-2);
        % Excluding the bars from the vertical projection
        vertical_projection(vertical_projection>dis_btw_2_stv_lines-2) = 0;
    end
    
    %% Plotting the vertical projection without the bar lines
    if (display_figures)
        figure('name', 'VISUALIZATION');
        bar(vertical_projection);
        title(char("Stave Section #" + stave + " : Vertical Projection of the Stave WITHOUT the Bar Lines"))
    end

    %% Removing Bar Lines from the Stave Section
    for i=1 : size(bar_pos,2)
        stave_section(:, bar_pos(i)) = 0;
    end
    
    result1 = stave_section;
    result2 = dis_btw_2_stv_lines;
    %% Visualizing the stave without the bar lines
    if (display_figures)
        figure_display('REMOVAL', stave_section, char("Stave Section #" + stave + " : After Barlines Removal"));
    end
end