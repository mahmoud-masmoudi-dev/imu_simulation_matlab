function [ guiComponents ] = createGui(callbacksMap)
%createWorld Create a GUI
% callbacksMap Custom callbacks for each gui component grouped in a map
% callbacksMap.playPauseCallback : for the playPauseButton
% callbacksMap.sliderCallback : for the slider

a_scale = 1;
guiComponents.f = figure;
guiComponents.a = axes('Parent', guiComponents.f, ...
    'XLim', a_scale*[-1 1], ...
    'YLim', a_scale*[-1 1], ...
    'ZLim', a_scale*[-1 1]);

view(3);
grid on;
cameratoolbar;
guiComponents.playPauseButton = uicontrol('Style', 'togglebutton', 'String', 'Play', 'Position', [0 0 100 20], 'Callback', callbacksMap.playPauseCallback);
guiComponents.timestampText = uicontrol('Style', 'text', 'String', '', 'Position', [0 20 100 20]);
guiComponents.frameText = uicontrol('Style', 'text', 'String', '', 'Position', [0 40 100 20]);
% Create slider
windowWidth = get(guiComponents.f, 'Position');
windowWidth = windowWidth(3);
guiComponents.slider = uicontrol('Style', 'slider', 'Position', [100 0 windowWidth-100 20], 'Callback', callbacksMap.sliderCallback);

end
