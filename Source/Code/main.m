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
    
    %% Dividing the music score into staves and recognising them
    ProcessStaves(binarized_image);
    disp("Finished !");
end

