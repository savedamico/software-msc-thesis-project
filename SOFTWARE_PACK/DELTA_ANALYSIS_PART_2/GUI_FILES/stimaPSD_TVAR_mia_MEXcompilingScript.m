% STIMAPSD_TVAR_MIA_MEXCOMPILINGSCRIPT   Generate MEX-function
%  stimaPSD_TVAR_mia_mex from stimaPSD_TVAR_mia.
% 
% Script generated from project 'stimaPSD_TVAR_mia.prj' on 29-Mar-2018.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Create configuration object of class 'coder.MexCodeConfig'.
cfg = coder.config('mex');
cfg.GenerateReport = true;
% cfg.ReportPotentialDifferences = false; % Commentato perché nelle versioni di Matlab
                                          % precedenti alla R2017b dà errore (e comunque non
                                          % c'è motivo per non farsi restituire anche questa
                                          % informazione nel report)!

%% Define argument types for entry-point 'stimaPSD_TVAR_mia'.
ARGS = cell(1,1);
ARGS{1} = cell(5,1);
ARGS{1}{1} = coder.typeof(0,[2  40 Inf],[0 1 1]);
ARGS{1}{2} = coder.typeof(0,[2  2 Inf],[0 0 1]);
ARGS{1}{3} = coder.typeof(0);
ARGS{1}{4} = coder.typeof(0);
ARGS{1}{5} = coder.typeof(0);

%% Invoke MATLAB Coder.
% codegen -config cfg stimaPSD_TVAR_mia -args ARGS{1} -nargout 14 % Commentato perché nelle versioni di Matlab
                                                                  % precedenti alla 2017b il parametro "-nargout"
                                                                  % non è riconosciuto (e comunque qui non serve,
                                                                  % perché il nostro MEX deve restituire tutti gli
                                                                  % output della funzione originale) 
codegen -config cfg stimaPSD_TVAR_mia -args ARGS{1}

