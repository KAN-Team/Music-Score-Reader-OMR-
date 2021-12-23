function Main()
    clc;
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

    closed_image = perform_morphological(image_without_stafflines, 'close', 'disk', 1);
    % figure, imshow(closed_image), title("After Closing Morph");
    %% Dividing the music score into staves and recognising them

    ProcessStaves(closed_image, stave_locs);

    disp("Finished !");


end

