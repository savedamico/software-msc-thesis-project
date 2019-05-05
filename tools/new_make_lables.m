%% LEGENDA NUMERI LABELS
% Stages:
%1. Move
%2. Wake
%3. REM
%4. PhREM
%5. S1
%6. S2
%7. S3
%8. S4

file_name='Acanfora_ipnog.txt';
file=fopen(file_name);
epoch_length=30;

[data]= textscan(file, '%s %{HH:mm:ss.SSS}D %s','headerlines',21);

l=length(data{1,2});

%% TIME2SAMPLE CONVERT
increase=epoch_length*250;
sample=zeros(l,1);
sample(1)=0;
sample(2)=0;
for(i=2:l)
  sample(i)=sample(i-1)+increase;
end
sample(1)=1;

%% MAKE MATRIX LABELS
labels=[];
lables(1,1)=1;
lables(1,2)=sample(1);

%% TAKE EVENT LABLES
str1=data{1,3}(1);
k=2;
num_stone=1;

% make temp2sample file_name
temp2samp=cell(l,2);
temp2samp{1,1}=0;
for(i=2:l)
  temp2samp{i}=temp2samp{i-1}+increase;
end
temp2samp{1,1}=1;
temp2samp{1,2}='Wake';

% make LABLES
for(i=2:l)
  str_now=data{1,3}(i);
  temp2samp{i,2}=str_now;

  if (~strcmp(str1,str_now))
    %num_mean=(i+num_stone)/2;
    %num_mean=ceil(num_mean);

    lables(k,2)=sample(i);
    str1=str_now;
    if (strcmp(str1,'Wake'))
      lables(k,1)=1;
    end
    if (strcmp(str1,'Move'))
      lables(k,1)=2;
    end
    if (strcmp(str1,'REM'))
      lables(k,1)=3;
    end
    if (strcmp(str1,'PhREM'))
      lables(k,1)=4;
    end
    if (strcmp(str1,'S1'))
      lables(k,1)=5;
    end
    if (strcmp(str1,'S2'))
      lables(k,1)=6;
    end
    if (strcmp(str1,'S3'))
      lables(k,1)=7;
    end
    if (strcmp(str1,'S4'))
      lables(k,1)=8;
    end

    num_stone=i-1;
    %k=k+1;
    %lables(k,2)=sample(i-1);
    %lables(k,1)=250;


    k=k+1;
  end

end

%lables(k,2)=sample(i);
%str1=data{1,3}(i);

%if (strcmp(str1,'Wake'))
%  lables(k,1)=1;
%end
%if (strcmp(str1,'Move'))
%  lables(k,1)=2;
%end
%if (strcmp(str1,'REM'))
%  lables(k,1)=3;
%end
%if (strcmp(str1,'PhREM'))
%  lables(k,1)=4;
%end
%if (strcmp(str1,'S1'))
%  lables(k,1)=5;
%end
%if (strcmp(str1,'S2'))
%  lables(k,1)=6;
%end
%if (strcmp(str1,'S3'))
%  lables(k,1)=7;
%end
%if (strcmp(str1,'S4'))
%  lables(k,1)=8;
%end

%lables(k+1,2)=sample(i);
%lables(k+1,1)=99;

save('events.mat','lables');

close all
clear all
clc
