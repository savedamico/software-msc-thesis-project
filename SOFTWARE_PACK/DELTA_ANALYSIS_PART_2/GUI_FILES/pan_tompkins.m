
function [tacogramma,respirogramma,locs]=pan_tompkins(ECG,resp,fs_ecg,tempo)

    % INPUT:
    % ECG: segnale ECG passato alla funzione come vettore colonna
    % resp: segnale respiratorio passato alla funzione come vettore colonna
    % fs_ecg: frequenza di campionamento del segnale ECG
    % tempo: vettore riga del tempo

    % OUTPUT:
    % tacogramma: matrice a due colonne, nella colonna 1 c'è l'istante di tempo
    % corrispondente al picco R dell'ECG, nella colonna 2 c'è la distanza RR
    % respirogramma: matrice a due colonne, nella colonna 1 c'è l'istante di tempo
    % corrispondente al picco R dell'ECG, nella colonna 2 c'è il valore del
    % segnale respiratorio campionato in corrispondenza del picco R
    % locs: posizione del picco R (espressa in campioni)

    %--------PARAMETRI---------%
    Q_factor = 5;   
    campioni_media_mobile = round(0.150 * fs_ecg);
    % Pier MOD: l'ideale sarebbe impostare automaticamente questo valore
    %           in base alla frequenza di campionamento dell'ECG
    %           considerato: Pan e Tompkins suggeriscono di impostare
    %           numero di campioni corrispondente a durata media del QRS:
    %           loro suggeriscono 150 ms. In effetti la durata media di un
    %           QRS non penso cambi molto in soggetti sani ...
    %--------------------------%

    
    % - Filtro Passa-Banda
    n = 20;             % n coefficienti del filtro
    fc = 17;            % frequenza centrale
    Q = Q_factor;       % Q factor
    BW = fc/Q;          % BandWidth
    banda = [(fc-BW/2)*2/fs_ecg (fc+BW/2)*2/fs_ecg];    % normalizzo la banda rispetto alla fs/2
    b = fir1(n,banda);  % coeff del filtro passa-banda
    y = filtfilt(b,1,ECG); % in y ho il segnale filtrato; uso filtfilt per avere fase nulla e quindi segnale non distorto

    
    % - Filtro derivatore
    H = [1/5 1/10 0 -1/10 -1/5];  % Coeff filtro derivatore
    y = filter(H,1,y);            % Ora derivo il segnale che prima avevo filtrato passa-banda:
                                  % evidenzio così il QRS che è una variazione veloce del segnale
    MDeriv=length(H)-1;           % PierMOD: Calcoliamo il ritardo imposto dal filtro FIR
    ritDeriv = round(MDeriv/2);   %
    y(1:MDeriv)=0;                % PierMOD: Transitorio di avvio del filtro derivatore:
                                  %          escludiamo i primi M (ordine modello) campioni dai passaggi
                                  %          successivi.
    
    % NB: il filtro derivatore qui usato è di tipo NON RICORSIVO (è un filtro "all-zeros" infatti
    %     a denominatore della FdT abbiamo messo 1 --> FIR) e SIMMETRICO (con
    %     simmetria dispari) e, quindi, a fase lineare. H sono i
    %     coefficienti (in questo caso sono tutti zeri) del filtro.
    % NB2: Nell'help di Matlab si sconsiglia l'uso di "filtfilt" con i
    %      filtri derivatori--> le differenze in termini di ampiezza
    %      relativa tra i picchi si sentono molto rispetto ad utilizzare il
    %      semplice "filter": ho provato a re-implementare il
    %      filtro derivatore calcolando il ritardo generato e riallineando
    %      il segnale ottenuto, anziché utilizzare "filtfilt". La
    %      differenza si vede soprattutto con gli ECG rumorosi (proprio
    %      quelli che fanno funzionare male la funzione originale).

    
    % - Quadratura + media mobile
    y = y.^2;   % elevo al quadrato il segnale filtrato e derivato
    N = campioni_media_mobile;
    % il filtraggio con il filtro scritto sotto equivale ad una media mobile
    % perchè nel tempo ho la convoluzione tra il segnale e il filtro; quindi
    % moltiplico 32 campioni per 1/N, equivale a fare la media su finestre di
    % 32 campioni che scorrono sul segnale
    H(1:N) = 1/N;   % creo un vettore che ha N termini tutti uguali a 1/N
    y = filtfilt(H,1,y);    % filtro il segnale
    y = y./max(y); 

    
    % - Riconoscimento QRS
%     [~,locs] = findpeaks(y,'MinPeakProminence',.1); %trovo i picchi nel segnale filtrato
    % Pier MOD: Ho modificato il criterio con cui "findpeaks" individua il
    %           punto fiduciario per il picco R (prima ne trovava troppi,
    %           arrivando anche a restituire distRR --> 0 per alcuni campioni).
    %           Dato che è fisiologicamente impossibile superare una
    %           frequenza cardiaca di 300 bpm, aggiungo un'ulteriore
    %           condizione al riconoscimento:
	fCardiacaMax = 200; %bpm
	fCardiacaMaxHz = fCardiacaMax/60; %Hz
    ncamp_min = round(fs_ecg/fCardiacaMaxHz);
    [~,locs] = findpeaks(y,'MinPeakProminence',.1,'MinPeakDistance',ncamp_min); %trovo i picchi nel segnale filtrato
    
    
    % - Correzione dei delay sul punto fiduciario
    locs = locs-ritDeriv; % PierMOD: Delay da filtro derivatore.
    
    % Pier MOD: Il procedimento sotto l'ho modificato leggermente per
    %           far sì che venissero individuati i picchi R anche quando negativi.
    %           Ho anche modificato la soglia, ponendola pari alla metà della finestra
    %           nella quale non ci si attende di trovare, fisiologicamente,
    %           altri picchi R.
    soglia = round(ncamp_min/2);  %Creo una soglia per trovare i reali picchi R sull'ECG di base
    for z=1:length(locs)
        
        % Estremo inferiore della finestra di ricerca
        minc=locs(z)-soglia;
        if minc<=0, minc=1; end   %Se l'estremo inferiore andasse oltre l'inizio del segnale ...
        
        % Estremo superiore della finestra di ricerca
        maxc=locs(z)+soglia;      
        if maxc>length(ECG), maxc=length(ECG); end %Se l'estremo superiore andasse oltre la fine del segnale ...
        
        % Cerco il picco più alto, rispetto ad una baseline costruita tra
        % gli estremi della finestra di ricerca (utile vs derive locali
        % del segnale)
        [~,pos] = max( abs( ECG(minc:maxc)-mean(ECG(minc:maxc)) ) );
        locs(z) = pos+minc-1;
        
    end


    % - TACOGRAMMA
    tacogramma = zeros(length(locs)-1,1); %inizializzo il vettore
    for i = 2:length(locs)
        tacogramma(i-1) = (locs(i)-locs(i-1))/fs_ecg;
        %il tacogramma è costituito dalle distanze dei picchi R, quindi il 
        %primo picco non viene utilizzato
    end
    tacogramma = [tempo(locs(2:end))' tacogramma];

    % - RESPIROGRAMMA
    respirogramma = resp(locs(2:end));
    %il respirogramma si calcola selezionando i valori del respiro in
    %corrispondenza dei picchi R
    respirogramma = [tempo(locs(2:end))' respirogramma];

end

