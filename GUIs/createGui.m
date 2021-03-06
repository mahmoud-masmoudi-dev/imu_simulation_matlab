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

windowWidth = get(guiComponents.f, 'Position');
windowWidth = windowWidth(3);
windowHeight = get(guiComponents.f, 'Position');
windowHeight = windowHeight(4);

view(3);
grid on;
cameratoolbar;
guiComponents.playPauseButton = uicontrol('Style', 'togglebutton', 'String', 'Play', 'Position', [0 0 100 20], 'Callback', callbacksMap.playPauseCallback);
guiComponents.timestampText = uicontrol('Style', 'text', 'String', 'Timestamp', 'Position', [0 20 100 20]);
guiComponents.frameText = uicontrol('Style', 'text', 'String', 'Frame#', 'Position', [0 40 100 20]);
% Create slider
guiComponents.slider = uicontrol('Style', 'slider', 'Position', [100 0 windowWidth-100 20], 'Callback', callbacksMap.sliderCallback);

% Create the tracing points checkbox
guiComponents.tracingPointsCheckbox = uicontrol('Style', 'checkbox', 'String', 'Tracing points', 'Position', [0 windowHeight-20 100 20], 'Callback', callbacksMap.checkboxCallback);
guiComponents.tracingPointsClearButton = uicontrol('Style', 'pushbutton', 'String', 'Clear tracing', 'Position', [0 windowHeight-40 100 20], 'Callback', callbacksMap.clearTracingButtonCallback);
guiComponents.tracingPointsExportButton = uicontrol('Style', 'pushbutton', 'String', 'Export tracing', 'Position', [0 windowHeight-60 100 20], 'Callback', callbacksMap.exportTracingButtonCallback);

end
