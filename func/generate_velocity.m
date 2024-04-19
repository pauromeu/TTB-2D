function velocity = generate_velocity(mu, sigma, min_val, max_val)
    % GENERATE_VELOCITY Generates a velocity from a truncated normal distribution
    % Input:
    %   mu - Mean of the normal distribution
    %   sigma - Standard deviation of the normal distribution
    %   min_val - Minimum value for truncation
    %   max_val - Maximum value for truncation
    %
    % Output:
    %   velocity - A single sample from the truncated normal distribution

    while true
        % Draw a sample from a normal distribution
        velocity = normrnd(mu, sigma);
        
        % Check if the sample is within the bounds
        if velocity >= min_val && velocity <= max_val
            break;  % If within bounds, accept the sample
        end
        % If not, loop will continue and draw another sample
    end
end