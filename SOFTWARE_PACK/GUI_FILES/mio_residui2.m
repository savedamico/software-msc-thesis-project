function [ST_real,pow,p]=mio_residui2(a,b,vep,med,ord,freq)

% metodo dei residui adattato per fare la decomposizione spettrale di un
% modello ARMA
%%%%%% NB1: modifica fatta in data 3/06/2014
%%%%%% ho fatto in modo di dare io in ingresso il vettore delle frequenze
%%%%%% che quindi viene creato in modo da avere una risoluzione spettrale
%%%%%% di fs/npspet e per farlo io devo creare il vettore tra -fs/2 e fs/2
%%%%%% con passo di campionamento pari a fs/npspet

%%%%%% NB2: modifica fatta in data 3/06/2014
%%%%%% vado a moltiplicare per 2 lo spettro calcolato sia con il metodo dei
%%%%%% residui che con quello tradizionale in modo da avere lo stesso
%%%%%% spettro che otterrei applicando la funzione matlab pyulear con
%%%%%% l'opzione onesided. Se non raddoppio i valori dello spettro, ottengo
%%%%%% lo spettro che risulta applicando la funzione matlab pyulear con l'
%%%%%% opzione centered

%%%%%% NB2: modifica fatta in data 2/10/2014
%%%%%% non moltiplico più lo spettro per 2

T=med;
maxfs=0.5/T;
A=a; % vettore coefficienti del denominatore
B=b;
p=roots(A); % si cercano le radici del polinomio A
zm=roots(B); % si cercano le radici del polinomio B
% PierMOD: riordino le radici dei polinomi in ordine crescente rispetto
%          alla propria parte immaginaria. Così facendo, faccio in modo che tutti i
%          complessi coniugati siano adiacenti, il che mi consentirà di
%          svolgere correttamente il "diff(real(p))" più avanti anche nel
%          codice compilato, in cui l'output di "roots" viene messo in
%          ordine sparso (differentemente a quanto avviene sul codice non
%          compilato, in cui l'ordine delle radici è messo in modo tale da
%          avvicinare, automaticamente, i complessi coniugati).
[~,opol] = sort(abs(imag(p)));
p = p(opol);
[~,opol] = sort(abs(imag(zm)));
zm = zm(opol);

L=length(p);

% aggiunta della parte del modello ARMA introducendo il termine C per il
% calcolo dei residui associati ai poli
gamma=zeros(1,L);
gamma=complex(gamma);
for l=1:L
    % calcolo il residuo associato al polo k che è un numero
    % alla fine del ciclo avrò k residui quanti sono i poli
    % calcolo del denominatore della formula
    z=p(l);
    prod1=z-p;
    prod1(l)=complex(1);
    prod2=(z^(-1)-p);
    % calcolo del numeratore della formula
    if(length(B)==1)
        num=complex(1);
    else
        num=(B(1)*prod((z-zm)))*(B(1)*prod((z^(-1)-zm)));
    end
    if(z==0)
        gamma(l)=complex(0);
    else
        gamma(l)=num/(z*prod(prod1)*prod(prod2));
    end
end

% calcolo delle componenti spettrali associate ai residui
% IL CODICE è CORRETTO!!!!!!
%figure;
ST=zeros(1,length(freq));
ST=complex(ST);
for l=1:L
    SS=zeros(1,length(freq));
    SS=complex(SS);
    for f=1:length(freq)
        zeta=(2*pi*(1i)*freq(f)*T);
        SS(f)=(((gamma(l)*p(l))/(exp(-zeta)-p(l)))+gamma(l)+((gamma(l)*p(l))/(exp(zeta)-p(l))));
    end
    SS=T*vep*SS;
    ST=ST+SS;
    %hold on;plot(freq,real(SS))
    %pause
end
% moltiplico lo spettro per due [modifica fatta in data 03/06/2014]
%ST=2*(real(ST));

% ST=(real(ST));  % --> modifica fatta 2 ottobre
ST_real=real(ST); % PierMOD: una variabile inizializzata come
                  %          "complex" in C, rimane complex anche se le
                  %          viene tolta la parte immaginaria, il che può
                  %          dare origine a problemi. Quindi dichiariamo
                  %          un'altra variabille apposta per contenere il
                  %          risultato di real(ST).
%plot(freq,ST,'r')

