function recognizedScore = ProcessStaves(binarized_image)
    %{
      PROCESS_STAVES Applying Pre-processing on the binarized image.
        Starts by removing unwanted margins, and splitting image into 
        a number of equal sections, then begins to detect Staff Lines, 
        Clef, Time Signature, Bar Lines, Stem Notes, Semibreve Notes, 
        Quarter Notes and Half Notes. 
        
        After Recognizing all of the above, it returns 'recognizedScore'
        a 2D matrix containing all the score sheet info ready to generate
        the proper audio file.
        
        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %% Normalizing Image
    
    % Removing small Margins from right and left sides
    binarized_image = RemoveMargins(binarized_image);
    
    % Getting the locations of the horizontal stave lines
    stafflines_locs = DetectStafflines(binarized_image);
    
    %% Processing
    global display_figures stave
    stave_section_space = round((stafflines_locs(6)-stafflines_locs(5))/3);
    staffline = 1;
    recognizedScore = {};
    
    for stave = 1 : size(stafflines_locs, 1)/5  % foreach section
        stave_section = binarized_image(stafflines_locs(staffline) ...
                      - stave_section_space : stafflines_locs(5*stave) ...
                      + stave_section_space, 1:size(binarized_image,2));
                  
        staffline = staffline + 5;
        
        % Checking wheather this section contains notes or not.
        if ~ContainsNotes(stave_section)
            continue;
        end
       
        % Displaying current section before any pre-process.
        if (display_figures)
            figure_display('VISUALIZATION', stave_section, char("Stave Section #" + stave));
        end
        
        % Detecting and Removing staff lines.
        [stave_section, section_stafflines_locs] = HandleStafflines(stave_section);
        
        % Applying Morphological closing.
        stave_section = apply_morphological(stave_section, 'close', 'disk', 1);
        
        % Detecting and Removing clef.
        stave_section = HandleClef(stave_section);
        
        % Detecting and Removing the time signature (it exists only in the first stave).
        if (stave == 1 || stave == 2)
            [stave_section, time_sig] = HandleTimeSignature(stave_section);
            if size(time_sig) ~= 0
                rec_time_sig = time_sig;
            end
        end
        
        % Detecting and Removing bar lines.
        [stave_section, dis_btw_2_stv_lines] = HandleBarLines(stave_section);
        
        % Detecting and Removing notes' stems.
        [stave_section] = HandleStems(stave_section, dis_btw_2_stv_lines);
        
        % Recognizing Semibreve note
        [stave_section, rec_semibreve] = RemoveSemibreve(stave_section, section_stafflines_locs);
        % figure, imshow(stave_section); title("After Semibreve Removal");
        
        % Recognizing Filled head note
        [stave_section, rec_fillednote] = RemoveFilledNotehead(stave_section, section_stafflines_locs);
         %figure, imshow(stave_section); title("After Quarter note Removal");
         
        % Recognizing Minims
        [stave_section, rec_headsminim] = RemoveHeadsminim(stave_section, section_stafflines_locs);
        % figure, imshow(stave_section); title("After Half note Removal");
        
        % Storing all the notes and their information
        recognizedScore = StoreNotesInfo(recognizedScore, stave, ...
                                        rec_semibreve, rec_fillednote, rec_headsminim);
    end
end