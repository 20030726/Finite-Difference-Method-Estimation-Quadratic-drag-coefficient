function X=masschangingaS(t,U,V0,z0,mfuel)
%% constant
c = U(1);
Vex = U(2);
m0 = U(5);
g = U(8);
Vzm0=V0;
Zm0=z0;
tbo=mfuel/c;%burnout
bbo = t <= tbo; %before burnout
abo = t > tbo; %after burnout
Zmbo=Zm0 + Vzm0*tbo - 0.5 * g * tbo.^2+ Vex*log(m0)*tbo+Vex/c * ( (m0-c*tbo) * log(  m0-c*tbo  ) + c*tbo - m0*log(m0)) ;
Vzmbo=Vzm0+Vex*log(m0/(m0-c*tbo))-g*tbo;
Zm = zeros(size(t)); % 初始化 ZD 為與 t 同樣大小的零數組

%% Z

Zm(bbo) = Zm0 + Vzm0.*t(bbo) - 0.5 .* g .* t(bbo).^2+ Vex.*log(m0).*t(bbo)+Vex/c .* ( (m0-c.*t(bbo)) .* log(  m0-c.*t(bbo)  ) + c.*t(bbo) - m0.*log(m0)) ;

Zm(abo) = Zmbo + Vzmbo.*(t(abo)-tbo) - 0.5 .* g .* (t(abo)-tbo).^2;

%% output
X=Zm;
end