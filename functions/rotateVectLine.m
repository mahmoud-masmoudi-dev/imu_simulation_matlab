function rotateVectLine( l_in, l_out, q )
%rotateVectLine Rotate vector line l_in by a quaternion q and store it
% in l_out

xData = get(l_in, 'XData');
yData = get(l_in, 'YData');
zData = get(l_in, 'ZData');

O1 = [xData(1); yData(1); zData(1)];
O2 = [xData(2); yData(2); zData(2)];

O1_rotated = rotateVect(O1, q);
O2_rotated = rotateVect(O2, q);

xData = [O1_rotated(1) O2_rotated(1)];
yData = [O1_rotated(2) O2_rotated(2)];
zData = [O1_rotated(3) O2_rotated(3)];

% Set rotated data to l_out
set(l_out, ...
    'XData', xData, ...
    'YData', yData, ...
    'ZData', zData);

end

