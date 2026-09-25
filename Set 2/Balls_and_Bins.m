function [max_load] = Balls_and_Bins(numOfBalls,numOfBins)
max_load = 0;

% Each array position holds the total number of balls thrown in the bin
bins = zeros(1,numOfBins);

% 1 in each ball position, indicating the existence of the ball
% 0 in the same position for inexistence (selection without replacement)
balls = zeros(1,numOfBalls);

for k=1:numOfBalls
    %ball_thrown = balls(k);
    %balls(k) = 0;

    throw_in_bin = randi(numOfBins);
    bins(throw_in_bin) = bins(throw_in_bin) + 1;
end

max_load = max(bins);

end