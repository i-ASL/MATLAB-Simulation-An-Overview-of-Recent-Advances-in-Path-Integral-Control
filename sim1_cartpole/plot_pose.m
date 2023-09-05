rs = 400;
cs = 700;
fs = 12; % legend font size
positionfs = 12;
xls = 10; % x label font size
yls = 10; % y      ""
lw = 1.8; % line width
lw_rotor = 1.2; % due to many rotor
ms = 11;  % marker size
titleFontSize = 14;

x_trajectory1=rad2deg(x_trajectory(:,1:total,1));
xf1=rad2deg(xf(1,1)*ones(1,total));

x_trajectory2=rad2deg(x_trajectory(:,1:total,2));
xf2=rad2deg(xf(2,1)*ones(1,total));


x_trajectory4=x_trajectory(:,1:total,4);
xf4=xf(4,1)*ones(1,total);

disp("pitch alp");
figure('Position', [0, 1.*rs, cs*1.2, rs*1.2]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);
% 

subplot(2,2,1)
plot(x_trajectory1, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(1:total,xf1, '--','LineWidth', lw, "Color", LineColors(2,:));

legend({'$\theta$','$goal$'},'Position',[0.382 0.8 0.05 0.05] ,"Interpreter", 'latex', 'FontSize', fs)

title("Pendulum Angle", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 200 -30 200]);
ylabel('Angle (deg)', "FontSize", yls, "Interpreter", 'latex')


subplot(2,2,2)
plot(x_trajectory2, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(1:total,xf2, '--','LineWidth', lw, "Color", LineColors(2,:));

legend({'$\dot{\theta}$','$goal$'},'Position',[0.822 0.8 0.05 0.05], "Interpreter", 'latex', 'FontSize', fs)

title("Pendulum Anglular Velocity", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 200 -114 687]);
ylabel('Anglular Velocity (deg/s)', "FontSize", yls, "Interpreter", 'latex')

subplot(2,2,3)
plot(x_trajectory(:,1:total,3), 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(xf(3,1)*ones(1,total), '--','LineWidth', lw, "Color", LineColors(2,:));

legend({'$\mathbf{x}$','$goal$'},'Position',[0.382 0.28 0.05 0.05], "Interpreter", 'latex', 'FontSize', fs)


title("Cart Position", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([0 200 -0.7 0.1]);
ylabel('Position (m)', "FontSize", yls, "Interpreter", 'latex')

subplot(2,2,4)
plot(x_trajectory4, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(1:total,xf4, '--','LineWidth', lw, "Color", LineColors(2,:));


legend({'$\dot{\mathbf{x}}$','$goal$'},'Position',[0.822 0.28 0.05 0.05], "Interpreter", 'latex', 'FontSize', fs)

title("Cart Velocity", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 200 -3 1]);
ylabel('Velocity (m/s)', "FontSize", yls, "Interpreter", 'latex')

saveas(gcf, "imgs/Pose.png")
print -depsc 'imgs/Pose.eps'
