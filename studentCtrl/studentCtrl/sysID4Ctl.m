function vehicleModel = sysID4Ctl(inputData,outputData)

% This function takes in two cell arrays of timeseries data and returns an
% LTI system object (this can be a transfer function or a state space
% model). 
%
% This is used to find a system model to pass into your control design 
% function. You could use the same code as for your sysID function, but 
% you could also use this code to generate a simpler model that is easier 
% to work with for control design.
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
% Hints:
% -- The system starts in equilibrium. From the input and output signals, 
%    you should be able to determine how much you need to subtract from each
%    to convert them into *deviation* of the input from equilibrium and 
%    *deviation* of the ouput from equilbrium. These should be the 
%    equivalent inputs and outputs of your LTI system modelso you should be able to work
% -- To access the number of timeSeries objects in inputData you can use
%    length(inputData). (Similarly for outputData.)
% Constraints:
% -- you are expected to use lsim to simulate your model within this function
% -- you should ** not ** call the function generateResponseData in this function. 
% The only information about the system you should use in this function are the input/output 
% timeSeries arrays that are passed as arguments to the function

% this is a fixed reference vehicle model to make the code run.
vehicleModel = tf(270,[100,1]);