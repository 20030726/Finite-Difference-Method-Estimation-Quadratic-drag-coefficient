% Define constants
g = 9.81;  % Gravitational acceleration (m/s^2)
rho = 1.225; % Air density (kg/m^3)
CD_data = 0.24; % Drag coefficient
S = 0.699223^2 * pi; % Cross-sectional area (m^2)
m0 = 42; % Mass (kg)

% Calculate air resistance coefficient
k = rho * CD_data * S / (2 * m0 * g);

% Initial conditions
V0 = 40;  % Initial velocity (m/s)
theta0 = deg2rad(45);  % Initial angle (radians)
x0 = 0;  % Initial x position (m)
y0 = 0;  % Initial y position (m)
t0 = 0;  % Initial time (s)

% Define the angle range
theta_span = linspace(theta0, 0, 500);

% Calculate velocity V(theta)
V = @(theta) (V0 * cos(theta0) ./ ...
    (cos(theta) .* (1 + k * V0 * cos(theta0)^2 * ...
    (sin(theta) ./ cos(theta).^2 + log(tan(theta / 2 + pi / 4)) - ...
    sin(theta0) / cos(theta0)^2 - log(tan(theta0 / 2 + pi / 4))))));

% Calculate position x(theta) and y(theta)
x = @(theta) x0 + (V0^2 * sin(2 * theta0) - V(theta).^2 .* sin(2 * theta)) / (2 * g * (1 + k));
y = @(theta) y0 + (V0^2 * sin(theta0)^2 - V(theta).^2 .* sin(theta).^2) / (2 * g * (1 + k));

% Calculate acceleration components and vectors
aV = @(theta) -g * sin(theta) - g * k * V(theta).^2;
a_theta = @(theta) -g * cos(theta);
a = @(theta) [aV(theta); a_theta(theta)];
g_vector = @(theta) [-g * sin(theta); -g * cos(theta)];

% Calculate time t(theta)
t = @(theta) t0 + (2 * (V0 * sin(theta0) - V(theta) .* sin(theta))) / ...
    (g * (2 + k * (V0 * sin(theta0) - V(theta) .* sin(theta))));

% Calculate CD(theta)
CD = @(theta) (-2 * m0 * dot(a(theta) - g_vector(theta), [V(theta); 0])) ./ ...
    (rho * S * abs(V(theta)).^3);

% Calculate values of functions with respect to the angle
V_values = arrayfun(V, theta_span);
x_values = arrayfun(x, theta_span);
y_values = arrayfun(y, theta_span);
aV_values = arrayfun(aV, theta_span);
a_theta_values = arrayfun(a_theta, theta_span);
t_values = arrayfun(t, theta_span);
CD_values = arrayfun(CD, theta_span);

% Find the index where y first becomes negative
negative_y_index = find(y_values < 0, 1);

if ~isempty(negative_y_index)
    % If there are negative y values, truncate all arrays at the first negative y
    V_values = V_values(1:negative_y_index);
    x_values = x_values(1:negative_y_index);
    y_values = y_values(1:negative_y_index);
    aV_values = aV_values(1:negative_y_index);
    a_theta_values = a_theta_values(1:negative_y_index);
    t_values = t_values(1:negative_y_index);
    CD_values = CD_values(1:negative_y_index);
end

% Plot the graphs in time domain
figure;
subplot(3, 2, 1);
plot(t_values, V_values, 'b', 'LineWidth', 2, 'DisplayName', 'V(t)');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity vs Time');
legend;
grid on;

subplot(3, 2, 2);
plot(t_values, aV_values, 'b', 'LineWidth', 2, 'DisplayName', 'a_V(t)');
xlabel('Time (s)');
ylabel('Tangential Acceleration (m/s^2)');
title('Tangential Acceleration vs Time');
legend;
grid on;

subplot(3, 2, 3);
plot(t_values, a_theta_values, 'b', 'LineWidth', 2, 'DisplayName', 'a_\theta(t)');
xlabel('Time (s)');
ylabel('Normal Acceleration (m/s^2)');
title('Normal Acceleration vs Time');
legend;
grid on;

subplot(3, 2, 4);
plot(t_values, x_values, 'b', 'LineWidth', 2, 'DisplayName', 'x(t)');
xlabel('Time (s)');
ylabel('Position x (m)');
title('Position x vs Time');
legend;
grid on;

subplot(3, 2, 5);
plot(t_values, y_values, 'b', 'LineWidth', 2, 'DisplayName', 'y(t)');
xlabel('Time (s)');
ylabel('Position y (m)');
title('Position y vs Time');
legend;
grid on;

subplot(3, 2, 6);
plot(t_values, CD_values, 'b', 'LineWidth', 2, 'DisplayName', 'CD(t)');
xlabel('Time (s)');
ylabel('Drag Coefficient (CD)');
title('Drag Coefficient vs Time');
legend;
grid on;
