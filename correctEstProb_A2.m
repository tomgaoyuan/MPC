function [ re ] = correctEstProb_A2( X, S, nTDOPA, a, sigma )
%calculate the correct estimation probability by method 2
%   Approximate : differential
v=1;
[newS flag] = MPCMaker(X, S, nTDOPA);
assert( flag == 0 );
tmp = sqrt( sum( ( newS - repmat( X, size( newS, 1), 1) ).^2, 2) );

cosPhi = ( X(1) - newS(:,1) ) ./ tmp;
sinPhi = ( X(2) - newS(:,2) ) ./ tmp;

A = a /4 /sigma / v * sqrt( sum( ( cosPhi(2:end) - cosPhi(1) ).^2 ) );
B = a /4 /sigma / v * sqrt( sum( ( sinPhi(2:end) - sinPhi(1) ).^2 ) );

re = ( 1/2 * erfc(-A) ).^2 * ( 1/2 * erfc(-B) ).^2;
end

