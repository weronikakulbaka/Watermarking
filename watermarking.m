clc;
clear all;
close all;

destinationFolder = 'medicalDB';

filelist = dir(destinationFolder);
for i=1 : length(filelist)
  filename = filelist(i);
  if ~strcmp(filename.name , '.') && ~strcmp(filename.name , '..')
      oryginalImagePath = sprintf('./%s/%s',destinationFolder, filename.name);
      watermarkImage = 'watermark_logo.png';
      fileName = filename.name;

      oryginalImagePath = imread(oryginalImagePath);
      oryginalImagePath=rgb2gray(oryginalImagePath);
      
      watermarkImage = imread(watermarkImage);
      watermarkImage=rgb2gray(watermarkImage);
 
      watermarkedImage = watermark(oryginalImagePath, watermarkImage, fileName);
          
   extractedWatermarkImage = ext_watermark(oryginalImagePath, watermarkImage, watermarkedImage, fileName);
   
   %showImages(oryginalImagePath,watermarkImage,watermarkedImage,extractedWatermarkImage);
   %  pointers(oryginalImagePath,extractedWatermarkImage);
     %attackWatermarkedImage(watermarkedImage,oryginalImagePath)
   %  rotateAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName);
    % doMotionAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName);
      sharpeningAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName);
   %  doNoiseGaussAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName);
 %out = imtile({watermarkImage,extractedWatermarkImage}, 'BorderSize', 1, 'BackgroundColor','black');
 %figure
 %imshow(out);

% timeElapsed = toc;
% disp(timeElapsed)
% saveTimeToExcel(timeElapsed);
end

  end




function[]  =saveTimeToExcel(time)
baseFileName = 'Time.xlsx';
fullFileName = fullfile(strcat(pwd,'\metrics'), baseFileName);
checkforfile=exist(strcat(pwd,'\','metrics\',baseFileName),'file');
if checkforfile==0 
    N=0;
else 
 N=size(xlsread('metrics\Time','Sheetname'),1);
end
AA=strcat('A',num2str(N+2));
xlswrite(fullFileName,time,'Sheetname',AA);
end


function y = watermark(oryginalImage,watermark, fileName)

 
%y = watermarkDWT(oryginalImage,watermark, fileName);
  %   y = watermarkSVD(oryginalImage,watermark,fileName);
    y = watermark_DWT_SVD(oryginalImage,watermark,fileName);

end


function [y] = ext_watermark(oryginalImage, watermark, watermarkedImage, fileName)
  % y = extractWatermarkDWT(oryginalImage, watermark, watermarkedImage, fileName);
% y = extractWatermarkSVD(oryginalImage, watermark, watermarkedImage, fileName);
 
 y = extract_DWT_SVD(oryginalImage, watermark, watermarkedImage, fileName);

end

function pointers(img, wimg)
    [peaksnr] = psnr(wimg, img);
    ssimResult = ssim(img,wimg);
    multissimResult = multissim(img,wimg);
    multissim3Result = multissim3(wimg,img,'Sigma',1);
    brisqueImg = brisque(img);
    brisqueWimg = brisque(wimg);
    niqeImg = niqe(img);
    niqeWimg = niqe(wimg);
    piqeImg = piqe(img);
    piqeWimg = piqe(wimg);
    [~,mse,maxerr,L2rat] = measerr(img,wimg);
   % disp(mse);
 
    
saveNoReferenceQualityMetricsToExcel(brisqueImg, brisqueWimg, niqeImg, niqeWimg,piqeImg,piqeWimg);
saveFullReferenceQualityMetricsToExcel(peaksnr, ssimResult,multissimResult,multissim3Result,mse,maxerr,L2rat);
end


function[] = rotateAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName)
     n = 0.01;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     first = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage1 = ext_watermark(oryginalImagePath, watermarkImage, rotatedMarkedImage, fileName);


     n=0.1;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     second = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
      
     n=0.5;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     third = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     extractedWatermarkImage1 = ext_watermark(oryginalImagePath, watermarkImage, rotatedMarkedImage, fileName);
% out = imtile({watermarkedImage,rotatedMarkedImage}, 'BorderSize', 1, 'BackgroundColor','black');
% figure
% imshow(out);  
% 
% out = imtile({watermarkImage,extractedWatermarkImage1}, 'BorderSize', 1, 'BackgroundColor','black');
% figure
% imshow(out);  
% %      
     n=10;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     forth = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
          extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, rotatedMarkedImage, fileName);

     n=45;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     fifth = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
      extractedWatermarkImage3 = ext_watermark(oryginalImagePath, watermarkImage, rotatedMarkedImage, fileName);

     n=90;
     rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
     sixth = calculateBERafterAttack(rotatedMarkedImage,watermarkImage,oryginalImagePath, fileName);
     
     extractedWatermarkImage4 = ext_watermark(oryginalImagePath, watermarkImage, rotatedMarkedImage, fileName);
