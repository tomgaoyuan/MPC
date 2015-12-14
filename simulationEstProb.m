clear all;
parameters;
load('data');
X = [ 150 50];
S = SYSTEM.S;
NDROP = 1000;
error = zeros(1, NDROP);
for drop = 1:NDROP
%     f = false;
%     while ~f
%     X = rand(1,2) .* [SYSTEM.X(2) - SYSTEM.X(1), SYSTEM.Y(2) - SYSTEM.Y(1)] + [  SYSTEM.X(1) SYSTEM.Y(1) ];   
%     f = confine(X);
%     end
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