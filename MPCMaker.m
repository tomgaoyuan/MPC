function [ re flag ] = MPCMaker( X, S, nTDOA )
%simulate the multiPath used for CRLB calculator & RFPMmain
%   X <1x2>
%   nTDOA : number of paths used -1
%   re <nTDOA x 2>
%   flag : status of return value
%           -1: default, re is not available
%           1 : no sufficient path, re is not available
%           2 : path coinciding, re is available
%           0 : normal, re is available

N = size(S,1);
d = sqrt( sum( (S - repmat( X, N ,1)).^2, 2 ) );

flag = -1;
re = zeros(nTDOA+1, length(X));
for p = 1:nTDOA+1
    [y i] = min(d);
    if isempty(y) || y >= Inf 
        flag = 1;
        return;
    end
    d(i) = Inf;
    re(p, :) = S(i, :);
    
    while y == min(d)       %if there are paths coinciding
        [y2 i2] = min(d);
        d(i2) = Inf;
        flag = 2;
    end
end
if flag == -1
    flag = 0;
end