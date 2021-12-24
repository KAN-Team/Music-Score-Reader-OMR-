function ProcessStaves(binarized_image)
    %% Normalize Image
    for i=1 : size(binarized_image, 1)
        for j=1 : 15
            binarized_image(i, j) = 0;
            binarized_image(i, size(binarized_image, 2) - j + 1) = 0;
        end
    end
    
    stave_locs = DetectStafflines(binarized_image);
    
    %% Process
    stave_sections_distance = round((stave_locs(6)-stave_locs(5))/3);
    line = 1;
    displayFigures = 0;
    
    for stave = 1 : size(stave_locs, 1)/5
        stave_section = binarized_image(stave_locs(line) ...
                      - stave_sections_distance : stave_locs(5*stave) ...
                      + stave_sections_distance, 1:size(binarized_image,2));
                  
        line = line + 5;
        
        if ~ContainsNotes(stave_section)
            continue;
        end
       
        if (displayFigures == 1)
            title_ = "Stave Section #" + stave;
            figure('name', char(title_));
            imshow(stave_section, 'InitialMagnification', 'fit');
        end
        
        % Removing horizontal stave lines
        [stave_section, stave_section_locs] = RemoveStafflines(stave_section);
        
        % Closing Image
        stave_section = perform_morphological(stave_section, 'close', 'disk', 1);
        % figure, imshow(stave_section), title("After Closing Morph");
        
        % figure, imshow(stave_section); title("Before Clef Deletion");
        stave_section = RemoveClef(stave_section);
        % figure, imshow(stave_section); title("After Clef Deletion");
        
        % Fast-Fourier Transformation for the time signature (it is executed only in the first stave)
        if (stave == 1 || stave == 2)
            [stave_section, time_sig] = RemoveTimeSignature(stave_section);
            if size(time_sig) ~= 0
                rec_time_sig = time_sig;
            end
            % figure, imshow(stave_section); title("After Time Signature Removal");
        end
        
        % Finding the bar positions
        % figure, imshow(stave_section); title("Before Barlines Removal");
        [stave_section, stave_height] = RemoveBarLines(stave_section);
        % figure, imshow(stave_section); title("After Barlines Removal");
        
        % Finding the stems from the vertical projection and deleting them
        % figure, imshow(stave_section); title("Before Stems Removal");
        [stave_section, res2, res3] = RemoveStems(stave_section, stave_height);
        % figure, imshow(stave_section); title("After Stems Removal");
        
        % Recognizing Semibreve note
        [stave_section, rec_semibreve] = RemoveSemibreve(stave_section, stave_section_locs);
        
        % Recognizing Filled head note
        [stave_section, rec_fillednote] = RemoveFilledNotehead(stave_section, stave_section_locs);
        
        % Recognizing Minims
        [stave_section, rec_headsminim] = RemoveHeadsminim(stave_section, stave_section_locs);
        
%         break;
    end
    
end