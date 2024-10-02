clc;
clear;
close all;

% Parameters
tbo = 7;            % s
m0 = 42;            % kg
mfuel=30.149;       % kg
rho = 1.225;        % kg/m^3
CD_data = 0.24;
g = 9.81;           % m/s^2
S = 0.065^2*pi;     % m^2
theta = deg2rad(80);  % rad input(deg) launch angle
c = 0;%4.307;            % mdot
Vex = 502;          % Vex
t0 = 0;           % starttime
V0 = 10;

% Initial conditions
v0 = Ctheta(theta)*[V0;0;0];
Vx0 =v0(1);
Vy0 =v0(2);
Vz0 =v0(3);
s0 = [0;0;0];
X0 =s0(1);
Y0 =s0(2);
Z0 =s0(3);

% combime Initial conditions and integral parameters
y0 = [Vx0; Vy0; Vz0; X0; Y0; Z0]; % IC
h = 1e-3;            % timestep
tf = 10000;             % final time

U = [c; Vex; t0; tbo; m0; rho; CD_data; g; S; theta];
% solve by Runge-Kutta
[t, y] = RungeKutta(y0, h, tf, U);

%% plot
Vx = y(1,:);
Vy = y(2,:);
Vz = y(3,:);
X = y(4,:);
Y = y(5,:);
Z = y(6,:);
plot(t,Z)