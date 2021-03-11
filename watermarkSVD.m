function [y] = watermarkSVD(oryginalImage,watermark,fileName)
alpha = 0.1;

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

imwrite(uint8(wimg),strcat('./WatermarkedImages/',fileName));
y = uint8(wimg);
end

