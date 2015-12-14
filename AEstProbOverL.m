clear all;
parameters;
load('data');
X = [ 150 50];
L = 0:0.01:4;
for i = 1:length(L)
    re(i) = correctEstProb(X, S, SYSTEM.NTDOPA, L(i), SYSTEM.SIGMA);
end
