
V = VideoReader( 'video.mp4' ); % create a video reader object
I_first_frame = readFrame(V); % read the first video frame
Ig = rgb2gray(I_first_frame);

numFrames = 1; % initialize a variable for number of frames
points = detectHarrisFeatures(Ig); % detect trackable points
 % (needs grayscale image)
 
points = points.Location; % get Nx2 vector of x-y locations
pointTracker = vision.PointTracker; % Create KLT tracker object
initialize(pointTracker, points, I_first_frame); % initialize the tracker with
% points in the first frame

while hasFrame(V) % iterate till end of video
    I = readFrame(V); % read current frame
    % track the points in the current frame using the point tracker object. Tracked points are in ‘points’, and pointValidity 
    %stores 0 if the point was lost (for instance because it left the cameraviewport).
    
    [points,pointValidity] = step(pointTracker,I);
    pointsVideo(:,:,numFrames) = points; % may want to pre-initialize
    % pointsVideo, else this will be
    % very slow
    numFrames = numFrames + 1;
end

imshow(I);
hold on;
%plot( points(:,1),points(:,2), 'g+');
topleft = [round(points(167,1)),round(points(167,2))];

S = imread('mySource.jpg');
%[Saligned, Scrop] = alignSource( S,I_first_frame,topleft);
z = size(Scrop);
M = roipoly(Saligned,[round( pointsVideo(167,1,1)),round( pointsVideo(167,1,1))+z(2),round(pointsVideo(167,1,1))+z(2),round(pointsVideo(167,1,1))],[round( pointsVideo(167,2,1)),round(pointsVideo(167,2,1)),round( pointsVideo(167,2,1))+z(1),round(pointsVideo(167,2,1))+z(1)]);
M=im2double(M);
V = VideoReader( 'video.mp4' ); % create a video reader object
vOut = VideoWriter('outputVideo.mp4','MPEG-4');
open(vOut);
numFrames = 1;
z = size(Scrop);
while hasFrame(V) % iterate till end of video
    I = readFrame(V);
    I = im2double(I);   
    frame = Saligned .* M + I .* (1-M);
    frame(find(frame>1)) = round(frame(find(frame>1))); %some values were going above 1 by like 0.0010
    frame(find(frame<0)) = round(frame(find(frame<0)));
    numFrames = numFrames + 1;
    if(numFrames <131)
        Saligned = alignSource( S,I,[round(pointsVideo(167,1,numFrames)), round(pointsVideo(167,2,numFrames))],[z(1),z(2)]);
    M = roipoly(Saligned,[round( pointsVideo(167,1,numFrames)),round( pointsVideo(167,1,numFrames))+z(2),round(pointsVideo(167,1,numFrames))+z(2),round(pointsVideo(167,1,numFrames))],[round( pointsVideo(167,2,numFrames)),round(pointsVideo(167,2,numFrames)),round( pointsVideo(167,2,numFrames))+z(1),round(pointsVideo(167,2,numFrames))+z(1)]);
    M=im2double(M);
    end
    writeVideo(vOut,frame);
end
close(vOut);