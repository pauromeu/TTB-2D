function simulate_single_pass(VehicleArgs, BridgeArgs, EnvironmentArgs, SimulationArgs)

    Train = set_train(VehicleArgs);

    A02_Track;

    Beam = set_bridge(BridgeArgs, EnvironmentArgs);

    % Set options with a predefined function
    A04_Options;

    % -- Model geometry --
    [Calc,Train,Beam] = B43_ModelGeometry(Calc, Train, Track, Beam);

    % -- Options Processing --
    [Calc,Train,Track,Beam] = B07_OptionsProcessing(Calc,Train,Track,Beam);

    % Elements and coordinates
    [Beam] = B01_ElementsAndCoordinates(Beam,Calc);

    % Add effect of damage
    [Beam] = set_bridge_localized_damage(Beam, BridgeArgs);


end

