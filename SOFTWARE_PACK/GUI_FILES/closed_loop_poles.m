function [lam,a11,a12,a21,a22]=closed_loop_poles(coef,ordine)

% provo a vedere se riesco a ricavare le componenti degli spettri parziali
% faccio riferimento all'articolo di barboeri 1996.
% lam contiene i coefficienti del polinomio caratteristico rappresentante
% il determinante della matrice A

a11=coef(1,1:2:end);
a12=coef(1,2:2:end);
a21=coef(2,1:2:end);
a22=coef(2,2:2:end);

% calcolo delle funzioni di trasferimento ( se sono tutti con il segno -,
% allora i termini che moltiplicano l'1 avranno il meno, mentre i prodotti
% di coefficienti avranno il +

lam=zeros(1,2*ordine+1);
% lam(1)=a11(1)+a22(1);
% I CICLI FOR SOTTOSTANTI SONO PENSATI PER IMPLEMENTARE LE LINEE DI CODICE
% SEGUENTI IN MODO PIù VELOCE
% lam(2)=a11(2)+a11(1)*a22(1)+a22(2)
% lam(3)=a11(3)+a11(2)*a22(1)+a11(1)*a22(2)+a22(3)

% primi elementi del determinante della matrice A
for o=1:ordine
    vec1=[fliplr(-a11(1:o)) 1];
    vec2=[1 -a22(1:o)];
    
    if(o>1)
        vec3=fliplr(a12(1:o-1));
        vec4=a21(1:o-1);
    else
        vec3=0;
        vec4=0;
    end
        
    lam(o)=sum(vec1.*vec2)-sum(vec3.*vec4);
end

% ultimi elementi del determinante della matrice A
for ind=1:ordine
    vec1=fliplr(-a11(ind:ordine));
    vec2=-a22(ind:ordine);
    
    vec3=fliplr(a12(ind:ordine));
    vec4=a21(ind:ordine);
    
   lam(ordine+ind)=sum(vec1.*vec2)-sum(vec3.*vec4);
    
end

lam=[1 lam];
%p=roots(lam);
% figure
% polar(angle(p),abs(p),'ro')
% hold on;
% pa11=roots([1 -a11]);
% pa22=roots([1 -a22]);
% polar(angle(pa11),abs(pa11),'gx')
% polar(angle(pa22),abs(pa22),'kd')
end


    
    

