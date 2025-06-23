poles = [-1, -4, 0.5i, -0.5i];
zeros = [-2, -3];

% K 預設為 -1
sys = zpk(zeros, poles, 1);

figure;
rlocus(-sys);

title('根軌跡 (Root Locus) for K < 0');
xlabel('實軸');
ylabel('虛軸');

grid on;

% xlim([-6 2]);
% ylim([-3 3]);