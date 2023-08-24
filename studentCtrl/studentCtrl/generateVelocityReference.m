function velocityReference = generateVelocityReference(Tmax,vnominal,flag)

% if flag='const' then output constant velocity
% if flag='var' then create velocity reference that switches twice in Tmax seconds. 
% The first switch is after 10 seconds. 
% The second switch is between 1/3 and 2/3 of the way through the simulation
 
ts = (0:0.1:Tmax)';
if strcmp(flag,'const')
    vrefVals = vnominal*ones(size(ts));
elseif strcmp(flag,'var')
   
changeTime1 = 10;
changeTime2 = round(Tmax/3)*(1+rand());

randSpeedVal = 0.5*rand(2,1)+0.5*ones(2,1); % two random values between 0.5 and 1.
randSpeedVal = randSpeedVal.*sign(randn(2,1)); % randomly switch signs

vrefVals = vnominal*(ts<=changeTime1) + ...
     (vnominal + 10*randSpeedVal(1))*((ts > changeTime1) & (ts <= changeTime2)) + ...
     (vnominal + 10*randSpeedVal(1)+10*randSpeedVal(2))*((ts > changeTime2));
end
velocityReference = timeseries(vrefVals,ts); % change to a timeseries object
