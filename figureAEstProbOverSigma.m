close all;
% clear all;
load;
h = plot(sigma,re4(2,:),sigmaSim,reSim4,'o-');
set(h(1),'lineWidth',2);
set(h(2),'lineWidth',2);
legend('Ana (Ass. 1 & 2 &3)','Sim');
hold on;
h = plot(sigma,re2(2,:),sigmaSim,reSim2,'o-');
set(h(1),'lineWidth',2);
set(h(2),'lineWidth',2);
hold on;
h = plot(sigma,re1(2,:),sigmaSim,reSim1,'o-');
set(h(1),'lineWidth',2);
set(h(2),'lineWidth',2);
axis([0 0.5 0 1]);
grid on;
xlabel('\sigma');
ylabel('P_m')