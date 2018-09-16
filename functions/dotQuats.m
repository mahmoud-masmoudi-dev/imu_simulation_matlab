function [ val ] = dotQuats( q1, q2 )
%dotQuats Compute the dot product of two quaternions

Q1 = reshapeQuat(q1);
Q2 = reshapeQuat(q2);

val = dot(Q1(2:end), Q2(2:end));

end

