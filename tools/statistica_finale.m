myFolder = 'C:\Users\Gabri\Desktop\poli\Tesi Magistrale\DATI PAZIENTI\PAZIENTE 1\export';

if exist(myFolder, 'dir') ~= 7
    Message = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(Message));
    return;
end

filePattern = fullfile(myFolder, '*.mat');
matFiles   = dir(filePattern);

for i=1:length(matFiles)
    baseFileName = matFiles(i).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf('Now reading %s\n', fullFileName);
    load(fullFileName);


    %%CALCOLO PARAMETRI

    % HF taco
    mean_HF_taco = mean(P_HF_Taco);
    std_HF_taco=std(P_HF_Taco);

    % LF taco
    mean_LF_taco = mean(P_LF_Taco);
    std_LF_taco=std(P_LF_Taco);

    % VLF taco
    mean_VLF_taco = mean(P_VLF_Taco);
    std_VLF_taco=std(P_VLF_Taco);

    % HF resp
    mean_HF_resp = mean(P_HLF_Resp);
    std_HF_resp=std(P_HLF_Resp);

    % LF resp
    mean_LF_resp = mean(P_LF_Resp);
    std_LF_resp=std(P_LF_Resp);

    % VLF resp
    mean_VLF_resp = mean(P_VLF_Resp);
    std_VLF_resp=std(P_VLF_Resp);

    % res/taco (guadagno alfa)
    gain_alpha_mean=mean(gain_alpha_tempo(1:end,1));
    gain_alpha_std=std(gain_alpha_tempo(1:end,1));

    % taco/res (guadagno beta)
    gain_beta_mean=mean(gain_beta_tempo(1:end,1));
    gain_beta_std=std(gain_beta_tempo(1:end,1));

    % potenzaCoerente TACO
    pot_coer_taco_tot=sum(potenzaCoerenteTaco(1:end,:),2)*diff(asseFrequenze(1:2));
    pot_coer_taco_mean=mean(pot_coer_taco_tot);
    pot_coer_taco_std=std(pot_coer_taco_tot);

    % potenzaIncoerente TACO
    pot_incoer_taco_tot=sum(potenzaIncoerenteTaco(1:end,:),2)*diff(asseFrequenze(1:2));
    pot_incoer_taco_mean=mean(pot_incoer_taco_tot);
    pot_incoer_taco_std=std(pot_incoer_taco_tot);

    % potenzaCoerente RESP
    pot_coer_resp_tot=sum(potenzaCoerenteTaco(1:end,:),2)*diff(asseFrequenze(1:2));
    pot_coer_resp_mean=mean(pot_coer_resp_tot);
    pot_coer_resp_std=std(pot_coer_resp_tot);

    % potenzaIncoerente RESP
    pot_incoer_resp_tot=sum(potenzaIncoerenteTaco(1:end,:),2)*diff(asseFrequenze(1:2));
    pot_incoer_resp_mean=mean(pot_incoer_resp_tot);
    pot_incoer_resp_std=std(pot_incoer_resp_tot);

    % rapporto simpato/Vagale (bande) TACO
    rapp_bande_taco=P_LF_Taco./P_HF_Taco;
    rapp_bande_taco_mean=mean(rapp_bande_taco);
    rapp_bande_taco_std=std(rapp_bande_taco);

    % rapporto simpato/Vagale (bande) RESP
    rapp_bande_resp=P_LF_Resp./P_HF_Resp;
    rapp_bande_resp_mean=mean(rapp_bande_resp);
    rapp_bande_resp_std=std(rapp_bande_resp);

    % rapporto simpato/Vagale (coerenza) TACO
    coerenza_base_taco=potenzaIncoerenteTaco./potenzaCoerenteTaco;
    coerenza_base_tot_taco=sum(coerenza_base_taco(1:end,:),2)*diff(asseFrequenze(1:2));
    coer_base_tot_taco_mean=mean(coerenza_base_tot_taco);
    coer_base_tot_taco_std=std(coerenza_base_tot_taco);

    % rapporto simpato/Vagale (coerenza) RESP
    coerenza_base_resp=potenzaIncoerenteResp./potenzaCoerenteResp;
    coerenza_base_tot_resp=sum(coerenza_base_resp(1:end,:),2)*diff(asseFrequenze(1:2));
    coer_base_tot_resp_mean=mean(coerenza_base_tot_resp);
    coer_base_tot_resp_std=std(coerenza_base_tot_resp);

    % HF LF norm TACO
    media_nHF_Taco = mean((P_HF_Taco./(P_HF_Taco + P_LF_Taco + P_VLF_Taco)));
    media_nLF_Taco = mean((P_LF_Taco./(P_HF_Taco + P_LF_Taco + P_VLF_Taco)));

    % HF LF norm RESP
    media_nHF_Resp = mean((P_HF_Resp./(P_HF_Resp + P_LF_Resp + P_VLF_Resp)));
    media_nLF_Resp = mean((P_LF_Resp./(P_HF_Resp + P_LF_Resp + P_VLF_Resp)));




