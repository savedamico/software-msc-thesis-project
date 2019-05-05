myFolder = uigetdir;

string_point='.';

if exist(myFolder, 'dir') ~= 7
    Message = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(Message));
    return;
end



filePattern = fullfile(myFolder, '*.mat');
matFiles   = dir(filePattern);
k=1;
for j=1:length(matFiles)
    baseFileName = matFiles(j).name;
    fullFileName = fullfile(myFolder, baseFileName);
    control = strncmpi(baseFileName,string_point,1);
    if (control==0)                    
        fprintf('Now reading %s\n', fullFileName);                   
        load(fullFileName);
        B(k,1:34) = table2array(DATA_EXPORT);
        k=k+1;
    end
end
k=k-1;
j=k;
B(j+1,1:34)= 0;
B(j+2,1:34) = mean(B(1:j,1:34));


Table = array2table(B, 'VariableNames',{'LF_TACO','HF_TACO',...
        'LFHF_TACO','TOT_TACO','NLF_TACO','NHF_TACO',...
        'NLFNHF_TACO','NTOT_TACO','POT_COER','POT_INCOER','COER_INCOER',...
        'PSD_HF','PSD_LF','PSD_LFHF','PSD_NHF','PSD_NLF','PSD_NLFNHF',...
        'std_LF_TACO','std_HF_TACO',...
        'std_LFHF_TACO','std_TOT_TACO','std_NLF_TACO','std_NHF_TACO',...
        'std_NLFNHF_TACO','std_NTOT_TACO','std_POT_COER','std_POT_INCOER','std_COER_INCOER',...
        'std_PSD_HF','std_PSD_LF','std_PSD_LFHF','std_PSD_NHF','std_PSD_NLF','std_PSD_NLFNHF'});
save('Table_evento','Table');
clear all;
close all;
