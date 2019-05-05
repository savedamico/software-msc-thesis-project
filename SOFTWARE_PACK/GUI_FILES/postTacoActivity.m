function postTacoActivity(tacogramma, respirogramma, order, lambda, wb, wbStart, wbEnd)
%POSTTACOACTIVITY Summary of this function goes here
%   Detailed explanation goes here
useWb = false;
defaultOrder = 7;
defaultLambda = 0.98;
if nargin == 2
    order = defaultOrder;
    lambda = defaultLambda;
elseif nargin == 3
    if isempty(order) || ~isnumeric(order) || length(order) ~= 1
        order = defaultOrder;
    end
    order = round(order); % order in input can be a decimal
    if order < 1
        order = 1;
    end
    lambda = defaultLambda;
elseif nargin == 4
    if isempty(order) || ~isnumeric(order) || length(order) ~= 1
        order = defaultOrder;
    end
    order = round(order); % order in input can be a decimal
    if order < 1
        order = 1;
    end
    if isempty(lambda) || ~isnumeric(lambda) || length(lambda) ~= 1
        lambda = defaultLambda;
    elseif lambda < 0
        lambda = 0;
    elseif lambda > 1
        lambda = 1;
    end
elseif nargin == 5
    if isempty(order) || ~isnumeric(order) || length(order) ~= 1
        order = defaultOrder;
    end
    order = round(order); % order in input can be a decimal
    if order < 1
        order = 1;
    end
    if isempty(lambda) || ~isnumeric(lambda) || length(lambda) ~= 1
        lambda = defaultLambda;
    elseif lambda < 0
        lambda = 0;
    elseif lambda > 1
        lambda = 1;
    end
    useWb = true;
    wbStart = 0;
    wbEnd = 1;
elseif nargin == 6
    if isempty(order) || ~isnumeric(order) || length(order) ~= 1
        order = defaultOrder;
    end
    order = round(order); % order in input can be a decimal
    if order < 1
        order = 1;
    end
    if isempty(lambda) || ~isnumeric(lambda) || length(lambda) ~= 1
        lambda = defaultLambda;
    elseif lambda < 0
        lambda = 0;
    elseif lambda > 1
        lambda = 1;
    end
    useWb = true;
    wbEnd = 1;
elseif nargin == 7
    if isempty(order) || ~isnumeric(order) || length(order) ~= 1
        order = defaultOrder;
    end
    order = round(order); % order in input can be a decimal
    if order < 1
        order = 1;
    end
    if isempty(lambda) || ~isnumeric(lambda) || length(lambda) ~= 1
        lambda = defaultLambda;
    elseif lambda < 0
        lambda = 0;
    elseif lambda > 1
        lambda = 1;
    end
    useWb = true;
end

global VG_taco;
global VG_resp;
global VG_coef;
global VG_ve;
global VG_p;
global VG_res;
global VG_Ts;
global VG_S1;
global VG_S2;
global VG_C;
global VG_MSC;
global VG_fase;
global VG_fr_dec;
global VG_D;
global VG_lambda;
global VG_pow11;
global VG_pow12;
global VG_pow21;
global VG_pow22;
global VG_S1_coer;
global VG_S2_coer;
global VG_PSD11;
global VG_PSD12;
global VG_PSD21;
global VG_PSD22;


if ~(isempty(tacogramma) || isempty(respirogramma) || (size(tacogramma, 1) ~= size(respirogramma, 1)) || (size(tacogramma, 2) ~= 2) || (size(respirogramma, 2) ~= 2))
    
    Ts = mean(tacogramma(:,2));
    
    VG_taco=tacogramma;
    VG_resp=respirogramma;
    VG_Ts=Ts;
    
    if useWb
        waitbar(wbStart + (wbEnd-wbStart)/5, wb);
    end
    
    s_t=size(tacogramma,1);
    s_r=size(respirogramma,1);
    D = zeros(s_t, 2);
    if s_r == s_t %per costruzione
        D(:, 1) = detrend(tacogramma(:,2));
        D(:, 2) = detrend(respirogramma(:,2));
    end
    
    if useWb
        waitbar(wbStart + 2*(wbEnd-wbStart)/5, wb);
    end
    
    VG_D = D;
    p = order; %ordine del modello generato
    res = 512; %numero campioni dei segnali in frequenza
    lamb = lambda; %coefficente di oblio
    VG_p = p;
    VG_res = res;
    VG_lambda = lamb;
    if ispc
        [coef, ve] = modelloAR_TVAR_mex(VG_D, VG_p, VG_lambda);
    else
        [coef, ve] = modelloAR_TVAR(VG_D, VG_p, VG_lambda);
    end
    
    VG_coef = coef;
    VG_ve = ve;
    
    if useWb
        waitbar(wbStart + 3*(wbEnd-wbStart)/5, wb);
    end
    
