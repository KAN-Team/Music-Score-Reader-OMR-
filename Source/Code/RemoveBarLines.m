function [result1, result2] = RemoveBarLines(stave_section)
% @Author: Kareem Sherif / KAN Org...

    %% Finding the bar positions
    vertical_projection = sum(stave_section, 1);
    % figure('name', 'Vertical Projection of the stave with the bar lines');
    % bar(vertical_projection);
    stave_height = vertical_projection(find(vertical_projection, 1, 'last'));
    bar_pos = find(vertical_projection>stave_height-2);

    % Excluding the bars from the vertical projection
    vertical_projection(vertical_projection>stave_height-2) = 0;

    %% Plotting the vertical projection without the bar lines
    displayFigures = 0;
    if (displayFigures == 1)
        figure('name', 'Vertical Projection of the stave without the bar lines');
        bar(vertical_projection);
    end

    %% Visualise the stave without the bar lines
    for i=1 : size(bar_pos,2)
        stave_section(:, bar_pos(i)) = 0;
    end
    clear i myVerticalProjection;
    displayFigures = 0;
    if (displayFigures == 1)
        figure('name', 'The cropped stave without the bar lines');
        imshow(stave_section, 'InitialMagnification', 'fit');
    end
    result1 = stave_section;
    result2 = stave_height;
end