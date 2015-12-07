clear all;
close all;
clc;

%import para. here
% X = [0 1/2];


% S = [ 0 0;
%       0 2;
%       -2 0
%       2 0;
%       0 -2
%       4 0;
%       -4 0;
%       0 4;
%       0 -4];
% theta = 2*pi * [ 0:7 ] /8; 
% S(:, 1) = [1:8] .* cos(theta);
% S(:, 2) = [1:8] .* sin(theta);
S = [  2 2;
       -2 2;
       -2 -2;
       2 -2];
 v = 1;
 sigma =0.005;
% x = linspace(-0.99, 0.99 , 100);
% y = linspace(-0.99, 0.99 , 100);
x = linspace(0, 4 , 100);
y = linspace(0, 4 , 100);

mZ = zeros(100);
for i = 1:100
    for j = 1:100
        [ sNew f] = MPCMaker([x(i) , y(j)], S, 3);
        if f == 0
            re = CRLBCalculator([x(i) , y(j)], sNew, v, sigma);
            mZ(i ,j) = trace(re);
        else
            mZ(i, j) = NaN;
        end
    end
end
[ mX mY] = meshgrid(x, y);
figure(1);
meshc(mX, mY, mZ);

% load('data');
% X = [discreteX(90) discreteY(5)]; 
% [ sNew f] = MPCMaker(X, S, 3);
% re = CRLBCalculator(X, sNew, v, sigma);
% trace(re)
