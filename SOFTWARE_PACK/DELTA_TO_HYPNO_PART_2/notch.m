function [filt_signal]=notch(signal,b1,b2,order)

Fs=250;
Fn = Fs/2;
b1 = b1/Fn;
b2 = b2/Fn;
d = designfilt('bandstopiir','FilterOrder',order, ...
               'HalfPowerFrequency1',b1,'HalfPowerFrequency2',b2, ...
               'DesignMethod','butter','SampleRate',Fs);
           
[filt_signal]=filtfilt(d,signal);

end
