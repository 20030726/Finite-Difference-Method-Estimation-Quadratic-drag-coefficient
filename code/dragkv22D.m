function [Vec, T, A, basicparameters] = dragkv22D(T)


global m0 rho CD_data g S theta0 V0 
% Constants and Initial Conditions

% Drag coefficient calculation
k = rho * CD_data * S / (2 * m0 * g);
% Derived quantities
H_D = (V0^2 * sin(theta0)^2) / (g * (2 + k * V0^2 * sin(theta0)));
T_D = 2 * sqrt(2 * H_D / g);
Va = (V0 * cos(theta0)) / sqrt(1 + k * V0^2 * (sin(theta0) + cos(theta0)^2 * log(tan(theta0 / 2 + pi / 4))));
L = Va * T_D;
ta = (T_D - k * H_D * Va) / 2;
xa = sqrt(L * H_D * cot(theta0));
a1 = L / xa;

% Calculate X and Z
ZD = H_D .* T .* (T_D - T) ./ (ta^2 + (T_D - 2 * ta) .* T);
index = ZD(:) >= 0;
Z = ZD(index);
T = T(index);

% Corrected definitions of w1, w2, and c
w1 = T - ta;
w2 = 2 .* T .* (T_D - T) / a1;
dw2dt = 2 * (T_D - 2 * T) / a1;
ddw2ddt = -4/a1;
c = 2 * (a1 - 1) / a1;

% Calculate A, dA/dt, d^2A/dt^2
A = L * (w1.^2 + w2 + w1 .* sqrt(w1.^2 + c .* w2));

dAdt = L * (2 * w1 + dw2dt + sqrt(w1.^2 + c * w2) + ...
    ( w1 ./ (2 * sqrt(w1.^2 + c * w2))) .* (2 * w1 + c * dw2dt));

ddAddt = L * (2 + ddw2ddt ...
    + (w1.^2 + c * w2).^(-1/2).*(2 * w1 + c * dw2dt)...
    - w1/4 .* (w1.^2 + c*w2).^(-3/2) .* (2*w1 + c*dw2dt).^2 ...
    + w1/2 .* (w1.^2 + c*w2).^(-1/2) .* (2 + c*ddw2ddt));

% Calculate B, dB/dt, d^2B/dt^2
B = 2 * w1.^2 + a1 * w2;
dBdt = 4*w1 + a1 * dw2dt;

% Calculate C, dC/dt, d^2C/dt^2
C = H_D * T .* (T_D - T);
dCdt = H_D * (T_D - 2 * T);
ddCddt2 = -2 * H_D;

D = ta^2 + (T_D - 2 * ta) * T;
dDdt = (T_D - 2 * ta);


% Calculate D, dD/dt, d^2D/dt^2

% Calculate E, F, G, H
E = dAdt .* B - A .* dBdt;
dEdt = ddAddt .* B ;

F = B.^2;
dFdt = 2 * B .* dBdt;


G = dCdt.* D - C * dDdt;
dGdt = ddCddt2 * D;

I = D.^2;
dIdt = 2*D*dDdt;

X = A./B;
Y = zeros(length(T), 1);
% Calculate velocities Vx(t) and Vy(t)
Vx = E./F;
Vy = zeros(length(T), 1);
Vz = G./I;

% Manually calculate accelerations ax(t) and ay(t)
ax = (dEdt .* F - E.* dFdt) ./ F.^2;
ay = zeros(length(T), 1);
az = (dGdt .* I - G.* dIdt) ./ I.^2;

Vec = [Vx',Vy ,Vz',X',Y ,Z'];
A = [ax',ay , az'];
basicparameters = [H_D, T_D, Va, L, ta, xa];
end


