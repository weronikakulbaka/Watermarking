%%Motion attack
function [attacked_image] = motionAttack(watermarked_image, len, theta)
    h = fspecial('motion',len,theta);
  [attacked_image] =  imfilter(watermarked_image,h,'replicate');
end

