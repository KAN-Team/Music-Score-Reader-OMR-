function [result, result2] = HandleSemibreve(stave_section, stafflines_locs)
    %{
      HANDLE_SEMIBREVE Detects, Recognizes and Removes musical semibreves.
        Semibreve is also known as a 'Whole Note'.
        
        It takes the stave_section image 
        and the section staff lines locations.

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
        the fifth is ones for predicting a whole note.

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
    detected_semibreve_note_centred = floor(detected_semibreve_note_centred + 1);
    [~,idx] = unique(detected_semibreve_note_centred(:,2)); % no 2 notes can be on same level
    detected_semibreve_note_centred = detected_semibreve_note_centred(idx, :);
    
    %% Recognizing the identified semibreve notes
    notations = cell(size(detected_semibreve_note_centred,1), 2);
    notePositions = [
                    stafflines_locs(1)-2*(stafflines_locs(2)-stafflines_locs(1)) ...
                    2*stafflines_locs(1)-stafflines_locs(2)-(stafflines_locs(2)-stafflines_locs(1))/2 ...
                    2*stafflines_locs(1)-stafflines_locs(2) ...
                    stafflines_locs(1)-(stafflines_locs(2)-stafflines_locs(1))/2 ...
                    stafflines_locs(1) ...
                    stafflines_locs(1)+(stafflines_locs(2)-stafflines_locs(1))/2 ...
                    stafflines_locs(2)...
                    stafflines_locs(2)+(stafflines_locs(3)-stafflines_locs(2))/2 ...
                    stafflines_locs(3)...
                    stafflines_locs(3)+(stafflines_locs(4)-stafflines_locs(3))/2 ...
                    stafflines_locs(4) ...
                    stafflines_locs(4)+(stafflines_locs(5)-stafflines_locs(4))/2 ...
                    stafflines_locs(5) ...
                    stafflines_locs(5)+(stafflines_locs(5)-stafflines_locs(4))/2 ...
                    2*stafflines_locs(5)-stafflines_locs(4) ...
                    (2*stafflines_locs(5)-stafflines_locs(4))+(stafflines_locs(5)-stafflines_locs(4))/2 ...
                    stafflines_locs(5)+2*(stafflines_locs(5)-stafflines_locs(4)) ...
                    stafflines_locs(5)+2*(stafflines_locs(5)-stafflines_locs(4))+(stafflines_locs(5)-stafflines_locs(4))/2
                    ];
    
    for i = 1 : size(detected_semibreve_note_centred, 1)
        idx = knnsearch(notePositions(:), detected_semibreve_note_centred(i, 1)+1);
        switch idx
            case 1
                notations(i)={'6'}; notations(i,2)={'C'};   % abv ln 1
            case 2
                notations(i)={'5'}; notations(i,2)={'B'};   % abv ln 1
            case 3
                notations(i)={'5'}; notations(i,2)={'A'};   % abv ln 1
            case 4
                notations(i)={'5'}; notations(i,2)={'G'};   % abv ln 1
            case 5
                notations(i)={'5'}; notations(i,2)={'F'};   % ln 1
            case 6
                notations(i)={'5'}; notations(i,2)={'E'};   % ln 1 : ln 2
            case 7
                notations(i)={'5'}; notations(i,2)={'D'};   % ln 2
            case 8
                notations(i)={'5'}; notations(i,2)={'C'};   % ln 2 : ln 3
            case 9
                notations(i)={'4'};  notations(i,2)={'B'};  % ln 3
            case 10
                notations(i)={'4'};  notations(i,2)={'A'};  % ln 3 : ln 4 
            case 11
                notations(i)={'4'}; notations(i,2)={'G'};   % ln 4
            case 12
                notations(i)={'4'};  notations(i,2)={'F'};  % ln 4 : ln 5
            case 13
                notations(i)={'4'};  notations(i,2)={'E'};  % ln 5
            case 14
                notations(i)={'4'}; notations(i,2)={'D'};   % blw ln 5
            case 15
                notations(i)={'4'}; notations(i,2)={'C'};   % blw ln 5
            case 16
                notations(i)={'3'}; notations(i,2)={'B'};   % blw ln 5
            case 17
                notations(i)={'3'}; notations(i,2)={'A'};   % blw ln 5
            case 18
                notations(i)={'3'}; notations(i,2)={'G'};   % blw ln 5
        end
        
    end
    
    recognizedSemibreveNotes = [num2cell(detected_semibreve_note_centred), notations];
    recognizedSemibreveNotes = [recognizedSemibreveNotes repmat({'1'}, size(recognizedSemibreveNotes,1),1)];
    recognizedSemibreveNotes(:, [1 2]) = recognizedSemibreveNotes(:,[2 1]);

    %% Removing the semibreve note pixels from the stave section
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