% out = imtile({watermarkedImage,rotatedMarkedImage}, 'BorderSize', 1, 'BackgroundColor','black');
% figure
% imshow(out);  
% 
% out = imtile({watermarkImage,extractedWatermarkImage4}, 'BorderSize', 1, 'BackgroundColor','black');
% figure
% imshow(out);  
%     figure
%     subplot(2,3,1)
%         imshow(extractedWatermarkImage1),title('1');
%     subplot(2,3,2)
%         imshow(extractedWatermarkImage2),title('2');
%     subplot(2,3,3)
%         imshow(extractedWatermarkImage3),title('3');
%     subplot(2,3,4)
%         imshow(extractedWatermarkImage4),title('4');
     
     
     
      saveRotationDataToExcel(first, second, third,forth,fifth,sixth);
     
end

function[ratio] = calculateBERafterAttack(attackedMarkedImage,watermarkImage,oryginalImagePath, fileName)
     extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, attackedMarkedImage, fileName);
     [ber,ratio] = biterr(watermarkImage, extractedWatermarkImage2); 
     ratio = ratio*100;
 
end

function[] = doMotionAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName)
     len = 2;
     theta = 5;
     attacked_image = motionAttack(watermarkedImage,len,theta);
     first = calculateBERafterAttack(attacked_image,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage1 = ext_watermark(oryginalImagePath, watermarkImage, attacked_image, fileName);

     
     len = 5;
     theta = 10;
     attacked_image = motionAttack(watermarkedImage,len,theta);
     second = calculateBERafterAttack(attacked_image,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, attacked_image, fileName);

     
     len = 20;
     theta = 30;
     attacked_image = motionAttack(watermarkedImage,len,theta);
     third = calculateBERafterAttack(attacked_image,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage3 = ext_watermark(oryginalImagePath, watermarkImage, attacked_image, fileName);

     
     len = 50;
     theta = 70;
     attacked_image = motionAttack(watermarkedImage,len,theta);
     fourth = calculateBERafterAttack(attacked_image,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage4 = ext_watermark(oryginalImagePath, watermarkImage, attacked_image, fileName);

     
     
% out = imtile({watermarkedImage,attacked_image}, 'BorderSize', 1, 'BackgroundColor','black');
% figure
% imshow(out);  
% 
% out = imtile({watermarkImage,extractedWatermarkImage4}, 'BorderSize', 1, 'BackgroundColor','black');
% figure
% imshow(out); 
     saveMotionDataToExcel(first, second, third,fourth);
     
end


function[] = sharpeningAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName)
%       strength=0.02;
%       sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);
%      extractedWatermarkImage1 = ext_watermark(oryginalImagePath, watermarkImage, sharpen_attacked_image, fileName);
%    
%      strength=0.07;
%      sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);
%      extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, sharpen_attacked_image, fileName);
%      
%      strength=0.1;
%      sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);
%      extractedWatermarkImage3 = ext_watermark(oryginalImagePath, watermarkImage, sharpen_attacked_image, fileName);
%      
%      strength=0.2;
%      sharpen_attacked_image =  sharpenAttack(watermarkedImage,strength);
%      extractedWatermarkImage4 = ext_watermark(oryginalImagePath, watermarkImage, sharpen_attacked_image, fileName);
%      
%      
%      figure
%     subplot(2,3,1)
%         imshow(extractedWatermarkImage1),title('1');
%     subplot(2,3,2)
%         imshow(extractedWatermarkImage2),title('2');
%     subplot(2,3,3)
%         imshow(extractedWatermarkImage3),title('3');
%     subplot(2,3,4)
%         imshow(extractedWatermarkImage4),title('4');
     
     
      strength=0.5;
      sharpenAttackedImage =  sharpenAttack(watermarkedImage,strength);
      first = calculateBERafterAttack(sharpenAttackedImage,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage1 = ext_watermark(oryginalImagePath, watermarkImage, sharpenAttackedImage, fileName);

        
     strength=7;
     sharpenAttackedImage =  sharpenAttack(watermarkedImage,strength);
      second = calculateBERafterAttack(sharpenAttackedImage,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, sharpenAttackedImage, fileName);

      
      
     strength=15;
     sharpenAttackedImage =  sharpenAttack(watermarkedImage,strength);
     third = calculateBERafterAttack(sharpenAttackedImage,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage3 = ext_watermark(oryginalImagePath, watermarkImage, sharpenAttackedImage, fileName);

     
     strength=20;
     sharpenAttackedImage =  sharpenAttack(watermarkedImage,strength);
     fourth = calculateBERafterAttack(sharpenAttackedImage,watermarkImage,oryginalImagePath, fileName);
     extractedWatermarkImage4 = ext_watermark(oryginalImagePath, watermarkImage, sharpenAttackedImage, fileName);

%      
%      out = imtile({watermarkedImage,sharpenAttackedImage}, 'BorderSize', 1, 'BackgroundColor','black');
% figure
% imshow(out);  
% 
% out = imtile({watermarkImage,extractedWatermarkImage1}, 'BorderSize', 1, 'BackgroundColor','black');
% figure
% imshow(out);
     
     
     saveSharpenDataToExcel(first, second, third,fourth);
     
end

function[] = doNoiseGaussAttack(watermarkedImage,watermarkImage,oryginalImagePath, fileName)
       value=0.00001;
       gauss_attacked_image =  noiseSpeckle(watermarkedImage,value);
      extractedWatermarkImage1 = ext_watermark(oryginalImagePath, watermarkImage, gauss_attacked_image, fileName);

       value=0.0001;
       gauss_attacked_image =  noiseSpeckle(watermarkedImage,value);
      extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, gauss_attacked_image, fileName);

       value=0.001;
       gauss_attacked_image =  noiseSpeckle(watermarkedImage,value);
      extractedWatermarkImage3 = ext_watermark(oryginalImagePath, watermarkImage, gauss_attacked_image, fileName);

       value=0.01;
       gauss_attacked_image =  noiseSpeckle(watermarkedImage,value);
      extractedWatermarkImage4 = ext_watermark(oryginalImagePath, watermarkImage, gauss_attacked_image, fileName);



out = imtile({watermarkedImage,gauss_attacked_image}, 'BorderSize', 1, 'BackgroundColor','black');
figure
imshow(out);       
      
%      figure
%     subplot(2,3,1)
%         imshow(extractedWatermarkImage1),title('1');
%     subplot(2,3,2)
%         imshow(extractedWatermarkImage2),title('2');
%     subplot(2,3,3)
%         imshow(extractedWatermarkImage3),title('3');
%     subplot(2,3,4)
%         imshow(extractedWatermarkImage4),title('4');
%      
     
%       strength=0.02;
%       sharpenAttackedImage =  sharpenAttack(watermarkedImage,strength);
%        first = calculateBERafterAttack(sharpenAttackedImage,watermarkImage,oryginalImagePath, fileName);
% 
%      strength=0.07;
%      sharpenAttackedImage =  sharpenAttack(watermarkedImage,strength);
%       second = calculateBERafterAttack(sharpenAttackedImage,watermarkImage,oryginalImagePath, fileName);
% 
%      strength=0.1;
%      sharpenAttackedImage =  sharpenAttack(watermarkedImage,strength);
%      third = calculateBERafterAttack(sharpenAttackedImage,watermarkImage,oryginalImagePath, fileName);
% 
%      strength=0.2;
%      sharpenAttackedImage =  sharpenAttack(watermarkedImage,strength);
%      fourth = calculateBERafterAttack(sharpenAttackedImage,watermarkImage,oryginalImagePath, fileName);
% 
%      saveSharpenDataToExcel(first, second, third,fourth);
     
end



