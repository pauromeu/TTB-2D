function write_result( ...
    Sol, n, filename, ...
    damage_factor, T, train_init_velocity, train_load, stiffness, sample_number, date, fs)
    % Writes sampled data from given solution structures to a CSV file.
    % Inputs:
    %   Sol - A structure containing matrices .Beam.U.xt and .Beam.Acc.xt
    %   n - Interval for sampling the data
    %   train_init_velocity - Initial velocity of the train to be added as a column
    %   filename - Name of the CSV file ('healthy.csv')
    %     
    % Sample the solution data
    u_sample = 1000*sample_solution(Sol.Beam.U.xt, n); % displacement in mm
    acc_sample = sample_solution(Sol.Beam.Acc.xt, n);
    
    length = size(u_sample, 2);  % Assuming u_sample is (n x m) where n is the number of samples

    date = datetime(date, 'Format', 'yyyy-MM-dd HH:mm:ss.SSSS');
    % Generate time vector starting from 'date', with increments corresponding to the sampling interval
    time_vector = date + seconds((0:(length-1)).' / fs);  % Column vector of datetime values


    % Prepare the data to be written - concatenate vertically
    combined_data = [
        u_sample; 
        acc_sample; 
        repmat(damage_factor, 1, length);
        repmat(T, 1, length);
        repmat(train_init_velocity, 1, length);
        repmat(train_load, 1, length);
        repmat(stiffness, 1, length);
        repmat(sample_number, 1, length);
    ];
    
    
    % Create variable names for each u_sample variable
    u_sample_var_names = strcat("disp_", string(1:n));
    acc_sample_var_names = strcat("acc_", string(1:n));

    variable_names = [u_sample_var_names, acc_sample_var_names,...
    "DamageFactor", "Temperature", "TrainInitVelocity", ...
    "TrainLoad", "Stiffness", "SampleNumber"];

    % Transpose the matrix to turn rows into columns
    transposed_data = combined_data.';
    
    % Create the table with dynamically created variable names
    data_table = array2table(transposed_data, 'VariableNames', variable_names);

    data_table.time = time_vector;

    % Check if the file exists
    if exist(filename, 'file')
        % If the file exists, read the existing data and append the new data
        opts = detectImportOptions(filename);  % Get import options that match the file structure
        existing_data = readtable(filename, opts);  % Read existing data with the same structure
        combined_data = [existing_data; data_table];  % Combine old and new data
        writetable(combined_data, filename);  % Write the combined data back to the file
    else
        % If the file does not exist, simply write the new table to the file
        writetable(data_table, filename);
    end
end
