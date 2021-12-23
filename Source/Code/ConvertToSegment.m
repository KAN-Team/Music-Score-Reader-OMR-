function ConvertToSegment()
    %% Converting to segments...
    image = imread('Segments/a_temp.tiff');
    imshow(image);
    crop = imcrop;
    imwrite(crop, 'croped_image.tiff');
end