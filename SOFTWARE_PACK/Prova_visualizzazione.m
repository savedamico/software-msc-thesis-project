%%%%%%%%%%%%%%%%%-       elaborazione del delta     %%%%%%%%%%%%%%%%%%%
%clear all
%close all
%clc
%[filename PathName] = uigetfile('*.mat', 'select data', 'multiselect' ,'on');
%load('DELTA.mat');
fc=250;
filename =1;
crisi_sec=0;
Delta_con=[];
Crisi_con=[];
% filtro media mobile
nsec=10;
MM=ones(1,nsec*fc);
MM=MM/length(MM);
for file=1: length(filename)
    crisi_sec=0;
     %load(filename{file})
     DELTA_mm=[];
for i=1:length(CHbip)
DELTA_mm(i,:)=(filtfilt(MM,1,DELTA(i,:)'))';
end
%
% times=[1/fc:1/fc:length(DELTA_mm(1,:))/fc];% in secondi
% figure
% for i =1:length(CHbip)
% xx(i)=subplot(length(CHbip),1,i);
% plot(times,DELTA_mm(i,:), 'k'), xlabel('Time [s]'), xlim([0 times(end)])
% if crisi_sec~=0
% hold on, line([crisi_sec crisi_sec],[0 max(DELTA_mm(i,:))],...
% 'Color','g', 'linewidth', 2)
%  end
% ylabel(CHbip{i})
%if i==1 ;title(sprintf('%s', filename{file})); end

% end
% xx(length(CHbip)+1)=subplot(length(CHbip)+1,1,length(CHbip)+1);
% plot(times,EOG_bip, 'k'), xlabel('Time [s]'), xlim([0 times(end)])
% linkaxes(xx,'x')
Delta_con=[Delta_con DELTA_mm];
len_rec(file)=length(DELTA_mm);
if crisi_sec~=0
crisi_rec= crisi_sec+((sum(len_rec)/fc) - (len_rec(file)/fc));% in secondi dall'inizio della prima registrazione
Crisi_con=[Crisi_con crisi_rec];
end
clear Delta_mm crisi_rec
end
save xx_DELTA_10sm Delta_con Crisi_con fc CHbip
%%
times=[1/fc:1/fc:length(Delta_con(1,:))/fc];% in secondi
% len_rec1=1350025/250;
% len_rec2=1350050/250;
% crisi_sec=[2897+len_rec1*2 566+len_rec1*2+len_rec2 1291+len_rec1*2+len_rec2*2];
for i =1:length(CHbip)
xx(i)=subplot(length(CHbip),1,i);
plot(times,Delta_con(i,:), 'k'), xlabel('Time [s]'), xlim([0 times(end)])
ylim([0 200]);
% if Crisi_con~=0
    for cr=1:length(Crisi_con)
hold on, line([Crisi_con(cr) Crisi_con(cr)],[0 max(Delta_con(i,:))],...
'Color','g', 'linewidth', 2)
    end
%  end
ylabel(CHbip{i})
%if i==1 ;title(sprintf('%s', filename{file})); end

end
% xx(length(CHbip)+1)=subplot(length(CHbip)+1,1,length(CHbip)+1);
% plot(times,EOG_bip, 'k'), xlabel('Time [s]'), xlim([0 times(end)])
linkaxes(xx,'x')

%% log
times=[1/fc:1/fc:length(Delta_con(1,:))/fc];% in secondi
% len_rec1=1350025/250;
% len_rec2=1350050/250;
% crisi_sec=[2897+len_rec1*2 566+len_rec1*2+len_rec2 1291+len_rec1*2+len_rec2*2];
for i =1:length(CHbip)
xx(i)=subplot(length(CHbip),1,i);
plot(times,log10(Delta_con(i,:)), 'k'), xlabel('Time [s]'), xlim([0 times(end)])
% if Crisi_con~=0
    for cr=1:length(Crisi_con)
hold on, line([Crisi_con(cr) Crisi_con(cr)],[0 max(log10(Delta_con(i,:)))],...
'Color','g', 'linewidth', 2)
    end
%  end
ylabel(CHbip{i})
%if i==1 ;title(sprintf('%s', filename{file})); end

end
% xx(length(CHbip)+1)=subplot(length(CHbip)+1,1,length(CHbip)+1);
% plot(times,EOG_bip, 'k'), xlabel('Time [s]'), xlim([0 times(end)])
linkaxes(xx,'x')
%% %% semilog
times=[1/fc:1/fc:length(Delta_con(1,:))/fc];% in secondi
% len_rec1=1350025/250;
% len_rec2=1350050/250;
% crisi_sec=[2897+len_rec1*2 566+len_rec1*2+len_rec2 1291+len_rec1*2+len_rec2*2];
for i =1:length(CHbip)
xx(i)=subplot(length(CHbip),1,i);
semilogy(times,Delta_con(i,:), 'k'), xlabel('Time [s]'), xlim([0 times(end)]), ylim([1 10^7])
% if Crisi_con~=0
    for cr=1:length(Crisi_con)
hold on, line([Crisi_con(cr) Crisi_con(cr)],[1 100000],...
'Color','g', 'linewidth', 2)
    end
%  end
ylabel(CHbip{i})
%if i==1 ;title(sprintf('%s', filename{file})); end

end
% xx(length(CHbip)+1)=subplot(length(CHbip)+1,1,length(CHbip)+1);
% plot(times,EOG_bip, 'k'), xlabel('Time [s]'), xlim([0 times(end)])
linkaxes(xx,'x')