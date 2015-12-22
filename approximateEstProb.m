clear all;
parameters;
load('data');
X = [ 150 50]; %S1
% X = [ 250 50];
% X = [ 250 150];
% X = [ 350 50];
% X = [ 350 150];
S = SYSTEM.S;
a(1) = correctEstProb(X, S, SYSTEM.NTDOPA, SYSTEM.L, SYSTEM.SIGMA);
a(2) = correctEstProbIndepen( X, S, SYSTEM.NTDOPA, SYSTEM.L, SYSTEM.SIGMA);
a(3) = correctEstProb_A2(X, S, SYSTEM.NTDOPA, SYSTEM.L, SYSTEM.SIGMA);
a