clear all;
close all;
clc;
parameters;
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
S = SYSTEM.S;
v = SYSTEM.C;
sigma = SYSTEM.SIGMA;
% x = linspace(-0.99, 0.99 , 100);
% y = linspace(-0.99, 0.99 , 100);
x = 0 : 10 * SYSTEM.L :400;
y = 0 : 10 * SYSTEM.L :400;

mZ = zeros(length(x), length(y));
for i = 1:length(x)
    for j = 1:length(y)
        [ sNew f] = MPCMaker([x(i) , y(j)], S, SYSTEM.NTDOPA);
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
[c,h] = contour(mX, mY, mZ);
clabel(c,h);
grid on;
axis square;
xlabel('X axis');
ylabel('Y axis');
set(h,'LineWidth',2)
hold on;
plot(SYSTEM.S(1,1),SYSTEM.S(1,2), 'ro','LineWidth',2);
legend('CRB','image');
% plot(150,50,'gx','LineWidth',2);
% plot(250,50,'gx','LineWidth',2);
% plot(350,50,'gx','LineWidth',2);
% plot(250,150,'gx','LineWidth',2);
% plot(350,150,'gx','LineWidth',2);
% plot(350,250,'gx','LineWidth',2);
% title('Cramer-Rao Bound contour');
figure(2);
meshc(mX, mY, mZ);
% load('data');
% X = [discreteX(90) discreteY(5)]; 
% [ sNew f] = MPCMaker(X, S, 3);
% re = CRLBCalculator(X, sNew, v, sigma);
% trace(re)
