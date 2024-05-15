function save_result(Sol, FileArgs, BridgeArgs, VehicleArgs, SimulationArgs, EnvironmentArgs)
    
    file_name = FileArgs.file_name;
    simulation_date = FileArgs.date;
    sample_number = FileArgs.sample_number;
    
    num_sensors = BridgeArgs.num_sensors;
    damage_factor = BridgeArgs.damage_factor;
    damage_center_location = BridgeArgs.damage_center_location;
    temperature_C = EnvironmentArgs.temperature_C;
    train_init_velocity = VehicleArgs.velocity_m_s;
    train_load = VehicleArgs.load_base_kg;
    stiffness = BridgeArgs.stiffness;
    fs = SimulationArgs.freq;

    u_sample = 1000*sample_solution(Sol.Beam.U.xt, num_sensors); % displacement in mm
    acc_sample = sample_solution(Sol.Beam.Acc.xt, num_sensors);

    length = size(u_sample, 2);  % Assuming u_sample is (n x m) where n is the number of samples

    date = datetime(simulation_date, 'Format', 'yyyy-MM-dd HH:mm:ss.SSSS');
    time_vector = date + seconds((0:(length-1)).' / fs);

    if sample_number == -1
        if exist(file_name, 'file')
            opts = detectImportOptions(file_name);
            existing_data = readtable(file_name, opts);
            sample_number = max(existing_data.SampleNumber) + 1;
        else
            sample_number = 1;
        end
    end

    combined_data = [
        u_sample; 
        acc_sample; 
        repmat(damage_factor, 1, length);
        repmat(damage_center_location, 1, length);
        repmat(temperature_C, 1, length);
        repmat(train_init_velocity, 1, length);
        repmat(train_load, 1, length);
        repmat(stiffness, 1, length);
        repmat(sample_number, 1, length);
        repmat(fs, 1, length);
    ];

    % Create variable names for each u_sample variable
    u_sample_var_names = strcat("disp_", string(1:num_sensors));
    acc_sample_var_names = strcat("acc_", string(1:num_sensors));

    variable_names = [u_sample_var_names, acc_sample_var_names,...
    "DamageFactor", "DamageRelativeLocation", "Temperature", "TrainInitVelocity", ...
    "TrainLoad", "Stiffness", "SampleNumber", "OriginalSamplingFrequency"];

    transposed_data = combined_data.';

    % Create the table with dynamically created variable names
    data_table = array2table(transposed_data, 'VariableNames', variable_names);

    data_table.time = time_vector;

    % Check if the file exists
    if exist(file_name, 'file')
        % If the file exists, read the existing data and append the new data
        opts = detectImportOptions(file_name);  % Get import options that match the file structure
        existing_data = readtable(file_name, opts);  % Read existing data with the same structure
        combined_data = [existing_data; data_table];  % Combine old and new data
        writetable(combined_data, file_name);  % Write the combined data back to the file
    else
        writetable(data_table, file_name);
    end
end