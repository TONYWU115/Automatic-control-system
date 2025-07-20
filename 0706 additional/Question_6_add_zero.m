clc; clear;

zeta = 0.69;
wn = 1;

num1 = [wn^2];
den1 = [1 2*zeta*wn wn^2];
sys1 = tf(num1, den1);

% 乘上 (-s + 1)
num2 = conv([-1 1], num1);  % (-s + 1)*wn^2
sys2 = tf(num2, den1);

t = 0:0.01:10;
figure;
step(sys1, t);
hold on;
step(sys2, t);
grid on;

legend('原二階系統', '原系統乘(-s + 1)');
title('單位階躍響應：原系統 vs 原系統乘(-s + 1)');
xlabel('Time (s)');
ylabel('Amplitude');
