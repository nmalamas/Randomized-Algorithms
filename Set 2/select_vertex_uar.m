function vertex_chosen = select_vertex_uar(ue_list)

idx = randi(length(ue_list));
while(ue_list(idx) == 0)
    idx = randi(length(ue_list));
end

vertex_chosen = idx;
end

