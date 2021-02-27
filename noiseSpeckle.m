%% Speckle Noise Attack
function [attacked_image] = noiseSpeckle(watermarked_image,value)
[attacked_image] = imnoise(watermarked_image, 'speckle', value);
end