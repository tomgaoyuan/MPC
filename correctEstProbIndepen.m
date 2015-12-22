function [ re ] = correctEstProbIndepen( X, S, nTDOPA, a, sigma )
%calculate the correct estimation probability
%   Approximate : dependence 4 neighbour
v=1;
[newS flag] = MPCMaker(X, S, nTDOPA);
assert( flag == 0 );
tmp = sqrt( sum( ( newS - repmat( X, size( newS, 1), 1) ).^2, 2) );
tmp = sort(tmp);
localAverage = ( tmp(2:end) - tmp(1) ) / v;
% C = sigma^2 * ( eye(nTDOPA) + ones(nTDOPA) );
C = sigma^2 * 2 * ( eye(nTDOPA) );     %HERE IGNORE the dependence

re = 1;
pattern = a *[ 1 0;
               0 1;
               -1 0;
               0 -1];
for i = 1: size(pattern , 1)               
    neighbour = X + pattern(1,:);
    tmp = sqrt( sum( ( newS - repmat( neighbour, size( newS, 1), 1) ).^2, 2) );     %assumption neighbour & local point have the same source
    tmp = sort(tmp);
    neighbourAverage =  ( tmp(2:end) - tmp(1) ) / v;
    d = localAverage - neighbourAverage;
%     beta = neighbourAverage - localAverage;
%     gama = localAverage.^2 - neighbourAverage.^2;
%     E = sum( 2 * localAverage .* beta + gama );
%     D = sigma^2 * 8 * sum (  beta.^2 );
% 
%     re = re * 1/2 * erfc( E / (sqrt(2 * D) ) ) ;  %HERE IGNORE the dependence. 
%       re = re * normcdf( sqrt( d.' * d) / (2 * sqrt(2) * sigma));   %HERE IGNORE the dependence. 
%     re = re * normcdf( d.' * d / sqrt( d.' * C * d ) /2 );    %
      re = re * normcdf( d.' * d / sqrt( d.' * C * d ) /2 ); %HERE Consider the dependence of observer vector
end
end

