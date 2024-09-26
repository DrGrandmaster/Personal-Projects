%% This script simulates the "Frog Problem"

% Number of simulations
Q = 1e3;

% Number of lilypads
N = parallel.pool.Constant(1:100);
lengthN = length(N.Value);

% Q=1e3 times lengthN=100 takes 6.3 sec to run w/ R7 5800X, keep in mind

% Vector for exp results
j = zeros(Q,length(N.Value));

% Simulation loop
parfor i=1:Q

    % For every numer of lilypads we are looking at
    for k=1:lengthN

        % Start at 0 jumps
        j(i, k) = 0;
    
        % Start on left bank
        pad = 0;
    
        % While not on right bank
        while(pad < N.Value(k))
    
            % Add one to jump count
            j(i, k) = j(i, k) + 1;
    
            % Jump with equal likelyhood to any pad between current pos and end
            pad = pad + randi(N.Value(k) - pad);
    
        end

    end

end

clear i k lengthN pad;

% Stats
avgJ = mean(j);

stem(avgJ);
xlim([0, length(avgJ)+1]);
ylim padded;
title("Expected Number of Jumps and Average Number of Jumps vs. Number of Lily Pads");
xlabel("Number of Lily Pads");
ylabel("Number of Jumps");

hold on;
plot(harmonic(1:length(avgJ)));
legend(["Average Number of Jumps" "Expected Number of Jumps"], 'Location', 'northwest');
hold off;