%% Speckle Noise Attack
function [attacked_image] = noiseSpeckle(watermarked_image)
[attacked_image] = imnoise(watermarked_image, 'speckle', 0.001);
end