clear all;
close all;
clc;

%import para. here
% X = [0 1/2];
S = [ 0 0;
      0 2;
      -2 0
      2 0;
      0 -2
      4 0;
      -4 0;
      0 4;
      0 -4];

x = linspace(-0.99, 0.99 , 100);
y = linspace(-0.99, 0.99 , 100);
mZ = zeros(100);
for i = 1:100
    for j = 1:100
        sNew = MPCMaker([x(i) , y(j)], S, 4);
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
            sNew = MPCMaker([x(i) , y(j)], S, 5);
            re = CRLBCalculator([x(i) , y(j)], sNew);
            mZ2(i ,j) = trace(re);
        catch ME
            mZ2(i ,j) = NaN;
        end
    end
end
figure(2);
meshc(mX, mY, mZ2);