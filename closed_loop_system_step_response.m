Zeros = [-1];
Poles = [0,3];
K = 10;             % 增益
H = 1;              % 回授增益

G = zpk(Zeros, Poles, K);
disp('開迴路傳遞函數 G(s):');
disp(G);

if isscalar(H)
    T = feedback(G, H);
else
    T = feedback(G, H);
end
disp('閉迴路傳遞函數 T(s):');
disp(T);

figure;
step(T);
grid on;
title(['閉迴路系統的步階響應圖 (K=', num2str(K), ', H=', num2str(H), ')']);