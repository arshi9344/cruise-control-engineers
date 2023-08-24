function theta = generateRoadSlope(maxSlope,Tmax,flag)

% returns a function handle theta for a function 
% theta : R -> R 
% that defines the road slope in degrees as a function of position.
% This should satisfy |theta| <= maxSlope.
% flag is a string that determines the mode in which the function works
% flag = 'step' means that the road slope is a step from 0 to +/- maxSlope at
%               time t=10.
% flag = 'pl'   means that the road slope is piecewise linear with randomly
%               chosen changepoints
% note that setting maxSlope = 0 ensures that theta is the zero function.
%
% updated: James Saunderson August 2023
% adds support for step inputs
% suppresses plotting code if maxSlope = 0, since it is trivial.

if strcmp(flag,'step')
    stepsgn = sign(randn(1)); % 1 with prob 1/2, -1 with prob 1/2
    theta = @(x) stepsgn*maxSlope*(x>=0);
else
% for now let's just make this a a piecewise linear slope 
% (corresponding to a piecewise quadratic road profile)

% maxDist is the last position at which we might want a slope change.
% assuming Tmax second simulation and nominal 16m/s speed, we would 
% like the last slope change well before Tmax*16m.
maxDist = 16*Tmax;
% sample six random positions for the slope to change at
% chosen so as not to be too close together.
lambda = 0.5;
changepoints = cumsum(((1-lambda)*rand(6,1)+lambda*1)*maxDist/6);
% list of possible slopes
possibleSlopes = maxSlope*([-1,-0.75,0.75,1]);
% sample two random slopes from the list
slopes = [possibleSlopes(randi(length(possibleSlopes),1));possibleSlopes(randi(length(possibleSlopes),1))];

% function handle that computes the value of the slope at a point x. 
% this is just linear interpolation based on the changepoints.
theta = @(x)interp1([0; changepoints; maxDist],[0; 0; slopes(1); slopes(1); slopes(2); slopes(2); 0; 0],x,'linear',0);

end

if maxSlope==0
    return; % avoid plotting
else
    
posVals = 0:0.1:16*Tmax;
thetaVals = arrayfun(theta,posVals);

F = figure();
F.Color = [1 1 1];
yyaxis left;
h1 = plot(posVals,thetaVals);
ylabel('road slope (degrees)');
yyaxis right;
% compute height of road. Divide by 10 beceause sample every 0.1 m
htVals = cumsum(tan(pi*thetaVals/180))/10; 
h2 = plot(posVals,htVals);
ylabel('road elevation (m)');
title('road slope profile')
xlabel('position (m)');

h1.LineWidth = 1.5;
h2.LineWidth = 1.5;
a = gca();
a.FontSize = 16;
end

end