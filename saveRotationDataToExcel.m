function[]  =saveRotationDataToExcel(first, second, third,forth,fifth,sixth)
baseFileName = 'Rotation.xlsx';
fullFileName = fullfile(strcat(pwd,'\BERdataAfterAttacks'), baseFileName);
checkforfile=exist(strcat(pwd,'\BERdataAfterAttacks','\','Rotation.xls'),'file');
if checkforfile==0 
    N=0;
else 
 N=size(xlsread('BERdataAfterAttacks\Rotation','Sheetname'),1);
end
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));
EE=strcat('E',num2str(N+2));
FF=strcat('F',num2str(N+2));



xlswrite(fullFileName,first,'Sheetname',AA);
xlswrite(fullFileName,second,'Sheetname',BB);
xlswrite(fullFileName,third,'Sheetname',CC);
xlswrite(fullFileName,forth,'Sheetname',DD);
xlswrite(fullFileName,fifth,'Sheetname',EE);
xlswrite(fullFileName,sixth,'Sheetname',FF);


end