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
      showImages(oryginalImagePath,watermarkImage,watermarkedImage,extractedWatermarkImage);
      pointers(oryginalImagePath,watermarkImage);
    % attackWatermarkedImage(watermarkedImage,oryginalImagePath)
      calculateBERForRotatedWatermarkedImages(watermarkedImage,watermarkImage,oryginalImagePath, fileName);
      
     
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


function y=ext_watermark(oryginalImage,watermark,watermarkedImage,fileName)
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
[peaksnr, snr] = psnr(wimg, img);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f \n', snr);

%MSE
err = immse(wimg, img);
fprintf('\n The mean-squared error is %0.4f\n', err);


%BER
ber = biterr(wimg, img);
fprintf('\n BER %d\n', ber);

%SSIM
ssimResult = ssim(img,wimg);
fprintf('\n SSIM %d\n', ssimResult);


%MULTISSIM
multissimResult = multissim(img,wimg);
fprintf('\n MULTISSIM %d\n', multissimResult);

%MULTISSIM3
multissim3Result = multissim3(wimg,img,'Sigma',1)
fprintf('\n MULTISSIM3 %d\n', multissim3Result);

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



function calculateBERForRotatedWatermarkedImages(watermarkedImage,watermarkImage,oryginalImagePath, fileName)
      n = 0.01;
      for k = 1 : 10
      rotatedMarkedImage = imrotate(watermarkedImage,n,'bilinear','crop');
      extractedWatermarkImage2 = ext_watermark(oryginalImagePath, watermarkImage, rotatedMarkedImage, fileName);
      n=n-0.01;
      
      ber = biterr(watermarkImage, extractedWatermarkImage2);
      checkforfile=exist(strcat(pwd,'\','Rotation.xls'),'file');
      if checkforfile==0; 
       header = {'ber'};
       xlswrite('Rotation',header,'Sheetname','A1');
       N=0;
      else 
       N=size(xlsread('Rotation','Sheetname'),1);
      end
      AA=strcat('A',num2str(N+2));
      xlswrite('Rotation',ber,'Sheetname',AA);

      end
end
