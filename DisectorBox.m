function DisectorBox(PixelSize,DisectorSize,Thickness)
if(~exist('PixelSize','var'))
    %PixelSize = 0.173; %in ?m x190
    PixelSize = 0.145; %in ?m x230
end
if(~exist('DisectorSize','var'))
    DisectorSize = 5; %in ?m
end
DisectorSizeInPixels = round(DisectorSize / PixelSize);
if(~exist('DisectorSize','var'))
    Thickness = 50; %in pixels
end
OutputFolder = 'Boxed/';
mkdir(OutputFolder);
%Sections
Sections = dir('*.tif');
%for loop through all disector images
for i=1:length(Sections)
  im = uint8(imread(Sections(i).name,'tif'));
  colorim = zeros(size(im,1),size(im,2),3);
  colorim(:,:,1) = im;
  colorim(:,:,2) = im;
  colorim(:,:,3) = im;
  startx = ceil(size(im,1)/2)-ceil(DisectorSizeInPixels/2)-Thickness+1;
  starty = ceil(size(im,2)/2)-ceil(DisectorSizeInPixels/2)-Thickness+1;
  stopx = ceil(size(im,1)/2)+floor(DisectorSizeInPixels/2)+Thickness;
  stopy = ceil(size(im,2)/2)+floor(DisectorSizeInPixels/2)+Thickness;
  colorim(startx:stopx,starty:stopy,1) = 255;
  startx = ceil(size(im,1)/2)-ceil(DisectorSizeInPixels/2)+1;
  starty = ceil(size(im,2)/2)-ceil(DisectorSizeInPixels/2)+1;
  stopx = ceil(size(im,1)/2)+floor(DisectorSizeInPixels/2);
  stopy = ceil(size(im,2)/2)+floor(DisectorSizeInPixels/2);
  colorim(startx:stopx,starty:stopy,1) = im(startx:stopx,starty:stopy,1);
  imwrite(uint8(colorim),strcat(OutputFolder,Sections(i).name),'tif');
end