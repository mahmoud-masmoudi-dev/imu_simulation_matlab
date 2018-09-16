function [ q ] = crossQuats( q1, q2 )
%crossQuats Compute the cross product of two quaternions

q = 0.5*(multiply2Quats(q1, q2) - multiply2Quats(conjQuat(q1), conjQuat(q2)));

end

