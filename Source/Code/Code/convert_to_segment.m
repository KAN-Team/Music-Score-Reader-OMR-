function convert_to_segment()
    %{
        CONVERT_TO_SEGMENT reads an image and display it for a manual
        cropping.
            [N.B] This function is completely independent of 
                  the main program, it runs individually.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}
    %% Converting to segments...
    image = imread('Segments/a_temp.tiff');
    imshow(image);
    crop = imcrop;
    imwrite(crop, 'croped_image.tiff');
end