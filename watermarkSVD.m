function [y] = watermarkSVD(oryginalImage,watermark,fileName)
alpha = 0.03;
%utworzenie macierzy z obrazu oryginalnego
[U,S,V] = svd(double(oryginalImage));

[x, y] = size(watermark);
wt = double(watermark);
for p = 1:x
    for q = 1:y
        S(p,q) = S(p,q) + alpha * wt(p,q);
    end
end

[~,S_img,~] = svd(S);
wimg = U * S_img * V';

imwrite(uint8(wimg),strcat('./WatermarkedImages/',fileName));
y = uint8(wimg);
end




