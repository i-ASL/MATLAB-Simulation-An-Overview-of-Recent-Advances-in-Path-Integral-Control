function [u_new,cost] = fn_pathIntegral(E,x_sampled,x_f,u_opt,noise)
    
%% initialize
dt          = E.dt;
num_samples = E.num_samples;
t           = E.timesteps;
lambda      = E.lambda;
Sigma_inv   = E.Sigma_inv;
Qf          = E.Qf;

S_trajectory = zeros(num_samples,1);
weights      = zeros(num_samples,1); 
R = E.R;

%% calculate trajectory cost
for k = 1:num_samples
    % initialize final cost
    terminal_state        = x_sampled(k,end,:);
%     S_trajectory(k,1)     = Qf(1,1)*(terminal_state(1,1) - x_f(1,1))^2 + Qf(2,2)*(terminal_state(1,2) - x_f(2,1))^2 + ...
%                             Qf(3,3)*(terminal_state(1,3) - x_f(3,1))^2 + Qf(4,4)*(terminal_state(1,4) - x_f(4,1))^2;
    S_trajectory(k,1)     = Qf(1,1)*(terminal_state(1,1) - x_f(1,1))^2 + Qf(2,2)*(terminal_state(1,2) - x_f(2,1))^2 + ...
                            Qf(3,3)*(terminal_state(1,3) - x_f(3,1))^2 + Qf(4,4)*(terminal_state(1,4) - x_f(4,1))^2;
    
%     S_trajectory(k,1)     = Qf(1,1)*(terminal_state(1,1) - x_f(1,1))^2 + Qf(2,2)*(terminal_state(1,2) - x_f(2,1))^2;

    % back propagate to get the total trajectory cost
    for i = (t-1):-1:1
        % states of one sample at one time
        x = x_sampled(k,i,:);
        % state cost
        
        q = (Qf(1,1)*(x(1,1) - x_f(1,1))^2 + Qf(2,2)*(terminal_state(1,2) - x_f(2,1))^2 + ... 
            Qf(3,3)*(terminal_state(1,3) - x_f(3,1))^2 + Qf(4,4)*(terminal_state(1,4) - x_f(4,1))^2 + 0.5*u_opt(:,i)'*R*u_opt(:,i))*dt;
        
%         q = (Qf(1,1)*(x(1,1) - x_f(1,1))^2 + Qf(2,2)*(terminal_state(1,2) - x_f(2,1))^2 + 0.5*u_opt(:,i)'*u_opt(:,i))*dt;

        S_trajectory(k,1) = S_trajectory(k,1) + q + lambda*u_opt(:,i)'*Sigma_inv*noise(k,i);
    end
end

%% calculate beta 
beta_min = min(S_trajectory);

%% calculate eta 
eta = sum(exp(-1/lambda*(S_trajectory-beta_min)));

%% calculate weights
for k = 1:num_samples
    weights(k,1) = 1/eta*exp(-1/lambda*(S_trajectory(k,1)-beta_min));
end

%% find du
du = weights'*noise;

%% update u optimal
u_new = u_opt + du;
cost  = S_trajectory;
end