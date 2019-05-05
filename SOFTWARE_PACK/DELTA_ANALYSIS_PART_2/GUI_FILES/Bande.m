%%%%ESTRAZIONE BANDE IN FREQUENZA%%%%
% Limiti di default
%ULF = [0-0.003] Hz
%VLF = [0.003-0.015] Hz %%% ULF e VLF sono state unificate
%LF = [0.015-0.15] Hz
%HF = [0.15-0.40] Hz
function [VLF, LF, HF]=Bande(fr_dec,limits)
VLF = [];
LF = [];
HF = [];
if size(limits) ~= [3 2]
	disp('Badly structured band limits');
	return;
end
%ESTRAZIONE VLF
VLF = find(limits(1,1)<=fr_dec & fr_dec<limits(1,2));
% j=1;
% VLF = [];
% for i=1:n
%     if fr_dec(i)>=0.003 && fr_dec(i)<0.015
%          VLF(j)=fr_dec(i);
%          j=j+1;
%     end
% end

%ESTRAZIONE LF
LF = find(limits(2,1)<=fr_dec & fr_dec<limits(2,2));
% k=1;
% LF = [];
% for i=1:n
%     if fr_dec(i)>=0.015 && fr_dec(i)<0.15
%          LF(k)=fr_dec(i);
%          k=k+1;
%     end
% end

%ESTRAZIONE HF
HF = find(limits(3,1)<= fr_dec & fr_dec<limits(3,2));
% l=1;
% HF = [];
% for i=1:n
%     if fr_dec(i)>=0.15 && fr_dec(i)<0.4
%          HF(l)=fr_dec(i);
%          l=l+1;
%     end
% end
