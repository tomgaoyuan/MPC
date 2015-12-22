function [ re flag ] = sampleTDOPAMaker( X, S, nTDOPA, v, sigma )
%Calculate observed TDOPA(time difference of path arrival) with noise
%   X <1x2>
%   nTDOPA : number of paths used -1
%   sigma : stand deviation
%   re <nTDOPA x 2>
%   flag : status of return value
%           1: no efficient data, re is not available
%           0: normal, re is available

[ newS f] = MPCMaker(X, S, nTDOPA);
switch f
    case { 0 2} %normal & paths coinciding
        d = sqrt( sum( ( newS - repmat( X, size( newS, 1), 1) ).^2, 2) );
        %add noise on TOA
        n = sigma * randn( size(d,1), size(d,2) ); %unit:time
        d = d + v* n ;
        re = ( d(2:end) - d(1) ) / v;
        flag = 0;
    otherwise
        re = zeros( nTDOPA, 1);
        flag = 1;
end

end

