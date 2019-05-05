myFolder = 'G:\TESI MAGISTRALE\Valid-resp-pks+filtri_save\PAZIENTE 21\S3';

if exist(myFolder, 'dir') ~= 7
    Message = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(Message));
    return;
end

filePattern = fullfile(myFolder, '*.mat');
matFiles = dir(filePattern);

for i=1:length(matFiles)
    baseFileName = matFiles(i).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf('Now reading %s\n', fullFileName);
    load(fullFileName);
    clear sig_respiro;
    [sig_respiro]=maling_respiro_beta1(sig_ECG);
    save(fullFileName,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');
        
end
clear all
%% eliminare tacogramma e respirogramm
%myFolder = 'G:\TESI MAGISTRALE\Valid-resp\PAZIENTE 1\S3';

%if exist(myFolder, 'dir') ~= 7
%    Message = sprintf('Error: The following folder does not exist:\n%s', myFolder);
%    uiwait(warndlg(Message));
%    return;
%end

%filePattern = fullfile(myFolder, '*.mat');
%matFiles = dir(filePattern);

%for i=1:length(matFiles)
%    baseFileName = matFiles(i).name;
%    fullFileName = fullfile(myFolder, baseFileName);
%    fprintf('Now reading %s\n', fullFileName);
%    load(fullFileName);
%    save(fullFileName,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');
%end