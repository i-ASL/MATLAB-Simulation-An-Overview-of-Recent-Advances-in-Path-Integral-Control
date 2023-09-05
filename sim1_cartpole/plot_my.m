
figure(1)
subplot(2,2,1)
plot(1:total,xf(1,1)*ones(1,total))
hold on
plot(x_trajectory(:,1:total,1))
legend('goal','simulation')
title('pole angle (rad)')

subplot(2,2,2)
plot(1:total,xf(2,1)*ones(1,total))
hold on
plot(x_trajectory(:,1:total,2))
legend('goal','simulation')
title('pole angular velocity (rad/s)')

subplot(2,2,3)
plot(1:total,xf(3,1)*ones(1,total))
hold on
plot(x_trajectory(:,1:total,3))
legend('goal','simulation')
title('cart position (m)')

subplot(2,2,4)
plot(1:total,xf(4,1)*ones(1,total))
hold on
plot(x_trajectory(:,1:total,4))
legend('goal','simulation')
title('cart velocity (m/s)')

figure(2)
plot(u_trajectory)
title('control (N)')


%%%%%%%%
disp("pitch alp");
figure('Position', [0, 1.2*rs, cs, rs]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);
% 

plot(1:total,xf(1,1)*ones(1,total), 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(x_trajectory(:,1:total,1), '--','LineWidth', lw, "Color", LineColors(2,:));

legend({'$\theta$','$\goal$'}, "Interpreter", 'latex', 'FontSize', fs)

xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 70 -inf 120]);
ylabel('Angle (deg)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/caros_pitch_alpha.png")