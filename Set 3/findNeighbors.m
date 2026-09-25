function neighbors_list = findNeighbors(G,cur_vertex)

neighbors_list = [];

for i = 1 : length(G(cur_vertex,:))
    if (G(cur_vertex,i) == 1)
        neighbors_list = [neighbors_list i];
    end
end

end