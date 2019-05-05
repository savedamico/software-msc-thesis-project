function BandExtrapolation()
%BANDEXTRAPOLATION Summary of this function goes here
%   Detailed explanation goes here
%MIA

global VG_taco;
global VG_S1;
global VG_S2;
global VG_MSC;
global VG_fr_dec;
global VG_BandLimits;
global VG_VLF;
global VG_LF;
global VG_HF;
global VG_pow11;
global VG_pow12;
global VG_pow21;
global VG_pow22;

global P_TOT_Taco;
global P_VLF_Taco;
global P_LF_Taco;
global P_HF_Taco;
%global P_VLF_NU_Taco;
global P_LF_NU_Taco;
global P_HF_NU_Taco;
%global P_Rapp;
%global P_Rapp_NU;
global P_TOT_Resp;
global P_VLF_Resp;
global P_LF_Resp;
global P_HF_Resp;
%global P_VLF_NU_Resp;
global P_LF_NU_Resp;
global P_HF_NU_Resp;
global P_Coer;
global P_Incoer;
%global P_RappCoer;
global PSD_parz_LF;
global PSD_parz_HF;
global PSD_parz_LF_NU;
global PSD_parz_HF_NU;
%global rapp_PSD_parz;


[VLF, LF, HF] = Bande(VG_fr_dec, VG_BandLimits);
% indici del vettore fr_dec formanti le varie bande
VG_VLF = VLF;
VG_LF = LF;
VG_HF = HF;


% Potenze
P_t = size(VG_taco,1);
P_TOT_Taco = zeros(P_t, 1);
P_VLF_Taco = zeros(P_t, 1);
P_LF_Taco = zeros(P_t, 1);
P_HF_Taco = zeros(P_t, 1);
P_LF_NU_Taco = zeros(P_t, 1);
P_HF_NU_Taco = zeros(P_t, 1);

P_TOT_Resp = zeros(P_t, 1);
P_VLF_Resp = zeros(P_t, 1);
P_LF_Resp = zeros(P_t, 1);
P_HF_Resp = zeros(P_t, 1);
P_LF_NU_Resp = zeros(P_t, 1);
P_HF_NU_Resp = zeros(P_t, 1);
PSD_parz_LF=zeros(P_t, 1);
PSD_parz_HF=zeros(P_t, 1);
PSD_parz_LF_NU=zeros(P_t, 1);
PSD_parz_HF_NU=zeros(P_t, 1);

P_Coer = zeros(P_t, 1);
P_Incoer = zeros(P_t, 1);


% parametri per tacogramma
for i=1:size(VG_pow11,3)   % ciclo sui campioni
   pow=zeros(3,2);
   PT=0;
   % le righe della matrice pow indicano la banda (1->VLF, 2->LF, 3->HF) mentre
   % le colonne indicano lo spettro di riferimento (1->PSD11, 2->PSD12)
   dec=VG_pow11;   % spettro parziale 1
   dec2=VG_pow12;   % spettro parziale 2
   
   for j=1:size(dec,2)  % ciclo sui poli  
       % vado a vedere se ci sono più poli che cadono nei range di
       % frequenze di interesse, se si, sommo le loro potenze
       % banda VLF
       if (dec(2,j,i)>=VG_BandLimits(1,1) && dec(2,j,i)<VG_BandLimits(1,2))
           % faccio un unico ciclo sulla frequenza visto che è la stessa
           % (anche il modulo del polo è lo stesso in realtà)
           if(dec(1,j,i)>0 && dec(3,j,i)<1)
               pow(1,1)=pow(1,1)+dec(1,j,i);
           end
           if(dec2(1,j,i)>0 && dec2(3,j,i)<1)
               pow(1,2)=pow(1,2)+dec2(1,j,i);
           end
       end
       % banda LF
       if (dec(2,j,i)>=VG_BandLimits(2,1) && dec(2,j,i)<VG_BandLimits(2,2))
           if(dec(1,j,i)>0 && dec(3,j,i)<1)
               pow(2,1)=pow(2,1)+dec(1,j,i);
           end
           if(dec2(1,j,i)>0 && dec2(3,j,i)<1)
               pow(2,2)=pow(2,2)+dec2(1,j,i);
           end
       end
       % banda HF
       if (dec(2,j,i)>=VG_BandLimits(3,1) && dec(2,j,i)<VG_BandLimits(3,2))
           if(dec(1,j,i)>0 && dec(3,j,i)<1)
                pow(3,1)=pow(3,1)+dec(1,j,i);
           end
           if(dec2(1,j,i)>0 && dec2(3,j,i)<1)
                pow(3,2)=pow(3,2)+dec2(1,j,i);
           end
       end
   end
   % potenza totale
   PT=sum(sum(pow));
   % calcolo la potenza associata agli spettri parziali
   ptaco_taco=sum(pow(:,1))-pow(1,1); % potenza totale meno VLF per PSD11
   p_taco_resp=sum(pow(:,2))-pow(1,2);% potenza totale meno VLF per PSD12
   PSD_parz_LF(i)=ptaco_taco;
   PSD_parz_HF(i)=p_taco_resp;
   PSD_parz_LF_NU(i)=(ptaco_taco/sum(sum(pow)))*100;  % normalizzazione rispetto autospettro meno VLF
   PSD_parz_HF_NU(i)=(p_taco_resp/sum(sum(pow)))*100;% normalizzazione rispetto autospettro meno VLF
   
   pow=sum(pow,2);
   P_TOT_Taco(i)=2*PT;
   P_VLF_Taco(i)=2*pow(1);
   P_LF_Taco(i)=2*pow(2);
   P_HF_Taco(i)=2*pow(3);
   %P_VLF_NU_Taco(i) = 100*P_VLF_Taco(i,1)/(P_TOT_Taco(i,1) - P_VLF_Taco(i,1));
   P_LF_NU_Taco(i) = 100*P_LF_Taco(i,1)/(P_TOT_Taco(i,1) - P_VLF_Taco(i,1));
   P_HF_NU_Taco(i) = 100*P_HF_Taco(i,1)/(P_TOT_Taco(i,1) - P_VLF_Taco(i,1));
  
   
