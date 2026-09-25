% Randomized Algorithms 2024-25 %
% --- EXERCISE 2 --- %
% Nikolaos Malamas (2020030180)

clear all; close all; clc;
%% Maximum Load in n-Balls and n-Bins experiment
k = 4;
n = 10^k;
K = 1000;
L = log(n)/log(log(n)) .* ones(1,K);
M = (3*log(n))/log(log(n)) .* ones(1,K);
max_loads = zeros(1,K);

cntr=1;
while (cntr <= K)
    max_loads(cntr) = Balls_and_Bins(n,n);
    cntr = cntr + 1;
end

K = [1:K];

figure
plot(K,L,LineWidth=2);
hold on;
plot(K,M,LineWidth=2);
hold on;
plot(K,max_loads,'LineStyle','none','Marker','o',MarkerFaceColor="#EDB120",MarkerEdgeColor="k");
grid on;
xlabel('K','FontSize',13);
ylabel('maximum loads','FontSize',13);
title('max loads for K=1000 runs of n-Balls and n-Bins experiment');
legend('lower bound(L)','upper bound(M)','max-loads');

%% Hamiltonian Cycles
n = 500;

% Step 1
p = 40*log(n)/n;
A = zeros(n,n);
for i=1:n
    for j=i+1:n
        A(i,j) = randsrc(1, 1, [1,0; p, 1-p]);
    end
end

A = A + A';

% Step 2
q = 1-sqrt(1-p);

% Create the unused edges lists, for every vertex of the random Graph
nue_lists = zeros(n,n);
nue_lists_copy = nue_lists;

% Create the used edges lists, for every vertex of the random Graph
ue_lists = zeros(n,n);

for i=1:n
    for j=i+1:n
        
        if (A(i,j) == 1)
            w = rand();
            if (w<q)
                nue_lists(i,j) = j;    
            else
                nue_lists(i,j) = j;
                nue_lists(j,i) = i;
            end
        end
    end
end

% permute unused edges list
for i = 1:n
    nue_lists(i, :) = nue_lists(i, randperm(n));  % Permute elements of row i
end

% Step 3
% (a)
HEAD = randi(n);
path = [HEAD];

isHP = true;
EXISTS = false;
POSITION = -1;

iter = 0;
while(1)
    
    %(a)
    % Convension: the HEAD of the path always last placed in the array
    %HEAD = path(end);


    % (b)
    p_i = 1/n;
    p_ii = nnz(ue_lists(HEAD))/n;
    p_iii = 1 - 1/n - nnz(ue_lists(HEAD))/n;

    execute_choice = randsrc(1, 1, [1,2,3; p_i, p_ii, p_iii]);
    
    if(execute_choice == 1)
        path = REVERSE(path);
        HEAD = path(end);
    elseif(execute_choice == 2)
        v = select_vertex_uar(ue_lists(HEAD));
        [EXISTS,POSITION] = checkIfVertexInPath(v,path);
        if(EXISTS)
            path = ROTATE(path,v,POSITION);
        end
    else
        pos_of_1st_nue_in_list = find(nue_lists(HEAD,:),1);
        u = nue_lists(HEAD,pos_of_1st_nue_in_list);        
        [EXISTS,POSITION] = checkIfVertexInPath(u,path);
        prev_head = path(end);

        EXISTS;
        % B.
        if(EXISTS == true && POSITION ~= -1 && POSITION ~= 0)
            path = ROTATE(path,u,POSITION);
            HEAD = path(end);
            
        % A.
        else
            path = [path u];
            HEAD = u;
        end

         % (c)
        nue_lists = update_nue_lists(nue_lists,prev_head,u);
        ue_lists(prev_head) = update_ue_lists(ue_lists,prev_head,u);
    end 

    iter = iter + 1;

    
    % -- Exit conditions --
    % FAIL if the unused_edges list of HEAD is EMPTY
    if(nnz(nue_lists(prev_head,:)) == 0)
        isHP = false;
        break;
    end

    % FAIL if max 2nlog(n) iterations limit is exceeded
    if(iter>2*n*log(n))
        isHP = false;
        break;
    end

    % Hamiltonian Path FOUND, if all n distinct vertices visited
    if(length(path)==n)
        isHP = pathHamCheck(path);
        break;
    end

end

isHC = true;
iter2 = 0;
while(isHP)

    %(a)
    % Convension: the HEAD of the path always last placed in the array

    % (b)
    execute_choice = randsrc(1, 1, [1,2,3; 1/n, nnz(ue_lists(HEAD))/n, 1 - 1/n - nnz(ue_lists(HEAD))/n]);

    if(execute_choice == 1)
        path = REVERSE(path);
        HEAD = path(end);
    elseif(execute_choice == 2)
        v = select_vertex_uar(ue_lists(HEAD));
        [EXISTS,POSITION] = checkIfVertexInPath(v,path);
        if(EXISTS)
            path = ROTATE(path,v,POSITION);
        end
    else
        u = nue_lists(HEAD,find(nue_lists(HEAD,:),1));        
        [EXISTS,POSITION] = checkIfVertexInPath(u,path);
        prev_head = path(end);

        % A.
        if(~EXISTS)
            HEAD = u;
            path = [path HEAD];
        % B.
        else
            if(POSITION == n-1)                
                % Perform the rotation that step (B) as the algorithm 
                % suggests,  as in any other iteration
                path = ROTATE(path,u,POSITION);
                HEAD = path(end);
                isHC = true;
                break;
            end

            path = ROTATE(path,u,POSITION);
            HEAD = path(end);
        end

        % (c)
        nue_lists = update_nue_lists(nue_lists,prev_head,u);
        ue_lists(prev_head) = update_ue_lists(ue_lists,prev_head,u);
    end 

    iter2 = iter2 + 1;

    % -- Exit conditions --
    % FAIL if the unused_edges list of HEAD is EMPTY
    if(nnz(nue_lists(prev_head,:)) == 0)
        isHC = false;
        break;
    end

    % FAIL if max 2nlog(n) iterations limit is exceeded
    if(iter2>n*log(n))
        isHC = false;
        break;
    end

end

% HC verification
verifyHC(path,u);