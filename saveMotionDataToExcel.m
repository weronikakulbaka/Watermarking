function[]  =saveMotionDataToExcel(first, second, third,forth)
checkforfile=exist(strcat(pwd,'\','BERdataAfterAttacks\','MotionAttackResults.xls'),'file');
if checkforfile==0 
    N=0;
else 
 N=size(xlsread('BERdataAfterAttacks\MotionAttackResults','Sheetname'),1);
end
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));

baseFileName = 'MotionAttackResults.xlsx';
fullFileName = fullfile(strcat(pwd,'\BERdataAfterAttacks'), baseFileName);

xlswrite(fullFileName,first,'Sheetname',AA);
xlswrite(fullFileName,second,'Sheetname',BB);
xlswrite(fullFileName,third,'Sheetname',CC);
xlswrite(fullFileName,forth,'Sheetname',DD);


end