function [y] = extractWatermarkDWT(oryginalImage, watermark, watermarkedImage, fileName)
    %orginalny obraz dwt
    img = oryginalImage;
    [m, n , ~] = size(img);
    [img_LL,~,~,~] = dwt2(img,'haar');
    %watermark dwt
    wimg = watermark;
    wimg = imresize(wimg,[m n]);
    [~,wimg_LH,wimg_HL,wimg_HH] = dwt2(wimg,'haar');
    %oznakowany obraz dwt
    wm = watermarkedImage;
    [wm_LL,~,~,~] = dwt2(wm,'haar');
    %ekstrakcja
    eimg= (wm_LL-img_LL)/0.03;
    watermark = idwt2(eimg,wimg_LH,wimg_HL,wimg_HH,'haar');
    imwrite(uint8(watermark),strcat('./ExtractedWatermarks/',fileName));  
    y = uint8(watermark);
end

