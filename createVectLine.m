function [ l ] = createVectLine( a, u, origin, color )
%createVectLine Create a 3D vector line object in an axes a, given the
% vector u
% origin (optional) : The coordinates of the origin of the vector line
% color (optional) : The color of the line (string format)

U = reshapeVect(u);
O = [0; 0; 0]; % Default origin
C = 'red';

if nargin >= 4
    C = color;
end
if nargin >= 3
    O = reshapeVect(origin);
end

l = line('Parent', a, ...
    'XData', [O(1) U(1)], 'YData', [O(2) U(2)], 'ZData', [O(3) U(3)], ...
    'Color', C, 'marker', '.');

end

