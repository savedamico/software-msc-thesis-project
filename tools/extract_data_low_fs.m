ECG_number=7;
RESP_number=9;
EEG_number=5;

ECG=signalCell(ECG_number);
ECG=cell2mat(ECG);

RESP=signalCell(RESP_number);
RESP=cell2mat(RESP);



for(i=1:EEG_number)
    tmp=signalCell(i);
    tmp=cell2mat(tmp);
    EEG_tmp(:,i)=tmp;
end

big1=length(ECG);
big2=length(RESP);

xv1=linspace(1,big1,big1);
xv2=linspace(1,big2,big2);

var1=250/256;
var2=250/32;

[RESP,y]=resample(RESP,xv2,var2);
[ECG,y]=resample(ECG,xv1,var1);


for(i=1:EEG_number)
    [EEG(:,i),y]=resample(EEG_tmp(:,i),xv1,var1);
end

save('ECG.mat','ECG');
save('RESP.mat','RESP');
save('EEG.mat','EEG');






save('ECG.mat','ECG');
save('RESP.mat','RESP');
save('EEG.mat','EEG');
