%%%% PLOT EVENTI GENERALIZZATI
function legend_flag = plot_eventi(hlegend,ax,meventi,events_label,fs,legend_flag)

% DESCRIZIONE: La funzione aggiunge le linee verticali in corrispondenza
%              degli istanti in cui si verificano gli eventi contenuti
%              nella matrice "meventi" e, se non è stato già fatto,
%              aggiunge all'interfaccia grafica due "uitable" contenenti,
%              rispettivamente, i colori associati a ciascun tipo di evento
%              e la sua descrizione.
%          NB: Richiede struct array "events_label" nei file .MAT 
%              caricati attraverso "GUI_Schermata_Iniziale"
%
% INPUT:
% hlegend = handle allo uipanel (va bene anche uibuttongroup) della
%           legenda.
% ax      = handle agli axes sui quali disegnare le linee verticali.
% meventi = matrice di dimensioni Nx2 contenente, per ogni riga, il codice
%           dell'evento e l'istante in cui si è verificato (espresso in
%           numero di campioni).
% events_label = struct array di due variabili: la variabile "code"
%                contiene il codice degli eventi presenti nel file; la
%                variabile "label" contiene le etichette associate a
%                ciascun codice.
%                NB: events_label può contenere anche più tipologie di
%                eventi di quelle effettivamente contenute nel file
%                meventi (consente maggior robustezza del codice)  (^_^)
% fs      = frequenza di campionamento del segnale a cui sono riferiti
%           gli eventi.
% legend_flag  = flag binario: 0 -> disegna la "uitable" con la legenda
%                                   degli eventi.
%                              1 -> NON            "             "
%
% OUTPUT:
% legend_flag = viene aggiornato il valore del flag binario:
%               se input = 0 -> output = 1
%               se input = 1 -> output = 1

% Mostriamo lo uipanel della "Legenda" (finora nascosto):
set(hlegend,'Visible','on');
ntipi = length(events_label); % Numero di tipi di eventi contenuti nello struct array delle labels
if isempty(meventi)
    return;
end
ntipi_usati = length( unique(meventi(:,1)) );  % Numero di tipi di eventi effettivamente usati

% Inizializzazione colori utilizzabili per i tipi di eventi contenuti
% nello struct array "etichette_ev"
f = figure; cmap = colormap(f,'hsv'); close(f);
cmap = cmap(1:end-5,:);  %Togliamo i rossi in fondo per non far ripetere il
%colore presente gia' all'inizio.
r = round(linspace(1,length(cmap),ntipi));
RGBcolors = cmap(r,:);

% Inizializzazione del vettore che memorizza i tipi di evento
% effettivamente usati:
usati = false(ntipi,1);

% Settiamo gli assi su cui disegnare
axes(ax);
hold on;

% Cicla sui tipi di eventi contenuti nello struct array "etichette_ev"
for iev = 1:ntipi
    
    % Prelevo il codice associato a quel certo TIPO di evento...
    codAtt = events_label(iev).code;
    % ... prelevo gli eventi con quel determinato codice ...
    eventiAtt = meventi( meventi(:,1)==codAtt,2 ) / fs;
    
    % ... verifico che ci siano eventi con quel codice ...
    if ~isempty(eventiAtt)
        
        % ... se cosï¿½ fosse, traccio le linee relative a quegli eventi
        %     con il colore definito per quel certo tipo di evento ...
        h = vline(eventiAtt, '--');
        set(h,'Color',RGBcolors(iev,:),'LineWidth',2);
        
        % ... e tengo traccia dei tipi di eventi effettivamente utilizzati:
        usati(iev) = true;
        
    end
    
end

hold off;

% Disegno la legenda con le etichette realmente usate (una volta sola)
if ~legend_flag
    htcolors = findobj(hlegend, 'Tag','EventColorLegend');
	htlabels = findobj(hlegend, 'Tag','EventLegend');
	if ~isempty(htcolors) && ~isempty(htlabels)
		legend_flag = true;
		return;
	end
	if ~isempty(htcolors)
		delete(htcolors);
	end
	if ~isempty(htlabels)
		delete(htlabels);
	end
	
    labels = structarray2cell(events_label);
    labels = labels(usati,2);
    labels_color = RGBcolors(usati,:);
    
    % Mostriamo la legenda attraverso "uitable": creiamo una tabella
    % per i colori e gliene affianchiamo un'altra con le etichette
    % (ciascuna tabellina, quindi, avrà una sola colonna).
    % Qui si impostano anche tutte le proprietà grafiche delle nuove
    % tabelline create.
    tcolors = repmat( {' '} , ntipi_usati,1 );
    
    bgcol = get(hlegend,'BackgroundColor');
	originalUnits = hlegend.Units;
    set(hlegend,'Units','pixels');
    panelsize = get(hlegend,'Position');
    htcolors = uitable(hlegend,'Data',tcolors,'RowName',[],'ColumnName',[],'ColumnWidth',{20},'FontSize',8,'BackgroundColor',labels_color,'Units','pixels','Tag','EventColorLegend');
    tcolext = get(htcolors,'Extent');
    vertpos = panelsize(4)-tcolext(4)-25;
    htcolors.Position = [10,vertpos,tcolext(3:4)];
    htlabels = uitable(hlegend,'Data',labels,'RowName',[],'ColumnName',[],'ColumnWidth',{80},'FontSize',8,'RowStriping','off','BackgroundColor',bgcol,'Units','pixels','Tag','EventLegend');
    tlabext = get(htlabels,'Extent');
    htlabels.Position = [tcolext(3)+10,vertpos,tlabext(3:4)];
    
    % Resettiamo l'unità di misura in tutti gli handles in termini di unità
    % normalizzate (in questo modo non si avranno errori in seguito a
    % successivi ridimensionamenti della finestra della GUI)
    set([htcolors,htlabels],'Units','normalized');
	hlegend.Units = originalUnits;
    
    % Cambiamo il valore del flag in modo che la creazione della legenda
    % venga effettuata una volta sola, indipendentemente dal numero di
    % volte in cui questa funzione sarà chiamata
    legend_flag = true;
end