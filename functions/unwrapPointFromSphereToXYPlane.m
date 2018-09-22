function [ coords2d ] = unwrapPointFromSphereToXYPlane( M )
%unwrapPointFromSphereToXYPlane Compute coordinates of input 3D data into
% XY plane after unwrapping the sphere centered around the [0;0;1] of the
% sphere frame, viewed from the center of the sphere [0;0;0]
% M is the point's coordinates
% coord2d is the coordinates in the XY plane viewed from the center of
% the sphere to the [0;0;1] point

x = M(1);
y = M(2);
z = M(3);

% Handle the case of [0 0 1] and [0 0 -1]
if (dot(M, [0 0 1]) > 0.99)
    coords2d = [0; 0];
    return;
elseif (dot(M, [0 0 1]) < -0.99)
    coords2d = [pi; 0];
    warning('Or maybe [0 pi] ??');
    return;
end

coords2d = NaN(2, 1);
coords2d(2) = acos(z)*sin(acos(x/sqrt(1-z^2))*sign(y));
coords2d(1) = acos(z)*cos(acos(x/sqrt(1-z^2))*sign(y));

end

