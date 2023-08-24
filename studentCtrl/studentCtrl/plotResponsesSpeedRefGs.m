function plotResponsesSpeedRefGs(velocityRef,velocityResponseData,graceProfile,metric,speedingFine,accelerationResponse,jerkResponse)

    % plots two timeSeries objects of the same size represting velocities
    % also plots the vehicle acceleration
    F = figure();
    F.Color = [1 1 1];
    F.Position = [100 100 800 640];
    
    subplot(2,1,1);
    h = plot(velocityRef.Time,velocityRef.Data,velocityResponseData.Time,velocityResponseData.Data,velocityResponseData.Time,graceProfile,'r');
    if speedingFine
        titleStr = 'Speeding fine! ';
    else
        titleStr = 'No speeding fine! ';
    end
    
    title([titleStr, sprintf('Normalized RMSE = %f',metric)]);
    xlabel('time (s)');
    ylabel('velocity (km/h)');
    legend('reference velocity','vehicle velocity','speeding fine risk','location','northeastoutside')
    
    h(1).LineWidth = 1.5;
    h(2).LineWidth = 1.5;
    h(3).LineWidth = 1.5;
    a = gca();
    a.FontSize = 16;
    
    subplot(2,1,2);
    % acceleration computed by finite differences, but applied to velocity
    % in m/s
    h2 = plot(accelerationResponse.Time(1:end-1),accelerationResponse.Data(1:end-1),jerkResponse.Time,jerkResponse.Data);
    xlabel('time (s)');
    title(sprintf('max |acceleration| = %f, max |jerk| = %f',max(abs(accelerationResponse.Data)),max(abs(jerkResponse.Data))));
  
    legend('acceleration (m/s^2)','jerk (m/s^3)','location','northeastoutside')
    
    h2(1).LineWidth = 1.5;
    h2(2).LineWidth = 1.5;

    a = gca();
    a.FontSize = 16;