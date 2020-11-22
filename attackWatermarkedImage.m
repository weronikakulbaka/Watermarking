function [] = attackWatermarkedImage(watermarkedFile,oryginalImagePath)
    wimg = imread(watermarkedFile);
    wimg=wimg(:,:,1);

%ataki
    %test funkcji ze zwracaniem parametru
    motion_attacked_image=  motionAttack(wimg);
  %   figure
    % imshowpair(uint8(img),motion_attacked_image,'montage'),title('Motion attack');  
    [median_attacked_image]= medianAttack(uint8(wimg),3);
   % figure
    % imshowpair(uint8(img),median_attacked_image,'montage'),title('Median attack');  
  
    [noise_gauss_attacked_image]= noiseGauss(wimg,0.02);
   %  figure
     %imshowpair(uint8(img),noise_gauss_attacked_image,'montage'),title('Noise gauss attack');  
     
   [noise_speckle_attacked_image]=  noiseSpeckle(wimg);
    % figure
    % imshowpair(uint8(img),noise_speckle_attacked_image,'montage'),title('Noise speckle attack');  
     
    [sharpen_attacked_image]=  sharpenAttack(wimg,0.02);
 %    figure
   %  imshowpair(uint8(img),sharpen_attacked_image,'montage'),title('Sharpen attack');  
     
   figure
    subplot(2,3,1)
        imshow(imread(oryginalImagePath)),title('Obraz oryginalny');
    subplot(2,3,2)
        imshow(wimg),title('Oznakowany obraz');
    subplot(2,3,3)
        imshow(uint8(motion_attacked_image)),title('Motion attack');
    subplot(2,3,4)
        imshow(uint8(noise_gauss_attacked_image));title('Noise attack');
  subplot(2,3,5)
        imshow(uint8(noise_speckle_attacked_image));title('Noise speckle attack');
    subplot(2,3,6)
        imshow(uint8(sharpen_attacked_image));title('Sharpen attack');
      
end