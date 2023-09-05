%% initialization
clear;
clc;
close all;

% running time and iterations
dt        = 0.01;
horizon   = 2;
total     = horizon./dt;
timesteps = round(total/5);

E.dt        = dt;
E.total     = total;
E.horizon   = horizon;
E.timesteps = timesteps;

% path integral optimization
iterations  = 50;   % iterations of optimzation
num_samples = 500;   % k number of samples

mu        = 0;      % initial mean
lambda    = 0.9;    % parameters
Sigma_inv = 0.05;   % initial variance

E.iterations  = iterations;
E.num_samples = num_samples;
E.mu          = mu;
E.lambda      = lambda;
E.Sigma_inv   = Sigma_inv;

% model parameters 
states        = 4;

% model parameters
g  = 9.81;     % gravity, m/s^2
mc = 0.5;      % mass of the cart, kg
mp = 0.2;      % mass of the pole, kg
l  = 0.25;     % length of the pole, m
h  = 0.000001; % finite differences discretization

E.states = states;
E.g  = g;
E.mc = mc;
E.mp = mp;
E.l  = l;
E.h  = h;

% initial states
x0      = zeros(states,1);
x0(1,1) = 0; % theta
x0(2,1) = 0;  % thetadot
x0(3,1) = 0;  % x
x0(4,1) = 0;  % xdot

% final states (desired) 
xf(1,1) = pi;   % theta
xf(2,1) = 0;   % thetadot
xf(3,1) = 0;   % x
xf(4,1) = 0;   % xdot

% state and control trajectories
% control and state trajectories (nominal)
x_trajectory  = zeros(1,total+timesteps,states);    % state trajectory over each time step
u_trajectory  = zeros(1,total+timesteps-1,1);       % control trajectory over each time step
x_sampled     = zeros(num_samples,total,states);

% state and control cost matrices
Qf = zeros(states,states);  % initialize control matrix
Qf(1,1) = 100;              % weight for theta
Qf(2,2) = 100;              % weight for thetaDot
Qf(3,3) = 100;              % weight for x
Qf(4,4) = 100;              % weight for xDot

R       = 0.01;             % control cost matrix

E.Qf    = Qf; 
E.R     = R;

current_time = 0;
index        = 1;

while current_time < horizon
    % set control trajectory for prediction time horizon
    u_opt = u_trajectory(1,index:index+timesteps-2);
    
    for i = 1:iterations
        %% sample state trajectories 
        [x_sampled, noise] = calcTrajectory(E,x0,u_opt,1);
        
        %% path integral optimization of control trajectories
        [u_opt,cost] = fn_pathIntegral(E,x_sampled,xf,u_opt,noise);
    end
    
    %% forward propogate dynamics 1 timestep
    [X,noise] = calcTrajectory(E,x0,u_opt(1,1),0);
    
    % save optimized control trajectory
    u_trajectory(1,index:index+timesteps-2) = u_opt;
    
    % save current state
     x_trajectory(1,index+1,1) = X(:,:,1);
     x_trajectory(1,index+1,2) = X(:,:,2);
     x_trajectory(1,index+1,3) = X(:,:,3);
     x_trajectory(1,index+1,4) = X(:,:,4);
     
    %% update current state for next MPC iteration
    x0(1,1) = X(:,:,1);
    x0(2,1) = X(:,:,2);
    x0(3,1) = X(:,:,3);
    x0(4,1) = X(:,:,4);

    current_time = current_time + dt;
    index = index + 1
end
total     = horizon./dt;

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


