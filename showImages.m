function[]= showImages(oryginalImage,watermark,watermarkedImage,extractedWatermark)
figure
    subplot(2,3,1)
        imshow(oryginalImage),title('Obraz oryginalny');
    subplot(2,3,2)
        imshow(watermark),title('Znak wodny');
    subplot(2,3,3)
        imshow(watermarkedImage),title('Obraz oznakowany');
    subplot(2,3,4)
        imshow(extractedWatermark),title('Wyekstraktowany znak wodny');
end