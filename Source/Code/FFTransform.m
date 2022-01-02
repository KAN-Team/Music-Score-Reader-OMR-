function [detected_signature, isFound] = FFTransform(stave_section, seg_img, thresh, segm)
    %{
        FF_TRANSFORM correlates and locates image features.
                It takes the stave_section image, the featured image
                and the proper threshold for segmenting the stave_section
                image, and a string to identify the Segmented Object.
                
                It returns the detected signature matrix
                and wheather the object is found in the stave_section or
                not.

        [N.B]   The FFT code is introduced in the 
                "FFT-Based Correlation to Locate Image Features" 
                Tutorial from MathWorks.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %%
    C = real(ifft2(fft2(stave_section) .* fft2(rot90(seg_img,2), size(stave_section,1), size(stave_section,2))));
    D = C > thresh;
    se = strel('square', 1);
    E = imdilate(D, se);
    [seg_H, seg_W] = find(E);
    detected_signature = [seg_H seg_W];
    
    global display_figures stave
    isFound = false;
    if ~isempty(detected_signature)
        isFound = true;
        if (display_figures)
            se = strel('disk', 5);
            E = imdilate(D, se);
            figure_display('DETECTION', E, char("Stave Section #" + stave + " : " + segm +" Start Point"));
        end
    end
    
end