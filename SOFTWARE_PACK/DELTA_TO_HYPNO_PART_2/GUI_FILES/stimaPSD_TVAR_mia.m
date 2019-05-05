function [S1,S2,C,MSC,fase,fr_dec,PSD11,PSD12,PSD21,PSD22,dec11,dec12,dec21,dec22] = stimaPSD_TVAR_mia(coef,ve,ordine,res,Ts)

%%%%%%%%%%%%%%%%% SCRIPT RIVISTO 14/7/2016

%       analisi tempo-variante -> STIMA SPETTRALE.
%       INPUT:
%       coef= matrice coefficienti modello (righe=M; colonne=p*M; terza dimensione=T)
%       ve= matrice varianza errore di predizione (righe=M; colonne=p*M; terza dimensione=T)
%       ordine = ordine modello AR
%       res = risoluzione in frequenza
%       Ts = periodo di campionamento del segnale
%       OUTPUT:
%       S1, S2 = autospettri dei segnali 1 e 2 rispettivamente
%       C = cross-spettro
%       MSC = coerenza quadratica
%       fase = fase del cross-spetro
%       PC1, PNC1 = integrale su tutte le frequenze di potenza coerente e non coerente (rispettivamente) del segnale 1
%       PC2, PNC2 = integrale su tutte le frequenze di potenza coerente e non coerente (rispettivamente) del segnale 2
%       fr_dec = asse delle frequenze
Fs=1/Ts;
fr_dec=(0:(Fs/2)/res:Fs/2);    % asse delle frequenze
npoint=length(fr_dec);

T=size(coef,3); % numero di campioni del segnale
deltaf=diff(fr_dec(1:2));

% inizializzazioni
S1=zeros(T,npoint);  
S2=zeros(T,npoint);    
C=zeros(T,npoint);   
MSC=zeros(T,npoint);
fase=zeros(T,npoint);
% PC1=zeros(T,1);
% PNC1=zeros(T,1);
% PC2=zeros(T,1);
% PNC2=zeros(T,1);
PSD11=zeros(T,npoint);  % spettro parziale 1/1
PSD12=zeros(T,npoint);  % spettro parziale 1/2
PSD21=zeros(T,npoint);  % spettro parziale 2/1
PSD22=zeros(T,npoint);  % spettro parziale 2/2
dec11=zeros(3,ordine*3,T);
dec12=zeros(3,ordine*3,T);
dec21=zeros(3,ordine*3,T);
dec22=zeros(3,ordine*3,T);

