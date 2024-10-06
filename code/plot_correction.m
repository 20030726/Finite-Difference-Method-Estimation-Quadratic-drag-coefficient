function plot_correction(t_range_N, left_norm_N, right_norm_N, left_x_N, left_z_N, right_x_N, right_z_N, ...
                         rmse_norm_N, rmse_x_N, rmse_z_N, ...
                         t_range_a, left_norm_a, right_norm_a, left_x_a, left_z_a, right_x_a, right_z_a, ...
                         rmse_norm_a, rmse_x_a, rmse_z_a)

    % Plot the norms
    figure
    subplot(2,1,1)
    plot(t_range_N, left_norm_N, 'r', 'LineWidth', 2)
    hold on 
    plot(t_range_N, right_norm_N, 'b--', 'LineWidth', 2)
    title(['Numerical Left and Right Norms (RMSE = ', num2str(rmse_norm_N), ')'])
    xlabel('Time')
    ylabel('Norm')
    xlim([0, t_range_N(end)]);
    legend('Left Norm', 'Right Norm')
    hold off

    subplot(2,1,2)
    plot(t_range_a, left_norm_a, 'g', 'LineWidth', 2)
    hold on 
    plot(t_range_a, right_norm_a, 'm--', 'LineWidth', 2)
    title(['Analytical Left and Right Norms (RMSE = ', num2str(rmse_norm_a), ')'])
    xlabel('Time')
    ylabel('Norm')
    xlim([0, t_range_a(end)]);
    legend('Left Norm', 'Right Norm')
    hold off

    % Define components and titles for plotting
    components = {'x', 'z'};
    titles = {'X Components', 'Z Components'};
    left_components_N = {left_x_N, left_z_N};
    right_components_N = {right_x_N, right_z_N};
    rmse_values_N = {rmse_x_N, rmse_z_N};

    left_components_a = {left_x_a, left_z_a};
    right_components_a = {right_x_a, right_z_a};
    rmse_values_a = {rmse_x_a, rmse_z_a};

    % Plot the X, Z components in subplots using a for loop
    figure
    for i = 1:2
        subplot(2, 2, 2*i-1)
        plot(t_range_N, left_components_N{i}, 'r', 'LineWidth', 2)
        hold on 
        plot(t_range_N, right_components_N{i}, 'b--', 'LineWidth', 2)
        title(['Numerical Left and Right ', titles{i}, ' (RMSE = ', num2str(rmse_values_N{i}), ')'])
        xlabel('Time')
        ylabel([upper(components{i}), ' Component'])
        xlim([0, t_range_N(end)]);
        legend(['Left ', upper(components{i})], ['Right ', upper(components{i})])
        hold off

        subplot(2, 2, 2*i)
        plot(t_range_a, left_components_a{i}, 'g', 'LineWidth', 2)
        hold on 
        plot(t_range_a, right_components_a{i}, 'm--', 'LineWidth', 2)
        title(['Analytical Left and Right ', titles{i}, ' (RMSE = ', num2str(rmse_values_a{i}), ')'])
        xlabel('Time')
        ylabel([upper(components{i}), ' Component'])
        xlim([0, t_range_a(end)]);
        legend(['Left ', upper(components{i})], ['Right ', upper(components{i})])
        hold off
    end
end
