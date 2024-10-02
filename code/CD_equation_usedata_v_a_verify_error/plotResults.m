function plotResults(T, X, Z, X_origin, Z_origin, CD, CD_data, sigma, mu, RMSE_CD, Dimensions)
%% 6. Plot the result
global  theta0

theta0rad = rad2deg(theta0);
if Dimensions == 1
    % trajectory compare (1-D)
    figure;
    plot(T,Z_origin,'r','LineWidth',2)
    hold on
    plot(T,Z, 'b--','LineWidth',2)
    hold on
    legend('Original Trajectory', 'Trajectory with Noise')
    xlabel('T (s)')
    ylabel('Z (m)')
    title(['Trajectories with random noise at standard deviation = ',num2str(sigma),' (m) mean of noises = ',num2str(mu),' Flight time: ',num2str(T(end))])
    axis equal
else
    % trajectory compare (2-D)
     figure;
    plot(X_origin, Z_origin, 'r-', 'LineWidth', 2); 
    hold on;
    plot(X, Z, 'b--', 'LineWidth', 2); 
    hold off;
    legend('Original Trajectory', 'Trajectory with Noise');
    xlabel('X (m)');
    ylabel('Z (m)');
    xlim([T(1),T(end)])
    title(['2-D Trajectories launch angle: ', num2str(theta0rad), '° with random noise at standard deviation = ', num2str(sigma), ' (m)']);

    axis equal;
end

% CD

figure;
plot(T,CD,'r',LineWidth=2)
hold on
plot(T, CD_data * ones(size(T)), 'b--', 'LineWidth', 1);
hold off

% Adding labels and legend
xlabel('Time (s)');
ylabel('Drag Coefficient (CD)');
xlim([T(1),T(end)])
ylim([-1,1])
legend('Calculated CD', 'Actual CD', 'Location', 'best');
% Displaying the MSE on the plot
title(['Calculated CD vs. Actual CD ( RMSE: ', num2str(RMSE_CD),')',], 'FontSize', 12);
% Displaying the plot
hold off;
end