function [y] = extractWatermarkDWT(oryginalImage, watermark, watermarkedImage, fileName)
    host = oryginalImage;
    [m, n , ~] = size(host);
    [host_LL,~,~,~] = dwt2(host,'haar');
    water_mark = watermark;
    water_mark = imresize(water_mark,[m n]);
    [~,water_mark_LH,water_mark_HL,water_mark_HH] = dwt2(water_mark,'haar');
    wm = watermarkedImage;
    [wm_LL,~,~,~] = dwt2(wm,'haar');
    extracted_watermark= (wm_LL-host_LL)/0.03;
    ext = idwt2(extracted_watermark,water_mark_LH,water_mark_HL,water_mark_HH,'haar');
    imwrite(uint8(ext),strcat('./ExtractedWatermarks/',fileName));  
    y = uint8(ext);
end

