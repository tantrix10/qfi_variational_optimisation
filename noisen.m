function [ rhon ] = noisen( rho, E,n )
%NOISEN Summary of this function goes here
%   Detailed explanation goes here

rhon=zeros(2^n);

for i =1:2^n;
    rhon=rhon+(E{i}*rho*E{i});

end

