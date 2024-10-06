function a = compute_acceleration(t, y, g, k)
    V = y(:, 1);
    theta = y(:, 2);
    a = [-g * sin(theta) - g * k * V.^2, ...
         -g * cos(theta) ./ V];
end
