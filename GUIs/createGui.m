function [ guiComponents ] = createGui(playPauseCallback)
%createWorld Create a GUI
% playPauseCallback Custom callback for the playPauseButton

a_scale = 2;
guiComponents.f = figure;
guiComponents.a = axes('Parent', guiComponents.f, ...
    'XLim', a_scale*[-1 1], ...
    'YLim', a_scale*[-1 1], ...
    'ZLim', a_scale*[-1 1]);

view(3);
grid on;
cameratoolbar;
guiComponents.playPauseButton = uicontrol('Style', 'togglebutton', 'String', 'Play', 'Callback', playPauseCallback);

end
