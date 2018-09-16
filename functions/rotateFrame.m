function rotateFrame( identityFrame, rotatedFrame, q )
%rotateFrame Rotate a frame composed of 3 orthogonal lines
% identityFrame : 3x1 cell of lines for the identity frame
% rotatedFrame : 3x1 cell of lines for the rotated frame
% q : Rotation quaternion

rotateVectLine(identityFrame.x, rotatedFrame.x, q);
rotateVectLine(identityFrame.y, rotatedFrame.y, q);
rotateVectLine(identityFrame.z, rotatedFrame.z, q);

end

