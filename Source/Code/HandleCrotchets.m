function [result1, result2] = HandleCrotchets(stave_section, stafflines_locs)
    %{
      HANDLE_CROTCHETS Detects, Recognizes and Removes musical Crotchets.
        Crotchet is also known as a 'Quarter Note'.
        
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

        It returns the binarized image without the Crotchet notes
        and the recognized Crotchet object containing 5 cols,
        the first 2 are for the location, the third is for 
        the pitch interval, the fourth is the ABC notation, 
        the fifth is ones for predicting a quarter note duration.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}
    
    %% Finding the filled note heads
    stave_section = imclose(stave_section, strel('disk', 1));
    stave_section = bwareaopen(stave_section, 15);
    stave_section = apply_morphological(stave_section, 'close', 'square', 3);
    
    [B, L] = bwboundaries(stave_section, 'noholes');
    
    stats = regionprops(L, 'Area', 'Centroid');
    threshold = 0.74;
    crotchets = [];

    for k = 1:length(B)

        % obtain (X, Y) boundary coordinates corresponding to label 'k'
        boundary = B{k};

        % compute a simple estimate of the object's perimeter
        delta_sq = diff(boundary) .^ 2;
        perimeter = sum(sqrt(sum(delta_sq, 2)));

        % obtain the area calculation corresponding to label 'k'
        area = stats(k).Area;

        % compute the roundness metric
        metric = 4*pi*area / perimeter^2;

        % mark objects above the threshold with a black circle
        if metric > threshold
            centroid = stats(k).Centroid;
            crotchets(end+1, :) = round(centroid);
        end
    end

    %% Recognising the identified crotchet notes
    notations = RecognizeNotes(crotchets, stafflines_locs, 2);
    
    recognizedNotes = [num2cell(crotchets), notations];
    recognizedNotes = [recognizedNotes repmat({'0.25'}, size(recognizedNotes,1), 1)];
    recogniseFilledNotes = sortrows(recognizedNotes, 1);

    %% Removing the recognised crotchets filled note heads
    for i=1 : size(crotchets, 1)    % foreach Crotchet
        for j = crotchets(i,1)-10 : crotchets(i,1)+10
            for k = crotchets(i,2)-5 : crotchets(i,2)+5
                stave_section(k, j) = 0;
            end
        end
    end
    
    result1 = stave_section;
    result2 = recogniseFilledNotes;
    
    %% Visualization
    
    global display_figures stave
    if display_figures
        figure_display('REMOVAL', stave_section, char("Stave Section #" + stave + " : After Crotchet Removal"));
    end
end