% 分子：K(s+8) -> [K 8K]
num = [1 8]; 

% 分母：s(s+5)(s+6) = s(s^2 + 11s + 30) = s^3 + 11s^2 + 30s
den = [1 11 30 0]; 

sys = tf(num, den);

figure;
rlocus(sys);
title('根軌跡圖');
xlabel('實軸');
ylabel('虛軸');
grid on;
axis equal;