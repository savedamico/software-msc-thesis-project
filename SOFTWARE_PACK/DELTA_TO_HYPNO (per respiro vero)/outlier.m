function [signal, nout]=outlier(signal)
mu = mean(signal);
sigma = std(signal);
[n,p] = size(signal);
% Create a matrix of mean values by
% replicating the mu vector for n rows
MeanMat = repmat(mu,n,1);
% Create a matrix of standard deviation values by
% replicating the sigma vector for n rows
SigmaMat = repmat(sigma,n,1);
% Create a matrix of zeros and ones, where ones indicate
% the location of outliers
outliers = abs(signal - MeanMat) > 5*SigmaMat;
% Calculate the number of outliers in each column
nout = sum(outliers);

signal(find(outliers))=mu;


