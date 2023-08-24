function [speedingFine,velUpper] = computeSpeeding(velocityRef,velocityResponseData)

% function to determine if speeding and show the bad region of speeds.

% determine the red region
    velUpper = velocityRef.Data + 3; % 3km/h grace
    % detects reference decreases
    dvelUpper = diff(velUpper).*(diff(velUpper)<0); 
    
    % 20 seconds grace when reference decreases
    grace = [0;ones(find(velocityRef.Time<=20, 1, 'last' )-1,1)];
    graceCorrection = conv(dvelUpper,grace);
    velUpper = velUpper - graceCorrection(1:length(velUpper));
    
    % checks for speeding
    if any(velocityResponseData.Data > velUpper)
        speedingFine = true;
    else
        speedingFine = false;
    end
    