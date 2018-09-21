function [ quat ] = quatFromTwoVectors( startVect, endVect )
%quatFromTwoVector Create the quaternion that transforms startVect to
%endVect

cosAngle = dot(startVect, endVect)/(norm(startVect)*norm(endVect));
sinAngle = norm(cross(startVect, endVect))/(norm(startVect)*norm(endVect));

if(sinAngle >= 0)
    angle = acos(cosAngle);
else
    angle = -acos(cosAngle);
end

quat = quatFromAngleAndAxis(angle, cross(startVect, endVect));


end

