function result = perform_morphological(image, morph_type, SE_shape, r)
    % image must be in a gray scale or a binary...
    if (strcmp(morph_type, 'open'))
        result = imopen(image, strel(SE_shape, r));
    else
        result = imclose(image, strel(SE_shape, r));
    end
end