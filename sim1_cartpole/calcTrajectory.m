function [x_sampled, noise] = calcTrajectory(E,x1,u,mode)

x           = x1;
dt          = E.dt;

num_samples = E.num_samples;
states      = E.states;
Sigma_inv   = E.Sigma_inv;

if mode == 1 % update entire trajectory of x
    timesteps = E.timesteps;
    
    % sample trajectories
    x_sampled = zeros(num_samples,timesteps,states);
    
    % initialize noise vector
    noise     = zeros(num_samples,timesteps-1);

    for k = 1:num_samples
        % evaluate control noise
        noise(k,:) = randn(1,timesteps-1)*Sigma_inv;
        
        for i = 1:(timesteps-1)
           
            % add noise to the control 
            u_now = u(:,i) + noise(k,i);
            
            % update dynamics
            F(1,1) = x(2,i);                           % d/dt theta = thetaDot
            F(2,1) = thetaDyn(E,x(1,i),x(2,i),u_now);  % d/dt thetaDot = thetaDotDot
            F(3,1) = x(4,i);                           % d/dt x = xDot
            F(4,1) = xDyn(E,x(1,i),x(2,i),u_now);      % d/dt thetaDot = thetaDotDot

            x(:,i+1) = x(:,i) + F*dt;
        end
        
        x_sampled(k,:,1) = x(1,:);
        x_sampled(k,:,2) = x(2,:);
        x_sampled(k,:,3) = x(3,:);
        x_sampled(k,:,4) = x(4,:);
    end

else    % forward propagate dynamics only one timestep
        
        noise  = 0;
        F(1,1) = x(2,1);                            % d/dt theta = thetaDot
        F(2,1) = thetaDyn(E,x(1,1),x(2,1),u(:,1));  % d/dt thetaDot = thetaDotDot
        F(3,1) = x(4,1);                            % d/dt x = xDot
        F(4,1) = xDyn(E,x(1,1),x(2,1),u(:,1));      % d/dt thetaDot = thetaDotDot
        
        x = x + F*dt;
        
        x_sampled(1,:,1) = x(1,:);
        x_sampled(1,:,2) = x(2,:);
        x_sampled(1,:,3) = x(3,:);
        x_sampled(1,:,4) = x(4,:);
end
end