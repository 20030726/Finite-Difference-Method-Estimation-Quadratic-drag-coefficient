clc
clear
close all

% Define constants
g = 9.81;  % Gravitational acceleration (m/s^2)
rho = 1.225; % Air density (kg/m^3)
CD_data = 0.24; % Drag coefficient
S = 0.699223^2*pi; % Cross-sectional area (m^2)
m0 = 42; % Mass (kg)

% Air resistance coefficient (adjust as needed)
k = rho * CD_data * S / (2 * m0 * g);

% Initial conditions
V0 = 40;  % Initial velocity (m/s)
theta0 = deg2rad(45);  % Initial angle (radians)
x0 = 0;  % Initial x position (m)
y0 = 0;  % Initial y position (m)

% Initial state
y_initial = [V0; theta0; x0; y0];

% Integration time span
t_span = [0 10];  % Integrate from 0 to 10 seconds
t_eval = linspace(t_span(1), t_span(2), 1000);  % Define evaluation points

% Anonymous function to pass parameters
odefun = @(t, y) equations(t, y, g, k);

% Solve differential equations
[t, y] = ode45(odefun, t_eval, y_initial);

% Extract results
V = y(:, 1);
theta = y(:, 2);
X = y(:, 3);
Z = y(:, 4);

% Filter to include only y >= 0
index = Z >= 0;
t_N = t(index);
V_N = V(index);
theta_N = theta(index);
X_N = X(index);
Z_N = Z(index);

% Use dragkv22D function to generate analytical solution
[Vec_a, T_a, a_a, basicparameters_a] = dragkv22D(t_eval);

Vx_a = Vec_a(:, 1);
Vy_a = Vec_a(:, 2);
Vz_a = Vec_a(:, 3);
V_a = vecnorm([Vx_a, Vy_a, Vz_a], 2, 2);
X_a = Vec_a(:, 4);
Y_a = Vec_a(:, 5);
Z_a = Vec_a(:, 6);

% Plot results
figure;

subplot(2, 2, 1);
plot(t_N, V_N, 'b', 'LineWidth', 2);
hold on;
plot(T_a, V_a, 'r--', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity vs Time');
legend('Numerical V', 'Analytical V');

subplot(2, 2, 2);
plot(t_N, rad2deg(theta_N), 'b', 'LineWidth', 2);
hold on;
plot(T_a, rad2deg(atan2(Vz_a, Vx_a)), 'r--', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Angle (degrees)');
title('Angle vs Time');
legend('Numerical \theta', 'Analytical \theta');

subplot(2, 2, 3);
plot(X_N, Z_N, 'b', 'LineWidth', 2);
hold on;
plot(X_a, Z_a, 'r--', 'LineWidth', 2);
xlabel('Distance x (m)');
ylabel('Height y (m)');
title('Trajectory');
legend('Numerical', 'Analytical');

sgtitle('Projectile Motion with Quadratic Drag');

