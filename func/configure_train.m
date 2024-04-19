function Train = configure_train(option, load_path, seed)
    % CONFIGURE_TRAIN Function to set up train configurations dynamically
    % with velocity drawn from a truncated normal distribution.
    % Input:
    %   option - A string specifying the type of train configuration.
    %   load_path - Path to the directory containing train configuration files.
    %   seed - Seed for the random number generator to ensure reproducibility.

    % Set the seed for reproducibility
    rng(seed);

    % Draw a sample from a normal distribution with mean 160 and std 3
    velocity = normrnd(160, 3);
    % Truncate between 150 and 170 (min/min allowed velocity)
    Train.vel = min(max(velocity, 150), 170);  

    Train.Load.path = load_path;

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
            for veh_num = 1:length(config_files)
                run(fullfile(Train.Load.path, config_files{veh_num}));
                % Set the velocity for all vehicles
                Train.Veh(veh_num).vel = Train.vel;

                % Draw a sample from a normal distribution with mean 47800
                % and std 500
                mass = normrnd(47800, 500);
                Train.Veh(veh_num).Body.m = min(max(mass, 42100), 53500);  
            end
            
        case 'Eurostar'
            % Add cases for Eurostar, Chinese Star, etc., as per the original script
            % TODO: add train configs
            error('Train configuration %s has not yet been refactored', option);

        otherwise
            error('Unsupported train configuration option: %s', option);
    end
end
