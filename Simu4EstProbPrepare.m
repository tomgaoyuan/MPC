clc;
clear all;

parameters;
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
disp('Preparation Done!')