%% SAVE DATA

    A(i+1,1) = baseFileName;
    %TACO
    A(i+1,2) = media_HF_taco;
    A(i+1,3) = std_HF_taco;
    A(i+1,4) = media_nHF_taco;
    A(i+1,5) = std_nHF_taco;
    A(i+1,6) = media_LF_taco;
    A(i+1,7) = std_LF_taco;
    A(i+1,8) = media_nLF_taco;
    A(i+1,9) = std_nLF_taco;
    A(i+1,10) = media_VLF_taco;
    A(i+1,11) = std_VLF_taco;
    %RESP
    A(i+1,12) = media_HF_resp;
    A(i+1,13) = std_HF_resp;
    A(i+1,14) = media_nHF_resp;
    A(i+1,15) = std_nHF_resp;
    A(i+1,16) = media_LF_resp;
    A(i+1,17) = std_LF_resp;
    A(i+1,18) = media_nLF_resp;
    A(i+1,19) = std_nLF_resp;
    A(i+1,20) = media_VLF_resp;
    A(i+1,21) = std_VLF_resp;
    %guadagno alfa e beta
    A(i+1,22) = gain_alpha_mean;
    A(i+1,23) = gain_apha_std;
    A(i+1,24) = gain_beta_mean;
    A(i+1,25) = gain_beta_std;
    %potenzaCoerente Taco
    A(i+1,26) = pot_coer_taco_mean;
    A(i+1,27) = pot_coer_taco_std;
    %potenzaIncoerente Taco
    A(i+1,28) = pot_incoer_taco_mean;
    A(i+1,29) = pot_incoer_taco_std;
    %potenzaCoerente Resp
    A(i+1,30) = pot_coer_resp_mean;
    A(i+1,31) = pot_coer_resp_std;
    %potenzaIncoerente Resp
    A(i+1,32) = pot_incoer_resp_mean;
    A(i+1,33) = pot_incoer_resp_std;
    %rapporto simpato/vagale (bande) Taco
    A(i+1,34) = rapp_bande_taco_mean;
    A(i+1,35) = rapp_bande_taco_std;
    %rapporto simpato/vagale (bande) Resp
    A(i+1,36) = rapp_bande_resp_mean;
    A(i+1,37) = rapp_bande_resp_std;
    %rapporto simpato/vagale (coerenza) Taco
    A(i+1,38) = coer_base_tot_taco_mean;
    A(i+1,39) = coer_base_tot_taco_std;
    %rapporto simpato/vagale (coerenza) Resp
    A(i+1,40) = coer_base_tot_resp_mean;
    A(i+1,41) = coer_base_tot_resp_std;


    %LEGENDA
    LEGENDA = {' media_HF_taco '; ' std_HF_taco ';' media_nHF_taco ';' std_nHF_taco ';' media_LF_taco ';' std_LF_taco ';' media_nLF_taco ';' std_nLF_taco '; ...
        ' media_VLF_taco ';' std_VLF_taco ';' media_HF_resp ';' std_HF_resp ';' media_nHF_resp ';' std_nHF_resp ';...
        ' media_LF_resp ';' std_LF_resp ';' media_nLF_resp ';' std_nLF_resp ';' media_VLF_resp ';' std_VLF_resp ';...%%poi vanno alfa e beta in questa riga
        ' pot_coer_taco_mean ';' pot_coer_taco_std ';' pot_incoer_taco_mean ';' pot_incoer_taco_std ';' pot_coer_resp_mean ';' pot_coer_resp_std ';' pot_incoer_resp_mean ';...
        ' pot_incoer_resp_std ';' rapp_bande_taco_mean ';' rapp_bande_taco_std ';' rapp_bande_resp_mean ';' rapp_bande_resp_std ';' coer_base_tot_taco_mean ';' coer_base_tot_taco_std ';...
        ' coer_base_tot_resp_mean ';' coer_base_tot_resp_std '};
    legenda = LEGENDA';
    
