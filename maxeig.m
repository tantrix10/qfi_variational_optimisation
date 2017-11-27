function [ nextrho ] = maxeig( A )
%MAXEIG Summary of this function goes here
%   Detailed explanation goes here
[V,D]=eig(A); %eigs(A,size(A,1));%

if ~issorted(diag(D))
    [V,D] = eig(A);
    [D,I] = sort(diag(D));
    V = V(:, I);
end

nextrho=V(:,end);


end

