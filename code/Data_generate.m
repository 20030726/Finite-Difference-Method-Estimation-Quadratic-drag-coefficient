function [Vec, T, A, basicparameters,CD_a] = Data_generate(Solution_section, Dimension,T)
% Solution_section
%   A : Analytical Solution
%   N : Numerical Solution
%'Dimension : 1,2,3
% T : time span
global theta0
validInput = false;
while ~validInput
    if Solution_section == 'A'
        switch Dimension
            case 1
                [Vec, T, A] = dragaS(T);
                validInput = true;
            case 2
                % [Vec, T, A, basicparameters] = dragkv22D(T);
                % validInput = true;
                %[Vec, T, A, basicparameters,CD_a] = dragkv22D_theta_domain_modify();
                [Vec, T, A, basicparameters,CD_a] = dragkv22D_theta_domain();
                validInput = true;
            case 3
                disp("We don't have 3-D Analytical Solution yet")
                Dimension = input('Please choose another dimension (1 or 2): ');
            otherwise
                disp('Invalid dimension. Please choose 1, 2, or 3.');
                Dimension = input('Enter a valid dimension (1, 2, or 3): ');
        end

    elseif Solution_section == 'N'
        switch Dimension
            case 1
                [Vec, T, A] = dragRungeKutta(T, deg2rad(90));
                validInput = true;
            case 2
                [Vec, T, A, basicparameters] = dragRungeKutta(T, theta0);
                validInput = true;
            case 3
                disp("We don't have 3-D Numerical Solution yet")
                Dimension = input('Please choose another dimension (1 or 2): ');
            otherwise
                disp('Invalid dimension. Please choose 1, 2, or 3.');
                Dimension = input('Enter a valid dimension (1, 2, or 3): ');
        end
    else
        disp('Invalid solution type. Please choose "A" for Analytical or "N" for Numerical.');
        Solution_section = input('Enter a valid solution section ("A" for Analytical, "N" for Numerical): ', 's');
    end

end
end

% function [X, Y, Z, T] = Data_generate(Solution_section, Dimension, T)
%     Solution_section
%       A : Analytical Solution
%       N : Numerical Solution
%     Dimension : 1, 2, 3
%     T : time span
% 
%     validInput = false;
% 
%     while ~validInput
%         if Solution_section == 'A'
%             if Dimension == 1
%                 [X, Y, Z, T] = dragaS(T);
%                 validInput = true;
%             elseif Dimension == 2
%                 [X, Y, Z, T] = dragkv22D(T);
%                 validInput = true;
%             elseif Dimension == 3
%                 disp("We don't have 3-D Analytical Solution yet");
%                 Dimension = input('Please choose another dimension (1 or 2): ');
%             else
%                 disp('Invalid dimension. Please choose 1, 2, or 3.');
%                 Dimension = input('Enter a valid dimension (1, 2, or 3): ');
%             end
%         elseif Solution_section == 'N'
%             if Dimension == 1
%                 theta0 = deg2rad(90);
%                 [X, Y, Z, T] = dragRungeKutta(T, theta0);
%                 validInput = true;
%             elseif Dimension == 2
%                 disp("What launch angle do you want?");
%                 theta0_deg = input('Please choose launch angle (degrees): ');
%                 theta0 = deg2rad(theta0_deg);
%                 [X, Y, Z, T] = dragRungeKutta(T, theta0);
%                 validInput = true;
%             elseif Dimension == 3
%                 disp("We don't have 3-D Numerical Solution yet");
%                 Dimension = input('Please choose another dimension (1 or 2): ');
%             else
%                 disp('Invalid dimension. Please choose 1, 2, or 3.');
%                 Dimension = input('Enter a valid dimension (1, 2, or 3): ');
%             end
%         else
%             disp('Invalid solution type. Please choose "A" for Analytical or "N" for Numerical.');
%             Solution_section = input('Enter a valid solution section ("A" for Analytical, "N" for Numerical): ', 's');
%         end
%     end
% end
