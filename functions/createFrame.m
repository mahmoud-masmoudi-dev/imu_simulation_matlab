function [ frame ] = createFrame(a)
%createFrame Create absolute frame
% a : The parent axes
% frame : The output lines of the frame in a map format

% The origin O
O = [0 0 0];

l1 = createVectLine(a, [1 0 0], O, 'red');
l2 = createVectLine(a, [0 1 0], O, 'green');
l3 = createVectLine(a, [0 0 1], O, 'blue');
set(l1, 'Marker', '.');
set(l2, 'Marker', '.');
set(l3, 'Marker', '.');

frame.x = l1;
frame.y = l2;
frame.z = l3;

end

