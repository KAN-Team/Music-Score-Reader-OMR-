function result = perform_morphological(image, morph_type, SE_shape, r)
    % image must be in a gray scale or a binary...
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