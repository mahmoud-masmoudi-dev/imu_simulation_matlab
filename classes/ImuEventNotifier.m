classdef ImuEventNotifier < handle
    %FrameNotifier To notify about a frame that has just been displayed
    events
        FrameDisplayed
    end
    
    properties
    end
    
    methods
        function obj = ImuEventNotifier
        end
        
        function notifyForFrameDisplayed(obj, handles)
            notify(obj, 'FrameDisplayed', ImuEventData(handles));
        end
    end
end

