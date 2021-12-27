function result = RemoveMargins(binarized_image)
    %{
      REMOVE_MARGINS Removes small Margins from right and left sides.
        
        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %%
    for i=1 : size(binarized_image, 1)
        for j=1 : 15 % margin size -> 15 pixels from left and right.
            binarized_image(i, j) = 0;
            binarized_image(i, size(binarized_image, 2) - j + 1) = 0;
        end
    end
    result = binarized_image;
end