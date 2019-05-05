%% dopo aver eseguito blockEDF e plotEDF, per capire il numero dei canali di interesse

ECG_number=25;
RESP_number=32;
EEG_number=19;

ECG=signalCell(ECG_number);
ECG=cell2mat(ECG);

RESP=signalCell(RESP_number);
RESP=cell2mat(RESP);

for(i=1:EEG_number)
    tmp=signalCell(i);
    tmp=cell2mat(tmp);
    EEG_tmp(:,i)=tmp;
end

big=length(ECG);
xv=linspace(1,big,big);
[RESP,y]=resample(RESP,xv,0.5);
[ECG,y]=resample(ECG,xv,0.5);
for(i=1:EEG_number)
    [EEG(:,i),y]=resample(EEG_tmp(:,i),xv,0.5);
end

save('ECG.mat','ECG');
save('RESP.mat','RESP');
save('EEG.mat','EEG');
