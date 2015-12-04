clc;
clear all;

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
% S(:, 2) = [1:8] .* sin(theta)
S = [  2 2;
       -2 2;
       -2 -2;
       2 -2];

FLAG_LOAD = 1;
SYSTEM.NTDOPA = 3;
SYSTEM.X = [ 0 1];
SYSTEM.Y = [ 0 1];
SYSTEM.C = 1;
SYSTEM.SIGMA = 0.01;
%FIRST PHASE
load('data');
error = zeros(1, 1000);
% discreteX = linspace( SYSTEM.X(1), SYSTEM.X(2), 100);
% discreteY = linspace( SYSTEM.Y(1), SYSTEM.Y(2), 100);
X = [discreteX(90) discreteY(5)]; 
for drop = 1:1000
    [ sample flag ] = sampleTDOPAMaker(X, S, SYSTEM.NTDOPA,SYSTEM.C, SYSTEM.SIGMA);
    assert(flag == 0);
    %%using knn arthimetic
    % idx = knnsearch( fingerPrintCol, sample.');
    % idx = [ mod(idx, size(fingerPrint,1)) fix(idx/size(fingerPrint,1)) ];
    
    distance = Inf;
    for i = 1: length(discreteX)
        for j = 1:length(discreteY)
            if fingerPrintFlag(i, j) == -1
                continue;
            end
            tmp = sqrt( sum( (fingerPrintCol(i + (j -1) * size(fingerPrint,1), :) - sample.').^2) );
            if  tmp < distance
                distance = tmp;
                idx = [i j];
            end
        end
    end
    XEst = [ discreteX( idx(1) ) discreteY( idx(2) ) ];
    error(drop) =  sum( (X - XEst).^2 );
    disp(error(drop));
end