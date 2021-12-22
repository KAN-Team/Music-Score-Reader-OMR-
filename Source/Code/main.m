function Main()

    clc;
    %% Converting to segments...
    % image = imread('Segments/Clef.tif');
    % size(image)
    % grayImage = rgb2gray(image);
    % binarized = imbinarize(grayImage);
    % imwrite(binarized, 'TEST_4.tif');
    
    %% reading image
    original_image = imread('JingleBells.bmp'); % TwinkleTwinkleLittleStar.bmp % JingleBells.bmp

    % Gray Image
    if (ndims(original_image) == 3)
        gray_image = rgb2gray(original_image);
    end

    % Binarizing Image
    binarized_image = ~(imbinarize(gray_image));

    [image_without_stafflines, stave_locs] = RemoveStafflines(original_image, binarized_image);
    % figure, imshow(image_without_stafflines), title("After Stafflines Removal");

    % closed_image = perform_morphological(binarized_image_without_staff, 'close', 'disk', 7);

    % closed_image = imdilate(binarized_image_without_staff, strel('disk', 1));
    % figure, imshow(closed_image), title("Dilated Image");
    %% Dividing the music score into staves and recognising them

    ProcessStaves(image_without_stafflines, stave_locs);

    disp("Finished !");


end

