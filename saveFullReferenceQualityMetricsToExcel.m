function[]  =saveFullReferenceQualityMetricsToExcel(peaksnr, err, ber,ssimResult,multissimResult,multissim3Result)

  baseFileName = 'FullReference.xlsx';
  fullFileName = fullfile(strcat(pwd,'\metrics'), baseFileName);
checkforfile=exist(strcat(pwd,'\metrics\',baseFileName),'file');
if checkforfile==0; % if not create new one
    header = {'peaksnr', 'mse', 'ber','ssim','multissim','multissim3'};
    xlswrite(fullFileName,header,'Sheetname','A1');
    N=0;
else % if yes, count the number of previous inputs
    N=size(xlsread('metrics\FullReference','Sheetname'),1);
end

% add the new values (your input) to the end of Excel file
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));
EE=strcat('E',num2str(N+2));
FF=strcat('F',num2str(N+2));

xlswrite(fullFileName,peaksnr,'Sheetname',AA);
xlswrite(fullFileName,err,'Sheetname',BB);
xlswrite(fullFileName,ber,'Sheetname',CC);
xlswrite(fullFileName,ssimResult,'Sheetname',DD);
xlswrite(fullFileName,multissimResult,'Sheetname',EE);
xlswrite(fullFileName,multissim3Result,'Sheetname',FF);

end

