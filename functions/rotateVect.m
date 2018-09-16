function [ v ] = rotateVect( u, q )
%rotateVect Rotate a vector u using the quaternion q. Store the result in
% the vector v. q must be unit quaternion

if abs(norm(q)-1) > 1e-5
    error('q must be unit quaternion');
end

U = vectToQuat(u);
Q = reshapeQuat(q);
V = multiplyQuats(Q, U, conjQuat(Q));
v = V(2:end);

end

