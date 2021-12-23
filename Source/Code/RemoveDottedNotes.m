function result = RemoveDottedNotes(stave_section)
    % @Author: Kareem Sherif / KAN Org...

    %% Finding the dots for the dotted notes
    figure, imshow(stave_section); title("BEFORE");
    stave_section = bwareaopen(stave_section, 20);
    se = strel('square', 3);
    stave_section = imclose(stave_section, se);

    [B, L] = bwboundaries(stave_section, 'noholes');
    stats = regionprops(L, 'Area', 'Centroid');
    threshold = 1;
    dots_centred = [];

    for k = 1 : length(B)
      boundary = B{k};
      delta_sq = diff(boundary).^ 2;    
      perimeter = sum(sqrt(sum(delta_sq,2)));
      area = stats(k).Area;
      metric = 4 * pi*area / perimeter^2;
      if metric > threshold
        centroid = stats(k).Centroid;
        dots_centred(end+1,:) = round(centroid);    
      end
    end
    clear B k L stats threshold boundary delta_sq perimeter area metric centroid;

    %% Deleting the dots from the image (the radius is approx. 6 pixels)
    radius = 1;
    for i=1 : size(dots_centred,1)
        for j = dots_centred(i,1)-radius+1 : dots_centred(i,1)+radius
            for k=dots_centred(i,2)-radius : dots_centred(i,2)+radius
                stave_section(k, j) = 0;
            end
        end
    end
    stave_section = imdilate(stave_section, strel('disk', 1));
    figure, imshow(stave_section); title("AFTER");
    clear i j k;
    result = stave_section;

end