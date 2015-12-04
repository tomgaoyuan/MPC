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

SYSTEM.NTDOPA = 3;
SYSTEM.X = [ 0 1];
SYSTEM.Y = [ 0 1];
SYSTEM.C = 1;
SYSTEM.SIGMA = 0.0001;
%FIRST PHASE
discreteX = linspace( SYSTEM.X(1), SYSTEM.X(2), 100);
discreteY = linspace( SYSTEM.Y(1), SYSTEM.Y(2), 100);
FLAG_LOAD = 0;
if FLAG_LOAD
    %establish the dataBase of average
    fingerPrintFlag = -1 * ones( length(discreteX) , length(discreteY) );    %-1 for not conclude, 0 for correct, 1 for no enough data
    fingerPrint = zeros( length(discreteX) , length(discreteY), SYSTEM.NTDOPA);
    for i = 1: length(discreteX)
        for j = 1:length(discreteY)
            X = [ discreteX(i) discreteY(j) ];
            [ fingerPrint( i, j, :) fingerPrintFlag(i, j) ] = TDOPAMaker(X, S, SYSTEM.NTDOPA,SYSTEM.C);
            if ~confine(X)
                fingerPrintFlag(i, j) = -1;
            end
        end
    end
    fingerPrintCol = reshape( fingerPrint, size(fingerPrint,1) * size(fingerPrint,2), SYSTEM.NTDOPA );
    save('data','discreteX', 'discreteY', 'fingerPrintFlag', 'fingerPrint','fingerPrintCol','S');
else
    load('data');
end

NDROP = 1000;
error = zeros(1, NDROP);
for drop = 1:NDROP
    f = false;
    while ~f
    X = rand(1,2) .* [SYSTEM.X(2) - SYSTEM.X(1), SYSTEM.Y(2) - SYSTEM.Y(1)] + [  SYSTEM.X(1) SYSTEM.Y(1) ];   
    f = confine(X);
    end
    [ sample flag ] = sampleTDOPAMaker(X, S, SYSTEM.NTDOPA,SYSTEM.C, SYSTEM.SIGMA);
    
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
    error(drop) = sqrt( sum( (X - XEst).^2 ) );
    disp( [ num2str(drop) 'of' num2str(NDROP)] );
    disp(error(drop));
end