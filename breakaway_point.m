% 使用零極點 (Poles and Zeros) 定義系統並分析分離點
syms s;

z = [-1];
p = [-25,2,2]; % s^4 + 8s^3 + 24s^2 + 32s 的根為 0, -4, -2±2i

% 計算 (s-z1)(s-z2)...
num_sym = prod(s - z);
% 計算 (s-p1)(s-p2)...
den_sym = prod(s - p);

G_sym = num_sym / den_sym;


dG = diff(G_sym, s);
dG_simplified = simplify(dG);

fprintf('轉移函數 G(s) = \n');
disp(expand(G_sym));
fprintf('微分結果 dG(s)/ds = \n');
disp(dG_simplified);

[n, d] = numden(dG_simplified);
break_roots = double(solve(n == 0, s));

num_poly = double(poly(z));
den_poly = double(poly(p));
sys = tf(num_poly, den_poly);

figure('Color', 'w');
rlocus(sys); 
hold on;

fprintf('\n所有 dG/ds = 0 的根與對應的增益 k：\n');
for i = 1:length(break_roots)
    r = break_roots(i);
    % 計算該點對應的增益 k = -1/G(s)
    k_val = -1/double(subs(G_sym, s, r));
    
    fprintf('s = %10.4f + %10.4fi,  k = %10.4f\n', real(r), imag(r), k_val);

    if abs(imag(r)) < 1e-6 && real(k_val) > 0
        plot(real(r), imag(r), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
        text(real(r), imag(r)+0.5, sprintf('  Breakaway: s = %.2f', real(r)), 'Color', 'r');
    end
end

title('Root Locus with Pole-Zero Input Analysis');
grid on;
hold off;