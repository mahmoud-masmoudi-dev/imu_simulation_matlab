function [ quat ] = quatFromTwoVectors( startVect, endVect )
%quatFromTwoVector Create the quaternion that transforms startVect to
%endVect

cosAngle = dot(startVect, endVect)/(norm(startVect)*norm(endVect));
sinAngle = norm(cross(startVect, endVect))/(norm(startVect)*norm(endVect));

if cosAngle > 1
    angle = 0;
elseif cosAngle < -1
    angle = pi;
elseif(sinAngle >= 0)
    angle = acos(cosAngle);
else
    angle = -acos(cosAngle);
end

if angle == 0
    quat = [1; 0; 0; 0];
else
    quat = quatFromAngleAndAxis(angle, cross(startVect, endVect));
end


end

