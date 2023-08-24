function plotResponses(tSeriesArray1,tSeriesArray2,nrmseArray,deltaSteps)

% plots the first four elements of two cell arrays of timeseries.
% also reports a normalized root mean squared error quantity.

numSeries = length(tSeriesArray1); % should be the same for both
F = figure();
F.Color = [1 1 1];
% make the figure window bigger than usual
F.Position = [100 100 800 640];
% this line only works in MATLAB 2018b or newer(!)
if verLessThan('matlab','9.5')
    % do nothing;
else
    sgtitle(sprintf('Average normalized root mean squared error = %f',sum(nrmseArray)/length(nrmseArray)));
end

for j=1:numSeries
    subplot(2,2,j);
    h = plot(tSeriesArray1{j}.Time,tSeriesArray1{j}.Data,tSeriesArray2{j}.Time,tSeriesArray2{j}.Data);
    title(sprintf('Normalized RMSE = %f',nrmseArray(j)));
    xlabel('time (s)');
    ylabel('velocity (km/h)');
    if deltaSteps(j) > 0
        legend('model response','system response','Location','southeast');
    else 
        legend('model response','system response','Location','northeast');
    end
    h(1).LineWidth = 1.5;
    h(2).LineWidth = 1.5;
    a = gca();
    a.FontSize = 16;
end
