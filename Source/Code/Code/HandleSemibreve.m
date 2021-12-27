function [result, result2] = HandleSemibreve(stave_section, stafflines_locs)
    %{
      HANDLE_SEMIBREVE Detects, Recognizes and Removes musical semibreves.
        Semibreve is also known as a 'Whole Note'.
        
        It takes the stave_section image 
        and the section staff lines' locations.

        Detection is applied using FF-Transform.
        Recognition is applied using the ABC Musical notations,
        Which are the first 7 letters in the English Alphabet
        [A, B, C, D, E, F, G] that determines the pitch.
        There are 18 possible locations that may any note be at,
        By knowing the stafflines locations and the note location,
        using KNN search would provide the accurate location, from which 
        the specified Letter and then knowing the right pitch.

        It returns the binarized image without the semibreve notes
        and the recognized Semibreves object containing 5 cols,
        the first 2 are for the location, the third is for 
        the pitch interval, the fourth is the ABC notation, 
        the fifth is ones for predicting a whole note duration.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %% Fast-Fourier Transformation for the semibreve notes
    % figure, imshow(stave_section); title("BEFORE");
    semibreve_img = imread('Segments/Semibreve.tiff');
    % maxC = max(C(:))  % to determine threshold value...
    thresh = 58.9;        % a bit smaller than maxC...
    [detected_semibreve_note] = FFTransform(stave_section, semibreve_img, thresh, "Semibreve");
    
    semibreve_note_H_centred = detected_semibreve_note(:,1)-size(semibreve_img,1)/2-2;
    semibreve_note_W_centred = detected_semibreve_note(:,2)-size(semibreve_img,2)/2;
    detected_semibreve_note_centred = [semibreve_note_H_centred semibreve_note_W_centred];
    detected_semibreve_note_centred = floor(detected_semibreve_note_centred + 2);
    [~,idx] = unique(detected_semibreve_note_centred(:,2)); % no 2 notes can be on same level
    detected_semibreve_note_centred = detected_semibreve_note_centred(idx, :);
    
    %% Recognizing the identified semibreve notes
    notations = RecognizeNotes(detected_semibreve_note_centred, stafflines_locs, 1);
    
    recognizedSemibreveNotes = [num2cell(detected_semibreve_note_centred), notations];
    recognizedSemibreveNotes = [recognizedSemibreveNotes repmat({'1'}, size(recognizedSemibreveNotes,1),1)];
    recognizedSemibreveNotes(:, [1 2]) = recognizedSemibreveNotes(:,[2 1]);

    %% Removing the semibreve notes pixels from the stave section
    for i = 1 : size(detected_semibreve_note, 1) % foreach semibreve
        for j = detected_semibreve_note(i,1)-size(semibreve_img,1) : detected_semibreve_note(i,1)
            for k = detected_semibreve_note(i,2)-size(semibreve_img,2) : detected_semibreve_note(i,2)
                stave_section(j, k) = 0;
            end
        end
    end
    
    result = stave_section;
    result2 = recognizedSemibreveNotes;
    
    %% Visualization
    global display_figures stave
    if display_figures
        figure_display('REMOVAL', stave_section, char("Stave Section #" + stave + " : After Semibreve Removal"));
    end
end