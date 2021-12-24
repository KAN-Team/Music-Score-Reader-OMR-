function [result, result2] = RemoveTimeSignature(stave_section)
    %% Fast-Fourier Transformation for the 4/4 time signature...
    % This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
    
    time_sig_img = imread('Segments/TS_4_4.tiff');
    C = real(ifft2(fft2(stave_section) .* fft2(rot90(time_sig_img,2), size(stave_section,1), size(stave_section,2))));
    % maxC = max(C(:)) % to determine threshold value...
    thresh = 180;
    D = C > thresh;
    se = strel('square', 1);
    E = imdilate(D, se);
    [time_sig_H, time_sig_W] = find(E);
    detected_time_sig = [time_sig_H time_sig_W];
 
    recognisedTimeSignature = 0;
    isFound = false;
    if ~isempty(detected_time_sig)
        TimeSignature = '4/4';
        isFound = true;
        se = strel('disk', 5);
        E = imdilate(D, se);
        displayFigures = 0;
        if (displayFigures == 1)
            figure('name', 'Finding the time signature.');
            imshow(E, 'InitialMagnification','fit');
        end
    end
    
    %% Fast-Fourier Transformation for the e/4 time signature
    if (isFound == false)
        time_sig_img=imread('Segments/TS_e.tiff');
        C = real(ifft2(fft2(stave_section) .* fft2(rot90(time_sig_img,2), size(stave_section,1), size(stave_section,2))));
        % maxC = max(C(:)) % to determine threshold value...
        thresh = 58;
        D = C > thresh;
        se = strel('square', 1);
        E = imdilate(D, se);
        [time_sig_H, time_sig_W] = find(E);
        detected_time_sig = [time_sig_H time_sig_W];

        if ~isempty(detected_time_sig)
            TimeSignature = 'e/4';
            se = strel('disk', 5);
            E = imdilate(D, se);
            displayFigures = 0;
            if (displayFigures == 1)
                figure('name', 'Finding the time signature.');
                imshow(E, 'InitialMagnification','fit');
            end
        end
    end

    %% Deleting the time signature's pixels from the cropped stave
    if ~isempty(detected_time_sig)
        for i = detected_time_sig(1)-size(time_sig_img, 1) : detected_time_sig(1)
            for j = 1 : detected_time_sig(2)
                stave_section(i, j) = 0;
            end
        end
        recognisedTimeSignature = [num2cell(detected_time_sig) cellstr(TimeSignature)];
    end
    
    result = stave_section;
    result2 = recognisedTimeSignature;
    clear i j found TimeSignature time_sig time_sig detected_time_sig posOfTimeSig;
end