end

% parametri per respirogramma
for i=1:size(VG_pow21,3)   % ciclo sui campioni
   pow=zeros(3,2);
   PT=0;
   % le righe della matrice pow indicano la banda (1->VLF, 2->LF, 3->HF) mentre
   % le colonne indicano lo spettro di riferimento (1->PSD11, 2->PSD12)
   dec=VG_pow21;   % spettro parziale 1
   dec2=VG_pow22;   % spettro parziale 2
   
   for j=1:size(dec,2)  % ciclo sui poli  
       % vado a vedere se ci sono più poli che cadono nei range di
       % frequenze di interesse, se si, sommo le loro potenze
       % banda VLF
       if (dec(2,j,i)>=VG_BandLimits(1,1) && dec(2,j,i)<VG_BandLimits(1,2))
           % faccio un unico ciclo sulla frequenza visto che è la stessa
           % (anche il modulo del polo è lo stesso in realtà)
           if(dec(1,j,i)>0 && dec(3,j,i)<1)
               pow(1,1)=pow(1,1)+dec(1,j,i);
           end
           if(dec2(1,j,i)>0 && dec2(3,j,i)<1)
               pow(1,2)=pow(1,2)+dec2(1,j,i);
           end
       end
       % banda LF
       if (dec(2,j,i)>=VG_BandLimits(2,1) && dec(2,j,i)<VG_BandLimits(2,2))
           if(dec(1,j,i)>0 && dec(3,j,i)<1)
               pow(2,1)=pow(2,1)+dec(1,j,i);
           end
           if(dec2(1,j,i)>0 && dec2(3,j,i)<1)
               pow(2,2)=pow(2,2)+dec2(1,j,i);
           end
       end
       % banda HF
       if (dec(2,j,i)>=VG_BandLimits(3,1) && dec(2,j,i)<VG_BandLimits(3,2))
           if(dec(1,j,i)>0 && dec(3,j,i)<1)
                pow(3,1)=pow(3,1)+dec(1,j,i);
           end
           if(dec2(1,j,i)>0 && dec2(3,j,i)<1)
                pow(3,2)=pow(3,2)+dec2(1,j,i);
           end
       end
   end
   % potenza totale
   PT=sum(sum(pow));
   pow=sum(pow,2);
   P_TOT_Resp(i)=2*PT;
   P_VLF_Resp(i)=2*pow(1);
   P_LF_Resp(i)=2*pow(2);
   P_HF_Resp(i)=2*pow(3);
%    P_VLF_NU_Resp(i) = 100*P_VLF_Resp(i,1)/(P_TOT_Resp(i,1) - P_VLF_Resp(i,1));
   P_LF_NU_Resp(i) = 100*P_LF_Resp(i,1)/(P_TOT_Resp(i,1) - P_VLF_Resp(i,1));
   P_HF_NU_Resp(i) = 100*P_HF_Resp(i,1)/(P_TOT_Resp(i,1) - P_VLF_Resp(i,1));
       
   % 	Potenza tacogramma secondo coerenza
   P_Coer(i) = 2*Area(VG_fr_dec, VG_S1(i,:).*VG_MSC(i,:));
   P_Incoer(i) = 2*Area(VG_fr_dec, VG_S1(i,:).*(1-VG_MSC(i,:)));
 
    

end






