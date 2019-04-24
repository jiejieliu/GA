function main
A = imread('pears.png');
figure,imshow(A);
B = smooth(A,12,6);
figure,imshow(B);
[C,D] = segement(B,5);
figure,imshow(C); 
figure,imshow(D);
end