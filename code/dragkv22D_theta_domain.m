function [Vec, T, A, basicparameters, CD_a] = dragkv22D_theta_domain()
    global m0 rho CD_data g S theta0 V0 t0

    % Calculate air resistance coefficient
    k = rho * CD_data * S / (2 * m0 * g);

    x0 = 0;  % Initial x position (m)
    y0 = 0;  % Initial y position (m)

    % Define the angle range
    theta_span = theta0 : -1e-3 : deg2rad(-90);
    f = @(theta) (sin(theta0) / cos(theta0).^2 + log(tan(theta0 / 2 + pi / 4)) - ...
        (sin(theta) ./ cos(theta).^2 + log(tan(theta / 2 + pi / 4))));
    % Calculate velocity V(theta)
    V = @(theta) (V0 * cos(theta0) ./ ...
        (cos(theta) * (1 + k * V0^2 * cos(theta0)^2 .* ...
        f(theta)).^(1/2)));

    % Calculate epsilon(theta)
    epsilon = @(theta) k * (V0^2 * sin(theta0) - V(theta).^2 .* sin(theta));

    % Calculate position x(theta) and y(theta)
    x = @(theta) x0 + (V0^2 * sin(2 * theta0) - V(theta).^2 .* sin(2 * theta)) / (2 * g * (1 + epsilon(theta)));
    y = @(theta) y0 + (V0^2 * sin(theta0)^2 - V(theta).^2 .* sin(theta).^2) / (g * (2 + epsilon(theta)));

    % Calculate acceleration components and vectors
    aV = @(theta) -g * sin(theta) - g * k * V(theta).^2;
    a_theta = @(theta) -g * cos(theta);
    a = @(theta) [aV(theta); a_theta(theta)];
    g_vector = @(theta) [-g * sin(theta); -g * cos(theta)];

    % Calculate time t(theta)
    t = @(theta) t0 + (2 * (V0 * sin(theta0) - V(theta) .* sin(theta))) / ...
        (g * (2 + epsilon(theta)));
    % % t = @(theta) t0*(2 - epsilon(theta))/(2 + epsilon(theta)) + (2 * (V0 * sin(theta0) - V(theta) .* sin(theta))) / ...
    % %     (g * (2 + epsilon(theta)));

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

    % Only consider y >= 0
    index = y_values(:) >= 0;
    V_values = V_values(index);
    x_values = x_values(index);
    y_values = y_values(index);
    aV_values = aV_values(index);
    a_theta_values = a_theta_values(index);
    t_values = t_values(index);
    CD_a = CD_values(index);

    % Sort all values by time
    [t_values, sort_idx] = sort(t_values);
    V_values = V_values(sort_idx);
    x_values = x_values(sort_idx);
    y_values = y_values(sort_idx);
    aV_values = aV_values(sort_idx);
    a_theta_values = a_theta_values(sort_idx);
    CD_a = CD_a(sort_idx);

    % Calculate Vec, T, A, and basicparameters
    T = t_values;
    H_D = (V0^2 * sin(theta0)^2) / (g * (2 + k * V0^2 * sin(theta0)));
    T_D = 2 * sqrt(2 * H_D / g);
    Va = (V0 * cos(theta0)) / sqrt(1 + k * V0^2 * (sin(theta0) + cos(theta0)^2 * log(tan(theta0 / 2 + pi / 4))));
    L = Va * T_D;
    ta = (T_D - k * H_D * Va) / 2;
    xa = sqrt(L * H_D * cot(theta0));

    Vec = [V_values; x_values; y_values];
    A = [aV_values; a_theta_values];
    basicparameters = [H_D, T_D, Va, L, ta, xa];
end
