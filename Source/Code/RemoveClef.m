function result = RemoveClef(stave_section)

     %% using fft technique...
     %% Fast-Fourier Transformation for the clef / Al-Moftah Al-Mosiqi
     clef = imread('Segments/Clef.tif');
     % This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks 
     C = real(ifft2(fft2(stave_section) .* fft2(rot90(clef,2),size(stave_section,1),size(stave_section,2))));
     
     % maxC = max(C(:)) % to determine threshold value...
     thresh = 330;
 
     D = C > thresh;
     se = strel('square', 120);
     E = imdilate(D, se);
     [clef_h, clef_w] = find(E); % gets non zero elements
     % clear clef_h clef_y C D E maxC se thresh;

    %% Deleting the clef pixels from the cropped stave
    for i = 1 : size(clef_h)
        stave_section(clef_h(i), clef_w(i)) = 0;
    end
    result = stave_section;
end