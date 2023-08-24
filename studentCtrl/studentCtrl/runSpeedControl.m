function [torqueRequestData, velocityResponseData,velocityRefData] = runSpeedControl(myController,Ki,Kt,Tmax,Tmin,velocityRef)

% runs the speed control simulation with a given controller and a given 
% velocity reference signal 
%
% torqueRequestData is a timeSeries object corresponding to the output of
% the controller.
% velocityResponseData is a timeSeries object corresponding to the velocity 
% output of the vehicle.

hws = get_param('vehicleCtl','modelWorkspace');
hws.assignin('myController',myController);
hws.assignin('Ki',Ki);
hws.assignin('Kt',Kt);
hws.assignin('TmaxAW',Tmax);
hws.assignin('TminAW',Tmin);
hws.assignin('velocityRef',velocityRef);

simOut = sim('vehicleCtl');
torqueRequestData = simOut.torqueRequestCtl;
velocityResponseData = simOut.velocityResponseCtl;
velocityRefData = simOut.velocityRefCtl;
