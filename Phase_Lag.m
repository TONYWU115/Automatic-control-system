% 相位落後補償器 Gc(s)
% 繪製 G(s)、Gc(s) 和補償後開路系統 Gc(s)G(s) 的波德圖

clc;
clear;
close all;


K_plant = 10;
T_plant = 0.5;
G_num = [K_plant];
G_den = [T_plant, 1, 0]; 
G_s = tf(G_num, G_den);

disp('開路系統 G(s):');
disp(G_s);


% Gc(s) = Kc * (1 + T_c*s) / (1 + beta*T_c*s)
% 條件: beta > 1

beta = 10;      % 必須大於 1，決定低頻增益的提升量 (20*log10(beta) dB)
T_c = 10;       % 決定零點和極點的位置
K_c = 1;        % 補償器的額外增益

% |p| < |z|
z = -1 / T_c;
p = -1 / (beta * T_c);

% Gc(s) = (1/beta) * (1 + T_c*s) / (1 + beta*T_c*s) * (beta * K_c)
Gc_num = K_c * [T_c, 1];
Gc_den = [beta * T_c, 1];
Gc_lag = tf(Gc_num, Gc_den);

disp('相位落後補償器 Gc(s):');
disp(Gc_lag);


G_comp = Gc_lag * G_s;

figure('Name', '相位落後補償器 Bode 圖分析');

subplot(2, 1, 1);
h_mag = bodeplot(G_s, 'b', G_comp, 'r--');
setoptions(h_mag, 'FreqUnits', 'rad/s', 'MagUnits', 'dB');
grid on;
title('增益圖 (Magnitude Plot)');
legend('原始系統 G(s)', '補償後系統 G_c(s)G(s)', 'Location', 'SouthWest');

subplot(2, 1, 2);
h_phase = bodeplot(G_s, 'b', G_comp, 'r--');
setoptions(h_phase, 'FreqUnits', 'rad/s', 'PhaseUnits', 'deg');
grid on;
title('相位圖 (Phase Plot)');
legend('原始系統 G(s)', '補償後系統 G_c(s)G(s)', 'Location', 'SouthWest');


figure('Name', '相位落後補償器 Gc(s) 單獨波德圖');
bode(Gc_lag);
grid on;
title('相位落後補償器 G_c(s) 的 Bode 圖特性');

w_z = 1 / T_c;
w_p = 1 / (beta * T_c);
text(w_z, 10, ['\leftarrow 零點轉折 \omega_z = ' num2str(w_z, '%.3f') ' rad/s']);
text(w_p, -10, ['\leftarrow 極點轉折 \omega_p = ' num2str(w_p, '%.3f') ' rad/s']);