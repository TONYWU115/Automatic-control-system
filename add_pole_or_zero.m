%0706補充講義討論三
wn = 1;
zeta = 0.69;

t = 0:0.01:15;

sys1 = tf(wn^2, [1 2*zeta*wn wn^2]);
sys2 = series(sys1, tf(1, [1 1]));
sys3 = series(sys1, tf([1 1], 1));

figure; hold on; grid on;

[y1,t1] = step(sys1, t);
plot(t1,y1,'b','LineWidth',2);

[y2,t2] = step(sys2, t);
plot(t2,y2,'r','LineWidth',2);

[y3,t3] = step(sys3, t);
plot(t3,y3,'g','LineWidth',2);

legend('原二階系統 \zeta=0.69', '乘上 1/(s+1)', '乘上 (s+1)');
xlabel('時間 (秒)');
ylabel('輸出 y(t)');
title('含極點及零點的二階系統響應比較');
