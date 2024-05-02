function Train = configure_train(option, load_path, load_factor)
    % CONFIGURE_TRAIN Function to set up train configurations dynamically
    % with velocity drawn from a truncated normal distribution.
    % Input:
    %   option - A string specifying the type of train configuration.
    %   load_path - Path to the directory containing train configuration files.

    % Draw a sample from a normal distribution with mean 160 and std 3
    velocity = normrnd(160, 3);
    % Truncate between 150 and 170 (min/max allowed velocity)
    velocity = min(max(velocity, 150), 170); 
    Train.vel = velocity / 3.6;

    Train.Load.path = load_path;
    
    base_load = 42100;
    mean_vehicle_load = base_load * (1+load_factor/100);

    % Initialize the vehicle setup based on the option
    switch option
        case 'Manchester_Benchmark'
            for veh_num = 1:3
                run(fullfile(Train.Load.path, 'TrainProp_Manchester_Benchmark'));
            end
            
        case 'AVE_S103_ICE3'
            config_files = {'TrainProp_AVE_S103_ICE3_Velaro_E_C1', ...
                            'TrainProp_AVE_S103_ICE3_Velaro_E_C2367', ...
                            'TrainProp_AVE_S103_ICE3_Velaro_E_C2367', ...
                            'TrainProp_AVE_S103_ICE3_Velaro_E_C45', ...
                            'TrainProp_AVE_S103_ICE3_Velaro_E_C45', ...
                            'TrainProp_AVE_S103_ICE3_Velaro_E_C2367', ...
                            'TrainProp_AVE_S103_ICE3_Velaro_E_C2367', ...
                            'TrainProp_AVE_S103_ICE3_Velaro_E_C8'};
            total_mass = 0;
            for veh_num = 1:length(config_files)
                run(fullfile(Train.Load.path, config_files{veh_num}));
                % Set the velocity for all vehicles
                Train.Veh(veh_num).vel = Train.vel;

                % Draw a sample from a normal distribution with mean 
                % mean_vehicle_load (47800) and std 500 with min 42100 and max
                % 53500
                mass = normrnd(mean_vehicle_load, 500);
                vehical_mass = min(max(mass, base_load), 53500);
                total_mass = total_mass + vehical_mass;
                Train.Veh(veh_num).Body.m = vehical_mass;  
            end
            Train.TotalVariableMass = total_mass - base_load * veh_num;
            
        case 'Eurostar'
            % Add cases for Eurostar, Chinese Star, etc., as per the original script
            % TODO: add train configs
            error('Train configuration %s has not yet been refactored', option);

        otherwise
            error('Unsupported train configuration option: %s', option);
    end
end
