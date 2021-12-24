function [result, result2] = RemoveSemibreve(stave_section, stave_locs)
    % @Author: Kareem Sherif / KAN Org...

    %% Fast-Fourier Transformation for the semibreve notes
    % figure, imshow(stave_section); title("BEFORE");
    semibreve_img = imread('Segments/Semibreve.tiff');
    C = real(ifft2(fft2(stave_section) .* fft2(rot90(semibreve_img,2), size(stave_section,1), size(stave_section,2))));
    % maxC = max(C(:)) % to determine threshold value...
    thresh = 58;
    D = C > thresh;
    se = strel('square', 1);
    E = imdilate(D, se);
    [semibreve_note_H, semibreve_note_W] = find(E);
    detected_semibreve_note = [semibreve_note_H semibreve_note_W];
    semibreve_note_H_centred = detected_semibreve_note(:,1)-size(semibreve_img,1)/2-2;
    semibreve_note_W_centred = detected_semibreve_note(:,2)-size(semibreve_img,2)/2;
    detected_semibreve_note_centred = [semibreve_note_H_centred semibreve_note_W_centred];
    detected_semibreve_note_centred = floor(detected_semibreve_note_centred);

    clear semibreve_note_H semibreve_note_H_centred semibreve_note_W semibreve_note_W_centred C D E maxC se thresh;

    % Recognising the identified semibreve notes
    textCol = cell(size(detected_semibreve_note_centred,1), 2);
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
                
    for i = 1 : size(detected_semibreve_note_centred, 1)
        idx = knnsearch(notePositions(:), detected_semibreve_note_centred(i,1));
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
    recogniseSemibreveNotes = [num2cell(detected_semibreve_note_centred), textCol];
    recogniseSemibreveNotes = [recogniseSemibreveNotes repmat({'1'}, size(recogniseSemibreveNotes,1),1)];
    recogniseSemibreveNotes(:,[1 2]) = recogniseSemibreveNotes(:,[2 1]);
    clear i textCol idx notePositions;

    %% Deleting the semibreve note pixels from the cropped stave
    for i = 1 : size(detected_semibreve_note, 1)
        for j = detected_semibreve_note(i,1)-size(semibreve_img,1) : detected_semibreve_note(i,1)
            for k = detected_semibreve_note(i,2)-size(semibreve_img,2) : detected_semibreve_note(i,2)
                stave_section(j, k) = 0;
            end
        end
    end
    % figure, imshow(stave_section); title("AFTER");
    
    clear i j k semibreve_note;
    result = stave_section;
    result2 = recogniseSemibreveNotes;
end