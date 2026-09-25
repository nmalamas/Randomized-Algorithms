function [sortedArray,comparisons] = Quick_Sort(unsortedArray,comparisons)
    counter = 0;
    array_length = length(unsortedArray);

    if array_length == 0 | array_length == 1
        sortedArray = unsortedArray;
        comparisons = counter;
        return;
    end

    % Worst case senario is that the pivot is chosen in the left-most
    % (or right-most) position of the array, thus making one of the 
    % sub-arrays n-1 positions long
    S_ltp = zeros(1,array_length - 1); % List less than pivot
    S_gtp = zeros(1,array_length - 1); % List greater than pivot
    
    piv_idx = randi(array_length);
    piv = unsortedArray(piv_idx);

    for i=1:array_length
        if (piv > unsortedArray(i))
            for j = 1:length(S_ltp)
                if (S_ltp(j) == 0)
                    S_ltp(j) = unsortedArray(i);
                    break;
                end
                continue;
            end
            counter = counter + 1;
            continue;
        elseif (piv < unsortedArray(i))
            for j = 1:length(S_gtp)
                if (S_gtp(j) == 0)
                        S_gtp(j) = unsortedArray(i);
                        break;
                end
                continue;
            end
            counter = counter + 1;
            continue;
        end
        counter = counter + 2;
    end
    
    idx_ltp = find(S_ltp);
    S_ltp = S_ltp(idx_ltp);

    idx_gtp = find(S_gtp);
    S_gtp = S_gtp(idx_gtp);
    
    [sortedLow,cmrLow] = Quick_Sort(S_ltp,comparisons);
    [sortedHigh,cmprHigh] = Quick_Sort(S_gtp,comparisons);

    sortedArray = [sortedLow piv sortedHigh];
    comparisons = cmrLow + cmprHigh + counter;
end