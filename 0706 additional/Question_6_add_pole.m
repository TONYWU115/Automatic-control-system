clc; clear;

zeta = 0.69;
wn = 1;

%G(s) = wn^2 / (s^2 + 2*zeta*wn*s + wn^2)
num1 = [wn^2];
den1 = [1 2*zeta*wn wn^2];
sys1 = tf(num1, den1);

% 乘上 1/(s - 1)，在右半平面加一個極點
num2 = num1;
den2 = conv(den1, [1 -1]);  % (s^2 + 2*zeta*wn*s + wn^2)(s - 1)
sys2 = tf(num2, den2);

t = 0:0.01:10;
figure;
step(sys1, t);
hold on;
step(sys2, t);
grid on;

legend('原二階系統', '原系統乘1/(s - 1)');
title('單位階躍響應：原系統 vs 原系統乘1/(s - 1)');
xlabel('Time (s)');
ylabel('Amplitude');