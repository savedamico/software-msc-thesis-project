    load('export_ECG_3.mat');
    %%CALCOLO PARAMETRI

    % HF taco
    mean_HF_taco = mean(P_HF_Taco);
    std_HF_taco=std(P_HF_Taco);
    A(1,1) = mean_HF_taco;
    A(1,2) = std_HF_taco;

    % LF taco
    mean_LF_taco = mean(P_LF_Taco);
    std_LF_taco=std(P_LF_Taco);
    A(1,3)=mean_LF_taco;
    A(1,4)=std_LF_taco;

    % VLF taco
    mean_VLF_taco = mean(P_VLF_Taco);
    std_VLF_taco=std(P_VLF_Taco);
    A(1,5)=mean_VLF_taco;
    A(1,6)=std_VLF_taco;

    % HF resp
    mean_HF_resp = mean(P_HF_Resp);
    std_HF_resp=std(P_HF_Resp);
    A(1,7)=mean_HF_resp;
    A(1,8)=std_HF_resp;

    % LF resp
    mean_LF_resp = mean(P_LF_Resp);
    std_LF_resp=std(P_LF_Resp);
    A(1,9)=mean_LF_resp;
    A(1,10)=std_LF_resp;

    % VLF resp
    mean_VLF_resp = mean(P_VLF_Resp);
    std_VLF_resp=std(P_VLF_Resp);
    A(1,11)=mean_VLF_resp;
    A(1,12)=std_VLF_resp;

    % res/taco (guadagno alfa)
    gain_alpha_mean=mean(gain_alpha_tempo(1:end,1));
    gain_alpha_std=std(gain_alpha_tempo(1:end,1));
    A(1,13)=gain_alpha_mean;
    A(1,14)=gain_alpha_std;
    
    % taco/res (guadagno beta)
    gain_beta_mean=mean(gain_beta_tempo(1:end,1));
    gain_beta_std=std(gain_beta_tempo(1:end,1));
    A(1,15)=gain_beta_mean;
    A(1,16)=gain_beta_std;

    % potenzaCoerente TACO
    pot_coer_taco_tot=sum(potenzaCoerenteTaco(1:end,:),2)*diff(asseFrequenze(1:2));
    pot_coer_taco_mean=mean(pot_coer_taco_tot);
    pot_coer_taco_std=std(pot_coer_taco_tot);
    A(1,17)=pot_coer_taco_mean;
    A(1,18)=pot_coer_taco_std;

    % potenzaIncoerente TACO
    pot_incoer_taco_tot=sum(potenzaIncoerenteTaco(1:end,:),2)*diff(asseFrequenze(1:2));
    pot_incoer_taco_mean=mean(pot_incoer_taco_tot);
    pot_incoer_taco_std=std(pot_incoer_taco_tot);
    A(1,19)=pot_incoer_taco_mean;
    A(1,20)=pot_incoer_taco_std;

    % potenzaCoerente RESP
    pot_coer_resp_tot=sum(potenzaCoerenteTaco(1:end,:),2)*diff(asseFrequenze(1:2));
    pot_coer_resp_mean=mean(pot_coer_resp_tot);
    pot_coer_resp_std=std(pot_coer_resp_tot);
    A(1,21)=pot_coer_resp_mean;
    A(1,22)=pot_coer_resp_std;

    % potenzaIncoerente RESP
    pot_incoer_resp_tot=sum(potenzaIncoerenteTaco(1:end,:),2)*diff(asseFrequenze(1:2));
    pot_incoer_resp_mean=mean(pot_incoer_resp_tot);
    pot_incoer_resp_std=std(pot_incoer_resp_tot);
    A(1,23)=pot_incoer_resp_mean;
    A(1,24)=pot_incoer_resp_std;

    % rapporto simpato/Vagale (bande) TACO
    rapp_bande_taco=P_LF_Taco./P_HF_Taco;
    rapp_bande_taco_mean=mean(rapp_bande_taco);
    rapp_bande_taco_std=std(rapp_bande_taco);
    A(1,25)=rapp_bande_taco_mean;
    A(1,26)=rapp_bande_taco_std;

    % rapporto simpato/Vagale (bande) RESP
    rapp_bande_resp=P_LF_Resp./P_HF_Resp;
    rapp_bande_resp_mean=mean(rapp_bande_resp);
    rapp_bande_resp_std=std(rapp_bande_resp);
    A(1,27)=rapp_bande_resp_mean;
    A(1,28)=rapp_bande_resp_std;

    % rapporto simpato/Vagale (coerenza) TACO
    coerenza_base_taco=potenzaIncoerenteTaco./potenzaCoerenteTaco;
    coerenza_base_tot_taco=sum(coerenza_base_taco(1:end,:),2)*diff(asseFrequenze(1:2));
    coer_base_tot_taco_mean=mean(coerenza_base_tot_taco);
    coer_base_tot_taco_std=std(coerenza_base_tot_taco);
    A(1,29)=coer_base_tot_taco_mean;
    A(1,30)=coer_base_tot_taco_std;

    % rapporto simpato/Vagale (coerenza) RESP
    coerenza_base_resp=potenzaIncoerenteResp./potenzaCoerenteResp;
    coerenza_base_tot_resp=sum(coerenza_base_resp(1:end,:),2)*diff(asseFrequenze(1:2));
    coer_base_tot_resp_mean=mean(coerenza_base_tot_resp);
    coer_base_tot_resp_std=std(coerenza_base_tot_resp);
    A(1,31)=coer_base_tot_resp_mean;
    A(1,32)=coer_base_tot_resp_std;

    % HF LF norm TACO
    media_nHF_Taco = mean((P_HF_Taco./(P_HF_Taco + P_LF_Taco + P_VLF_Taco)));
    media_nLF_Taco = mean((P_LF_Taco./(P_HF_Taco + P_LF_Taco + P_VLF_Taco)));
    A(1,33)=media_nHF_Taco;
    A(1,34)=media_nLF_Taco;

    % HF LF norm RESP
    media_nHF_Resp = mean((P_HF_Resp./(P_HF_Resp + P_LF_Resp + P_VLF_Resp)));
    media_nLF_Resp = mean((P_LF_Resp./(P_HF_Resp + P_LF_Resp + P_VLF_Resp)));
    A(1,35)=media_nHF_Resp;
    A(1,36)=media_nLF_Resp;
    
    
    
 
    
    
    
    
