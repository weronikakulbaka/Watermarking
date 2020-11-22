
function [] = saveNoReferenceQualityMetricsToExcel(brisqueImg,brisqueWimg,niqeImg,niqeWimg,piqeImg,piqeWimg)

% Check if you have created an Excel file previously or not 
checkforfile=exist(strcat(pwd,'\','NoReference.xls'),'file');
if checkforfile==0; % if not create new one
    header = {'brisqueImg','brisqueWimg','niqeImg','niqeWimg','piqeImg','piqeWimg'};
    xlswrite('NoReference',header,'Sheetname','A1');
    N=0;
else % if yes, count the number of previous inputs
    N=size(xlsread('NoReference','Sheetname'),1);
end
% add the new values (your input) to the end of Excel file
AA=strcat('A',num2str(N+2));
BB=strcat('B',num2str(N+2));
CC=strcat('C',num2str(N+2));
DD=strcat('D',num2str(N+2));
EE=strcat('E',num2str(N+2));
FF=strcat('F',num2str(N+2));

xlswrite('NoReference',brisqueImg,'Sheetname',AA);
xlswrite('NoReference',brisqueWimg,'Sheetname',BB);
xlswrite('NoReference',niqeImg,'Sheetname',CC);
xlswrite('NoReference',niqeWimg,'Sheetname',DD);
xlswrite('NoReference',piqeImg,'Sheetname',EE);
xlswrite('NoReference',piqeWimg,'Sheetname',FF);

end
