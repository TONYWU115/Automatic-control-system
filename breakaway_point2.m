syms s;

num_sym = s + 6;
den_sym = s^4 + 8*s^3 + 24*s^2 + 32*s;
G_sym = num_sym / den_sym;

dG = diff(G_sym, s);
dG_simplified = simplify(dG);

fprintf('轉移函數 G(s) = \n');
disp(G_sym);
fprintf('微分結果 dG(s)/ds = \n');
disp(dG_simplified);

[n, d] = numden(dG_simplified);
break_roots = double(solve(n == 0, s));

% --- 3. 繪圖與標註 ---
num = [1 6];
den = [1 8 24 32 0];
sys = tf(num, den);

figure('Color', 'w');
rlocus(sys); 
hold on;

% 篩選實數分離點 (針對 k > 0)
fprintf('所有 dG/ds = 0 的根：\n');
for i = 1:length(break_roots)
    r = break_roots(i);
    k_val = -1/double(subs(G_sym, s, r));
    
    % 顯示所有根及其對應的 k 值
    fprintf('s = %f + %fj,  k = %f\n', real(r), imag(r), k_val);
    
    % 若是實數且 k > 0，則在圖上標註（分離點）
    if isreal(r) && k_val > 0
        plot(real(r), imag(r), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
        text(real(r), imag(r)+0.5, sprintf('  Breakaway: s = %.2f', real(r)), 'Color', 'r');
    end
end

title('Root Locus with dG(s)/ds Analysis');
grid on;
hold off;