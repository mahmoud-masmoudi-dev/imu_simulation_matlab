close all; clc;

cameratoolbar;

load('C:\Users\Mahmoud\Documents\SyncToy\dev\MATLAB\imu\tracings\test3.mat');

U = [tracing.xData(1); tracing.yData(1); tracing.zData(1)];

q = quatFromTwoVectors(U, [0 0 1]);

newTracing = tracing; % Transformed around Z axis
for i=1:length(tracing.xData)
    v = rotateVect([tracing.xData(i) tracing.yData(i) tracing.zData(i)], q);
    newTracing.xData(i) = v(1);
    newTracing.yData(i) = v(2);
    newTracing.zData(i) = v(3);
end

[ data2d ] = unwrapTracingFromSphereToXYPlane( newTracing );

a = axes();

[xData,yData,zData] = sphere();
s = surf('Parent', a, 'EdgeAlpha', 0.2, 'FaceAlpha', 0.2, ...
    'XData', xData, 'YData', yData, 'ZData', zData);
line('Parent', a, 'Color', 'magenta', 'LineStyle', 'none', 'Marker', '.', ...
    'XData', data2d(1, :), ...
    'YData', data2d(2, :), ...
    'ZData', ones(1, length(data2d)));
line('Parent', a, 'Color', 'black', 'LineStyle', 'none', 'Marker', '.', ...
    'XData', tracing.xData, ...
    'YData', tracing.yData, ...
    'ZData', tracing.zData);

line('Parent', a, 'Color', 'red', 'LineStyle', 'none', 'Marker', '.', ...
    'XData', newTracing.xData, ...
    'YData', newTracing.yData, ...
    'ZData', newTracing.zData);

set(a, 'DataAspectRatio', [1 1 1]);
