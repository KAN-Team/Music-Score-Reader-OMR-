function result = RemoveClef(stave_section)

     %% using fft technique...
     %% Fast-Fourier Transformation for the clef / Al-Moftah Al-Mosiqi
     clef_img = imread('Segments/Clef.tiff');
     % This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks 
     C = real(ifft2(fft2(stave_section) .* fft2(rot90(clef_img,2), size(stave_section,1), size(stave_section,2))));
     
     % maxC = max(C(:)) % to determine threshold value...
     thresh = 360.9;
 
     D = C > thresh;
     se = strel('square', 1);
     E = imdilate(D, se);
     [clef_H, clef_W] = find(E);
     detected_clef = [clef_H clef_W];
    
     isFound = false;
     if ~isempty(detected_clef)
         isFound = true;
         displayFigures = 0;
         if (displayFigures==1)
             se = strel('disk', 5);
             E = imdilate(D,se);
             figure('name', 'Finding the cleff');
             imshow(E, 'InitialMagnification','fit');
         end
     end
     
     
     %% Fast-Fourier Transformation for another clef shape / Al-Moftah Al-Mosiqi
     if ~isFound
         clef_img = imread('Segments/Clef_2.tiff');
         % This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks 
         C = real(ifft2(fft2(stave_section) .* fft2(rot90(clef_img,2), size(stave_section,1), size(stave_section,2))));

         % maxC = max(C(:)) % to determine threshold value...
         thresh = 230;

         D = C > thresh;
         se = strel('square', 1);
         E = imdilate(D, se);
         [clef_H, clef_W] = find(E);
         detected_clef = [clef_H clef_W];

         displayFigures = 0;
         if (displayFigures==1)
             se = strel('disk', 5);
             E = imdilate(D,se);
             figure('name', 'Finding the cleff');
             imshow(E, 'InitialMagnification','fit');
         end
     end

    %% Deleting the clef pixels from the cropped stave
    if (size(detected_clef, 1) ~= 0)
        for i=1 : detected_clef(1)
            for j=1 : detected_clef(2)
                stave_section(i, j) = 0;
            end
        end
    end
    result = stave_section;
    
%     result = stave_section;
%     for i = 1 : size(stave_section, 1)
%         for j = 1 : 95
%             result(i, j) = 0;
%         end
%     end
end