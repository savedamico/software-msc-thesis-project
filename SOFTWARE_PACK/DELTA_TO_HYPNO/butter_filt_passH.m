function [filt_sig]=butter_filt_passH(X,b,order);

    Fs = 250;
    Fn = Fs/2;
    Wp = b/Fn;
    %Ws = [0.1*0.95 1/0.95]/Fn;
    %Rp =   1;                                                   % Passband Ripple (dB)
    %Rs = 20;                                                   % stopband ripple (dB)
    %[n,Wn] = buttord(Wp,Ws,Rp,Rs);  
    [z,p,k] = butter(order,Wp); 
    [sosbp,gbp] = zp2sos(z,p,k);                %zp2sos(z,p,k); 

    filt_sig=filtfilt(sosbp,gbp,X);

end