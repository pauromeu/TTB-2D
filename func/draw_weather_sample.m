function sample = draw_weather_sample(variable_name, sample_size)
    % Draws a sample from the distribution of a specified variable in the hourly weather data
    %
    % Input:
    %   mat_filename - The name of the .mat file containing the weather data
    %   variable_name - The name of the variable to sample from (e.g., 'temperature')
    %   sample_size - The number of samples to draw
    %
    % Output:
    %   sample - The drawn sample

    weather_data  = load("property/zurich_2023-2024.mat").hourly_weather_data;
    
    % Check if the variable exists in the data
    if ismember(variable_name, weather_data.Properties.VariableNames)
        % Extract the data for the specified variable
        variable_data = weather_data.(variable_name);
        
        % Check if the variable_data is a table, extract the column of interest
        if istable(variable_data)
            variable_data = variable_data.(variable_name);
        end
        
        % Draw random samples from the observed data
        indices = randi(length(variable_data), sample_size, 1);
        sample = variable_data(indices);
    else
        error('Variable %s not found in the loaded data.', variable_name);
    end
end
