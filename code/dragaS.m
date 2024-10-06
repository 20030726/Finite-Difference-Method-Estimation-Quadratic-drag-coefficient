function [Vec, T] = dragaS(T) 
global m0 rho CD_data g S V0 
%% constant
z0 = 0; % assume from sea level
Vz0 = V0;
k=0.5*rho*CD_data*S;
Vterm=sqrt((m0*g)/k);  
% velocity during launch
ttop = Vterm/g*(atan(Vz0/Vterm));
Ztop = z0 + Vterm^2/g * log( abs( cos( atan(Vz0/Vterm) - g*ttop/Vterm ) / cos( atan(Vz0/Vterm) ) ) );
ZD = zeros(size(T)); 
ascent = T < ttop;
descent = T >= ttop;
%% Z axis
% V>0
ZD(ascent) = z0 + Vterm.^2/g * log( abs( cos( atan(Vz0/Vterm)-g.*T(ascent)/Vterm) ./ cos( atan(Vz0/Vterm) ) ) );

% V<=0
ZD(descent) = Ztop - Vterm.^2/g * log(cosh(-g.*(T(descent)-ttop)/Vterm));

%% output
index = ZD(:)>=0;
X = zeros(1,length(T(index)));
Y = zeros(1,length(T(index)));
Z = ZD(index);
T = T(index);

Vec = [X;Y;Z];
end 
