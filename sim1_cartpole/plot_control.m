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

disp("pitch alp");
figure('Position', [0, 1.2*rs, cs, rs]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);
% 

plot(u_trajectory, 'LineWidth', lw, "Color", LineColors(2,:));
hold on
grid on
legend({'$F$',}, "Interpreter", 'latex', 'FontSize', fs)


title("Control input (Horizontal force on cart)", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([0 200 -15 15]);
ylabel('Force (N)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/control.png")
print -depsc 'imgs/control.eps'
