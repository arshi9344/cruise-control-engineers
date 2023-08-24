function [mseArray,nmseArray] = computeMSE(tSeriesArray1,tSeriesArray2)

% computes the mse between two cell arrays of timeSeries objects of the
% same size.
% also computes the normalized mse. In this case, the normalization
% is to divide by the squared 2-norm of the second argument
numSeries = length(tSeriesArray1); % should be the same for both
lenSeries = length(tSeriesArray1{1}.Data); % should be the same for both

mseArray = zeros(numSeries,1);
nmseArray = zeros(numSeries,1); 

for j=1:numSeries
    mseArray(j) = sum((tSeriesArray1{j}.Data - tSeriesArray2{j}.Data).^2)/lenSeries;
    nmseArray(j) = mseArray(j)/(sum((tSeriesArray2{j}.Data).^2)/lenSeries);
end