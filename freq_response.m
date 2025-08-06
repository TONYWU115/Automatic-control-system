wn = 10;
zetas = [0, 0.2, 0.6, 1];
colors = {'k', 'b', 'r', 'm'};

w = logspace(0, 2, 500);

figure;
hold on;
for i = 1:length(zetas)
    zeta = zetas(i);
    num = wn^2;
    den = [1 2*zeta*wn wn^2];
    [mag, phase] = bode(tf(num, den), w);
    mag = squeeze(mag);
    phase = squeeze(phase);
    % 大小(dB)
    subplot(2,1,1);
    semilogx(w, 20*log10(mag), colors{i}, 'LineWidth', 1);
    hold on;
    % 相位(deg)
    subplot(2,1,2);
    semilogx(w, phase, colors{i}, 'LineWidth', 1);
    hold on;
end

subplot(2,1,1);
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('標準二階系統 幅值響應');
legend('zeta=0', 'zeta=0.2', 'zeta=0.6', 'zeta=1');
grid on;

subplot(2,1,2);
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)');
title('標準二階系統 相位響應');
legend('zeta=0', 'zeta=0.2', 'zeta=0.6', 'zeta=1');
grid on;
hold off;