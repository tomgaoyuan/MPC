function [ re ] = MPCMaker( X, S, nPath )
%simulate the multiPath used for CRLB calculator
%   X <1x2>
%   nPath : number of paths used -1
%   re <nPath x 2>

N = size(S,1);
d = sqrt( sum( (S - repmat( X, N ,1)).^2, 2 ) );

re = zeros(nPath+1, length(X));
for p = 1:nPath+1
    [y i] = min(d);
    if y >= Inf 
        throw(MException('MPCMaker:RuntimeError','No sufficent path'));
    end
    d(i) = Inf;
    re(p, :) = S(i, :);
    
    while y == min(d)       %if there are paths coinciding
        [y2 i2] = min(d);
        d(i2) = Inf;
    end
end

