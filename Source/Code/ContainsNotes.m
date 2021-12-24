function result = ContainsNotes(stave_section)
    total_pixels = size(stave_section, 1) * size(stave_section, 2);
    % disp("total_pixels = " + total_pixels);
    white_pixels = nnz(stave_section);
    % disp("white_pixels = " + white_pixels);
    white_pixels_percent = (white_pixels/total_pixels * 100);
    % disp("white pixels precentage = " +  white_pixels_percent + "%");
    if (white_pixels_percent < 12)
        result = 0;
    else 
        result = 1;
    end
end