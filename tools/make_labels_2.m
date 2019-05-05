filename = 'Saverio D Amico-EsportazioneScoring.txt';
delimiterIn = ' ';
data = importdata(filename,delimiterIn);

for i=1:length(data)
    data(i) = erase( data(i), 'SLEEP-');
end

l=length(data);
epoch_length=15;
increase=epoch_length*250;


lables(1,1)=1;
lables(1,2)=1;

str=data(1);
k=1;

for(i=2:l)
  str_now=data(i);

  if(~strcmp(str,str_now))
    k=k+1;
    lables(k,2)=(i-1)*15*250;

    if (strcmp(str_now,'S0'))
      lables(k,1)=1;
    end
    if (strcmp(str_now,'REM'))
      lables(k,1)=2;
    end
    if (strcmp(str_now,'S1'))
      lables(k,1)=3;
    end
    if (strcmp(str_now,'S2'))
      lables(k,1)=4;
    end
    if (strcmp(str_now,'S3'))
      lables(k,1)=5;
    end

    str=str_now;
  end
end
