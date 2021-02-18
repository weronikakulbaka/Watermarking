function[]  =saveMotionDataToExcel(first, second, third,fourth)
checkforfile=exist(strcat(pwd,'\','MotionAttackResults.xls'),'file');
if checkforfile==0 
    header = {'0.1', '0.5', '1','1.2'};
    xlswrite('MotionAttackResults',header,'Sheetname','A1');
    N=0;
else 
 N=size(xlsread('MotionAttackResults','Sheetname'),1);
end
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));

xlswrite('MotionAttackResults',first,'Sheetname',AA);
xlswrite('MotionAttackResults',second,'Sheetname',BB);
xlswrite('MotionAttackResults',third,'Sheetname',CC);
xlswrite('MotionAttackResults',fourth,'Sheetname',DD);

end