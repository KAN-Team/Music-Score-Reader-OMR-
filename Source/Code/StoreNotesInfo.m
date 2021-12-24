function result = StoreNotesInfo(recognizedScore, stave, recognizedSemibreve, ...
                                 recognizedFilledHead, recognizedMinimHead)
    % @Author: Kareem Sherif

    % Creating a matrix including all the notes and their information
    recognisedStaveNotes = [recognizedSemibreve; recognizedFilledHead; recognizedMinimHead];
    recognisedStaveNotes = sortrows(recognisedStaveNotes, 1);
    recognisedStaveNotes = [recognisedStaveNotes repmat({' '}, size(recognisedStaveNotes,1), 1)];
    
    if stave == 1
        recognizedScore = recognisedStaveNotes;
    else
        recognizedScore = [recognizedScore ; recognisedStaveNotes];
    end
    result = recognizedScore;

end