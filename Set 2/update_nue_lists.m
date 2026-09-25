function nue_list_of_prev_head = update_nue_lists(nue_lists,prev_head,u)

for i=1:length(nue_lists(prev_head,:))
    
    if nue_lists(prev_head,i) == u
        nue_lists(prev_head,i) = 0;
        break;
    end
end

nue_list_of_prev_head = nue_lists;

end