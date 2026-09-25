function verifyHC(path,u)

frst_element = path(1);
HEAD = path(end);

% Check for unique vertices
[unique_elements, ~, indices] = unique(path);
repeated_indices = find(histcounts(indices, 1:max(indices)+1) > 1);

if length(repeated_indices) ~= 0
    disp('There are \033[31mduplicated\033[0m vertices.\n');
    fprintf('NOT an HC\n');
else
    fprintf(':There are n distinct vertices in the path.\n');
    
    if frst_element == u
        fprintf(':The first and last vertices of the path match!\n')
        fprintf('> The given HP, is indeed an HC!\n');
    end
end

end