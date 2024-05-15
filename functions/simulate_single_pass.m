function simulate_single_pass(VehicleArgs, BridgeArgs, EnvironmentArgs, SimulationArgs)

    Train = set_train(VehicleArgs);

    A02_Track;

    Beam = set_bridge(BridgeArgs, EnvironmentArgs);

    % Set options with a predefined function
    A04_Options;
    
    if Calc.Solver.max_accurate_frq ~= SimulationArgs.freq
        Calc.Solver.max_accurate_frq = SimulationArgs.freq;
        disp("Using solver freq of " + SimulationArgs.freq + "Hz.");
    end

    % -- Model geometry --
    [Calc,Train,Beam] = B43_ModelGeometry(Calc, Train, Track, Beam);

    % -- Options Processing --
    [Calc,Train,Track,Beam] = B07_OptionsProcessing(Calc,Train,Track,Beam);

    % Elements and coordinates
    [Beam] = B01_ElementsAndCoordinates(Beam,Calc);

    % Add effect of damage
    [Beam] = set_bridge_localized_damage(Beam, BridgeArgs);

    % Run simulation
    [Sol, Model, Calc, Train, Track, Beam] = run_simulation(Train, Track, Beam, Calc);

     % Write out solution to a CSV file
     file_name = 'healthy.csv';
     if damage_factor ~= 1
         file_name = 'damaged.csv';
     end
 
     write_result(Sol, N, file_name, ...
         damage_factor, T, train_init_velocity, ET,...
         sample_number);
end

