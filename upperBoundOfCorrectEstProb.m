clc;
clear all;

parameters;
L = SYSTEM.L;
v = SYSTEM.C;
N = 3:12;
sigma = [0.3 0.5 0.7 0.9];
for i = 1:length(sigma)
    for j = 1:length(N)
        re(i,j) = normcdf( L/2/v/sigma(i) * sqrt(2*N(j)))^4;
    end
end
plot(N,re','-o','LineWidth',2);
legend('\sigma=0.3','\sigma=0.5','\sigma=0.7','\sigma=0.9');
grid on;
xlabel('N');
ylabel('P_m');