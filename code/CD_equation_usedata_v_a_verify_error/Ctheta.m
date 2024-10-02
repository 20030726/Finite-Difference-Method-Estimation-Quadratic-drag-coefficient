function y = Ctheta(theta)
%% 
if abs(cos(theta)) < 1e-10
    cos_theta = 0;
else
    cos_theta = cos(theta);
end

y = [cos_theta  0         -sin(theta);   
          0         1         0       ;
          sin(theta)  0         cos_theta];
end