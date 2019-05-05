function resetEditWindowsStruct()
%RESETEDITWINDOWSSTRUCT Summary of this function goes here
%   Detailed explanation goes here
global VG_editWindowsStruct

VG_editWindowsStruct.tempo = []; % vettore dei tempi di riferimento
VG_editWindowsStruct.signal = []; % vettore del segnale (facoltativo)
VG_editWindowsStruct.fs = NaN; % frequenza di campionamento
VG_editWindowsStruct.eventi = []; % matrice degli eventi
VG_editWindowsStruct.labelEventi = struct('code',{}, 'label', {}); % struttura dei label (facoltativo)
VG_editWindowsStruct.file = ''; % file su cui si sta lavorando (facoltativo, per quando verranno salvate le finestrature)
VG_editWindowsStruct.btnHandle = []; % handle al bottone che ricarica le finestre (facoltativo)

end

