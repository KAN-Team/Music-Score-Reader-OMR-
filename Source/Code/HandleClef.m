function result = HandleClef(stave_section)
    %{
      HANDLE_CLEF Detects and Removes musical clef.
        It returns the binarized image without the clef.

        @Author Kareem Saeed
        @Copyright 12-2021 The KAN, Org.
    %}

     %% Fast-Fourier Transformation for the clef / Al-Moftah Al-Mosiqi
     clef_img = imread('C:\Users\LENOVO\OneDrive\Documents\githup\GUI\Music-Score-Reader-OMR-\Source\Segments\Clef.tiff');
     % maxC = max(C(:)) % to determine threshold value...
     thresh = 360.9;    % a bit smaller than maxC...
     [detected_clef, isFound] = FFTransform(stave_section, clef_img, thresh, "Clef");
     
     %% Fast-Fourier Transformation for another clef shape / Al-Moftah Al-Mosiqi
     if ~isFound
         clef_img = imread('C:\Users\LENOVO\OneDrive\Documents\githup\GUI\Music-Score-Reader-OMR-\Source\Segments\Clef_2.tiff');
         % maxC = max(C(:)) % to determine threshold value...
         thresh = 230;      % a bit smaller than maxC...
         [detected_clef, isFound] = FFTransform(stave_section, clef_img, thresh, "Clef");
     end

     %% Fast-Fourier Transformation for another clef shape / Al-Moftah Al-Mosiqi
     if ~isFound
         clef_img = imread('C:\Users\LENOVO\OneDrive\Documents\githup\GUI\Music-Score-Reader-OMR-\Source\Segments\Clef_3.tiff');
         % C = real(ifft2(fft2(stave_section) .* fft2(rot90(clef_img,2), size(stave_section,1), size(stave_section,2))));
         % maxC = max(C(:)) % to determine threshold value...
         thresh = 104;    % a bit smaller than maxC...
         [detected_clef, isFound] = FFTransform(stave_section, clef_img, thresh, "Clef");
     end
     
     %% Fast-Fourier Transformation for another clef shape / Al-Moftah Al-Mosiqi
     if ~isFound
         clef_img = imread('C:\Users\LENOVO\OneDrive\Documents\githup\GUI\Music-Score-Reader-OMR-\Source\Segments\Clef_4.tiff');
         % C = real(ifft2(fft2(stave_section) .* fft2(rot90(clef_img,2), size(stave_section,1), size(stave_section,2))));
         % maxC = max(C(:)) % to determine threshold value...
         thresh = 395;    % a bit smaller than maxC...
         [detected_clef] = FFTransform(stave_section, clef_img, thresh, "Clef");
     end
     
    %% Removing the clef pixels from the stave section
    if (size(detected_clef, 1) ~= 0)
        for i=1 : detected_clef(1)
            for j=1 : detected_clef(2)
                stave_section(i, j) = 0;
            end
        end
    end
    result = stave_section;
    
    %% Visualizing
    global display_figures stave
    if (display_figures)
         figure_display('REMOVAL', result, char("Stave Section #" + stave + " : After Clef Removal"));
    end
end