function generated_audio = GenerateAudio(recognizedScore)
    %{
        GENERATE_AUDIO Generates .wav file from the recognized score.
                It takes the recognized score object, which acts as 
                notes data holder, containing the notes' locations 
                in the sheet, intervals, ABC notations and pitch
                durations.

                It starts by reshpaing the data in the recognizedScore
                taking no more than the notation and pitch duration for
                each note. Then it reformats the pitch duration to 
                the right format. Then it maps between the notes
                and the pitches that represents the piano keys. Finally,
                Starts the audio generation process.
                
                It returns the generated audio object which contains
                the playback file info that can be directly played.

        [N.B]   The getKey code is introduced by Yi-Wen Chen and it is 
                included in the MathWorks File Exchange Repository.

        @Author Nada Mohamed
        @Copyright 12-2021 The KAN, Org.
    %}
    
    %% Reshaping Data
    reshaped_data = ReshapeData(recognizedScore);
    song = reshaped_data(:, 1)';    % transpose [col to row]
    duration = str2double(reshaped_data(:, 2)');
    
    %% Reformatting the durationation array
    for i=1 : size(duration, 2)
        if duration(1, i) == 0.5
            duration(1, i) = 2;
        elseif duration(1, i) == 0.25
            duration(1, i) = 4;
        end
    end
    
    % Making the tempo faster
    duration = duration * 3/2;  % 1.5x faster
 
    %% Mapping between the notesArray and the pitch, which represents the piano keys
    notesArray = {'Gb3' 'G3' 'G#3' 'Ab3' 'A3' 'A#3' 'Bb3' 'B3' 'B#3'...
                  'Cb4' 'C4' 'C#4' 'Db4' 'D4' 'D#4' 'Eb4' 'E4' 'E#4'...
                  'Fb4' 'F4' 'F#4' 'Gb4' 'G4' 'G#4' 'Ab4' 'A4' 'A#4'...
                  'Bb4' 'B4' 'B#4' 'Cb5' 'C5' 'C#5' 'Db5' 'D5' 'D#5'...
                  'Eb5' 'E5' 'E#5' 'Fb5' 'F5' 'F#5' 'Gb5' 'G5' 'G#5'...
                  'Ab5' 'A5' 'A#5' 'Bb5' 'B5' 'B#5' 'Cb6' 'C6' 'C#6'};
              
    pitch = [34 35 36 36 37 38 38 39 40 ...
             39 40 41 41 42 43 43 44 45 ...
             44 45 46 46 47 48 48 49 50 ...
             50 51 52 51 52 53 53 54 55 ...
             55 56 57 56 57 58 58 59 60 ...
             60 61 62 62 63 64 63 64 65];
       
    generated_audio = [];
    fs = 44100; % sample rate in hertz
    
    for i=1 : size(song, 2)
        idx = find(strcmp(song(1,i), notesArray));
        generated_audio = [generated_audio, getKey(pitch(idx), duration(1,i), fs)];
    end
    audiowrite('TestCases/GeneratedAudio.wav', generated_audio, fs);
    
end

%% Helpers
function data = ReshapeData(recognizedScore)
    for i=1 : size(recognizedScore, 1)  % foreach notation
        lbl_1 = cell2mat(recognizedScore(i, 3));
        lbl_2 = cell2mat(recognizedScore(i, 4));
        recognizedScore(i, 4) = {strcat(lbl_1, lbl_2)};
    end
    recognizedScore = recognizedScore(:, 4:5);
    data = recognizedScore;
end

% The purpose of using getKey is to achieve a fade-in/fade-out effect 
% in combination with the creation of the audio wave, 
% based on the sinusoids (sine waves).
function wave = getKey(p, n, fs)  
        t = 0:1/fs:4/n;
        idx = 440*2^((p-49)/12);
        mid = (t(1)+t(end))/2;
        tri = -(abs(t-mid)-mid);
        tri = tri./max(tri);
        wave = (sin(2*pi*idx*t)).*tri;
end