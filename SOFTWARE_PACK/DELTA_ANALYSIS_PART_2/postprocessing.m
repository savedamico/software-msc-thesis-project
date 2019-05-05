function [l]=postprocessing(l2)

l=num2str(l2');

%l=strrep(l,num2str([1 0 0 0 1]),num2str([1 1 1 1 1]));
%l=strrep(l,num2str([1 0 0 1]),num2str([1 1 1 1]));
%l=strrep(l,num2str([1 0 1]),num2str([1 1 1])); 

%l=strrep(l,num2str([1 0 0 0 1]),num2str([1 1 1 1 1]));

      
      
l=strrep(l,num2str([0 1 0]),num2str([0 0 0]));     
l=strrep(l,num2str([0 1 1 0]),num2str([0 0 0 0]));%era tolto
l=strrep(l,num2str([0 1 1 1 0]),num2str([0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 0]),num2str([0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 1 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0 0 0 0 0 0 0]));
l=strrep(l,num2str([0 1 1 1 1 1 1 1 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]));      
l=strrep(l,num2str([0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]),num2str([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]));   

%l=strrep(l,num2str([0 1 1 1 1 1 1 1]),num2str([0 0 0 0 0 0 0 0])); %finale

l=strrep(l,num2str([1 0 1]),num2str([1 1 1]));
l=strrep(l,num2str([1 0 0 1]),num2str([1 1 1 1]));
l=strrep(l,num2str([1 0 0 0 1]),num2str([1 1 1 1 1]));
l=strrep(l,num2str([1 0 0 0 0 1]),num2str([1 1 1 1 1 1]));
l=strrep(l,num2str([1 0 0 0 0 0 1]),num2str([1 1 1 1 1 1 1]));
l=strrep(l,num2str([1 0 0 0 0 0 0 1]),num2str([1 1 1 1 1 1 1 1]));
l=strrep(l,num2str([1 0 0 0 0 0 0 0 1]),num2str([1 1 1 1 1 1 1 1 1]));
%l=strrep(l,num2str([1 0 0 0 0 0 0 0 0 1]),num2str([1 1 1 1 1 1 1 1 1]));

%dd=length(l);
%l(dd)='0';

%rr=length(l2);

%if(dd<rr) l(dd+1)=='0'; end

l=str2num(l);
l(find(l==11))=1;
l=l';
    