% ciclo sui campioni del segnale
for ind=1:T
    
    % coeff modello AR bivariato
    Acoef=coef(:,:,ind);
    % varianza errori predizione
    Pvar=ve(:,:,ind);
    Pvar(1,2)=0;Pvar(2,1)=0;
    a=npoint;
    w=2*pi*fr_dec*Ts;
    OM=exp(-(1i)*[1:ordine]'*w);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % METODO DEI RESIDUI PER MODELLO BIVARIATO
    % SE DI INTERESSE, METTERE IN OUTPUT I PARAMETRI SOTTOSTANTI
    [lam,a11,a12,a21,a22]=closed_loop_poles(Acoef,ordine);
    ac=lam;
    % AUTOSPETTRO SEGNALE 1 DECOMPOSTO IN SPETTRI PARZIALI
    %%% s11 = spettro parziale (1/1) 
    b=[1 -a22];vep=Pvar(1,1);
    [s11,pow11]=mio_residui2(ac,b,vep,Ts,ordine,fr_dec);
%     [bs11,bpow11,~,cc1,tp1]=mio_residui2_mex(ac,b,vep,Ts,ordine,fr_dec);  % Per DEBUG
    dec11(:,1:size(pow11,2),ind)=pow11;
    PSD11(ind,:)=abs(s11);
    % dec11 = matrice 3D (righe = features; colonne = numero di poli; 
    % terza dimensione = numero di campioni). Riga 1 = potenza spettrale;
    % riga 2 = frequenza centrale della campana di decomposizione; 
    % riga 3 = modulo del polo.
    %%% s11 = spettro parziale (1/2)
    b=[-a12];vep=Pvar(2,2);
    [s12,pow12]=mio_residui2(ac,b,vep,Ts,ordine,fr_dec);
%     [bs12,bpow12,~,cc2,tp2]=mio_residui2_mex(ac,b,vep,Ts,ordine,fr_dec);  % Per DEBUG
    dec12(:,1:size(pow12,2),ind)=pow12; % stessa struttura di dec11
    PSD12(ind,:)=abs(s12);
    
    % AUTOSPETTRO SEGNALE 2 DECOMPOSTO IN SPETTRI PARZIALI
    %%% s21 = spettro parziale (2/1)
    b=[-a21];vep=Pvar(1,1);
    [s21,pow21]=mio_residui2(ac,b,vep,Ts,ordine,fr_dec);
%     [bs21,bpow21,~,cc3,tp3]=mio_residui2_mex(ac,b,vep,Ts,ordine,fr_dec);  % Per DEBUG
    dec21(:,1:size(pow21,2),ind)=pow21; % stessa struttura di dec11
    PSD21(ind,:)=abs(s21);
    %%% s22 = spettro parziale (2/2)
    b=[1 -a11];vep=Pvar(2,2);
    [s22,pow22]=mio_residui2(ac,b,vep,Ts,ordine,fr_dec);
%     [bs22,bpow22,~,cc4,tp4]=mio_residui2_mex(ac,b,vep,Ts,ordine,fr_dec);  % Per DEBUG
    dec22(:,1:size(pow22,2),ind)=pow22; % stessa struttura di dec11
    PSD22(ind,:)=abs(s22);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % ciclo sui punti che vanno a comporre il singolo spettro per il campione
    % considerato
    pxx=zeros(1,a);pxx=complex(pxx);
    pyy=zeros(1,a);pyy=complex(pyy);
    pxy=zeros(1,a);pxy=complex(pxy);
    pyx=zeros(1,a);pyx=complex(pyx);
    cxy=zeros(1,a);cxy=complex(cxy);
    for nf=1:a

        % omega rappresenta il vettore delle frequenze espresse in radianti.
        % durante il ciclo ottengo ciascun punto del vettore omega
        %omega = (nf-1)*pi/(npoint);
        A = zeros(2,2); % matrice A
        A=complex(A);
        for k=1:ordine
            A = A + Acoef(:,2*k-1:2*k)*OM(k,nf);
        end
        
        % definisco I-A
        AA = eye(2)- A;

        % la matrice AA è il denominatore della formula della psd. 
        % I coeff nel vettore Acoef hanno segno positivo, ecco perchè viene
        % fatto I-A

        % la matrice di trasferimento del filtro AR è l'inversa della matrice
        % AA, quindi H=inv(AA)
        AInv = inv(AA); % --> mi da la matrice N dell'articolo baselli 1997, infatti
        % N=inv(I-A)=inv(AA)

        % la mtrice spettrale spt=N*Pvar*N' 
        % power spectral density matrix
        spt  = (AInv)*(Pvar*Ts)*(AInv');

        % a questo punto dalla matrice spettrale calcolata per nf, prendo il
        % valore corrispondente al cross-spettro e quelli corrispondenti
        % all'auto-spettro
        pxx(nf) = (spt(1,1));
        pyy(nf) = (spt(2,2));   
        pxy(nf) = (spt(1,2));
        pyx(nf) = (spt(2,1));
        % calcolo della coerenza (numero complesso) 
        cxy(nf) = pxy(nf)/sqrt(pxx(nf)*pyy(nf));
    end
    
    %ora metto tutto in matrice
    S1(ind,:)=abs(pxx);   % autospettro segnale 1
    S2(ind,:)=abs(pyy);   % Autospettro segnale 2
    C(ind,:)=abs(pxy);   % cross-spettro
    MSC(ind,:)=abs(cxy).*abs(cxy);   % coerenza quadratica (0<MSC<1)
    fase(ind,:)=-angle(pxy);    % sfasamento di y rispetto a x [phi(y)-phi(x)]
    
%     % calcolo potenza coerente e non coerente
%     Pxcoer=(abs(pxx)).*MSC(ind,:);
%     Pycoer=(abs(pyy)).*MSC(ind,:);
%     Pxin=abs(pxx)-Pxcoer;
%     Pyin=abs(pyy)-Pycoer;
%     
%     % faccio integrale potenza coerente e non coerente
%     PC1(ind,:) = sum(Pxcoer)*deltaf;
%     PNC1(ind,:) = sum(Pxin)*deltaf;
%     PC2(ind,:) = sum(Pycoer)*deltaf;
%     PNC2(ind,:) = sum(Pyin)*deltaf;
    
end