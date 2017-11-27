function [ K ] = G(H,X)
%G Summary of this function goes here
%   Detailed explanation goes here
K = ((-X*X + 2*sqrt(-1)*((H*X)-(X*H))));

end

