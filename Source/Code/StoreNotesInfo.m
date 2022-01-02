function result = StoreNotesInfo(recognizedScore, recognizedSemibreve, ...
                                 recognizedCrotchets, recognizedMinims)
    %{
      STORE_NOTES_INFO Creats a matrix contains all the notes' information.
         It takes the recognizer score object, recognized semibreve object,
         recognized crotchets object and recognized minims object.
        
         It Merges all the taken recognized objects into the recognizer
         score object, which acts as a database.
        
         It returns the new recognizer score object.
                              
         @Author Kareem Sherif
         @Copyright 12-2021 The KAN, Org.
    %}

    %% Creating a matrix including all the notes and their information
    global stave
    recognisedStaveNotes = [recognizedSemibreve; recognizedCrotchets; recognizedMinims];
    recognisedStaveNotes = sortrows(recognisedStaveNotes, 1);
    recognisedStaveNotes = [recognisedStaveNotes repmat({stave}, size(recognisedStaveNotes,1),1)];
    
    if stave == 1
        recognizedScore = recognisedStaveNotes;
    else
        recognizedScore = [recognizedScore ; recognisedStaveNotes];
    end
    result = recognizedScore;

end