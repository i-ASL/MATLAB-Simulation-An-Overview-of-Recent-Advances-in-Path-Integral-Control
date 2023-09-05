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

plot(x_trajectory(:,1:total,3), 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(xf(3,1)*ones(1,total), '--','LineWidth', lw, "Color", LineColors(2,:));

legend({'$\mathbf{x}$','$goal$'}, "Interpreter", 'latex', 'FontSize', fs)


title("Cart position", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([0 200 -0.7 0.1]);
ylabel('Position (m)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/cart_position.png")
print -depsc 'imgs/cart_position.eps'
