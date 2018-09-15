function [ u_out ] = reshapeVect( u_in )
%reshapeVect Reshape vector into 3x1 matrix if needed
%   throws an error if u_in has a wrong shape

if isequal(size(u_in), [3 1])
    u_out = u_in;
elseif isequal(size(u_in), [1 3])
    u_out = u_in(:);
else
    error('Bad vector shape');
end

end

