function fixed_image = HandleRotation(gray_image)
    %{
      HANDLE_ROTATION Gets a rotated image and corrects it.
        If the image is in it's normal orientation it returns the original
        image.
        
        Radon transform projections along 180 degrees, from -90 to +89....
        R: Radon transform of the intensity image 'grayImage' for -90:89 degrees.
        In fact, each column of R shows the image profile along corresponding angle. 
        xp: a vector containing the radial coordinates corresponding to each row of 'R'.
        Negative angles correspond to clockwise directions, while positive angles
        correspond to counterclockwise directions around the center point (up-left corner).
        R1: A 1x180 vector in which, each element is equal the maximum value of Radon transform along each angle.
        This value reflects the maximum number of pixels along each direction. 
        r_max: A 1x180 vector, which includes corresponding radii of 'R1'.
        
        In Line detection section it performs a Hough-like search. 
        It finds maximum value of Radon transform over all radii and 
        angles in angles greater than 50 or= less than -50. First detected 
        angle indicates the slope of the upper bond of the image. 
        
        [N.B] This pice of code was introduced by Amir Omidvarnia
        in "Image Rotation Correction" at MATLAB Central File Exchange.

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %% Checks Orientation
    global isRotated
    if (~isRotated)
        fixed_image = ~imbinarize(gray_image);
        return;
    end
    
    theta = getTheta(gray_image);
    
    if (theta == 0)
        fixed_image = ~imbinarize(gray_image);
        return;
    end
    
    %% Fixes the Orientation
    fixed_image = imrotate(gray_image, -theta, 'crop'); % Rotation correction
    fixed_image(fixed_image == 0) = 255; % Converts black resgions to white regions
    fixed_image = imbinarize(fixed_image);
    fixed_image = ~fixed_image;
    
    %% Fixes dashed-line issue
%     scan_line = mean(fixed_image, 2);
%     scan_peak_thresh = mean(scan_line) + 3/2 * std(scan_line);
%     scan_filtered = (scan_line > scan_peak_thresh);
%     [~, peak_locs] = findpeaks(double(scan_filtered));
%     for i=1 : size(peak_locs)
%         for j=1 : size(fixed_image, 2)
%             fixed_image(peak_locs(i), j) = 1;
%         end
%     end
    
end

function theta = getTheta(gray_image)
    %% Edge detection and linking
    binaryImage = edge(gray_image,'canny'); % 'Canny' edge detector
    binaryImage = bwmorph(binaryImage,'thicken'); % A morphological operation for edge linking

    %% Radon transform 
    theta = -90:89;
    [R] = radon(binaryImage,theta);
    [R1] = max(R);

    %% Line detection....
    theta_max = 90;
    while(theta_max > 50 || theta_max<-50)
        [~,theta_max] = max(R1); % R2: Maximum Radon transform value over all angles. 
                                  % theta_max: Corresponding angle 
        R1(theta_max) = 0; % Remove element 'R2' from vector 'R1', so that other maximum values can be found.
        theta_max = theta_max - 91;
    end
    theta = theta_max;
    
end
