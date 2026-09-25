function ue_list_of_prev_head = update_ue_lists(ue_lists,prev_head,edgeToBeAdded)

i = 1;
while(ue_lists(prev_head) == 0)
    ue_lists(prev_head,i) = edgeToBeAdded;
    i=i+1;
end

ue_list_of_prev_head = ue_lists(prev_head);

end