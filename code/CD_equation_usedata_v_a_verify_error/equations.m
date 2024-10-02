function [dydt, a] = equations(t, y, g, k)
    V = y(1);
    theta = y(2);
    x = y(3);
    y_pos = y(4);
    a_V = -g * sin(theta) - g * k * V^2;
    a_theta = -g * cos(theta) / V;
    dydt = [a_V;
            a_theta;
             V * cos(theta);
             V * sin(theta)];
    a = [a_V, a_theta];
end