function [y] = watermarkDWT(oryginalImage,watermark, fileName)
    host = oryginalImage;
    [m, n , ~]=size(host);
    [host_LL,host_LH,host_HL,host_HH]=dwt2(host,'haar');
    water_mark = watermark;
    water_mark = imresize(water_mark,[m n]);
    [water_mark_LL,~,~,~]=dwt2(water_mark,'haar');
    water_marked_LL = host_LL + (0.03*water_mark_LL);
    watermarked = idwt2(water_marked_LL,host_LH,host_HL,host_HH,'haar');
    imwrite(uint8(watermarked),strcat('./WatermarkedImages/',fileName)); 
    y = uint8(watermarked);
end

