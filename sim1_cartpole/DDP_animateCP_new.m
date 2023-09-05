rs = 400;
cs = 700;

lw = 1.8; % line width
lw_rotor = 1.2; % due to many rotor
ms = 11;  % marker size


titleFontSize = 14;
fs = 14; % legend font size
positionfs = 10;
xls = 13; % x label font size
yls = 12; % y      ""
figure, set(gcf, 'Color','white')


time   = E.horizon;
mp     = E.mp;
mc     = E.mc;
l      = 2*E.l;

T = 0:dt:horizon;

x_traj(1,:) = x_trajectory(1,1:length(T),1);
x_traj(2,:) = x_trajectory(1,1:length(T),2);
x_traj(3,:) = -1*x_trajectory(1,1:length(T),3);
x_traj(4,:) = x_trajectory(1,1:length(T),4);


name = 'Cart Pole System';

for k = 1:length(x_traj)
%     figure()
%     h = gca;
%     hold on
%     set([gcf gca],'Visible','off')
    clf
    axes
    axis equal
    hold on
    grid on
    fill(([-.5 .5 .5 -.5 -.5]-x_traj(3,k)), [0 0 .5 .5 0], [0 152/255 153/255])
    
    plot([-x_traj(3,k), -x_traj(3,k) + l*sin(x_traj(1,k))], [0.25, 0.25-l*cos(x_traj(1,k))], 'k', 'LineWidth', 3)
    
    rectangle('Position',[(-x_traj(3,k) + l*sin(x_traj(1,k))-0.25*sin(pi/4)),(0.25-l*cos(x_traj(1,k))-0.25*cos(pi/4)),0.35,0.35],'Curvature',[1,1],...
        'FaceColor',[150/255 0 0])
    
%     rectangle('Position',[(-x_traj(3,k) + l*sin(x_traj(1,k)) - 0.25*sin(pi/4)),(0.4+l*cos(x_traj(1,k))-0.25*cos(pi/4)),0.35,0.35],'Curvature',[1,1],...
%         'FaceColor',[150/255 0 0])
    
    xlim([-4 4])
    ylim([-1 2])
    title("Cart Pole System", 'FontSize', titleFontSize, 'interpreter','latex');
    legend(['Cart Mass = ' num2str(mc) ' kg'],['1st Link Mass = ' num2str(mp) ' kg'],'Location','southeast')
    MM(k) = getframe(gcf);
end
figure;



movie(MM,1,length(x_traj)/time);
lastFrame = MM(end).cdata;
% Create a figure using the last frame


lastFigure = figure;

disp("pitch alp");
figure('Position', [0, 1.2*rs, cs*0.7, rs*0.6]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);
% 
axis([148 158 118 128]);
set(gca, 'Position', [-0.415, -0.45, 1.8, 1.8]);
imshow(lastFrame);  % Display the last frame

% Save the last figure as an EPS file

saveas(gcf, "imgs/anim.png")
print -depsc 'imgs/anim.eps'
%Save to an avi file