%--------------------------------------------------------------------------    
% STIMA PSD CON METODO TEMPO-VARIANTE

    try
        % Proviamo ad eseguire il MEX compilato già presente nella
        % cartella:
        [S1,S2,C,MSC,fase,fr_dec,PSD11,PSD12,PSD21,PSD22,pow11,pow12,pow21,pow22] = stimaPSD_TVAR_mia_mex(VG_coef, VG_ve, order,VG_res, VG_Ts);
        
        % Se l'esecuzione del MEX ha successo, inizializzo no_MEX a
        % "false", altrimenti l'istruzione seguente non verrà eseguita:
        no_MEX = false;
    catch
        % Se l'esecuzione del "try" statement generasse errore
        % (funzione compilata non presente, compilazione non
        % valida per l'attuale versione di Matlab o SO, ecc.), domando
        % all'utente come vuole procedere:
        q = 'La funzione MEX "stimaPSD_TVAR_mia_mex" non funziona, vuoi provare a ricompilarla?';
        b = questdlg(q,'Compilazione MEX','Si','No, usa versione script','Si');
        
        switch b
            case 'Si'
                % Provo a ricompilare il MEX (uso le istruzioni di
                % compilazione contenute nello script "stimaPSD_TVAR_mia_MEXcompilingScript.m"
                no_MEX = false;
                fprintf('\nCompilazione in corso (potrebbe richiedere alcuni minuti) ... \n');
                stimaPSD_TVAR_mia_MEXcompilingScript;
                try
                    % Ritento con il nuovo MEX:
                    [S1,S2,C,MSC,fase,fr_dec,PSD11,PSD12,PSD21,PSD22,pow11,pow12,pow21,pow22] = stimaPSD_TVAR_mia_mex(VG_coef, VG_ve, order,VG_res, VG_Ts);
                catch
                    % Se ancora il MEX non dovesse funzionare, ripieghiamo
                    % sulla versione NON compilata:
                    hwdlg = warndlg('La versione ricompilata non funziona! Utilizzo versione script.');
                    uiwait(hwdlg);
                    no_MEX = true;
                end
            case 'No, usa versione script'
                no_MEX = true;
        end
    end
    
    % Eseguo la versione non compilata se esplicitamente richiesto in
    % precedenza o a causa di ulteriore errore:
    if no_MEX == true
        [S1,S2,C,MSC,fase,fr_dec,PSD11,PSD12,PSD21,PSD22,pow11,pow12,pow21,pow22] = stimaPSD_TVAR_mia(VG_coef, VG_ve, order,VG_res, VG_Ts);
    end
    
%--------------------------------------------------------------------------


    if useWb
        waitbar(wbStart + 4*(wbEnd-wbStart)/5, wb);
    end
    
    VG_S1 = S1; %spettro tacogramma
    VG_S2 = S2; %spettro respirogramma
    VG_C = C; %cross-spettro
    VG_MSC = MSC; %coerenza quadratica
    VG_S1_coer = VG_S1.*VG_MSC; %potenza coerente tacogramma
    VG_S2_coer = VG_S2.*VG_MSC; %potenza coerente respirogramma
    VG_fase = fase; %fase
    VG_fr_dec = fr_dec; %asse delle frequenze
    VG_PSD11 = PSD11;   %spettro parziale (influenza taco su se stesso)
    VG_PSD12 = PSD12;   %spettro parziale (influenza resp su taco)
    VG_PSD21 = PSD21;   %spettro parziale (influenza taco su se stesso)
    VG_PSD22 = PSD22;   %spettro parziale (influenza resp su taco)
    VG_pow11 = pow11;   % matrice con potenze dei poli dello spettro parziale 1/1
    VG_pow12 = pow12;   % matrice con potenze dei poli dello spettro parziale 1/2
	VG_pow21 = pow21;   % matrice con potenze dei poli dello spettro parziale 2/1
	VG_pow22 = pow22;   % matrice con potenze dei poli dello spettro parziale 2/2
    
    
    
    if useWb
        waitbar(wbEnd, wb);
    end
    
    BandExtrapolation();
else
    error('I vettori tacogramma e respirogramma non sono validi');
end
end

