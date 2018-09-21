function [ data2d ] = unwrapTracingFromSphereToXYPlane( tracing )
%unwrapTracingFromSphereToXYPlane unwrap a whole tracing
% tracing : struct that has N x, y, z data points of a tracing
% data2d : 2xN matrix, where each column is the coordinates of an unwrapped
% point on the XY plane

N = length(tracing.xData);
data2d = nan(2, N);

for i=1:N
    M = [tracing.xData(i); tracing.yData(i); tracing.zData(i)];
    data2d(:, i) = unwrapPointFromSphereToXYPlane( M );
end


end

