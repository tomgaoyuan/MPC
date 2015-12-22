clear all;
parameters;
% load('data');
X = [ 150 50]; %S1
% X = [ 350 50]; %S6
S = SYSTEM.S;
[localAverage ~] = TDOPAMaker(X, S, SYSTEM.NTDOPA,SYSTEM.C);
XNeighbour = X + SYSTEM.L* [1 0];
[neighbourAverage ~] = TDOPAMaker(XNeighbour, S, SYSTEM.NTDOPA,SYSTEM.C);
C = SYSTEM.SIGMA^2 * ( eye(SYSTEM.NTDOPA) + ones(SYSTEM.NTDOPA) );
d = localAverage - neighbourAverage;
normcdf( d.' * d / sqrt( d.' * C * d ) /2 )
% normcdf( sqrt( d.' * d) / (2 * sqrt(2) * SYSTEM.SIGMA))  %HERE IGNORE the dependence. 
% normcdf( sqrt( d.' * d) / (2 * sqrt(2) * SYSTEM.SIGMA))  %HERE IGNORE the dependence. 
sigma = 0.1:0.01:5;
for i = 1:length(sigma)
   C = sigma(i)^2 * ( eye(SYSTEM.NTDOPA) + ones(SYSTEM.NTDOPA) );
   y(i) = normcdf( d.' * d / sqrt( d.' * C * d ) /2 );
end