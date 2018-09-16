function [ q_out ] = reshapeQuat( q_in )
%reshapeQuat Reshape quaternion into 4x1 matrix if needed
%   throws an error if q_in has a wrong shape
%   the q_out is of the form [w; x; y; z] where w is the scalar component
%   q_in(1) must be the scalar component

if isequal(size(q_in), [4 1])
    q_out = q_in;
elseif isequal(size(q_in), [1 4])
    q_out = q_in(:);
else
    error('Bad vector shape');
end

end