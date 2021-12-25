function [result1, result2] = RemoveFilledNotehead(stave_section, stave_locs)
    % @Author:  Kareem Sherif / KAN Org...
    
    %% Finding the filled note heads
    % figure, imshow(stave_section); title("BEFORE");
    stave_section = imclose(stave_section, strel('disk', 1));
    stave_section = bwareaopen(stave_section, 15);
    stave_section = apply_morphological(stave_section, 'close', 'square', 3);
    
    [B, L] = bwboundaries(stave_section, 'noholes');
    
    stats = regionprops(L, 'Area', 'Centroid');
    threshold = 0.74; % First was 0.79
    noteHeads = [];

    % The following technique is based on a MATLAB's tutorial for 
    % identifying the round objects.

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
            noteHeads(end+1, :) = round(centroid);
        end
    end
    clear k B L stats metric threshold centroid delta_sq area boundary perimeter;

    %% Recognising the identified notes
    %disp("stave_locs(1) = " + stave_locs(1));
    %disp("stave_locs(2) = " + stave_locs(2));
    %disp("stave_locs(1)-2*(stave_locs(2)-stave_locs(1)) = " + (stave_locs(1)-2*(stave_locs(2)-stave_locs(1))));
    textCol = cell(size(noteHeads, 1), 2);
    notePositions = [
                    stave_locs(1)-2*(stave_locs(2)-stave_locs(1)) ...
                    2*stave_locs(1)-stave_locs(2)-(stave_locs(2)-stave_locs(1))/2 ...
                    2*stave_locs(1)-stave_locs(2) ...
                    stave_locs(1)-(stave_locs(2)-stave_locs(1))/2 ...
                    stave_locs(1) ...
                    stave_locs(1)+(stave_locs(2)-stave_locs(1))/2 ...
                    stave_locs(2)...
                    stave_locs(2)+(stave_locs(3)-stave_locs(2))/2 ...
                    stave_locs(3)...
                    stave_locs(3)+(stave_locs(4)-stave_locs(3))/2 ...
                    stave_locs(4) ...
                    stave_locs(4)+(stave_locs(5)-stave_locs(4))/2 ...
                    stave_locs(5) ...
                    stave_locs(5)+(stave_locs(5)-stave_locs(4))/2 ...
                    2*stave_locs(5)-stave_locs(4) ...
                    (2*stave_locs(5)-stave_locs(4))+(stave_locs(5)-stave_locs(4))/2 ...
                    stave_locs(5)+2*(stave_locs(5)-stave_locs(4)) ...
                    stave_locs(5)+2*(stave_locs(5)-stave_locs(4))+(stave_locs(5)-stave_locs(4))/2
                    ];
    
    for i=1 : size(noteHeads,1)
        idx = knnsearch(notePositions(:), noteHeads(i,2));
        switch idx
            case 1
                textCol(i)={'6'}; textCol(i,2)={'C'};
            case 2
                textCol(i)={'5'}; textCol(i,2)={'B'};
            case 3
                textCol(i)={'5'}; textCol(i,2)={'A'};
            case 4
                textCol(i)={'5'}; textCol(i,2)={'G'};
            case 5
                textCol(i)={'5'}; textCol(i,2)={'F'};
            case 6
                textCol(i)={'5'}; textCol(i,2)={'E'};
            case 7
                textCol(i)={'5'}; textCol(i,2)={'D'};
            case 8
                textCol(i)={'5'}; textCol(i,2)={'C'};
            case 9
                textCol(i)={'4'};  textCol(i,2)={'B'};
            case 10
                textCol(i)={'4'};  textCol(i,2)={'A'};
            case 11
                textCol(i)={'4'}; textCol(i,2)={'G'};
            case 12
                textCol(i)={'4'};  textCol(i,2)={'F'};
            case 13
                textCol(i)={'4'};  textCol(i,2)={'E'};
            case 14
                textCol(i)={'4'}; textCol(i,2)={'D'};
            case 15
                textCol(i)={'4'}; textCol(i,2)={'C'};
            case 16
                textCol(i)={'3'}; textCol(i,2)={'B'};
            case 17
                textCol(i)={'3'}; textCol(i,2)={'A'};
            case 18
                textCol(i)={'3'}; textCol(i,2)={'G'};
        end
    end
    
    recogniseNotes = [num2cell(noteHeads), textCol];
    recogniseNotes = [recogniseNotes repmat({'0.25'}, size(recogniseNotes,1), 1)];
    recogniseFilledNotes = sortrows(recogniseNotes, 1);
    clear i textCol recogniseNotes notePositions idx;

    %% Deleting the recognised filled noteheads
    for i=1 : size(noteHeads, 1)
        for j = noteHeads(i,1)-10 : noteHeads(i,1)+10
            for k = noteHeads(i,2)-5 : noteHeads(i,2)+5
                stave_section(k, j) = 0;
            end
        end
    end
    clear i j k;
    
    % figure, imshow(stave_section); title("AFTER");
    result1 = stave_section;
    result2 = recogniseFilledNotes;
end