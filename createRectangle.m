function [ R ] = createRectangle( a, h_vect, w_vect, origin )
%createRectangle Create a rectangle whose height is directed by h_vect and
% whose width is directed by w_vect
% origin : The coordinates of the middle point

A = [0; 0; 0];
B = reshapeVect(h_vect);
D = reshapeVect(w_vect);
C = B+D;

% Shift all points by -C/2 to make the center of the rectangle at the
% origin
A = A - C/2;
B = B - C/2;
D = D - C/2; % Pay attention ! Must be before modifying C
C = C - C/2;

% Translate all points by origin
T = reshapeVect(origin);
A = A + T;
B = B + T;
C = C + T;
D = D + T;

R = patch('Parent', a, ...
    'XData', [A(1) B(1) C(1) D(1)], ...
    'YData', [A(2) B(2) C(2) D(2)], ...
    'ZData', [A(3) B(3) C(3) D(3)]);

end

