function [ q ] = quatFromAngleAndAxis( alpha, u )
%quatFromAngleAndAxis Compute a quaternion given an angle of rotation
% alpha around an axis defined by the vector u

u_normalized = reshapeVect(u)/norm(u);

q = [cos(alpha/2); sin(alpha/2)*u_normalized];

end

