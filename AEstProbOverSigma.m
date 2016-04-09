clear all;
parameters;
load('data');
S = SYSTEM.S;
% X = [ 150 50];
% X = [ 250 150];
% X = [ 250 50];
X = [ 350 50];
sigma = 0:0.005:0.5;
for i = 1:length(sigma)
    disp(i);
    re2(1,i) = correctEstProb(X, S, SYSTEM.NTDOPA, SYSTEM.L, sigma(i));
    re2(2,i) = correctEstProb_A2(X, S, SYSTEM.NTDOPA, SYSTEM.L, sigma(i));
end

sigmaSim = 0.1:0.05:0.5;
for i = 1:length(sigmaSim)
    disp(i);
    reSim2(i) = simCorrectEstProb(X,S,3,NaN,sigmaSim(i));
end