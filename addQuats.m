function [ q ] = addQuats( varargin )
%addQuats Adds up many quaternions

q = [0; 0; 0; 0];

for i=1:nargin
    q = q + reshapeQuat(varargin{i});
end

end

