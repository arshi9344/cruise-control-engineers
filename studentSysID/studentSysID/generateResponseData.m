function [systemInputData,systemResponseData, myResponseData] = generateResponseData(Gvehicle, numResponses, deltaSteps)

% takes in numResponses different relative torque request steps
% and returns response data. 
%
% systemResponseData is a numResponses x 1 cell array of timeSeries objects.
% systemInputData{j} is the input timeSeries for the jth response
% systemResponseData{j} is the output timeSeries for the jth response
% myResponseData{j} is the output timeSeries for the jth response of the
% LTI model.
%
% deltaSteps(j) is the percentage step increase in the torque request 
% for the jth response. i.e., the input for the jth response steps from
% some nominal torque request Tnominal to (1+deltaSteps(j))*Tnominal

% initialize to empty cell arrays
systemResponseData = cell(numResponses,1);
systemInputData = cell(numResponses,1);
myResponseData = cell(numResponses,1);

if numResponses == 0 
    return
end

hws = get_param('vehicleID','modelWorkspace');
hws.assignin('myVehicleModel',Gvehicle);
for j=1:numResponses
    % sets a parameter in the simulink model
    hws.assignin('deltaStep',deltaSteps(j));
    simOut = sim('vehicleID');
    systemInputData{j} = simOut.torqueRequest;
    systemResponseData{j} = simOut.velocityResponse;
    myResponseData{j} = simOut.velocityModelResponse;
end

    
