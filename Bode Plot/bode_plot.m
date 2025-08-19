T = 1;
num = [T 1]; % 分子係數 (T*s + 1)
den = [1];   % 分母係數 (1)
sys = tf(num, den);

bode(sys);
grid on;
title('Bode Plot of H(s) = 1 + sT');