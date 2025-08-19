%p.101
zeta = 0.6;
omega_n = 10;

% G(s) = omega_n^2 / (s^2 + 2*zeta*omega_n*s + omega_n^2)
numerator = omega_n^2;
denominator = [1, 2*zeta*omega_n, omega_n^2];
sys = tf(numerator, denominator);

bode(sys);
grid on;
title('Bode Plot for a Second-Order System');