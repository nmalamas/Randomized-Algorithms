function isHP = pathHamCheck(path)
isHP = true;

[unique_elements, ~, indices] = unique(path);
repeated_indices = find(histcounts(indices, 1:max(indices)+1) > 1);

if length(repeated_indices) ~= 0
    isHP = false;
end

end