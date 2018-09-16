function rotateRectangle( r_in, r_out, q )
%rotateRectangle Rotate rectangle patch r_in by a quaternion q and store it
% in r_out

xData = get(r_in, 'XData');
yData = get(r_in, 'YData');
zData = get(r_in, 'ZData');

O1 = [xData(1); yData(1); zData(1)];
O2 = [xData(2); yData(2); zData(2)];
O3 = [xData(3); yData(3); zData(3)];
O4 = [xData(4); yData(4); zData(4)];

O1_rotated = rotateVect(O1, q);
O2_rotated = rotateVect(O2, q);
O3_rotated = rotateVect(O3, q);
O4_rotated = rotateVect(O4, q);

xData = [O1_rotated(1) O2_rotated(1) O3_rotated(1) O4_rotated(1)];
yData = [O1_rotated(2) O2_rotated(2) O3_rotated(2) O4_rotated(2)];
zData = [O1_rotated(3) O2_rotated(3) O3_rotated(3) O4_rotated(3)];

% Set rotated data to r_out
set(r_out, ...
    'XData', xData, ...
    'YData', yData, ...
    'ZData', zData);

end

