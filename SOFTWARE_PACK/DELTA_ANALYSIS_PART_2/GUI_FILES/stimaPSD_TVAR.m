function [S1,S2,C,MSC,fase,fr_dec,PSD11,PSD12] = stimaPSD_TVAR(coef,ve,res,Ts)

%%%%%%%%%%%%%%%%% SCRIPT RIVISTO 14/7/2016

%       analisi tempo-variante -> STIMA SPETTRALE.
%       INPUT:
%       coef= matrice coefficienti modello (righe=M; colonne=p*M; terza dimensione=T)
%       ve= matrice varianza errore di predizione (righe=M; colonne=p*M; terza dimensione=T)
%       res = risoluzione in frequenza (numero di campioni in output)
%       Ts = periodo di campionamento del segnale
%       OUTPUT:
%       S1, S2 = autospettri dei segnali 1 e 2 rispettivamente
%       C = cross-spettro
%       MSC = coerenza quadratica
%       fase = fase del cross-spettro
%       fr_dec = asse delle frequenze
Fs = 1/Ts;
npoint = res+1;
fr_dec = linspace(0,Fs/2, npoint);
%fr_dec=0:(Fs/2)/res:Fs/2;    % asse delle frequenze
%npoint=length(fr_dec);

T = size(coef,3); % numero di campioni del segnale
ordine = round(size(coef, 2)/size(coef,1)); %ordine del modello AR

% inizializzazioni
S1 = zeros(T,npoint);  
S2 = zeros(T,npoint);    
C = zeros(T,npoint);   
MSC = zeros(T,npoint);
fase = zeros(T,npoint);
PSD11 = zeros(T,npoint); 
PSD12 = zeros(T,npoint); 

for ind=1:T
    
    % coeff modello AR bivariato
    Acoef = coef(:,:,ind);
    % varianza errori predizione
    Pvar = ve(:,:,ind);
    Pvar(1,2) = 0;
	Pvar(2,1) = 0;
    %a=npoint;
    w=2*pi*fr_dec*Ts;
    OM=exp(-(1i)*(1:ordine)'*w);
    
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % METODO DEI RESIDUI PER MODELLO BIVARIATO
    % SE DI INTERESSE, METTERE IN OUTPUT I PARAMETRI SOTTOSTANTI
    [lam,a11,a12,a21,a22]=closed_loop_poles(Acoef,ordine);
    ac=lam;
    % AUTOSPETTRO SEGNALE 1 DECOMPOSTO IN SPETTRI PARZIALI
    %%% s11 = spettro parziale (1/1) 
    b=[1 -a22];vep=Pvar(1,1);
    [s11,pow11]=mio_residui2(ac,b,vep,Ts,ordine,fr_dec); 
    dec11(:,1:size(pow11,2),ind)=pow11;
    PSD11(ind,:)=abs(s11);
    % dec11 = matrice 3D (righe = features; colonne = numero di poli; 
    % terza dimensione = numero di campioni). Riga 1 = potenza spettrale;
    % riga 2 = frequenza centrale della campana di decomposizione; 
    % riga 3 = modulo del polo.
    %%% s11 = spettro parziale (1/2)
    b=[-a12];vep=Pvar(2,2);
    [s12,pow12]=mio_residui2(ac,b,vep,Ts,ordine,fr_dec); 
    dec12(:,1:size(pow12,2),ind)=pow12; % stessa struttura di dec11
    PSD12(ind,:)=abs(s12);
    
    % AUTOSPETTRO SEGNALE 2 DECOMPOSTO IN SPETTRI PARZIALI
    %%% s21 = spettro parziale (2/1)
    b=[-a21];vep=Pvar(1,1);
    [s21,pow21]=mio_residui2(ac,b,vep,Ts,ordine,fr_dec); 
    dec21(:,1:size(pow21,2),ind)=pow21; % stessa struttura di dec11
    %%% s22 = spettro parziale (2/2)
    b=[1 -a11];vep=Pvar(2,2);
    [s22,pow22]=mio_residui2(ac,b,vep,Ts,ordine,fr_dec);
    dec22(:,1:size(pow22,2),ind)=pow22; % stessa struttura di dec11
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % ciclo sui punti che vanno a comporre il singolo spettro per il campione
    % considerato
    
    %preallocazioni
    pxx = zeros(npoint, 1)*1i;
    pyy = zeros(npoint, 1)*1i;
    pxy = zeros(npoint, 1)*1i;
    pyx = zeros(npoint, 1)*1i;
    cxy = zeros(npoint, 1)*1i;
    for nf=1:npoint

        % omega rappresenta il vettore delle frequenze espresse in radianti.
        % durante il ciclo ottengo ciascun punto del vettore omega
        %omega = (nf-1)*pi/(npoint);
        A = zeros(2,2)*1i; % matrice A
        for k=1:ordine
            A = A + Acoef(:,2*k-1:2*k)*OM(k,nf);
        end
       
        %gain_alpha(ind,nf) = abs(A(1,2)/(1-A(1,1)));
        
        %gain_beta(ind,nf) = abs(A(2,1)/(1-A(2,2)));
        
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
    S1(ind,:) = abs(pxx);   % autospettro segnale 1
    S2(ind,:) = abs(pyy);   % Autospettro segnale 2
    C(ind,:) = abs(pxy);   % cross-spettro
    MSC(ind,:) = abs(cxy).*abs(cxy);   % coerenza quadratica (0<MSC<1)
    fase(ind,:) = -angle(pxy);    % sfasamento di y rispetto a x [phi(y)-phi(x)]
    
end