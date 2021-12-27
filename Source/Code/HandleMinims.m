function [result, result2] = HandleMinims(stave_section, stafflines_locs)
    %{
      HANDLE_MINIMS Detects, Recognizes and Removes musical Minims.
        Minim is also known as a 'Half Note'.
        
        It takes the stave_section image 
        and the section staff lines' locations.

        Detection is applied using the concept of identifying the round
        objects, that is introduced in 
        MATHWORKS's tutorial -> 'Identifying Round Objects'

        Recognition is applied using the ABC Musical notations,
        Which are the first 7 letters in the English Alphabet
        [A, B, C, D, E, F, G] that determines the pitch.
        There are 18 possible locations that may any note be at,
        By knowing the staff lines locations and the note location,
        using KNN search would provide the accurate location, from which 
        the specified Letter and then knowing the right pitch.

        It returns the binarized image without the Minims notes
        and the recognized Minim object containing 5 cols,
        the first 2 are for the location, the third is for 
        the pitch interval, the fourth is the ABC notation, 
        the fifth is ones for predicting a half note duration.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %% Identifying the minim notes' heads
    stave_section = apply_morphological(stave_section, 'close', 'disk', 5);
    stave_section = imclose(stave_section, strel('disk', 3));
    
    [B, L] = bwboundaries(stave_section, 'noholes');

    stats = regionprops(L, 'Area', 'Centroid');
    threshold = 0.82; % was 0.80
    minims = [];
    
    % looping over the boundaries
    for k = 1 : length(B)

        % obtain (X, Y) boundary coordinates corresponding to label 'k'
        boundary = B{k};

        % compute a simple estimate of the object's perimeter
        delta_sq = diff(boundary).^2;
        perimeter = sum(sqrt(sum(delta_sq,2)));

        % obtain the area calculation corresponding to label 'k'
        area = stats(k).Area;

        % compute the roundness metric
        metric = 4*pi*area/perimeter^2;

        % mark objects above the threshold with a black circle
        if metric > threshold
            centroid = stats(k).Centroid;
            minims(end+1, :) = round(centroid);
        end
    end

    %% Recognising the identified minim notes
    notations = RecognizeNotes(minims, stafflines_locs, 2);
    
    recognizedMinimNotes = [num2cell(minims), notations];
    recognizedMinimNotes = [recognizedMinimNotes repmat({'0.5'}, size(recognizedMinimNotes,1), 1)];

    %% Removing the recognised minims note heads
    for i = 1 : size(minims,1)
        for j = minims(i,1)-10:minims(i,1)+10
            for k = minims(i,2)-5:minims(i,2)+5
                stave_section(k, j) = 0;
            end
        end
    end
    
    result = stave_section;
    result2 = recognizedMinimNotes;

    %% Visualization
    
    global display_figures stave
    if display_figures
        figure_display('REMOVAL', stave_section, char("Stave Section #" + stave + " : After Minims Removal"));
    end
end