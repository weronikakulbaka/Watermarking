clc;
clear all;
close all;

filelist = dir('TrainingData');
for i=1 : length(filelist)
  filename = filelist(i);
  if ~strcmp(filename.name , '.') && ~strcmp(filename.name , '..')
      oryginalImagePath = sprintf('./TrainingData/%s', filename.name);
      watermarkFile = 'watermark.png';
      fileName = filename.name;
      watermark(oryginalImagePath, watermarkFile, fileName)
  end
end

filelist = dir('WatermarkedImages');
for i=1 : length(filelist)
  filename = filelist(i);
  if ~strcmp(filename.name , '.') && ~strcmp(filename.name , '..')
      oryginalImagePath = sprintf('./TrainingData/%s', filename.name);
      watermarkFile = 'watermark.png';
      watermarkedFile = sprintf('./WatermarkedImages/%s',filename.name);
      fileName = filename.name;
      ext_watermark(oryginalImagePath, watermarkFile, watermarkedFile, fileName);
  end
end

filelist = dir('ExtractedWatermarks');
for i=1 : length(filelist)
  filename = filelist(i);
  if ~strcmp(filename.name , '.') && ~strcmp(filename.name , '..')
      oryginalImagePath = sprintf('./TrainingData/%s', filename.name);
      watermarkFile = 'watermark.png';
      watermarkedFile = sprintf('./WatermarkedImages/%s',filename.name);
      extractedWatermark = sprintf('./ExtractedWatermarks/%s',filename.name);
      showImages(oryginalImagePath,watermarkFile,watermarkedFile,extractedWatermark)
  end
end



function watermark(oryginalImage,watermark, fileName)
host=imread(oryginalImage);
[m n p]=size(host);
[host_LL,host_LH,host_HL,host_HH]=dwt2(host,'haar');
water_mark=imread(watermark);
water_mark=imresize(water_mark,[m n]);
[water_mark_LL,water_mark_LH,water_mark_HL,water_mark_HH]=dwt2(water_mark,'haar');
water_marked_LL = host_LL + (0.03*water_mark_LL);
watermarked=idwt2(water_marked_LL,host_LH,host_HL,host_HH,'haar');
imwrite(uint8(watermarked),strcat('./WatermarkedImages/',fileName)); 


pointers(host,watermarked)
%figure
    %subplot(1,3,1)
        %imshow(host),title('Obraz oryginalny');
    %subplot(1,3,2)
        %imshow(water_mark),title('Watermark');
    %subplot(1,3,3)
        %imshow(uint8(watermarked)),title('Obraz oznakowany');

end


function ext_watermark(oryginalImage,watermark,watermarkedImage,fileName)
host=imread(oryginalImage);
[m n p]=size(host);
[host_LL,host_LH,host_HL,host_HH]=dwt2(host,'haar');
water_mark=imread(watermark);
water_mark=imresize(water_mark,[m n]);
[water_mark_LL,water_mark_LH,water_mark_HL,water_mark_HH]=dwt2(water_mark,'haar');
wm=imread(watermarkedImage);
[wm_LL,wm_LH,wm_HL,wm_HH]=dwt2(wm,'haar');
extracted_watermark= (wm_LL-host_LL)/0.03;
ext=idwt2(extracted_watermark,water_mark_LH,water_mark_HL,water_mark_HH,'haar');
imwrite(uint8(ext),strcat('./ExtractedWatermarks/',fileName)); 
%figure
%imshow(uint8(ext));
%title('Extracted watermark');
end


function showImages(oryginalImage,watermark,watermarkedImage,extractedWatermark)
figure
    subplot(2,3,1)
        imshow(oryginalImage),title('Obraz oryginalny');
    subplot(2,3,2)
        imshow(watermark),title('Znak wodny');
    subplot(2,3,3)
        imshow(watermarkedImage),title('Obraz oznakowany');
    subplot(2,3,4)
        imshow(extractedWatermark),title('Wyekstraktowany znak wodny');
end


function pointers(img, wimg)
%PSNR
[peaksnr, snr] = psnr(uint8(wimg), uint8(img));
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f \n', snr);

%MSE
err = immse(uint8(wimg), uint8(img));
fprintf('\n The mean-squared error is %0.4f\n', err);

end
