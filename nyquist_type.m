clear;
clc;

sys_type0 = tf(1, [1 1]);
sys_type1 = tf(1, [1 1 0]);
sys_type2 = tf(1, [1 1 0 0]);
sys_type3 = tf(1, [1 1 0 0 0]);

figure;
hold on;

nyquist(sys_type0);
nyquist(sys_type1);
nyquist(sys_type2);
nyquist(sys_type3);

hold off;

legend('Type 0', 'Type 1', 'Type 2', 'Type 3');
title('Nyquist Plots for Different System Types');
grid on;

axis([-2 2 -2 2]);