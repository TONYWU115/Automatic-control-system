% Q165
% 給G(s)的極零點，求單位回授的二階步階響應

clear;
clc;

G_zeros = [1];
G_poles = [-2,-1];
G_gain = 1;


G = zpk(G_zeros, G_poles, G_gain);
disp('開迴路傳遞函數 G(s):');
disp(G);

% T(s) = G(s) / (1 + G(s))
% feedback (H=1)
T = feedback(G, 1);
disp('閉迴路傳遞函數 T(s):');
disp(T);


figure;
step(T);
grid on;
title('單位回授系統的單位步階響應');
xlabel('時間 (秒)');
ylabel('響應');

info = stepinfo(T);
disp('步階響應特性:');
disp(info);