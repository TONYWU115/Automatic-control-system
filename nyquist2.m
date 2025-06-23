K = 1;

% K(s+10) = Ks + 10K
numerator_ks_plus_10 = [K, 10*K];

% s(s+1)(s+5) = s(s^2 + 6s + 5) = s^3 + 6s^2 + 5s + 0
denominator = [1 6 5 0];

sys_ks_plus_10_numerator = tf(numerator_ks_plus_10, denominator);

figure;
nyquist(sys_ks_plus_10_numerator);
grid on;
title('奈氏圖');
xlabel('實數軸');
ylabel('虛數軸');

disp('系統傳遞函數');
disp(sys_ks_plus_10_numerator);