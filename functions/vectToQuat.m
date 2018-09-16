function [ q ] = vectToQuat( u )
%vectToQuat Transform a vector into a quaternion
% The vector is the vector part of the quaternion. The scalar part is zero

q = [0; reshapeVect(u)];

end

