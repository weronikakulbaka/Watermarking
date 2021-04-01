function [watermarkedImg] = watermark_DWT_SVD(oryginalImage,watermark,fileName)

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

%watermarking
S = S_img+0.03*S_wimg;
watermarked = U_img * S * V_img';
watermarkedImage = idwt2(watermarked, img_LH, img_HL, img_HH, 'haar');

%figure;imshow(uint8(watermarkedImage));title('Watermarked Image');

imwrite(uint8(watermarkedImage),strcat('./WatermarkedImages/',fileName));
watermarkedImg = uint8(watermarkedImage);

end

