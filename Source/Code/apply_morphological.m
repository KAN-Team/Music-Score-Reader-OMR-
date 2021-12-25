function result = apply_morphological(image, morph_type, SE_shape, r)
    %{
      APPLY_MORPHOLOGICAL Performs morphological process.
        It takes the binary image and the process type 
        e.g. (open - close - dilate - erode),
        and the shape of any type ('square' - 'disk' - 'line', etc...),
        and finally the r param which is the shape radius length.
        
        [N.B] Image width must be less than 700 pixels to apply.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}
    
    %% image must be in a gray scale or a binary...
    if (size(image, 2) > 700) % image width must be suitable...
        result = image;
    elseif (strcmp(morph_type, 'open'))
        result = imopen(image, strel(SE_shape, r));
    elseif (strcmp(morph_type, 'close'))
        result = imclose(image, strel(SE_shape, r));
    elseif (strcmp(morph_type, 'erode'))
        result = imerode(image, strel(SE_shape, r));
    elseif (strcmp(morph_type, 'dilate'))
        result = imdilate(image, strel(SE_shape, r));
    end
end