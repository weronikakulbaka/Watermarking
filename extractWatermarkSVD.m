function [y] = extractWatermarkSVD(oryginalImage, watermark, watermarkedImage, fileName)
alpha = 0.03;

%utworzenie macierzy z obrazu oryginalnego
[U,S,V] = svd(double(oryginalImage));
SIGMA = S;

% umieszczanie watermarku w obrazie 
% (trzeba wziąć sigmę i na jej podstawie umieścić watermark w obrazie)
% -- https://www.youtube.com/watch?v=QQ8vxj-9OfQ

[x y] = size(watermark);
wt = double(watermark);
for p=1:x
    for q=1:y
        S(p,q) = S(p,q) + alpha * wt(p,q);
    end
end

[U_img,S_img,V_img]=svd(S);
wimg =U* S_img * V';

%Wyciąganie znaku wodnego z obrazu
%( sigma_z_obrazu_oznakowanego - sigma_z_obrazu_oryginalnego ) / alpha

[U_wimg, S_wimg, V_wimg] =svd(wimg);

eimg = U_img* S_wimg * V_img';

for p=1:x
    for q=1:y
        watermark(p,q) = (eimg(p,q) - SIGMA(p,q))/ alpha;
    end
end

imwrite(uint8(watermark),strcat('./ExtractedWatermarks/',fileName)); 
y = uint8(watermark);
end

