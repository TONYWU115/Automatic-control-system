%0706補充講義討論二
wn = 1;

zeta_values = [1, 0.69, 0.4];
t = 0:0.01:10;

figure; hold on; grid on;
colors = ['r', 'g', 'b'];

for i = 1:length(zeta_values)
    zeta = zeta_values(i);
    sys = tf(wn^2, [1 2*zeta*wn wn^2]);
    [y, t_out] = step(sys, t);

    plot(t_out, y, colors(i), 'LineWidth', 2);
end

title('二階系統響應');
xlabel('時間 (秒)');
ylabel('輸出 y(t)');
legend('\zeta = 1', '\zeta = 0.69', '\zeta = 0.4');
