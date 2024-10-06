function [V, Vx, Vy, Vz, a, ax, ay, az] = calVaXYZ(S, T, differentiator)

X = S(:, 1);
Y = S(:, 2);
Z = S(:, 3);

if differentiator == 'F'
    % Forward method
    V = zeros(length(T)-1, 3);
    for i = 1:length(T)-1
        V(i, 1) = (X(i+1) - X(i)) / (T(i+1) - T(i)); % Vx
        V(i, 2) = (Y(i+1) - Y(i)) / (T(i+1) - T(i)); % Vy
        V(i, 3) = (Z(i+1) - Z(i)) / (T(i+1) - T(i)); % Vz
    end

    a = zeros(length(T)-2, 3);
    for i = 1:length(T)-2
        a(i, 1) = (V(i+1, 1) - V(i, 1)) / (T(i+1) - T(i)); % ax
        a(i, 2) = (V(i+1, 2) - V(i, 2)) / (T(i+1) - T(i)); % ay
        a(i, 3) = (V(i+1, 3) - V(i, 3)) / (T(i+1) - T(i)); % az
    end

elseif differentiator == 'C'
    % Central method
    V = zeros(length(T)-2, 3);
    for i = 2:length(T)-1
        V(i-1, 1) = (X(i+1) - X(i-1)) / (T(i+1) - T(i-1)); % Vx
        V(i-1, 2) = (Y(i+1) - Y(i-1)) / (T(i+1) - T(i-1)); % Vy
        V(i-1, 3) = (Z(i+1) - Z(i-1)) / (T(i+1) - T(i-1)); % Vz
    end

    a = zeros(length(T)-4, 3);
    for i = 2:length(V)-1
        a(i-1, 1) = (V(i+1, 1) - V(i-1, 1)) / (T(i+1) - T(i-1)); % ax
        a(i-1, 2) = (V(i+1, 2) - V(i-1, 2)) / (T(i+1) - T(i-1)); % ay
        a(i-1, 3) = (V(i+1, 3) - V(i-1, 3)) / (T(i+1) - T(i-1)); % az
    end
end
Vx =V(:,1);
Vy =V(:,2);
Vz =V(:,3);

ax =a(:,1);
ay =a(:,2);
az =a(:,3);

end
