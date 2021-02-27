
function [attacked_image] = sharpenAttack(watermarked_image,strength)
    [attacked_image] = imsharpen(watermarked_image,'Amount',strength);
end
