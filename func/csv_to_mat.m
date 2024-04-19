function csv_to_mat(filename)
    % Reads an hourly weather data CSV file and converts it to a .mat file.
    %
    % Input:
    %   csv_filename - The name of the CSV file to read.
    %   mat_filename - The name of the .mat file to create.

    % Read the CSV file into a table
    hourly_weather_data = readtable(strcat(filename, ".csv"));
    
    % Save the table to a .mat file
    save(filename, 'hourly_weather_data');
end
