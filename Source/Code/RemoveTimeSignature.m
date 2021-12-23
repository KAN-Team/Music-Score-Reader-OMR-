function [result, result2] = RemoveTimeSignature(stave_section)
    %% Fast-Fourier Transformation for the 4/4 time signature...
    % This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
    
    time_signature_img = imread('Segments/TS_4_4.tiff');
    C = real(ifft2(fft2(stave_section) .* fft2(rot90(time_signature_img,2), size(stave_section,1), size(stave_section,2))));
    % maxC = max(C(:)) % to determine threshold value...
    thresh = 180;
    D = C > thresh;
    se = strel('square', 1);
    E = imdilate(D,se);
    [time_sig_H, time_sig_W] = find(E);
    detected_time_sig_4_4 = [time_sig_H time_sig_W];
 
    if ~isempty(detected_time_sig_4_4)
        TimeSignature = '4/4';
        clear time_sig_H time_sig_W;
        se = strel('disk', 5);
        E = imdilate(D, se);
        displayFigures = 0;
        if (displayFigures == 1)
            figure('name', 'Finding the time signature.');
            imshow(E, 'InitialMagnification','fit');
        end
        detected_time_sig = detected_time_sig_4_4;
        clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
    end
    
    %% Deleting the time signature's pixels from the cropped stave
    for i = detected_time_sig(1)-size(time_signature_img, 1) : detected_time_sig(1)
        for j = 1 : detected_time_sig(2)
            stave_section(i, j) = 0;
        end
    end
    
    recognisedTimeSignature = [num2cell(detected_time_sig) cellstr(TimeSignature)];
    
    result = stave_section;
    result2 = recognisedTimeSignature;
    clear i j found TimeSignature time_sig time_sig detected_time_sig posOfTimeSig;
end