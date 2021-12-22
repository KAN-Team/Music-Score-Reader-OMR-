function RemoveClef(stave_section)

%% using fft technique...
     %% Fast-Fourier Transformation for the clef / Al-Moftah Al-Mosiqi
     clef = imread('Segments/clef.tif');
     % This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks 
     C = real(ifft2(fft2(stave_section) .* fft2(rot90(clef,2),size(stave_section,1),size(stave_section,2))));
     maxC = max(C(:))
     thresh = 2.0808e+03;
 
     D = C > thresh;
     se = strel('square', 1);
     E = imdilate(D, se);
     [clef_x, clef_y] = find(E); % gets non zero elements
     detected_clef = [clef_x, clef_y];
 
%     clef_x_centred = detected_clef(:,1)-size(clef,1)/2+22;
%     clef_y_centred = detected_clef(:,2)-size(clef,2)/2+1;
%     detected_clef_centred = [clef_x_centred clef_y_centred];
%     detected_clef_centred = floor(detected_clef_centred);
%     se = strel('disk',7);
%     E = imdilate(D,se);
%     if displayFigures==1
%     figure('name','Finding the cleff');
%     imshow(E,'InitialMagnification','fit');
%     end
%     clear clef_x clef_x_centred clef_y clef_y_centred C D E maxC se thresh;
% 
%     %% Deleting the clef pixels from the cropped stave
%     for i=1:detected_clef(1)
%         for j=1:detected_clef(2)
%             stave_section(i,j)=0;
%         end
%     end
%     clear i j clef detected_clef;

end