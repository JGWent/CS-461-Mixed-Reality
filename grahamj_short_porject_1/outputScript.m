%John Graham 
%Short Project 1

%Image 1: https://spongebob.fandom.com/wiki/Bold_and_Brash
%Citation: SpongeBob SquarePants. Full screen. Hollywood, Calif.: Distributed by Paramount Pictures, 2010.

%Image 2: Personal image


S = imread('mySource.jpg');
figure(1)
imshow(S)
T = imread('myTarget.jpg');
T = imrotate(T,-90);
figure(2)
imshow(T)
Sd = im2double(S);
Td = im2double(T);
%Saligned = alignSource( Sd,Td );
figure(3)
imshow(Saligned)
%M = roipoly(Saligned);
imshow(M)
M=im2double(M);
%imwrite(Saligned, 'mySource.png')
%imwrite(M, 'myMask.png')
%imwrite(Td, 'myTarget.png')

%%
S = imread('mySource.png');
T = imread('myTarget.png');
Saligned = im2double(S);
Td = im2double(T);
M = imread('myMask.png');
Md = im2double(M);

Gsize_1 = 7;
OutputImage1 = alphaBlending(Saligned, Td, Md, Gsize_1);
imwrite(OutputImage1,sprintf('%s_%d.png','myOutput',Gsize_1))
figure(1)
imshow(OutputImage1)

Gsize_2 = 13;
OutputImage2 = alphaBlending(Saligned, Td, Md, Gsize_2);
imwrite(OutputImage2,sprintf('%s_%d.png','myOutput',Gsize_2))
figure(2)
imshow(OutputImage2)

Gsize_3 = 25; 
OutputImage3 = alphaBlending(Saligned, Td, Md, Gsize_3);
imwrite(OutputImage3,sprintf('%s_%d.png','myOutput',Gsize_3))
figure(3)
imshow(OutputImage3)

Gsize_4 = 49; 
OutputImage4 = alphaBlending(Saligned, Td, Md, Gsize_4);
imwrite(OutputImage4,sprintf('%s_%d.png','myOutput',Gsize_4))
figure(4)
imshow(OutputImage4)

Gsize_5 = 96;
OutputImage5 = alphaBlending(Saligned, Td, Md, Gsize_5);
imwrite(OutputImage5,sprintf('%s_%d.png','myOutput',Gsize_5))
figure(5)
imshow(OutputImage5)