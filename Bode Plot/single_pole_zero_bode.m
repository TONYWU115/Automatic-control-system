clear; clc; close all;

% G(s)=\frac{10(s+1)}{s(s+10)(s^2+2s+5)}
num = 10 * [1, 1];
den = conv([1, 0], [1, 10]);
den = conv(den, [1, 2, 5]);
G = tf(num, den);

% 常數增益 K = 10
Gk = tf(10, 1);

% 積分器 1/s
Gi = tf(1, [1, 0]);

% 一階零點 (s+1)
Gz1 = tf([1, 1], 1);

% 一階極點 1/(s+10)
Gp1 = tf(1, [1, 10]);

% 二階極點 1/(s^2+2s+5)
Gp2 = tf(1, [1, 2, 5]);

figure;
%subplot(2,1,1);
bode(Gk, 'r'); hold on;
bode(Gi, 'b');
bode(Gz1, 'g');
bode(Gp1, 'm');
bode(Gp2, 'c');
grid on;
title('分項增益波德圖');
legend('K=10', '1/s', '(s+1)', '1/(s+10)', '1/(s^2+2s+5)');

%subplot(2,1,2);
%bode(Gk, 'r--'); hold on;
%bode(Gi, 'b--');
%bode(Gz1, 'g--');
%bode(Gp1, 'm--');
%bode(Gp2, 'c--');
%grid on;
%title('分項相位波德圖');

figure;
bode(G);
grid on;
title('完整的轉移函數波德圖');