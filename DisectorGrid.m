%Sections should be horizontal

%Use of the script: Place the images (ending in .tif!) the should receive 
%a Grid overlay in a folder with this script. 
%A subfolder Grid will be created with the grid overlay images.

function DisectorGrid(PixelSize,DisectorSize,DisectorInterval,type)


%%%% INPUT
if(~exist('PixelSize','var'))
    PixelSize = 0.173; %in ?m x190
end
%PixelSize = 0.145; %in ?m x230

if(~exist('DisectorSize','var'))
    DisectorSize = 5; %in ?m
end
DisectorSizeInPixels = round(DisectorSize / PixelSize);

if(~exist('DisectorInterval','var'))
DisectorInterval = 50;
end
DisectorIntervalInPixels = round(DisectorInterval / PixelSize);

%defining the output folder name
OutputFolder = 'Grid/';
mkdir(OutputFolder);

%Sections
Sections = dir('*.tif');
%Initialize the random number generator state
rand('state',sum(100*clock));

%for loop through all disector images
for i=1:length(Sections)
  im = uint8(imread(Sections(i).name,'tif'));
  %prepare an initial random starting position
  randx = ceil(rand*(DisectorIntervalInPixels-DisectorSizeInPixels))...
      +ceil(DisectorSizeInPixels/2);
  randy = ceil(rand*(DisectorIntervalInPixels-DisectorSizeInPixels))...
      +ceil(DisectorSizeInPixels/2);
  %prepare a color image for the position overlay
  colorim = zeros(size(im,1),size(im,2),3);
  colorim(:,:,1) = im;
  colorim(:,:,2) = im;
  colorim(:,:,3) = im;
  
  %make the center pixels of the disectors red
  for j=randx:DisectorIntervalInPixels:size(im,1)
      for k=randy:DisectorIntervalInPixels:size(im,2)
          colorim(j-ceil(DisectorSizeInPixels/2):j+floor(DisectorSizeInPixels/2)-1,...
              k-ceil(DisectorSizeInPixels/2):k+floor(DisectorSizeInPixels/2)-1,1) = 255;
          %Comment or uncomment the following lines to determine the
          %transparency of the disector squares
          %colorim(j-ceil(DisectorSize/2):j+floor(DisectorSize/2)-1,...
          %    k-ceil(DisectorSize/2):k+floor(DisectorSize/2)-1,2) = 0;
          %colorim(j-ceil(DisectorSize/2):j+floor(DisectorSize/2)-1,...
          %    k-ceil(DisectorSize/2):k+floor(DisectorSize/2)-1,3) = 0;
      end
  end
  imwrite(uint8(colorim),strcat(OutputFolder,Sections(i).name),'tif');
end