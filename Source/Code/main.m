function Main()
    %% Tidying up
    clc; clear; close all;
    warning off;
    global display_figures isRotated
    display_figures = false;
    isRotated = false;
    set(0, 'Children', flipud(get(0, 'Children'))) % Reverse Figure Window Order
    %% Run Project
     Gui(); 
    %% Finale
    disp("====================================");
    disp("Finished !");
    disp(" --> Go to 'TestCases' Folder and Play 'GeneratedAudio.wav'");
    disp("====================================");
end

