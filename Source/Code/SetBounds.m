function SetBounds(binarized_image, recognizedScore, stafflines_locs, stave_section_space)
    %{
      SET_BOUNDS Custom objects' bounds and annotation generation.
        It takes the image and the recognizedScore matrix.

        It Displays an annotated figure contating objects' boundaries
        and each object notation.
        
        @Author Nada Anies
        @Copyright 12-2021 The KAN, Org.
    %}

    figure, imshow(binarized_image); title("Annotated Sheet");
    hold on;
    for i = 1 : size(recognizedScore, 1)
        stave = cell2mat(recognizedScore(i, 6));
        staffline = (stave-1)*5 + 1;
        stv_section_start = stafflines_locs(staffline) - stave_section_space;
        CP = cell2mat(recognizedScore(i, 1:2));
        CP(1, 1) = CP(1, 1) - 8;
        CP(1, 2) = stv_section_start + CP(1, 2) - 30;
        CWH = [16, 34];
        Notation = cell2mat(recognizedScore(i, 3:4));
        Notation = strcat(Notation(1, 1), Notation(1, 2));
        
        rectangle('Position', [CP CWH], 'EdgeColor', 'red', 'LineWidth', 2);
        text('position', [CP(1), CP(2)-10], ...
             'fontsize', 6, ...
             'string', Notation, ...
             'color' , 'white', ...
             'BackgroundColor', [0 0.4470 0.7410]);
    end
    hold off;
end