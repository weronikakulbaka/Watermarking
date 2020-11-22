%%Motion attack
function [attacked_image] = motionAttack(watermarked_image)
    h = fspecial('motion',7,4);
  [attacked_image] =  imfilter(watermarked_image,h,'replicate');
end

