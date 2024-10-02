function [Vec, T, A, basicparameters, CD_a] = dragkv22D_theta_domain_modify()
    global m0 rho CD_data g S theta0 V0 t0

    % Calculate air resistance coefficient
    k = rho * CD_data * S / (2 * m0 * g);

    % Initial conditions
    x0 = 0;  % Initial x position (m)
    y0 = 0;  % Initial y position (m)

    % Define the angle range
    theta_span = theta0 : -1e-3 : deg2rad(-90);
    f = @(theta) (sin(theta0) ./ cos(theta0).^2 + log(tan(theta0 / 2 + pi / 4)) - ...
        (sin(theta) ./ cos(theta).^2 + log(tan(theta / 2 + pi / 4))));
    
    % Calculate velocity V(theta)
    V = @(theta) (V0 * cos(theta0) ./ ...
        (cos(theta) .* (1 + k * V0^2 * cos(theta0)^2 .* ...
        f(theta)).^(1/2))      );

    % Initialize arrays for storing results
    t_values = zeros(size(theta_span));
    x_values = zeros(size(theta_span));
    y_values = zeros(size(theta_span));
    alpha_values = zeros(size(theta_span));

    % Initial values
    t_values(1) = t0;
    x_values(1) = x0;
    y_values(1) = y0;

    % Loop through each angle to compute values
    for i = 2:length(theta_span)
        theta_i = theta_span(i);
        theta_i_1 = theta_span(i-1);

        Vi = V(theta_i);
        Vi_1 = V(theta_i_1);

        alpha_i = k * (Vi_1^2 .* sin(theta_i_1)^2 + Vi^2 .* sin(theta_i)^2);
        alpha_values(i) = alpha_i;

        t_values(i) = t_values(i-1) + (2 * (Vi_1 .* sin(theta_i_1) - Vi .* sin(theta_i))) / (g * (2 + alpha_i));
        x_values(i) = x_values(i-1) + (Vi_1^2 .* sin(2 * theta_i_1) - Vi^2 .* sin(2 * theta_i)) / (2 * g * (1 + alpha_i));
        y_values(i) = y_values(i-1) + (Vi_1^2 .* sin(theta_i_1)^2 - Vi^2 .* sin(theta_i)^2) / (g * (2 + alpha_i));
    end

    % Only consider y >= 0
    index = y_values(:) >= 0;
    t_values = t_values(index);
    x_values = x_values(index);
    y_values = y_values(index);
    alpha_values = alpha_values(index);

    % Calculate acceleration components and vectors
    theta_index = theta_span(index); % subset of theta_span corresponding to y >= 0
    V_index = V(theta_index); % velocities for the same subset

    aV = -g .* sin(theta_index) - g .* k .* V_index.^2;
    a_theta = -g .* cos(theta_index);
    a = [aV; a_theta];

    % Calculate CD(theta)
    g_vector = [-g .* sin(theta_index); -g .* cos(theta_index)];
    CD = (-2 * m0 * sum((a - g_vector) .* [V_index; zeros(size(V_index))], 1)) ./ ...
        (rho * S * abs(V_index).^3);

    % Calculate Vec, T, A, and basicparameters
    T = t_values;
    H_D = (V0^2 * sin(theta0)^2) / (g * (2 + k * V0^2 * sin(theta0)));
    T_D = 2 * sqrt(2 * H_D / g);
    Va = (V0 * cos(theta0)) / sqrt(1 + k * V0^2 * (sin(theta0) + cos(theta0)^2 * log(tan(theta0 / 2 + pi / 4))));
    L = Va * T_D;
    ta = (T_D - k * H_D * Va) / 2;
    xa = sqrt(L * H_D * cot(theta0));

    Vec = [V_index; x_values; y_values];
    A = [aV; a_theta];
    basicparameters = [H_D, T_D, Va, L, ta, xa];
    CD_a = CD;

    % Plotting x_values versus theta_span
    figure;
    plot(rad2deg(theta_span(index)), y_values);
    xlabel('\theta (radians)');
    ylabel('x (meters)');
    title('x vs. \theta');
end

