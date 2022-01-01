function result = RecognizeNotes(notes, stafflines_locs, dim)
    %{
      RECOGNIZE_NOTES Helper function used in Recognition.
        
        It takes the notes object, the staff lines' locations and notes
        object dimensions.

        It returns the notation matrix.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

%%
    notations = cell(size(notes, 1), 2);
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
    
    for i = 1 : size(notes, 1)
        idx = knnsearch(notePositions(:), notes(i, dim));
        switch idx
            case 1
                notations(i)={'C'}; notations(i,2)={'6'};   % abv ln 1
            case 2
                notations(i)={'B'}; notations(i,2)={'5'};   % abv ln 1
            case 3
                notations(i)={'A'}; notations(i,2)={'5'};   % abv ln 1
            case 4
                notations(i)={'G'}; notations(i,2)={'5'};   % abv ln 1
            case 5
                notations(i)={'F'}; notations(i,2)={'5'};   % ln 1
            case 6
                notations(i)={'E'}; notations(i,2)={'5'};   % ln 1 : ln 2
            case 7
                notations(i)={'D'}; notations(i,2)={'5'};   % ln 2
            case 8
                notations(i)={'C'}; notations(i,2)={'5'};   % ln 2 : ln 3
            case 9
                notations(i)={'B'}; notations(i,2)={'4'};   % ln 3
            case 10
                notations(i)={'A'}; notations(i,2)={'4'};   % ln 3 : ln 4 
            case 11
                notations(i)={'G'}; notations(i,2)={'4'};   % ln 4
            case 12
                notations(i)={'F'}; notations(i,2)={'4'};   % ln 4 : ln 5
            case 13
                notations(i)={'E'}; notations(i,2)={'4'};   % ln 5
            case 14
                notations(i)={'D'}; notations(i,2)={'4'};   % blw ln 5
            case 15
                notations(i)={'C'}; notations(i,2)={'4'};   % blw ln 5
            case 16
                notations(i)={'B'}; notations(i,2)={'3'};   % blw ln 5
            case 17
                notations(i)={'A'}; notations(i,2)={'3'};   % blw ln 5
            case 18
                notations(i)={'G'}; notations(i,2)={'3'};   % blw ln 5
        end
    end
    
    result = notations;
end