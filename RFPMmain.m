clc;
clear all;
c = 3e8;
% S = [ 0 0;
%       0 2;
%       -2 0
%       2 0;
%       0 -2
%       4 0;
%       -4 0;
%       0 4;
%       0 -4];
theta = 2*pi * [ 0:7 ] /8; 
S(:, 1) = [1:8] .* cos(theta);
S(:, 2) = [1:8] .* sin(theta);

PATH = 3;
SYSTEM.X = [ -1 1];
SYSTEM.Y = [ -1 1];

%FIRST PHASE
discreteX = linspace( SYSTEM.X(1), SYSTEM.X(2), 1000);
discreteY = linspace( SYSTEM.Y(1), SYSTEM.Y(2), 1000); 
%establish the dataBase of average 
flag = zeros( length(discreteX) , length(discreteY) );    %0 for not conclude, 1 for correct, -1 for no enough data 
fingerPrint = zeros( length(discreteX) , length(discreteY), PATH);
for i = 1: length(discreteX)
    for j = 1:length(discreteY)
        X = [ discreteX(i) discreteY(j) ];
        try 
            re = MPCMaker(X, S, PATH);
            d = sqrt( sum( ( re - repmat( X, size( re, 1), 1) ).^2, 2) );
            sort(d);
            tdoa = ( d(2:end) - d(1) ) / c;
            fingerPrint( i, j, :) = tdoa;
            flag(i, j) =1;
        catch ME
            flag(i, j) =-1;
        end
    end
end

X = rand(1,2) .* [SYSTEM.X(2) - SYSTEM.X(1), SYSTEM.Y(2) - SYSTEM.Y(1)] + [  SYSTEM.X(1) SYSTEM.Y(1) ];
tdoaSample = fingerPrint( 2, 2, :);
distance = Inf;
re = [];
for i = 1: length(discreteX)
    for j = 1:length(discreteY)
        tmp = sqrt( sum( (fingerPrint(i, j, :) - tdoaSample).^2) );
        if  tmp < distance
            distance = tmp;
            re = [i j];
        end
    end
end