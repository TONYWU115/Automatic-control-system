% Q103
z1 = [1];
p1 = [-1];
k1 = 1;

sys1 = zpk(z1, p1, k1);

figure;
step(sys1);
grid on;