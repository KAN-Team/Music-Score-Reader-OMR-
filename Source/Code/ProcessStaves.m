function ProcessStaves(image_without_stafflines, stave_locs)

    stave_sections_distance = round((stave_locs(6)-stave_locs(5))/3);
    line = 1;
    displayFigures = 0;
    
    for stave = 1 : size(stave_locs, 1)/5
        stave_section = image_without_stafflines(stave_locs(line)-stave_sections_distance:stave_locs(5*stave)+stave_sections_distance, 1:size(image_without_stafflines,2));
        line = line + 5;
    
        if (displayFigures == 1)
            title_ = "Stave Section #" + stave;
            figure('name', char(title_));
            imshow(stave_section, 'InitialMagnification', 'fit');
        end
        
        % figure, imshow(stave_section); title("Before Clef Deletion");
        RemoveClef(stave_section);
        
        
    end
    
end