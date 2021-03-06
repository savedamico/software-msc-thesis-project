%[header signalHeader signalCell] = blockEdfLoad('FILE NAME');

fig = figure();
tmax = 14940;

% Get number of signals
num_signals = header.num_signals;
s=40;

    % get signal
    signal =  signalCell{s};
    samplingRate = signalHeader(s).samples_in_record;
    record_duration = header.data_record_duration;
    t = [0:length(signal)-1]/samplingRate';

    % Identify first 30 seconds
    indexes = find(t<=tmax);
    signal = signal(indexes);
    t = t(indexes);

    % Normalize signal
    sigMin = min(signal);
    sigMax = max(signal);
    signalRange = sigMax - sigMin;
    signal = (signal - sigMin);
    if signalRange~= 0
        signal = signal/(sigMax-sigMin);
    end
    signal = signal -0.5*mean(signal) + num_signals - s + 1;

    % Plot signal
    plot(t(indexes), signal(indexes));
    hold on


% Set title
title(header.patient_id);

% Set axis limits
v = axis();
v(1:2) = [0 tmax];
v(3:4) = [-3 10];
axis(v);

% Set x axis
xlabel('Time(sec)');

% Set yaxis labels
signalLabels = cell(1,num_signals);
signalLabels{num_signals-s+1} = signalHeader(s).signal_labels;

set(gca, 'YTick', [1:1:num_signals]);
set(gca, 'YTickLabel', signalLabels);
