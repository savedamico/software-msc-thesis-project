function   [coef,ve] = modelloAR_TVAR(dati,p,lambda)

%%%%%%%%%%%%%%%%% SCRIPT RIVISTO 14/7/2016

%       analisi tempo-variante -> CALCOLO COEFFICIENTI MODELLO.
%       INPUT:
%       dati= matrice TxM (T=numero di campioni, M=numero di segnali da analizzare)
%       p = ordine del modello
%       lambda = coefficiente di oblio
%       OUTPUT:
%       coef= matrice coefficienti modello (righe=M; colonne=p*M; terza dimensione=T)
%       ve= matrice varianza errore di predizione (righe=M; colonne=p*M; terza dimensione=T)

T=size(dati,1); % num campioni
M=size(dati,2); % num segnali
% Inizializzazioni dei vettori
p = round(p); % p deve essere intero
THETA  = zeros(M,M*p);  % parametri del modello AR, si tratta di una matrice con
% tante righe quanti sino i segnali e un numero di
% colonne pari al doppio dei parametri

% la matrice THETA definita per l'istante temporale n, equivale alla
% matrice An=[An(1) An(2) ... An(p)]

P = 1*eye(M*p);    % matrice di covarianza        
fi_tot=zeros(M*p,1);    % vettore delle osservazioni

% matrici che verranno restitite in uscita 
coef=zeros(M,M*p,T);
ve=zeros(M,M,T);

if p > T % se non ci sono abbastanza campioni
    return;
end

% inizializzazione del vettore delle osservazioni utilizzando tutti i
% segnali
for sig=1:M
    fi=dati(1:p,sig);
    fi_tot(sig:M:end)=fi(end:-1:1);
end

% inizializzazione delle variabili che conterranno i termini di interesse
varep = zeros(M,M);
oldvarep=zeros(M,M);

w = eye(M)*lambda;
% W=ones(M*p);
% % matrice coeff oblio. Ho visto che i termini legati al tacogramma
% % vanno a finire nelle righe e colonne dispari della matrice P, ecco
% % perchè creo una matrice W avente sulle righe e colonne dispari il
% % coef di oblio del taco e altrove il coeff di oblio del respiro
% for sig=1:M
%     W(sig:M:end,:)=w(sig,sig);
%     W(:,sig:M:end)=w(sig,sig);
% end
%modifica di efficienza
W = ones(M*p)*lambda;

% Algoritmo 
for i=p+1:T

	Pfi_tot   = P*fi_tot;
    denom = mean(diag(w)) + fi_tot'* Pfi_tot;
    % guadagno tempo variante
	K = Pfi_tot/denom;
	% matrice di covarianza
    P = (P-K*fi_tot'*P)./W;
    % le righe precedenti sono tutte corrette
    
    sample=dati(i,:);
    % errore a priori
    E = sample' - THETA*fi_tot;
    % var errore a priori
    %vvv = (E*E').*(1-w)+oldvvv.*w;
    
    % aggiornamento dei coefficienti del modello
    THETA=THETA+E*K';
    % errore a posteriori perchè calcolato con i coeff nuovi
    Ep = sample' - THETA*fi_tot;
    % varianza dell'errore di predizione(errore a posteriori)
    varep = (Ep*Ep').*(1-w)+oldvarep.*w;
        
    % aggiornamenti del vettore delle osservazioni 
    fi_tot = [sample';fi_tot(1:M*p-M)];
    oldvarep = varep;
    %oldvvv=vvv;
        
    % salvataggio parametri
    coef(:,:,i) = THETA;
    ve(:,:,i) = varep;

end

% faccio in modo che le prime 2p righe abbiano i coefficienti che trovo
% nelle righe 2p+1 e 2p+2 corrispondenti al p+1esimo campione del segnale.
% Faccio lo stesso per coeff di oblio e eper la varianza dell'errore di
% predizione
for ll=1:p
    coef(:,:,ll)=coef(:,:,p+1);
    ve(:,:,ll)=ve(:,:,p+1);
end