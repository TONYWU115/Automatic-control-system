omega_n = 1; 

zeta1 = 0.3; 
zeta2 = 1.0; 
zeta3 = 2.0; 

num1 = omega_n^2;
den1 = [1, 2*zeta1*omega_n, omega_n^2];
sys1 = tf(num1, den1);

num2 = omega_n^2;
den2 = [1, 2*zeta2*omega_n, omega_n^2];
den2(end) = den2(end);
sys2 = tf(num2, den2);

num3 = omega_n^2;
den3 = [1, 2*zeta3*omega_n, omega_n^2];
sys3 = tf(num3, den3);

figure;
hold on;

step(sys1, 'r');
step(sys2, 'g');
step(sys3, 'b');

title_text = sprintf('(二階系統)不同阻尼比下的單位步階響應 (ω_n = %.2f rad/s)', omega_n);
title(title_text);
xlabel('時間 (秒)');
ylabel('響應 (輸出)');
grid on;
legend(sprintf('欠阻尼 (ζ=%.1f)', zeta1), ...
       sprintf('臨界阻尼 (ζ=%.1f)', zeta2), ...
       sprintf('過阻尼 (ζ=%.1f)', zeta3));
   
hold off;