function result = ContainsNotes(stave_section)
    %{
      CONTAINS_NOTES returns wheather this section contains notes or not.
        if the binary image contains white pixels less than 12%,
        then it's useless section.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %%
    total_pixels = size(stave_section, 1) * size(stave_section, 2);
    white_pixels = nnz(stave_section);
    white_pixels_percent = (white_pixels/total_pixels * 100);
    if (white_pixels_percent < 12)
        result = 0;
    else 
        result = 1;
    end
end