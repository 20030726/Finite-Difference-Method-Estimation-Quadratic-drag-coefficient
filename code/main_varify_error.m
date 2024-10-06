clc
clear
close all
%% 1. Data generate
global m0 rho CD_data g S theta0 V0 h c Vex t0 tbo
% Parameters
tbo = 7;            % s
m0 = 42;            % kg
mfuel = 30.149;     % kg
rho = 1.225;        % kg/m^3
CD_data = 0.24;
g = 9.81;           % m/s^2
S = 0.699223^2*pi;  % m^2
theta0 = deg2rad(40);  % rad input(deg) launch angle
c = 0;              % mdot
Vex = 502;          % Vex
t0 = 0;             % starttime
V0 = 45;            % m/s
tf = 100;           % final time
h = 1e-3;           % timestep
T = t0:h:tf; 

% Solution_section 
%   A : Analytical Solution 
%   N : Numerical Solution
% Dimension : 1,2,3
Solution_section = 'N';
Dimensions = 2;
[Vec_N, T_N, A_N, basicparameters_N] = Data_generate(Solution_section, Dimensions, T);

Vx_N = Vec_N(:,1);
Vy_N = Vec_N(:,2);
Vz_N = Vec_N(:,3);
V_N = [Vx_N, Vy_N, Vz_N];
X_N = Vec_N(:,4);
Y_N = Vec_N(:,5);
Z_N = Vec_N(:,6);


ax_N = A_N(:,1);
ay_N = A_N(:,2);
az_N = A_N(:,3);
a_N = [ax_N, ay_N, az_N];

%% Generate Analytical Solution
Solution_section = 'A';
[Vec_a, T_a, A_a, basicparameters_a,CD_a] = Data_generate(Solution_section, Dimensions, T);

H_D_a = basicparameters_a(1);
T_D_a = basicparameters_a(2);
Va_a = basicparameters_a(3);
L_a = basicparameters_a(4);
ta_a = basicparameters_a(5);
xa_a = basicparameters_a(6);

V_a = Vec_a(1,:);
X_a = Vec_a(2,:);
Z_a = Vec_a(3,:);





%% 4. CD_equation
CD_N = calculateCD(a_N, V_N);


% Calculate RMSE with respect to CD_data
[RMSE_CD_N, ~] = calculateRMSE(CD_N, CD_data);
[RMSE_CD_a, ~] = calculateRMSE(CD_a, CD_data);

% Plot CD with Data and calculate RMSE
figure;
subplot(2,1,1)
plot(T_N, CD_N, 'b', 'LineWidth', 2);
hold on;
plot(T_N, CD_data * ones(size(T_N)), 'r--', 'LineWidth', 2);
legend('Numerical CD', 'Data CD');
xlabel('Time (s)');
ylabel('Drag Coefficient (C_D)');
xlim([0, T_N(end)]);
title(['Numerical CD vs Data CD (RMSE: ', num2str(RMSE_CD_N), ')']);
hold off;

subplot(2,1,2)
plot(T_a, CD_a, 'b', 'LineWidth', 2);
hold on;
plot(T_a, CD_data * ones(size(T_a)), 'r--', 'LineWidth', 2);
legend('Analytical CD', 'Data CD');
xlabel('Time (s)');
ylabel('Drag Coefficient (C_D)');
xlim([0, T_a(end)]);
title(['Analytical CD vs Data CD (RMSE: ', num2str(RMSE_CD_a), ')']);
hold off;
%% trajectory

figure;
plot(X_N, Z_N, 'b--', 'LineWidth', 2);
hold on;
plot(X_a, Z_a, 'r', 'LineWidth', 2);
legend('Numerical', 'Analytical');
xlabel('X (m)');
ylabel('Z (m)');
title('X vs Z ');
hold off;

%% Basic Parameters
H_D_N = max(Z_N);
[~, index_N] = max(Z_N);
T_D_N = T_N(end);
Va_N = norm([Vx_N(index_N), Vy_N(index_N), Vz_N(index_N)]);
L_N = max(X_N);
ta_N = T_N(index_N);
xa_N = X_N(index_N);

parameters_N = {
    'Max height (H_D)', 'H_D', H_D_N, 'm';
    'Total flight time (T_D)', 'T_D', T_D_N, 's';
    'Max speed (Va)', 'Va', Va_N, 'm/s';
    'Max horizontal distance (L)', 'L', L_N, 'm';
    'Time at max height (ta)', 'ta', ta_N, 's';
    'Horizontal position at max height (xa)', 'xa', xa_N, 'm'
};

parameters_a = {
    'Max height (H_D)', 'H_D', H_D_a, 'm';
    'Total flight time (T_D)', 'T_D', T_D_a, 's';
    'Max speed (Va)', 'Va', Va_a, 'm/s';
    'Max horizontal distance (L)', 'L', L_a, 'm';
    'Time at max height (ta)', 'ta', ta_a, 's';
    'Horizontal position at max height (xa)', 'xa', xa_a, 'm'
};

% create Tables
parameterTable_N = cell2table(parameters_N, 'VariableNames', {'Parameter', 'Symbol', 'Value', 'Unit'});
disp('Numerical Solution Parameters:');
disp(parameterTable_N);

parameterTable_a = cell2table(parameters_a, 'VariableNames', {'Parameter', 'Symbol', 'Value', 'Unit'});
disp('Analytical Solution Parameters:');
disp(parameterTable_a);

% %% Correction 
% % Calculate the norms and components of left and right vectors
% [left_N, right_N, left_a, right_a] = correction(a_N, V_N, CD_N, T_N, a_a, V_a, CD_a, T_a);
