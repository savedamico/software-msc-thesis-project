function C = structarray2cell(sarray)
% DESCRIZIONE: converte uno struct array, avente N record ed M attributi,
%              in un cell array di dimensioni N x M (avente una cella per
%              ogni elemento dello struct array di partenza).
% INPUT:
% saCol = struct array da convertire.
%
% OUTPUT:
% C     = cell array risultante.

N = length(sarray); % Numero di righe dello structarray.
M = length( fieldnames(sarray) ); % Numero di colonne dello structarray.

C = cell([N,M]);

for k = 1:N
	
	s = sarray(k); % Ottengo una singola struct per ogni riga...
	C(k,:) = struct2cell(s)'; % ... ottengo una singola riga del cell array.
	
end
end