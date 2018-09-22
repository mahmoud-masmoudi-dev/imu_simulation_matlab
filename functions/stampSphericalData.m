function [ planePoints ] = stampSphericalData( sphericalPoint )
%stampSphericalData Transform points on a sphere to a plane
% as if this sphere has stamped its dots on a plane paper
% sphericalPoint : 3xN matrix of dots coordinates on the sphere (N is the
% number of dots)
% planePoints : 2xN matrix of dots after being stamped on the XY plane

if size(sphericalPoint, 1) ~= 3
    error('Must enter valid spherical data (3xN matrix)');
end

N = size(sphericalPoint, 2);
NB = 2; % Each 2 points, we update our axis (point to the new point)
planePoints = NaN(2, N); % Initialize output

q = [1;0;0;0]; % Initial cumulative rotation 
T = [0; 0; 0]; % Initial cumulative translation

chunk = NaN(3, NB); % Initialize 3xNB chunk of points (point on each column) to be wrapped around its first point
for i=1:N    
    chunk(:, NB-rem(i, NB)) = rotateVect(sphericalPoint(:, i), q);
    
    if rem(i, NB) == 0
        % Unwrap the chunk + XY translation
        for j=1:NB
            planePoints(:, i-NB+j) = unwrapPointFromSphereToXYPlane(chunk(:, j)) + T(1:2);
        end
        
        % Change the origin point
        U = rotateVect(sphericalPoint(:, i), q);
        
        if (dot(U, [0 0 1]) == 1) || (dot(U, [0 0 1]) == -1)
            theta = 0;
            warning('Maybe any other theta value ??');
        else
            theta = acos(U(1)/sqrt(1-U(3)^2))*sign(U(2));
        end  
        phi = acos(U(3));
        
        % Combine the new rotation with the old cumulated rotations
        q = multiply2Quats(quatFromTwoVectors(U, [0 0 1]), q);
        % Combine translations (to move sphere
        T = T + [phi*cos(theta); phi*sin(theta); 0];
    end
end

end

