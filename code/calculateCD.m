function CD = calculateCD(a, V)
global m0 rho g S

% Environement Condition
V_norm = vecnorm(V, 2, 2);
vec_g = [0,0,-g];
W = [0,0,0];
% Calculate CD
A = (a - vec_g);
B = V-W;

CD = (-2 * m0 * dot(A,B,2)) ./ ( rho * V_norm.^3 * S);


end