clc; clear;

% 設定參數
K = 1;              % 增益
tau1 = 1;
tau2 = 0.5;
tau3 = 0.1;

% 定義系統
s = tf('s');
L = K / ((tau1*s + 1)*(tau2*s + 1)*(tau3*s + 1));

% (1) Polar Plot
figure;
nyquist(L);
title('Polar Plot (Nyquist)');
grid on;

% (2) Bode Plot with GM and PM
figure;
margin(L);
title('Bode Diagram');
grid on;

% (3) Nichols Diagram
figure;
nichols(L);
title('Nichols Chart');
grid on;

% (4) Root Locus
figure;
rlocus(L);
title('Root Locus');
grid on;

% (5) Print GM/PM
[GM, PM, Wcg, Wcp] = margin(L);
fprintf('Gain Margin: %.2f dB at %.2f rad/s\n', 20*log10(GM), Wcg);
fprintf('Phase Margin: %.2f° at %.2f rad/s\n', PM, Wcp);