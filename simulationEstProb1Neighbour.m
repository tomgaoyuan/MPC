clear all;
parameters;
% load('data');
X = [ 150 50]; %S1
% X = [ 350 50]; %S6
S = SYSTEM.S;
[localAverage ~] = TDOPAMaker(X, S, SYSTEM.NTDOPA,SYSTEM.C);
XNeighbour = X + SYSTEM.L* [1 0];
[neighbourAverage ~] = TDOPAMaker(XNeighbour, S, SYSTEM.NTDOPA,SYSTEM.C);
NDROP = 1000;
error = zeros(1, NDROP);

for drop = 1:NDROP
    
    [ sample flag ] = sampleTDOPAMaker(X, S, SYSTEM.NTDOPA,SYSTEM.C, SYSTEM.SIGMA);
    
    %%using knn arthimetic
    % idx = knnsearch( fingerPrintCol, sample.');
    % idx = [ mod(idx, size(fingerPrint,1)) fix(idx/size(fingerPrint,1)) ];
    
    d1 = EuclidNorm( localAverage, sample);
    d2 = EUclidNorm( neighbourAverage, sample);
    if d1 <= d2 
        XEst = X;
    else
        XEst = XNeighbour;
    end
    error(drop) = sqrt( sum( (X - XEst).^2 ) );
    disp( [ num2str(drop) 'of' num2str(NDROP)] );
    disp(error(drop));
end