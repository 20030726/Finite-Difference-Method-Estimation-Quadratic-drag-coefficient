function [Vec, T, A, basicparameters] = dragRungeKutta(T, theta0)
global m0 rho CD_data g S V0 h c Vex t0 tbo 

v0 = Ctheta(theta0) * [V0; 0; 0];
Vx0 = v0(1);
Vy0 = v0(2);
Vz0 = v0(3);
s0 = [0; 0; 0];
X0 = s0(1);
Y0 = s0(2);
Z0 = s0(3);

% Combine initial conditions and integral parameters
y0 = [Vx0; Vy0; Vz0; X0; Y0; Z0]; % Initial conditions
tf = T(end); % Final time

U = [c; Vex; t0; tbo; m0; rho; CD_data; g; S; theta0];

% Solve by Runge-Kutta
[t, y, a] = RungeKutta(y0, h, tf, U);

Vx = y(1,:);
Vy = y(2,:);
Vz = y(3,:);
X = y(4,:);
Y = y(5,:);
Z = y(6,:);
Ax = a(1,:);
Ay = a(2,:);
Az = a(3,:);
T = t;

[H, index] = max(Z);
ta = T(index);
xa = X(index);
Va = norm([Vx(index), Vy(index), Vz(index)]);
L = max(X);
T_D = T(end);

Vec = [Vx',Vy',Vz',X',Y',Z'];
A = [Ax',Ay',Az'];
basicparameters = [H, T_D, Va, L, ta, xa];
end
