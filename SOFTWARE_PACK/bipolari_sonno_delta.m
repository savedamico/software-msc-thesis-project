function bipolari_sonno_delta(DATA_FDS);
% estrazioni bipolari da elettrodi del sonno
%(bipolari_sonno_delta modificata per me)

global main_path;

Chname{1}='canale_1';
Chname{2}='canale_2';

%CHbip sono i canali 'bipolari buoni per la registrazione del delta...se possibile da scalpo
[r,c]=size(DATA_FDS);
if r==4
%estrazione dei biploari
BIP=[];
BIP(1,:)=DATA_FDS(1,:)-DATA_FDS(2,:);
BIP(2,:)=DATA_FDS(3,:)-DATA_FDS(4,:);
CHbip{1}= strcat(Chname{1},'-',Chname{2}); 
CHbip{2}= strcat(Chname{3},'-',Chname{4});
% eegplot(BIP,'srate',250);%

elseif r==6
%estrazione dei biploari
BIP=[];
BIP(1,:)=DATA_FDS(1,:)-DATA_FDS(2,:);
BIP(2,:)=DATA_FDS(3,:)-DATA_FDS(4,:);
BIP(3,:)=DATA_FDS(5,:)-DATA_FDS(6,:);
CHbip{1}= strcat(Chname{1},'-',Chname{2});
CHbip{2}= strcat(Chname{3},'-',Chname{4});
CHbip{3}= strcat(Chname{5},'-',Chname{6});

elseif r==2
BIP=[];
BIP(1,:)=DATA_FDS(1,:)-DATA_FDS(2,:);
CHbip{1}= strcat(Chname{1},'-',Chname{2});
end

%  eegplot(BIP,'srate',250);%
%% % da codice ERD-ERS di Giulia filtraggio in banda
banda_filtro=[1 5];% delta 
fc=250;
mags=[0 1 0];
devs = [0.05 0.5 0.05];
fcuts=[banda_filtro(1)-.2 banda_filtro(1) banda_filtro(2) banda_filtro(2)+.2];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fc);
n = n + rem(n,2);
coef = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
for i=1:length(CHbip)
filt_a=filtfilt(coef,1,BIP(i,:)');
filt_A(i,:)=filt_a; 
end
% eegplot(filt_A,'srate',250);%
%% % quadratura del segnale per il calcolo della potenza in banda
for i=1:length(CHbip)
        DELTA(i,:)=filt_A(i,:).*filt_A(i,:);
end

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


Delta_con=[Delta_con DELTA_mm];
times=[1/fc:1/fc:length(Delta_con(1,:))/fc];% in secondi


%% mia per stampare

%resample delta e smooth dell'andamento
[Delta_r,y1]=resample(Delta_con,linspace(1,length(Delta_con),length(Delta_con)),0.0004);
[times_r,y2]=resample(times,linspace(1,length(times),length(times)),0.0004);
Delta_s=smooth(Delta_r,0.04,'rloess');


%% stampa ipnogramma
subplot(3,1,1);

PSG=fullfile(main_path,'events.mat');
load(PSG);
slim=length(lables);
i=1;

%omologa lables (format 1,2,3,4,5)
while((lables(i,1)~=6) && (i~=slim))
    i=i+1; 
end

if(lables(i,1)==6) 
    for(i=1:slim)
        if((lables(i,1)==3)||(lables(i,1)==4)) lables(i,1)=2; end
        if(lables(i,1)==5) lables(i,1)=3; end
        if(lables(i,1)==6) lables(i,1)=4; end
        if(lables(i,1)==7) lables(i,1)=5; end
        
    end
end

i=0;

X=lables(:,2);
Y=lables(:,1);
X=X'; Y=Y';
Y=Y*(-1);


x = reshape( [X;X], 2,[] ); x(2) = [];
y = reshape( [Y;Y], 2,[] ); y(end) = [];

vnan = NaN(size(X)) ;
xp = reshape([X;vnan;X],1,[]); xp([1:2 end]) = [] ;
yp = reshape([Y;Y;vnan],1,[]); yp(end-2:end) = [] ;

xv = reshape([X;X;vnan],1,[]); xv([1:3 end]) = [] ;
yv = reshape([Y;vnan;Y],1,[]); yv([1:2 end-1:end]) = [] ;

[uy,~,colidx] = unique(Y) ;
ncolor = length(uy) ;
colormap(cool(ncolor))

cd = reshape([colidx.';colidx.';vnan],1,[]); cd(end-2:end) = [] ;
hp = patch(xp,yp,cd,'EdgeColor','flat','LineWidth',2) ;
hold on
hv = plot(xv,yv,':k') ;

xlim([0 length(Delta_con)]);
ylim([-6 0]);
xticks;
grid on;


subplot(3,1,2);plot(times_r,Delta_r,'color','k');
hold on; plot(times_r,Delta_s,'color','r','linewidth',3); grid on;
fs=length(Delta_r)/0.1;
xlim([0 fs]);
ylim([0 0.02*10^4]);
%subplot(3,1,3);plot(tacogramma(:,1),LFHF,'color','b');
%hold on; plot(tacogramma(:,1),LFHF_s,'color','r','linewidth',3); grid on;

xlim([-800 fs-800]); % per slittare finestra
ylim([0 4]); 



%% normalizzo delta e lf/hf
coeff_n_delta = max(Delta_s(1:(end/2),1));
Delta_n(:,1) = Delta_s(:,1) ./ coeff_n_delta; 

%coeff_n_lfhf = max(LFHF_s(:,1));
%LFHF_n(:,1) = LFHF_s(:,1) ./ coeff_n_lfhf;

figure();

subplot(3,1,1);
hp = patch(xp,yp,cd,'EdgeColor','flat','LineWidth',2) ;
hold on
hv = plot(xv,yv,':k') ;

xlim([0 length(Delta_con)]);
ylim([-6 0]);
xticks;
grid on;
subplot(3,1,2);
plot(times_r,Delta_n,'color','r','linewidth',3); grid on; hold on;
%plot(tacogramma_shift(:,1),LFHF_n,'color','k','linewidth',3); grid on;
xlim([0 fs]);

end