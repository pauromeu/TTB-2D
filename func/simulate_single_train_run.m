function simulate_single_train_run(damage_factor, seed)
    % Simulates the impact of weather on train infrastructure and writes the results to a CSV file.
    %
    % Input:
    %   damage_factor - The factor by which the bridge's properties are reduced to simulate damage
    %   seed - Seed for the random number generator for reproducibility


    addpath(genpath('simulation'));
    addpath(genpath('func'));

    % Set the random seed for reproducibility
    rng(seed);

    % Sample the temperature data
    T = draw_weather_sample("temp", 1, seed); % Assuming this function returns a scalar value

    % Set the number of samples for the output
    N = 10;

    % Configure the train with a predefined function
    load_path = 'property/';
    Train = configure_train('AVE_S103_ICE3', load_path, seed);
    train_init_velocity = Train.vel;

    fprintf('Simulating with train speed %.2f, temperature %.2f, and damage factor %.2f\n', ...
        train_init_velocity, T, damage_factor);


    % Configure the track with a predefined function
    A02_Track; % Assuming this script sets up the Track structure

    % Configure the bridge with temperature and random seed
    Beam = configure_bridge(T, seed);

    % Set options with a predefined function
    A04_Options; % Assuming this script sets up the Calc structure

    % -- Model geometry --
    [Calc,Train,Beam] = B43_ModelGeometry(Calc, Train, Track, Beam);

    % -- Options Processing --
    [Calc,Train,Track,Beam] = B07_OptionsProcessing(Calc,Train,Track,Beam);

    % Elements and coordinates
    [Beam] = B01_ElementsAndCoordinates(Beam,Calc);

    % Add effect of damage
    [Beam] = insert_damage(Beam, damage_factor, 2);

    % Run the simulation with a predefined function
    [Sol, Model, Calc, Train, Track, Beam] = run_simulation(Train, Track, Beam, Calc);

    % Write out solution to a CSV file
    file_name = 'healthy.csv';
    if damage_factor ~= 1
        file_name = 'damaged.csv';
    end

    write_result(Sol, N, file_name, damage_factor, T, train_init_velocity, seed);
end
