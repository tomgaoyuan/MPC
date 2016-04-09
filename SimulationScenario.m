close all;
clear all;
S = [ 
        200 200;
        200 -200;
        -200 200;
        -200 -200
     ];
figure;
plot(S(:,1)+1i*S(:,2), 'ro' );
hold on;
plot(250 + 150i, 'gs');
line([0 0] ,[0 400], 'LineWidth', 2, 'color', 'blue');
legend('image','sensor','reflector');
line([0 400] ,[0 0], 'LineWidth', 2, 'color', 'blue');
axis([-400 400 -400 400]);
axis square;
grid on;
for i =1:4
    text(S(i,1)-40,S(i,2)+40,['S_' num2str(i-1)]);
end
line([0 400] ,[0 400],'LineStyle', '-', 'LineWidth', 0.2, 'color', 'black');
for i = 10 : 20: 390
    line([i 400] ,[i i],'LineStyle', '-', 'LineWidth', 0.2, 'color', 'black');
    line([i i] ,[0 i],'LineStyle', '-', 'LineWidth', 0.2, 'color', 'black');
end
set(gca,'xtick',[-400: 200 : 400]);
set(gca,'ytick',[-400: 200 : 400]);
xlabel('X axis');
ylabel('Y axis');
