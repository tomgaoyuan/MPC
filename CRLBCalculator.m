function [ re ] = CRLBCalculator( X, S )
%calculate the CRLB of OTDOA scen.
%X <1x2> : Theta
%S <Nx2> : coors of source
%re : inv of I

N = size(S,1);
c = 3e8;
SIGMA = 1;

d = sqrt( sum( (S - repmat( X, N ,1)).^2, 2 ) );
C = ones(N-1) + eye(N-1);
pUpX = -( S(2:end, :) - repmat( X, N-1 ,1) )./ repmat(d(2:end), 1, 2) + ...
                repmat( (S(1,:) - X)/d(1), N-1, 1);

I = zeros(N-1);         %Fisher information
for i = 1: (N-1)
    for j = 1: (N-1)
        I(i,j) = pUpX(:, i).' * inv(C) * pUpX(:, j);
    end
end
re = c * SIGMA^2 * inv(I);

end

