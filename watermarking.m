clc;
clear all;
close all;

filelist = dir('medicalDB');
for i=1 : length(filelist)
  filename = filelist(i);
  if ~strcmp(filename.name , '.') && ~strcmp(filename.name , '..')
      oryginalImagePath = sprintf('./medicalDB/%s', filename.name);
      watermarkImage = 'watermark_logo.png';
      fileName = filename.name;

      oryginalImagePath = imread(oryginalImagePath);
      oryginalImagePath=rgb2gray(oryginalImagePath);
      
      watermarkImage = imread(watermarkImage);
      watermarkImage=rgb2gray(watermarkImage);
     
      
      watermarkedImage = watermark(oryginalImagePath, watermarkImage, fileName);
      extractedWatermarkImage = ext_watermark(oryginalImagePath, watermarkImage, watermarkedImage, fileName);
    % showImages(oryginalImagePath,watermarkImage,watermarkedImage,extractedWatermarkImage);
      pointers(oryginalImagePath,watermarkImage);
  %   attackWatermarkedImage(watermarkedImage,oryginalImagePath)
     % rotateAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName);
     % motionAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName);
      sharpeningAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName);

     
  end
end


function y=watermark(oryginalImage,watermark, fileName)
host=oryginalImage;
[m n p]=size(host);
[host_LL,host_LH,host_HL,host_HH]=dwt2(host,'haar');
water_mark=watermark;
water_mark=imresize(water_mark,[m n]);
[water_mark_LL,water_mark_LH,water_mark_HL,water_mark_HH]=dwt2(water_mark,'haar');
water_marked_LL = host_LL + (0.03*water_mark_LL);
watermarked=idwt2(water_marked_LL,host_LH,host_HL,host_HH,'haar');
imwrite(uint8(watermarked),strcat('./WatermarkedImages/',fileName)); 
 
y=uint8(watermarked);
end


function [y]=ext_watermark(oryginalImage,watermark,watermarkedImage,fileName)
host=oryginalImage;
[m n p]=size(host);
[host_LL,host_LH,host_HL,host_HH]=dwt2(host,'haar');
water_mark=watermark;
water_mark=imresize(water_mark,[m n]);
[water_mark_LL,water_mark_LH,water_mark_HL,water_mark_HH]=dwt2(water_mark,'haar');
wm = watermarkedImage;
[wm_LL,wm_LH,wm_HL,wm_HH]=dwt2(wm,'haar');
extracted_watermark= (wm_LL-host_LL)/0.03;
ext=idwt2(extracted_watermark,water_mark_LH,water_mark_HL,water_mark_HH,'haar');
imwrite(uint8(ext),strcat('./ExtractedWatermarks/',fileName)); 

y = uint8(ext);
end

function pointers(img, wimg)
%PSNR
[peaksnr, snr] = psnr(wimg, img);
%fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%fprintf('\n The SNR value is %0.4f \n', snr);

%MSE
err = immse(wimg, img);
%fprintf('\n The mean-squared error is %0.4f\n', err);


%BER
ber = biterr(wimg, img);
%fprintf('\n BER %d\n', ber);

%SSIM
ssimResult = ssim(img,wimg);
%fprintf('\n SSIM %d\n', ssimResult);


%MULTISSIM
multissimResult = multissim(img,wimg);
%fprintf('\n MULTISSIM %d\n', multissimResult);

%MULTISSIM3
multissim3Result = multissim3(wimg,img,'Sigma',1)
%fprintf('\n MULTISSIM3 %d\n', multissim3Result);

%No-Reference Quality Metrics
%BRISQUE
brisqueImg = brisque(img);
brisqueWimg = brisque(wimg);

%NIQE
niqeImg = niqe(img);
niqeWimg = niqe(wimg);

%PIQE
piqeImg = piqe(img);
piqeWimg = piqe(wimg);

saveNoReferenceQualityMetricsToExcel(peaksnr, err, ber, ssimResult,multissimResult,multissim3Result);
end


function[] = rotateAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName)
     n = 0.01;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     first = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     n=0.1;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     second = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
      
     n=0.15;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     third = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     n=0.2;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     forth = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     n=0.3;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     fifth = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     n=0.4;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     sixth = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     saveRotationDataToExcel(first, second, third,forth,fifth,sixth);
     
end

function[ber] = calculateBERafterAttack(attackedMarkedImage,watermarkImage,oryginalImagePath, fileName)
     extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, attackedMarkedImage, fileName);
     ber = biterr(watermarkImage, extractedWatermarkImage2);
end

function[] = motionAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName)
     len = 0.1;
     theta = 4;
     attacked_image = motionAttack(watermarkedImage,len,theta);
     first = calculateBERafterAttack(attacked_image, watermarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     len = 0.5;
     theta = 4;
     attacked_image = motionAttack(watermarkedImage,len,theta);
     second = calculateBERafterAttack(attacked_image, watermarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     len = 1;
     theta = 4;
     attacked_image = motionAttack(watermarkedImage,len,theta);
     third = calculateBERafterAttack(attacked_image, watermarkedImage,watermarkImage,oryginalImagePath, fileName);
    
     len = 1.2;
     theta = 4;
     attacked_image = motionAttack(watermarkedImage,len,theta);
     fourth = calculateBERafterAttack(attacked_image, watermarkedImage,watermarkImage,oryginalImagePath, fileName);
    
     saveMotionDataToExcel(first, second, third,fourth);
     
end


function[] = sharpeningAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName)
      strength=0.02;
      sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);
     extractedWatermarkImage1 = ext_watermark(oryginalImagePath, watermarkImage, sharpen_attacked_image, fileName);
   
     strength=0.5;
     sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);
     extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, sharpen_attacked_image, fileName);
     
     strength=1;
     sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);
     extractedWatermarkImage3 = ext_watermark(oryginalImagePath, watermarkImage, sharpen_attacked_image, fileName);
     
     strength=2;
     sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);
     extractedWatermarkImage4 = ext_watermark(oryginalImagePath, watermarkImage, sharpen_attacked_image, fileName);
     
     
     figure
    subplot(2,3,1)
        imshow(extractedWatermarkImage1),title('1');
    subplot(2,3,2)
        imshow(extractedWatermarkImage2),title('2');
    subplot(2,3,3)
        imshow(extractedWatermarkImage3),title('3');
    subplot(2,3,4)
        imshow(extractedWatermarkImage4),title('4');
     
     
     %sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);

    % first = calculateBERafterAttack(strength, watermarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     %len = 0.5;
    % theta = 4;
    % second = calculateBERafterAttack(strength, watermarkedImage,watermarkImage,oryginalImagePath, fileName);
     
    %len = 1;
     %theta = 4;
    % third = calculateBERafterAttack(strength, watermarkedImage,watermarkImage,oryginalImagePath, fileName);
    
      %len = 1.2;
     %theta = 4;
    % fourth = calculateBERafterAttack(strength, watermarkedImage,watermarkImage,oryginalImagePath, fileName);
    
    % saveMotionDataToExcel(first, second, third,fourth);
     
end



