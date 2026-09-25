function [median,cmpr] = Randomized_Median(n)
cmpr = 0;
FAIL = 0;
max_key = 100000;
l_d = 0;
l_u = 0;

S = randi(max_key,1,n);

R_samples = ceil(n^(3/4));
R = zeros(1,R_samples);

% Step 1
for r = 1:R_samples
    sample_idx = randi(n);
    R(r) = S(sample_idx);
end

% Step 2
R_sorted = Quick_Sort(R,0);

d_idx = floor((1/2)*n^(3/4) - sqrt(n));
u_idx = ceil((1/2)*n^(3/4) + sqrt(n));

d = R_sorted(d_idx);
u = R_sorted(u_idx);

% Step 3
for s = 1:length(S)
    if (d <= S(s) && S(s) <= u)
        cmpr = cmpr + 2;
        continue;
    elseif (S(s) < d)
        l_d = l_d + 1;
        cmpr = cmpr + 1;
        S(s) = 0;
    else
        l_u = l_u + 1;
        cmpr = cmpr + 1;
        S(s) = 0;
    end
end

C_idx = find(S);
C = S(C_idx);

% Step 4
if (l_d > (n/2) || l_u > (n/2))
    cmpr = cmpr + 1;
    if (l_d > (n/2) && l_u > (n/2))
        cmpr = cmpr + 1;
    end
    median = FAIL;
    return;
end

% Step 5
if (length(C) <= 4*n^(3/4))
    cmpr = cmpr + 1;
    C_sorted = Quick_Sort(C,0);
else
    median = FAIL;
    cmpr = cmpr + 1;
    return;
end

% Step 6
median = floor(n/2) - l_d + 1;

end