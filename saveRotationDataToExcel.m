function[]  =saveRotationDataToExcel(first, second, third,forth,fifth,sixth)
checkforfile=exist(strcat(pwd,'\','Rotation.xls'),'file');
if checkforfile==0 
   % header = {'0.01', '0.1', '0.15','0.2','0.3','0.4'};
   % xlswrite('Rotation',header,'Sheetname','A1');
    N=0;
else 
 N=size(xlsread('Rotation','Sheetname'),1);
end
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));
EE=strcat('E',num2str(N+2));
FF=strcat('F',num2str(N+2));


xlswrite('Rotation',first,'Sheetname',AA);
xlswrite('Rotation',second,'Sheetname',BB);
xlswrite('Rotation',third,'Sheetname',CC);
xlswrite('Rotation',forth,'Sheetname',DD);
xlswrite('Rotation',fifth,'Sheetname',EE);
xlswrite('Rotation',sixth,'Sheetname',FF);


end