function dxdt = odefun1(t, x)
    dxdt = zeros(2,1);
    dxdt(1) = x(2);
    dxdt(2) = 4*x(2) - 2*x(1);
end

clc; clear; close all;

x0 = [4; -3];
tspan = [0, 2];

[t45, x45] = ode45(@odefun1, tspan, x0);
[t23, x23] = ode23(@odefun1, tspan, x0);
[t113, x113] = ode113(@odefun1, tspan, x0);

figure;
plot(t45, x45(:,1), 'r-', 'LineWidth', 1.5); hold on;
plot(t23, x23(:,1), 'b--', 'LineWidth', 1.5);
plot(t113, x113(:,1), 'g:', 'LineWidth', 2);
grid on;
xlabel('t'); ylabel('y(t)');
title('Сравнение решателей: y'' \prime\prime - 4y'' + 2y = 0');
legend('ode45', 'ode23', 'ode113', 'Location', 'best');

% Проверка отличий решателей численно
fprintf('ode45,  y(2) = %.4f\n', x45(end,1));
fprintf('ode23,  y(2) = %.4f\n', x23(end,1));
fprintf('ode113, y(2) = %.4f\n', x113(end,1));


function dxdt = odefun2(t, x)
    A = [2 -1 -1;
         1  0 -1;
         3 -1 -2];
    dxdt = A*x;
end

clc; clear; close all;

x0 = [0; 1; 10];
tspan = [0, 3];

[t45, x45] = ode45(@odefun2, tspan, x0);
[t23, x23] = ode23(@odefun2, tspan, x0);
[t113, x113] = ode113(@odefun2, tspan, x0);

figure;
subplot(3,1,1);
plot(t45, x45(:,1), 'r-', t23, x23(:,1), 'b--', t113, x113(:,1), 'g:', 'LineWidth', 1.5);
grid on; xlabel('t'); ylabel('x_1(t)'); legend('ode45','ode23','ode113');
title('Компонента x_1(t)');

subplot(3,1,2);
plot(t45, x45(:,2), 'r-', t23, x23(:,2), 'b--', t113, x113(:,2), 'g:', 'LineWidth', 1.5);
grid on; xlabel('t'); ylabel('x_2(t)');
title('Компонента x_2(t)');

subplot(3,1,3);
plot(t45, x45(:,3), 'r-', t23, x23(:,3), 'b--', t113, x113(:,3), 'g:', 'LineWidth', 1.5);
grid on; xlabel('t'); ylabel('x_3(t)');
title('Компонента x_3(t)');

sgtitle('Решение системы x''=Ax тремя решателями');


fprintf('Разница ode45 vs ode23 при t=3: %.6f\n', ...
    norm(deval(ode45(@odefun2,[0 3],x0),3) - deval(ode23(@odefun2,[0 3],x0),3)));