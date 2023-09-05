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

x_trajectory1=rad2deg(x_trajectory(:,1:total,1));
xf1=rad2deg(xf(1,1)*ones(1,total));

disp("pitch alp");
figure('Position', [0, 1.2*rs, cs, rs]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);
% 

plot(x_trajectory1, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(1:total,xf1, '--','LineWidth', lw, "Color", LineColors(2,:));

legend({'$\theta$','$goal$'}, "Interpreter", 'latex', 'FontSize', fs)

title("Pendulum angle", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 200 -30 200]);
ylabel('Angle (deg)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/pole angle.png")
print -depsc 'imgs/pole angle.eps'
