clc; clear; close all;

f = @(x) x.^2./sqrt(1-x.^2);

x_plot = linspace(0, 0.999, 500);   % не берём x=1 — там разрыв
figure;
plot(x_plot, f(x_plot), 'b-', 'LineWidth', 1.5);
grid on;
xlabel('x'); ylabel('f(x)');
title('Подынтегральная функция f(x) = x^2/\surd(1-x^2)');



eps_shift = 1e-6;
b = 1 - eps_shift;

% Метод трапеций с разными шагами
h_values = [0.01, 0.1, 0.5];
I_trap = zeros(size(h_values));
for k = 1:length(h_values)
    h = h_values(k);
    x = 0:h:b;
    y = f(x);
    I_trap(k) = trapz(x, y);
end

% Метод Симпсона (составная формула, n=100 подынтервалов)
n = 100;
x_s = linspace(0, b, n+1);
y_s = f(x_s);
h_s = (b-0)/n;
I_simpson = h_s/3 * (y_s(1) + y_s(end) + 4*sum(y_s(2:2:end-1)) + 2*sum(y_s(3:2:end-2)));

% Ньютон-Котес 8-го порядка (замкнутая 9-точечная формула)
xn = linspace(0, b, 9);
yn = f(xn);
hn = (b-0)/8;
w = [989, 5888, -928, 10496, -4540, 10496, -928, 5888, 989];
I_nc8 = hn/28350 * sum(w .* yn) * 8;   

% Адаптивный метод MATLAB (эталон, справляется с особенностью)
I_adaptive = integral(f, 0, 1);



f2 = @(x,y) 2*x.^2 + 7*x + y.^2;
I2 = integral2(f2, 1, 2, 0, 1)   % пределы: xmin,xmax,ymin,ymax



syms x
f3 = sqrt(x+2)/x;
I3_exact = int(f3, x, 2, 7)
I3_num = double(I3_exact)



syms x
f4 = x/(1-x^4);
F4 = int(f4, x)
F4_simplified = simplify(F4)



syms x
f5 = x/(1-x^3);
I5 = int(f5, x, 0, Inf)     % symbolic вернёт NaN или сообщение о невозможности вычислить



% Численная попытка через integral — MATLAB выдаст предупреждение
f5n = @(x) x./(1-x.^3);
I5_num = integral(f5n, 0, Inf)   % Warning: Reached the singularity...



eps_vals = [0.1, 0.01, 0.001];
for e = eps_vals
    I_left  = integral(f5n, 0, 1-e);
    I_right = integral(f5n, 1+e, 50);   % 50 - достаточно большая "бесконечность"
    fprintf('eps=%.3f: sum = %.4f\n', e, I_left + I_right);
end