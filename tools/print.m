%load('Export_DELTA.mat');
%load('Export_ECG_gui.mat');

%resample delta e smooth dell'andamento
[Delta_r,y1]=resample(Delta_con,linspace(1,length(Delta_con),length(Delta_con)),0.0004);
[times_r,y2]=resample(times,linspace(1,length(times),length(times)),0.0004);
Delta_s=smooth(Delta_r,0.04,'rloess');


%% stampa ipnogramma
subplot(3,1,1);

load('events.mat');
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
subplot(3,1,3);plot(tacogramma(:,1),LFHF,'color','b');
hold on; plot(tacogramma(:,1),LFHF_s,'color','r','linewidth',3); grid on;

xlim([-800 fs-800]); % per slittare finestra
ylim([0 4]); 



%% normalizzo delta e lf/hf
coeff_n_delta = max(Delta_s(1:(end/2),1));
Delta_n(:,1) = Delta_s(:,1) ./ coeff_n_delta; 

coeff_n_lfhf = max(LFHF_s(:,1));
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

