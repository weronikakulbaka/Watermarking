function [y] = extract_DWT_SVD(oryginalImage, watermark, watermarkedImage, fileName)
%oryginal image
img = oryginalImage;
[img_LL,img_LH,img_HL,img_HH]=dwt2(img,'haar');
[U_img,S_img,V_img]= svd(img_LL);

%figure;imshow(uint8(img));title('Oryginal Image');

%watermark
wimg = watermark;
[wimg_LL, wimg_LH, wimg_HL, wimg_HH] = dwt2(wimg, 'haar');
[U_wimg, S_wimg, V_wimg] = svd(wimg_LL);

%figure;imshow(uint8(wimg));title('Watermark');

%watermarked
wmimg = watermarkedImage;
[wmimg_LL, wmimg_LH, wmimg_HL, wmimg_HH] = dwt2(wmimg, 'haar');
[U_wmimg, S_wmimg, V_wmimg] = svd(wmimg_LL);

%figure;imshow(uint8(wmimg));title('Watermarked image');
%extraction
S = (S_wmimg - S_img)/0.03;
extraction = U_wimg*S*V_wimg';

extractedWatremark = idwt2(extraction, wimg_LH, wimg_HL, wimg_HH, 'haar');

imwrite(uint8(extractedWatremark),strcat('./ExtractedWatermarks/',fileName)); 
%figure;imshow(uint8(extractedWatremark));title('Extracted watremark');

y = uint8(extractedWatremark);
end

