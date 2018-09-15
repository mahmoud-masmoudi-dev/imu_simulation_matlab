close all

%% Init graphics
a_scale = 2;
a = axes('XLim', a_scale*[-1 1], ...
    'YLim', a_scale*[-1 1], ...
    'ZLim', a_scale*[-1 1]);
view(3);
grid on;
cameratoolbar;
playPauseButton = uicontrol('Style', 'togglebutton', 'String', 'Play', 'Callback', @pushbutton1_Callback);

O = [0 0 0];
l1 = createVectLine(a, [1 0 0], O, 'red');
l2 = createVectLine(a, [0 1 0], O, 'green');
l3 = createVectLine(a, [0 0 1], O, 'blue');
set(l1, 'LineStyle', '--');
set(l2, 'LineStyle', '--');
set(l3, 'LineStyle', '--');

l_1 = line('Parent', a, 'Color', 'red', 'Marker', '.');
l_2 = line('Parent', a, 'Color', 'green', 'Marker', '.');
l_3 = line('Parent', a, 'Color', 'blue', 'Marker', '.');

R = createRectangle(a, [0.3 0 0], [0 0.7 0], [0 0 0]);
set(R, 'Visible', 'off');
R_ = createRectangle(a, [0.3 0 0], [0 0.7 0], [0 0 0]);

% set(l1, 'Visible', 'off');
% set(l2, 'Visible', 'off');
% set(l3, 'Visible', 'off');

%% Read csv file
M = csvread('csv\imu_record.csv');
pause
i = 1;
while i < size(M, 1)
    q = M(i, 2:end);
    q = q/norm(q);
    rotateVectLine(l1, l_1, q);
    rotateVectLine(l2, l_2, q);
    rotateVectLine(l3, l_3, q);
    rotateRectangle(R, R_, q);
    
    pause(0.25);
    i = i + 1;
end

%% TODOs
% Trace the extremity of the vector