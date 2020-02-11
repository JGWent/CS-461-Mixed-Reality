%John graham 

S = imread('mySource.png'); % my source is already alligned from before and saved as mySource.png
T = imread('myTarget.png');
Saligned = im2double(S);
Td = im2double(T);
M = imread('myMask.png');
Md = im2double(M);

Gsize_1 = [7 13 25];
OutputImage1 = pyramidBlending(Saligned, Td, Md, Gsize_1);
imwrite(OutputImage1,'myPyramidOutput.png')
figure(1)
imshow(OutputImage1)
