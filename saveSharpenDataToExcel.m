function[]  =saveSharpenDataToExcel(first, second, third,forth)
baseFileName = 'SharpeningAttackResults.xlsx';
fullFileName = fullfile(strcat(pwd,'\BERdataAfterAttacks'), baseFileName);
checkforfile=exist(strcat(pwd,'\','BERdataAfterAttacks\',baseFileName),'file');

if checkforfile==0 
    N=0;
else 
 N=size(xlsread('BERdataAfterAttacks\SharpeningAttackResults','Sheetname'),1);
end
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));



xlswrite(fullFileName,first,'Sheetname',AA);
xlswrite(fullFileName,second,'Sheetname',BB);
xlswrite(fullFileName,third,'Sheetname',CC);
xlswrite(fullFileName,forth,'Sheetname',DD);


end