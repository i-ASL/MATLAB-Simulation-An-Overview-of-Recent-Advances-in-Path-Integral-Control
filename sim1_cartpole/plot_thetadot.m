rs = 400;
cs = 700;
fs = 14; % legend font size
positionfs = 10;
xls = 13; % x label font size
yls = 12; % y      ""
lw = 1.8; % line width
lw_rotor = 1.2; % due to many rotor
ms = 11;  % marker size
titleFontSize = 19;

x_trajectory2=rad2deg(x_trajectory(:,1:total,2));
xf2=rad2deg(xf(2,1)*ones(1,total));

disp("pitch alp");
figure('Position', [0, 1.2*rs, cs, rs]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);
% 

plot(x_trajectory2, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(1:total,xf2, '--','LineWidth', lw, "Color", LineColors(2,:));

legend({'$\dot{\theta}$','$goal$'}, "Interpreter", 'latex', 'FontSize', fs)

title("Pendulum anglular velocity", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 200 -114 687]);
ylabel('Anglular velocity (deg/s)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/pole angle_vel.png")
print -depsc 'imgs/pole angle_vel.eps'
