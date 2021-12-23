function ProcessStaves(image_without_stafflines, stave_locs)
    %% Normalize Image
    for i=1 : size(image_without_stafflines, 1)
        for j=1 : 15
            image_without_stafflines(i, j) = 0;
            image_without_stafflines(i, size(image_without_stafflines, 2) - j + 1) = 0;
        end
    end
    
    %% Process
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
        stave_section = RemoveClef(stave_section);
        % figure, imshow(stave_section); title("After Clef Deletion");
        
        % Fast-Fourier Transformation for the time signature (it is executed only in the first stave)
        if (stave == 1)
            [stave_section, rec_time_sig] = RemoveTimeSignature(stave_section);
            % figure, imshow(stave_section); title("After Time Signature Removal");
        end
        
        % Finding the bar positions
        [stave_section, stave_height] = RemoveBarLines(stave_section);
        
        % Finding the stems from the vertical projection and deleting them
        [stave_section, res2, res3] = RemoveStems(stave_section, stave_height);
        
        % Removing dotted noise
        % stave_section = RemoveDottedNotes(stave_section);
        % break;
    end
    
end