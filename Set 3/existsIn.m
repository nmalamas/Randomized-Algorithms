function exists = existsIn(array,vertex)
exists = false;

for i=1:length(array)
    if array(i) == vertex
        exists = true;
    end
end
% exists = (array(1,:) == vertex);
end