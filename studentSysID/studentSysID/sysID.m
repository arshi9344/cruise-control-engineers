function vehicleModel = sysID(inputData,outputData)

% This function takes in two cell arrays of timeseries data and returns an
% LTI system object (this can be a transfer function or a state space
% model). 
%
% Arguments:
% -- inputData is a k x 1 cell array where each element is a timeSeries object
%    - inputData{j} is the timeSeries object corresponding to the jth 
%      "training" input
%    - inputData{j}.Time is an array of the simulation time-stamps for the
%      jth "training" input
%    - inputData{j}.Data is an array of the corresponding input signal values
%      for the jth "training" input
% -- ouputData is a k x 1 cell array where each element is a timeSeries object
%    - outputData{j} is the timeSeries object corresponding to the jth
%      "training" output
%    - outputData{j}.Time is an array of the simulation time-stamps for the
%      jth "training" output
%    - outputData{j}.Data is an array of the corresponding input signal values
%      for the jth "training" output
%
% Assumptions:
% -- the function assumes that all of the inputData{j}.Time vectors and 
% all of the outputData{j}.Time vectors are identical.
%
% Constraints:
% -- if you want to simulate your model within this function, you are 
%    expected to use lsim.
% -- you should ** not ** call the function generateResponseData in this function. 
%    The only information about the system you should use in this function are the input/output 
%    timeSeries arrays that are passed as arguments to the function
% 
% Hints:
% -- The system starts in equilibrium. In the data preprocessing given below, 
%    there is a shift that converts the given signals into the *deviation* 
%    of the input from equilibrium and the *deviation* of the ouput from 
%    equilbrium. Your LTI system model works with these deviation signals.
% -- To access the number of timeSeries objects in inputData you can use
%    length(inputData). (Similarly for outputData.)
% -- With a little trick (illustrated in the sample code below), you can run lsim 
%    on multiple different inputs simultanously (stored as an array) and 
%    it will return multiple outputs (stored as an array)

% Everything below is just sample code that may or may not be useful.
% It can be safely removed and replaced with your code.

% this is just a fixed reference vehicle model to get you started. It does not
% use the input/output data at all!
vehicle_tf = @(theta)tf(theta(1),[theta(2) theta(3)]);

% DATA PREPROCESSING (may be useful, can be removed if not needed):
% The following converts the cell arrays of time-series that are passed
% into the function into arrays that are (# timesteps) x (# timeSeries)
% and are shifted to remove the equilibrium values, so they are easier 
% to pass into lsim.
% -- inputTimesArray is a vector of time-stamps
% -- inputDataArray is an array of corresponding input signal values 
%    shifted to represent deviation from equilibrium, with
%    each column corresponding to a different input signal
% -- outputDataArray is an array of corrsponding output signal values, 
%    shifted to represent deviation from equilibrium, with 
%    each column corresponding to a different output signal

inputTimesVector = inputData{1}.Time; % uses assumption that these are all the same
inputDataArray = zeros(length(inputData{1}.Data),length(inputData));
outputDataArray = zeros(length(outputData{1}.Data),length(outputData));
for j=1:length(inputData)
    inputDataArray(:,j) = inputData{j}.Data - inputData{j}.Data(1);
end
for j=1:length(outputData)
    outputDataArray(:,j) = outputData{j}.Data - outputData{j}.Data(1);
end

% The following is an example of how to use lsim to simulate the response
% of vehicleModel to all of the inputs, and capture the responses in an array.
% The same approach may be useful for your systemID method.

% Please comment this out if you do not need to use this code!!
modelOutputArray = @(theta)lsim(vehicle_tf(theta)*eye(length(inputData)),inputDataArray,inputTimesVector);
theta0=[10;12;13];
rmse = @(A,B) sqrt(sum((A-B).^2)/length(A));
%reshaping so all data is in one column instead of 4 when run using sysIDeval
cost = @(theta) rmse(reshape(modelOutputArray(theta), [], 1), reshape(outputDataArray, [], 1)); 
    
thetaOpt = fminsearch(cost,theta0);
vehicleModel=vehicle_tf(thetaOpt)
disp("ok")

