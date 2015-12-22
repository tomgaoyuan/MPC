clc;
clear all;

parameters;
%FIRST PHASE
FLAG_LOAD = 0;
if FLAG_LOAD
    %establish the dataBase of average
    S = SYSTEM.S;
    discreteX = SYSTEM.X(1) : SYSTEM.L : SYSTEM.X(2);
    discreteY = SYSTEM.Y(1) : SYSTEM.L : SYSTEM.Y(2);
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
    save('data','discreteX', 'discreteY', 'fingerPrintFlag', 'fingerPrint','fingerPrintCol');
else
    load('data');
    S = SYSTEM.S;
end

NDROP = 1000;
error = zeros(1, NDROP);
%prepare
C = SYSTEM.SIGMA^2 * ( eye(SYSTEM.NTDOPA) + ones(SYSTEM.NTDOPA) );
Cinv = inv(C);

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
            %tmp = sqrt( sum( (fingerPrintCol(i + (j -1) * size(fingerPrint,1), :) - sample.').^2) );
            tmp = MNorm( fingerPrintCol(i + (j -1) * size(fingerPrint,1), :), sample.', Cinv);
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