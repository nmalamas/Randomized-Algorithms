function empty_bins = m_Balls_n_Bins(numOfBalls,numOfBins)
empty_bins = numOfBins;
bins = zeros(1,numOfBins);

while (numOfBalls ~= 0)
    bin_id = randi(numOfBins);
    bins(bin_id) = bins(bin_id) + 1;

    numOfBalls = numOfBalls - 1;
end

for i = 1:numOfBins
    if bins(i) ~= 0
        empty_bins = empty_bins - 1;
    end
end

end