% % % % proviamo il calcolo tradizionale dello spettro in base alla teoria dei
% % % % modelli arma che rappresentano una generalizzazione dei modelli ar
% % % % IL CODICE è CORRETTO!!!!!!
% % % S_trad=zeros(1,length(freq));
% % % for f=1:length(freq)
% % %     zeta=(2*pi*(1i)*freq(f)*T);
% % %     
% % %     % denominatore
% % %     vecz=ones(1,length(A)); % per la costruzione di H(z)
% % %     %vecz_m1=ones(1,length(a));  % per la costruzione di H(z^-1)
% % %     for vv=2:length(A)
% % %         vecz(1,vv)=exp((-(vv-1))*zeta);
% % %     end
% % %     Az=(A*vecz');
% % %     %numeratore
% % %     if(length(B)==1)
% % %         Cz=1;
% % %     elseif(length(B)==ord)
% % %         vC=ones(1,ord);
% % %         for vv=1:ord
% % %             vC(1,vv)=exp((-(vv))*zeta);
% % %         end
% % %         Cz=B*vC';
% % %     elseif(length(B)==ord+1)
% % %          vC=ones(1,ord+1);
% % %          for vv=2:ord+1
% % %             vC(1,vv)=exp((-(vv-1))*zeta);
% % %          end
% % %          Cz=B*vC';
% % %     end
% % %     H=Cz/Az;
% % %     S_trad(f)=T*vep*((abs(H))^2); 
% % % end
% % % % moltiplico lo spettro per due [modifica fatta in data 03/06/2014]
% % % S_trad=S_trad*2;
% % % %plot(freq,S_trad,'k');

% TUTTO FUNZIONA CORRETTAMENTE PERCHè LO SPETTRO CALCOLATO CON IL METODO
% DEI RESIDUI è EQUIVALENTE A QUELLO CALCOLATO CON IL METODO TRADIZIONALE

% Trova il numero di componenti spettrali (i poli complessi e
% coniugati hanno la stessa parte reale, quindi li devo contare una sola
% volta!)
res = gamma;
tipo_polo = diff(real(p)); % Laddove diff=0 --> posizione nel vettore p dell'occorrenza del primo complesso coniugato
cc = find( tipo_polo > -10^(-6) & tipo_polo < 10^(-6) ); % Necessario al posto di "find(tipo_polo==0)" per far funzionare codice compilato
res(cc) = res(cc)*2;
res(cc+1) = [];
p(cc)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% PORZIONE DI SCRIPT OBSOLETA
% % % res0=zeros(1,length(res));
% % % res0=complex(res0);
% % % p0=zeros(1,length(p));
% % % p0=complex(p0);
% % % pw=zeros(1,length(p));
% % % res0(1)=res(1);     % prende il residuo (parte reale e immaginaria) associato al primo polo
% % % p0(1)=p(1);         % prende il primo polo
% % % peak=1;
% % % % ciclo sui poli a partire dal secondo
% % % for n=2:L
% % %     % se due poli adiacenti hanno parte reale diversa, allora ho una sola
% % %     % componente spettrale (pw = 1)
% % % 	if real(p0(peak))~=real(p(n))
% % % 		peak=peak+1;
% % % 		res0(peak)=res(n);
% % % 		p0(peak)=p(n);
% % % 		pw(peak)=1;
% % % 	else
% % % 		pw(peak)=2;
% % % 	end
% % % end
% % % pw(pw==0)=[];
% % % res0=res0(1:length(pw));
% % % p0=p0(1:length(pw));
% % % powk=zeros(3,length(pw));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% determinazione delle potenze dei picchi ( unità di misura s^2 perchè 
% si tratta dell'integrale sotto la curva, quindi per forza è in secondi)
powk=zeros(3,length(res));
powk(1,:)=real(res)*vep;
% ho già moltiplico "res" per 2 laddove ho un polo complesso e coniugato
powk(2,:)=abs(angle(p))*(maxfs/pi);	% determinazione delle frequenze dei picchi (unità di misura Hz)
powk(3,:)=abs(p);
%%% powk= [------- potenza associata a ciascun polo ------]
%%%       [------- frequenza centrale del polo -----------]
%%%       [------- modulo del polo -----------------------]
[~,o]=sort(powk(2,:));
pow=powk(:,o);

