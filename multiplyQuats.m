function [ q ] = multiplyQuats( varargin )
%multiplyQuats Multiply many quaternions

q = [1; 0; 0; 0];

for i=1:nargin
    q = multiply2Quats(q, reshapeQuat(varargin{i}));
end

end

