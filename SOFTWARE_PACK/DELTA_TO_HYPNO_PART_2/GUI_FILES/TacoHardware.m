function [tacogram, locs, errMsg] = TacoHardware(ecg, fs_ecg, t_start, maxHeartRate)
%TACOHARDWARE R-R individuation function made as it would have been done in
%a hardware implementation.
% INPUTS
%	egc: ecg signal
%	fs_ecg: sampling frequency in Hz
%	t_start: starting value of the time array
%	maxHeartRate: maximum heart rate acceptable (in bpm)
% OUTPUTS
%	tacogram: 2-columns matrix of R-R distances and their locations in time
%	locs: R position in the signal (as index)

% output initialisation
tacogram = [];
locs = [];
errMsg = '';

% inputs check
if nargin < 2
	errMsg = 'Insufficient inputs';
	return;
elseif nargin < 3
	t_start = 0;
	maxHeartRate = 200;
elseif nargin < 4
	maxHeartRate = 200;
end
if fs_ecg <= 0
	errMsg = 'Too low sampling rate';
	return;
end
if isempty(ecg)
	errMsg = 'Invalid ECG signal';
	return;
end
if length(ecg) ~= sum(size(ecg)) - length(size(ecg)) + 1
	errMsg = 'Multidimensional ECG';
	return;
end

% in on-line implementation the for loop is not needed
% algorithm parameters
lastMaxSlope = 0.1 / fs_ecg; % percentage lost per second
proportion = 0.5;
hysteresis = 0.05;
attenuation = 1/5;
settlingSamples = 2 * fs_ecg; % 2s of settling time
minPeakDistance = 60/maxHeartRate * fs_ecg;

% band-pass parameters
% n = 20; % filter order
% fc = 34; % central frequency
% BW = fc/5; % BandWidth
% band = [(fc-BW/2)*2/fs_ecg (fc+BW/2)*2/fs_ecg]; % band normalised in respect to fs/2
% coeff = fir1(n,band); % band-pass coefficients
% it is more efficient because the coefficients are not computed every time
coeff = [-0.0074 -0.0152 -0.0300 -0.0481 -0.0586 -0.0490 -0.0123 ...
	0.0470 0.1134 0.1656 0.1854 0.1656 0.1134 0.0470 ...
	-0.0123 -0.0490 -0.0586 -0.0481 -0.0300 -0.0152 -0.0074];

lastMax = 0;
isHigh = false;
lastPeak = 0;
filtData = zeros(size(ecg));
for idx = 1:length(ecg)
	for filtIdx = 0:length(coeff)-1
		if idx-filtIdx < 1
			continue;
		end
		filtData(idx) = filtData(idx) + coeff(filtIdx+1) * ecg(idx-filtIdx);
	end
	data = filtData(idx).^2;
	lastMax = lastMax*(1-lastMaxSlope);
	if lastMax < data %#ok<BDSCI>
		lastMax = lastMax + (data-lastMax)*attenuation;
	end
	if idx > settlingSamples
		if (data > lastMax*proportion) && ~isHigh %#ok<BDSCI>
			locs = [locs; idx]; %#ok<AGROW>
			lastPeak = idx;
			isHigh = true;
		elseif (data < lastMax*proportion*(1-hysteresis)) && (idx - lastPeak > minPeakDistance) %#ok<BDSCI>
			isHigh = false;
		end
	end
end

time = (0:length(ecg))/fs_ecg + t_start;
tacogram = [time(locs(2:end)); diff(time(locs))]';
end

