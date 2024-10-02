function X=analysissolution(t,Vx0,Vz0,X0,Z0,g)

x=X0+Vx0.*t;
z=Z0+Vz0.*t-0.5*g*t.^2;

%% output
X=[x;z];
end