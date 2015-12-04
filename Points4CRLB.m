clear all;
close all;
clc;

%import para. here
X = [0 0];
S = [ 1 0;
      0 2;
      -3 0
      0 -4];

% N = size(S,1);
% c = 3e8;
% SIGMA = 1;
% 
% d = sqrt( sum( (S - repmat( X, N ,1)).^2, 2 ) );
% C = ones(N-1) + eye(N-1);
% pUpX = -( S(2:end, :) - repmat( X, N-1 ,1) )./ repmat(d(2:end), 1, 2) + ...
%                 repmat( (S(1,:) - X)/d(1), N-1, 1);
% 
% I = zeros(N-1);         %Fisher information
% for i = 1: (N-1)
%     for j = 1: (N-1)
%         I(i,j) = pUpX(:, i).' * inv(C) * pUpX(:, j);
%     end
% end
% re = c * SIGMA^2 * inv(I)

% MPCMaker(X,S,3)
% CRLBCalculator(X,S)

x = linspace(-0.99, 0.99 , 100);
y = linspace(-0.99, 0.99 , 100);
mZ = zeros(100);
for i = 1:100
    for j = 1:100
        sNew = MPCMaker([x(i) , y(j)], S, 2);
        re = CRLBCalculator([x(i) , y(j)], sNew);
        mZ(i ,j) = trace(re);
    end
end
[ mX mY] = meshgrid(x, y);
figure(1);
meshc(mX, mY, mZ);
mZ2 = zeros(100);
for i = 1:100
    for j = 1:100
        try
            sNew = MPCMaker([x(i) , y(j)], S, 3);
            re = CRLBCalculator([x(i) , y(j)], sNew);
            mZ2(i ,j) = trace(re);
        catch ME
            mZ2(i ,j) = NaN;
        end
    end
end
figure(2);
meshc(mX, mY, mZ2);