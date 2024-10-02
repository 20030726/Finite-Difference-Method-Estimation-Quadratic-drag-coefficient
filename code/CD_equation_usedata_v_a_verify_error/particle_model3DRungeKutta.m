function XDOT = particle_model3DRungeKutta(y,U)
%% State space
Vx = y(1); %Vx
Vy = y(2); %Vy
Vz = y(3); %Vz
X = y(4); %X
Y = y(5); %Y
Z = y(6); %Z
v =[Vx;Vy;Vz];
s =[X;Y;Z];
c = U(1);         %mdot
Vex = U(2);       %Vex
t = U(3);         %time
tbo = U(4);       %s
m0 = U(5);        %kg
rho = U(6);       %kg/m^3
Cd = U(7);         
g = U(8);         %m/s^2
S = U(9);         %m^2
thetar = U(10);    %theta degree
%% 
if t == 0
    gamma = thetar;
else
    gamma = atan2(Vz,sqrt(Vx^2+Vy^2));
end
Cgamma = [cos(-gamma)  0         -sin(-gamma);   
          0         1         0       ;
          sin(-gamma)  0         cos(-gamma)];

%% m(t)  mf = m0 - integral(u1,0,t)
mf = 0;
if t <= tbo
    mf = m0 -c.*t;
elseif t > tbo
    mf = m0 -c.*tbo;
end
%% FA    FA = 0.5*rho*V^2*Cd*S     opposite to velocity direction     
k= 0.5*rho*Cd*S;  
FAV = -k*norm([Vx;Vy;Vz]).*[Vx;Vy;Vz];

%% FT    FT = mdot*Vex    = g0*Isp*mdot    Isp (s)
if t <= tbo
    FT = c*Vex;
elseif t > tbo
    FT = 0;
end

FTV = FT*Cgamma.'*[1;0;0];

%% FG 
%
FG=mf*g;
FGV = FG*[0;0;-1];
% if t == 0
%     FGV = [0;0;0];
% elseif t > 0
%     FGV = FG*[0;0;-1];
% end

FB=FTV+FGV+FAV;

%% a = F/m(t) 

a = 1/mf*FB;

%% XDOT
% disp('a:');
% disp(num2str(a));
% disp('v:');
% disp(num2str(v));
XDOT = [a;v];

end