function[]  =saveFullReferenceQualityMetricsToExcel(peaksnr, err, ber,ssimResult,multissimResult,multissim3Result)
% Check if you have created an Excel file previously or not 
checkforfile=exist(strcat(pwd,'\','FullReference.xls'),'file');
if checkforfile==0; % if not create new one
    header = {'peaksnr', 'mse', 'ber','ssim','multissim','multissim3'};
    xlswrite('FullReference',header,'Sheetname','A1');
    N=0;
else % if yes, count the number of previous inputs
    N=size(xlsread('FullReference','Sheetname'),1);
end
% add the new values (your input) to the end of Excel file
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));
EE=strcat('E',num2str(N+2));
FF=strcat('F',num2str(N+2));

xlswrite('FullReference',peaksnr,'Sheetname',AA);
xlswrite('FullReference',err,'Sheetname',BB);
xlswrite('FullReference',ber,'Sheetname',CC);
xlswrite('FullReference',ssimResult,'Sheetname',DD);
xlswrite('FullReference',multissimResult,'Sheetname',EE);
xlswrite('FullReference',multissim3Result,'Sheetname',FF);

end

