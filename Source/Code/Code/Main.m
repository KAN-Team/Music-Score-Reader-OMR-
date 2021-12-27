function Main()
    %% Tidying up
    clc; clear; close all;
    warning off;
    global display_figures isRotated
    display_figures = false;
    isRotated = false;
    
    %% Reading Image
    original_image = imread('JingleBells.bmp'); % TwinkleTwinkleLittleStar.bmp % JingleBells.bmp

    % Greying Image
    if (ndims(original_image) == 3)
        gray_image = rgb2gray(original_image);
    end
    
    %% Dividing the music score into staves and recognising them
    recognizedScore = ProcessStaves(gray_image);
    set(0, 'Children', flipud(get(0, 'Children'))) % Reverse Figure Window Order
    
    %% Reshaping the data and Creating the audio sample
    GenerateAudio(recognizedScore);
    
    %% Finale
    disp("====================================");
    disp("Finished !");
    disp(" --> Go to 'TestCases' Folder and Play 'GeneratedAudio.wav'");
    disp("====================================");
end

