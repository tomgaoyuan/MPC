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
% S = [  2 2;
%        -2 2;
%        -2 -2;
%        2 -2];

%FIRST PHASE
load('data');
parameters;
error = zeros(1, 1000);
C = SYSTEM.SIGMA^2 * ( eye(SYSTEM.NTDOPA) + ones(SYSTEM.NTDOPA) );
Cinv = inv(C);
S = SYSTEM.S;
X = [150 50]; 
for drop = 1:5000
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
            tmp = MNorm( fingerPrintCol(i + (j -1) * size(fingerPrint,1), :), sample.', Cinv);
            if  tmp < distance
                distance = tmp;
                idx = [i j];
            end
        end
    end
    XEst = [ discreteX( idx(1) ) discreteY( idx(2) ) ];
    error(drop) =  sum( (X - XEst).^2 );    %here error is SE(square error)
%     disp(error(drop));
    disp(drop);
end
mean(error)