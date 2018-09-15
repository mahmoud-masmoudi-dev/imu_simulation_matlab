function [ conj_q ] = conjQuat( q )
%conjQuat Compute the conjugate of quaternion q

conj_q = -reshapeQuat(q);
conj_q(1) = -conj_q(1);

end

