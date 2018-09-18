classdef (ConstructOnLoad) ImuEventData < event.EventData
    % Allows passing data to imu events
    properties
        handles
    end
   
    methods
        function eventData = ImuEventData(handles)
            eventData.handles = handles;
        end
    end
end
