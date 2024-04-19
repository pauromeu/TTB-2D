function write_result( ...
    Sol, n, filename, ...
    damage_factor, T, train_init_velocity, sample_number)
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
    
    % Prepare the data to be written - concatenate vertically
    combined_data = [
        u_sample; 
        acc_sample; 
        repmat(damage_factor, 1, size(u_sample, 2));
        repmat(T, 1, size(u_sample, 2));
        repmat(train_init_velocity, 1, size(u_sample, 2));
        repmat(sample_number, 1, size(u_sample, 2));
    ];
    
    % Check if the CSV file exists
    if exist(filename, 'file')
        % File exists, append the data vertically (without headers)
        writematrix(combined_data.', filename, 'WriteMode', 'append', 'Delimiter', ',');
    else
        % File does not exist, write the data with headers
        headers = [strcat("disp(mm)_sample", string(1:size(u_sample, 1))), ...
                   strcat("acc_sample", string(1:size(acc_sample, 1))), ...
                   "damage_factor", "temperature", "train_init_velocity", "sample_number"].';
        % Create a full matrix including headers
        full_data = [headers, num2cell(combined_data)].';
        % Write to file with headers
        writematrix(full_data, filename);
    end
end
