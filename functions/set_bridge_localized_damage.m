function Beam = set_bridge_localized_damage(Beam, BridgeArgs)
    % Reduces the n values at the specified center_location of the Beam.Prop.E_n array by a given factor.
    %
    % Input:
    %   Beam - A structure that contains the array Beam.Prop.E_n
    %   BridgeArgs - A structure containing the following fields:
        %   factor - The factor by which the dmg n values are reduced
        %   damage_num_elements - The number of values to be reduced
        %   damage_center_location - The relative center_location of the damage along the bridge length (0 to 1)
        %   damage_local - A boolean flag indicating whether the damage is localized or global

    factor = BridgeArgs.damage_factor;
    center_location = BridgeArgs.damage_center_location;
    num_elements = BridgeArgs.damage_num_elements;
    local = BridgeArgs.damage_local;
    
    N = numel(Beam.Prop.E_n);
    
    if local
        % Calculate the starting and ending indices for the dmg n values
        dmg_start = ceil(N * center_location) - ceil(num_elements / 2) + 1;
        dmg_end = dmg_start + num_elements - 1;
    
        % Ensure the indices do not exceed the array bounds
        dmg_start = max(dmg_start, 1);
        dmg_end = min(dmg_end, N);
        
    else
        disp("[WARNING]: Global damage is being applied to the bridge.")
        dmg_start = 1;
        dmg_end = N;
    end

    disp("[INFO]: Localized damage is being applied to the bridge from element " + dmg_start + " to " + dmg_end + " out of " + N + " elements.");
    disp("[INFO]: Damage factor: " + factor + " applied at " + num_elements/N*100 + "% of the bridge length.");

    % Reduce the dmg n values by factor
    Beam.Prop.E_n(dmg_start:dmg_end) = Beam.Prop.E_n(dmg_start:dmg_end) * factor;

end
