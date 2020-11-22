
%% Gaussian Noise Attack
function [attacked_image] = noiseGauss(watermarked_image,var)
    [attacked_image] = imnoise(watermarked_image, 'gaussian', 0,var);
end