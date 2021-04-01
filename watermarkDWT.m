function [y] = watermarkDWT(oryginalImage,watermark, fileName)
    %dwt na oryginalnym obrazie
    img = oryginalImage;
    [m, n , ~]=size(img);
    [img_LL,img_LH,img_HL,img_HH]=dwt2(img,'haar');
    %dwt na watermarku
    wimg = watermark;
    wimg = imresize(wimg,[m n]);
    [wimg_LL,~,~,~]=dwt2(wimg,'haar');
    %osadzanie
    wimg_LL = img_LL + (0.03*wimg_LL);
    watermarked = idwt2(wimg_LL,img_LH,img_HL,img_HH,'haar');
    imwrite(uint8(watermarked),strcat('./WatermarkedImages/',fileName)); 
    y = uint8(watermarked);
end

