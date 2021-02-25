
function [] = saveNoReferenceQualityMetricsToExcel(brisqueImg,brisqueWimg,niqeImg,niqeWimg,piqeImg,piqeWimg)

baseFileName = 'NoReference.xlsx';
fullFileName = fullfile(strcat(pwd,'\metrics'), baseFileName);

checkforfile=exist(strcat(pwd,'\metrics\',baseFileName),'file');
if checkforfile==0; % if not create new one
    header = {'brisqueImg','brisqueWimg','niqeImg','niqeWimg','piqeImg','piqeWimg'};
    xlswrite(fullFileName,header,'Sheetname','A1');
    N=0;
else % if yes, count the number of previous inputs
    N=size(xlsread('metrics\NoReference','Sheetname'),1);
end
% add the new values (your input) to the end of Excel file
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));
EE=strcat('E',num2str(N+2));
FF=strcat('F',num2str(N+2));

xlswrite(fullFileName,brisqueImg,'Sheetname',AA);
xlswrite(fullFileName,brisqueWimg,'Sheetname',BB);
xlswrite(fullFileName,niqeImg,'Sheetname',CC);
xlswrite(fullFileName,niqeWimg,'Sheetname',DD);
xlswrite(fullFileName,piqeImg,'Sheetname',EE);
xlswrite(fullFileName,piqeWimg,'Sheetname',FF);

end
