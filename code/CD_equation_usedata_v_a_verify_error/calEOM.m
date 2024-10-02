% 清理环境
clc
clear
close all

% 定义符号变量
syms t H T Va L ta xa a1 c g k

% 计算w1及其一阶和二阶导数
w1 = t - ta;
dw1dt = diff(w1, t);
ddw1ddt = diff(dw1dt, t);

% 计算w2及其一阶和二阶导数
w2 = 2*t*(T - t) / a1;
dw2dt = diff(w2, t);
ddw2ddt = diff(dw2dt, t);

% 位置、速度和加速度的计算
x = L * (w1^2 + w2 + w1*sqrt(w1^2 + c*w2)) / (2*w1^2 + a1*w2);
dxdt = diff(x, t);
ddxddt = diff(dxdt, t);

y = H * t * (T - t) / ta^2 + (T - 2*ta) * t;
dydt = diff(y, t);
ddyddt = diff(dydt, t);

% 显示结果
disp('x(t):');
disp(x);

disp('dx/dt:');
disp(dxdt);

disp('d²x/dt²:');
disp(ddxddt);

disp('y(t):');
disp(y);


disp('dy/dt:');
disp(dydt);

disp('d²y/dt²:');
disp(ddyddt);


% clc;
% clear;
% close all;
% 
% %% Parameters
% syms t
% 
% % 数值参数
% H = 30.97; % m
% T = 5.00; % sec
% Va = 23.19; % m/s
% L = 117.8; % m
% ta = 2.35; % sec
% xa = 65.36; % m
% theta1 = -53.04 * pi / 180; % 转换为弧度
% V1 = 27.45; % m/s
% g = 9.81; % m/s²
% k = 0.000548; % s²/m²
% 
% a1 = Va; % 假设 a1 为 Va，因为它没有明确的数值
% c = 2 * (a1 - 1) / a1; % 根据提供的公式计算 c
% 
% % 定义 w1 和 w2 及其导数
% w1 = t - ta;
% dw1dt = diff(w1, t);
% ddw1ddt = diff(dw1dt, t);
% 
% w2 = 2 * t * (T - t) / a1;
% dw2dt = diff(w2, t);
% ddw2ddt = diff(dw2dt, t);
% 
% %% Position, Velocity, Acceleration
% 
% % 计算位置 x 和 y
% x = L * (w1^2 + w2 + w1 * sqrt(w1^2 + c * w2)) / (2 * w1^2 + a1 * w2);
% dxdt = diff(x, t);
% ddxddt = diff(dxdt, t);
% 
% y = H * t * (T - t) / (ta^2 + (T - 2 * ta) * t);
% dydt = diff(y, t);
% ddyddt = diff(dydt, t);
% 
% %% 数值验证
% % 将参数替换为具体数值
% dxdt_num = subs(dxdt);
% ddxddt_num = subs(ddxddt);
% dydt_num = subs(dydt);
% ddyddt_num = subs(ddyddt);


