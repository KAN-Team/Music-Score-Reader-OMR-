function ConvertToSegment()
%% Converting to segments...
     image = imread('Segments/TS_4_4.tif');
     size(image)
     grayImage = rgb2gray(image);
     binarized = imbinarize(grayImage);
     imwrite(binarized, 'TEST_4.tif');
end