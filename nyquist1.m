zeros_sys = -2;
poles_sys = [-1,3];
gain_sys = 1;   % 系統增益 K = 1

sys_zpk = zpk(zeros_sys, poles_sys, gain_sys);

figure;
nyquist(sys_zpk);
grid on;
title('奈氏圖');
xlabel('實數軸');
ylabel('虛數軸');

disp('系統傳遞函數 (ZPK 形式):');
disp(sys_zpk);