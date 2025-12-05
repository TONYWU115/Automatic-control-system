% 相位超前補償器 Gc(s)
% 繪製 G(s)、Gc(s) 和補償後開路系統 Gc(s)G(s) 的波德圖

clc;
clear;
close all;


% G(s) = K / (s * (T*s + 1))
K_plant = 10;
T_plant = 0.5;
G_num = [K_plant];
G_den = [T_plant, 1, 0]; 
G_s = tf(G_num, G_den);

disp('開路系統 G(s):');
disp(G_s);


% Gc(s) = Kc * (1 + alpha*T_c*s) / (1 + T_c*s)
% 條件: alpha > 1

alpha = 4;      % 決定最大相位超前角
T_c = 0.1;      % 決定零極點的位置
K_c = 1;        % 補償器的額外增益

z = -1 / (alpha * T_c);
p = -1 / T_c;

% Gc(s) = K_c * alpha * (s - z) / (s - p)
Gc_num = K_c * [alpha * T_c, 1];
Gc_den = [T_c, 1];
Gc_lead = tf(Gc_num, Gc_den);

disp('相位超前補償器 Gc(s):');
disp(Gc_lead);


G_comp = Gc_lead * G_s;

figure('Name', '相位超前補償器 Bode 圖分析');

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


figure('Name', '相位超前補償器 Gc(s) 單獨波德圖');
bode(Gc_lead);
grid on;
title('相位超前補償器 G_c(s) 的 Bode 圖特性');

w_z = 1 / (alpha * T_c);
w_p = 1 / T_c;
text(w_z, 10, ['\leftarrow 零點轉折 \omega_z = ' num2str(w_z, '%.2f') ' rad/s']);
text(w_p, -10, ['\leftarrow 極點轉折 \omega_p = ' num2str(w_p, '%.2f') ' rad/s']);