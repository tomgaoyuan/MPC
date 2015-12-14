clear all;
parameters;
load('data');
X = [ 150 50];
sigma = 0:0.01:4;
for i = 1:length(sigma)
    re(i) = correctEstProb(X, S, SYSTEM.NTDOPA, SYSTEM.L, sigma(i));
end
