Origin=im2double(imread('butterfly.jpg'));
figure;
imshow(Origin);
for hr=4
    hs=4;
    [newImage,edge]=meanShiftSeg(Origin,hs,hr);
    figure;
    imshow(newImage);
    figure;
    imshow(edge);
end
    