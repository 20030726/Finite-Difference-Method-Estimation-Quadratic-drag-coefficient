function [t, y, a] = RungeKutta( y0 , h , tf , U)
% RungeKutta method for numerical integration with less accuracy.
% Inputs:
%   y0: Initial state vector.
%   h: Time step size.
%   tf: Final time.
%   U: Control parameter vector.
% Outputs:
%   t: Time vector.
%   y: State matrix.
N = tf / h;
y = zeros(6,N+1);% N+1 is iteration time plus initial time
a = zeros(3, N+1); % Matrix to store accelerations
t = 0:h:tf; % initial condition already known so we only have to iterate N time
y(:,1) = y0;% place initial condition in list

for n = 1:N %%
    U(3) = t(n); % current time
    f = @(y) particle_model3DRungeKutta(y, U);

    k1 = f(y(:,n));
    a(:,n) = k1(1:3); % Acceleration is in the first three elements of k1

    U(3) = t(n) + h/2; % update t(n) + h/2
    k2 = f(y(:,n) + h/2 * k1);
    
    U(3) = t(n) + h/2; % hold t(n) + h/2
    k3 = f(y(:,n) + h/2 * k2);
    
    U(3) = t(n) + h; % update t(n) + h
    k4 = f(y(:,n) + h * k3);
    
    y(:,n+1) = y(:,n) + h/6*(k1+2*k2+2*k3+k4);
      % Calculate acceleration
    if y(6,n+1) <= 0
        y = y(:,1:n);
        a = a(:,1:n); % because a is use XDot to calculate
        t = t(:,1:n);
        break;
    end
end
end