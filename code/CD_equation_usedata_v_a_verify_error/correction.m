function [left_N, right_N, left_a, right_a] = correction(a_N, V_N, CD_N, T_N, a_a, V_a, CD_a, T_a)
global m0 rho g S
vec_g = [0, 0, -g];

% Numerical Solution
V_norm_N = vecnorm(V_N, 2, 2);
left_N = m0*(a_N-vec_g);
right_N = -0.5*rho*V_norm_N.*V_N*S.*CD_N;

left_norm_N = vecnorm(left_N, 2, 2); % Norm of left vectors
left_x_N = left_N(:, 1); % X component of left vectors
left_y_N = left_N(:, 2); % Y component of left vectors
left_z_N = left_N(:, 3); % Z component of left vectors

right_norm_N = vecnorm(right_N, 2, 2); % Norm of right vectors
right_x_N = right_N(:, 1); % X component of right vectors
right_y_N = right_N(:, 2); % Y component of right vectors
right_z_N = right_N(:, 3); % Z component of right vectors

% Analytical Solution
V_norm_a = vecnorm(V_a, 2, 2);
left_a = m0*(a_a-vec_g);
right_a = -0.5*rho*V_norm_a.*V_a*S.*CD_a;

left_norm_a = vecnorm(left_a, 2, 2); % Norm of left vectors
left_x_a = left_a(:, 1); % X component of left vectors
left_y_a = left_a(:, 2); % Y component of left vectors
left_z_a = left_a(:, 3); % Z component of left vectors

right_norm_a = vecnorm(right_a, 2, 2); % Norm of right vectors
right_x_a = right_a(:, 1); % X component of right vectors
right_y_a = right_a(:, 2); % Y component of right vectors
right_z_a = right_a(:, 3); % Z component of right vectors

% Calculate RMSE for numerical and analytical solutions
rmse_norm_N = sqrt(mean((left_norm_N - right_norm_N).^2));
rmse_x_N = sqrt(mean((left_x_N - right_x_N).^2));
rmse_z_N = sqrt(mean((left_z_N - right_z_N).^2));

rmse_norm_a = sqrt(mean((left_norm_a - right_norm_a).^2));
rmse_x_a = sqrt(mean((left_x_a - right_x_a).^2));
rmse_z_a = sqrt(mean((left_z_a - right_z_a).^2));

% Call the internal plotting function
plot_correction(T_N, left_norm_N, right_norm_N, left_x_N, left_z_N, right_x_N, right_z_N, ...
                rmse_norm_N, rmse_x_N, rmse_z_N, ...
                T_a, left_norm_a, right_norm_a, left_x_a, left_z_a, right_x_a, right_z_a, ...
                rmse_norm_a, rmse_x_a, rmse_z_a);

end
