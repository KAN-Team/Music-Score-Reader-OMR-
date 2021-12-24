function Main()
    clc; clear; close all;
    warning off;
    %% reading image
    original_image = imread('JingleBells.bmp'); % TwinkleTwinkleLittleStar.bmp % JingleBells.bmp

    % Gray Image
    if (ndims(original_image) == 3)
        gray_image = rgb2gray(original_image);
    end

    % Binarizing Image
    binarized_image = ~(imbinarize(gray_image));
    
    %% Dividing the music score into staves and recognising them
    recognizedScore = ProcessStaves(binarized_image);
    
    %% Reshaping the data and Creating the audio sample
    GenerateAudio(recognizedScore);
    
    %%
    disp("====================================");
    disp("Finished !");
    disp(" --> Go to 'TestCases' Folder and Play 'GeneratedAudio.wav'");
    disp("====================================");
end

