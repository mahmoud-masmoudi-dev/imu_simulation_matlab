function [ planePoints ] = stampSphericalData( sphericalPoint )
%stampSphericalData Transform points on a sphere to a plane
% as if this sphere has stamped its dots on a plane paper
% sphericalPoint : 3xN matrix of dots coordinates on the sphere (N is the
% number of dots)
% planePoints : 2xN matrix of dots after being stamped on the XY plane

planePoints = stampSphericalDataInitialized( sphericalPoint, [1;0;0;0], [0;0;0] );

end

