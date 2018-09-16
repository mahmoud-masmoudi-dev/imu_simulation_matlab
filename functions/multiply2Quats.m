function [ q ] = multiply2Quats( q1, q2 )
%multiply2Quats Multiply two quaternions

r1 = q1(1);
r2 = q2(1);

v1 = reshapeVect(q1(2:end));
v2 = reshapeVect(q2(2:end));

q = [r1*r2 - dot(v1, v2);...
     r1*v2 + r2*v1 + cross(v1, v2)];

end
