function [A,B] = iuar_assign_vertices(n)
A = [];
B = [];

while(n ~= 0)
    set = randi(2);
    if set == 1
        A = [A n];
        n = n-1;
        continue;
    end
    B = [B n];
    n = n-1;
end


end
