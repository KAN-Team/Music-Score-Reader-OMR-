function [result, result2] = HandleTimeSignature(stave_section)
    %{
      HANDLE_TIME_SIGNATURE Detects, and Removes musical time signature.
        It returns the binarized image without the time signature
        and the recognized time object.

        @Author Kareem Saeed
        @Copyright 12-2021 The KAN, Org.
    %}

    %% Fast-Fourier Transformation for the 4/4 time signature...
    time_sig_img = imread('Segments/TS_4_4.tiff');
    % maxC = max(C(:))  % to determine threshold value...
    thresh = 180;       % a bit smaller than maxC...
    [detected_time_sig, isFound] = FFTransform(stave_section, time_sig_img, thresh, "TimeSignature");
    
    recognisedTimeSignature = 0;
    TimeSignature = '4/4';
    
    %% Fast-Fourier Transformation for the e/4 time signature
    if (isFound == false)
        time_sig_img = imread('Segments/TS_e.tiff');
        % maxC = max(C(:))  % to determine threshold value...
        thresh = 58;        % a bit smaller than maxC...
        [detected_time_sig, isFound] = FFTransform(stave_section, time_sig_img, thresh, "TimeSignature");

        TimeSignature = 'e/4';
    end
    
    %% Fast-Fourier Transformation for another e/4 time signature
    if (isFound == false)
        time_sig_img = imread('Segments/TS_e_2.tiff');
        % C = real(ifft2(fft2(stave_section) .* fft2(rot90(time_sig_img,2), size(stave_section,1), size(stave_section,2))));
        % maxC = max(C(:))  % to determine threshold value...
        thresh = 25;        % a bit smaller than maxC...
        [detected_time_sig] = FFTransform(stave_section, time_sig_img, thresh, "TimeSignature");

        TimeSignature = 'e/4';
    end

    %% Deleting the time signature's pixels from the stave section
    if ~isempty(detected_time_sig)
        for i = detected_time_sig(1)-size(time_sig_img, 1) : detected_time_sig(1)
            for j = 1 : detected_time_sig(2)
                stave_section(i, j) = 0;
            end
        end
        try
            recognisedTimeSignature = [num2cell(detected_time_sig) cellstr(TimeSignature)];
        catch
            recognisedTimeSignature = 'NA';
        end
    end
    
    result = stave_section;
    result2 = recognisedTimeSignature;
    
    %% Visualizing
    global display_figures stave
    if ~isempty(detected_time_sig) && (display_figures)
        figure_display('REMOVAL', result, char("Stave Section #" + stave + " : After TimeSignature Removal"));
    end
end