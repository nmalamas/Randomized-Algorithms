% Randomized Algorithms 2024-25 %
% --- EXERCISE 4 --- %
% Nikolaos Malamas (2020030180)

clear all; close all; clc;
%% Johnson-Lindenstrauss Lemma
d = 10000;
m = 50; % m data points/vectors

% Step 1
X = randn(d,m);

% Step 2
numOfpwDist = (m*(m-1))/2;
pw_dist = zeros(1,numOfpwDist);

for i = 1:m-1
    for j = i+1:m
        dist = X(:,i) - X(:,j);
        pw_dist((i-1)*m+j) = norm(dist);
    end
end

% Step 3
epsilon = 0.1;
delta = 0.1;
Q_card = numOfpwDist;

n = round((6*log((2*Q_card)/delta))/epsilon^2);

% Step 4
W = randn(n,d)*sqrt(1/n);

Y = W*X;

% Step 5
numOfpwDist_reduced = (m*(m-1))/2;
pw_dist_red = zeros(1,numOfpwDist_reduced);

for i = 1:m-1
    for j = i+1:m
        dist = X(:,i) - X(:,j);
        pw_dist_red((i-1)*m+j) = norm(dist);
    end
end

% Step 6
dist_X_plus_epsilon = sqrt(1+epsilon)*pw_dist;
dist_X_minus_epsilon = sqrt(1-epsilon)*pw_dist;
dist_Y = pw_dist_red;


figure
plot(dist_X_minus_epsilon,".");
hold on;
plot(dist_X_plus_epsilon,".");
hold on;
plot(dist_Y,".");
hold off;
grid on;
legend({'$\sqrt(1+\epsilon)||X(:,i)-X(:,j)||$', '$\sqrt(1-\epsilon)||X(:,i)-X(:,j)||$','$||Y(:,i)-Y(:,j)||$'}, 'Interpreter', 'latex');
title('Pair-wise distances of the compressed and recovered data vectors');
ylim([120 160]);

% Step 7
JL_pairs = 0;

for i = 1:numOfpwDist
    if (dist_X_minus_epsilon(:,i) <= dist_Y(:,i) & dist_Y(:,i) <= dist_X_plus_epsilon(:,i))
        JL_pairs = JL_pairs + 1;
    end
end 

prob = JL_pairs/numOfpwDist;
fprintf('Empirical Probability of Success = %4.2f\n',prob);

%% 2-SAT algorithm
K = 5000;
n = 10000; % and >=K
m = 1;

% Step 1
% Generate the K random DIFFERENT pairs
numbers = 1:n;
allPairs = nchoosek(numbers, 2);
numPairs = K; % Specify how many random pairs

% Randomly select without replacement
clauses = allPairs(randperm(size(allPairs, 1), numPairs), :);

% Step 2
s = zeros(1,n);

for i = 1:n
    s(i) = round(rand);
end

% Step 3
lit_clauses = zeros(K,2);

for k=1:K
    i1 = clauses(k,1);
    i2 = clauses(k,2);

    chooseBV = randi([1,2]);
    if (chooseBV == 1)
        i = i1;
    else
        i = i2;
    end

    if (s(i) == 0)
        lit_clauses(k,chooseBV) = 1;
    end
end

% Arbitrary truth assignment
x = round(rand(n,1));

isSatisfiable=0;
iters = 0;    
while(iters <= 2*m*(n^2))
    idx_satisfy = check_2SAT(x,clauses,lit_clauses);

    if sum(idx_satisfy) ~= K
        for k=1:K
           % a
           if idx_satisfy(k) == 0
              % b
              i = randi([1,2]);
              varToFlip = clauses(k,i);
              x(varToFlip) = not(x(varToFlip));
              break;
           end
        end
    else
        isSatisfiable = 1;
        iters = iters+1;
        break;
    end

    iters = iters+1;
end

%% 3-SAT algorithm
K = 500;
n = 1000; % and >=K
m = 1;

% Step 1
% Generate the K random DIFFERENT pairs
numbers = 1:n;
allPairs = nchoosek(numbers, 3);
numPairs = K; % Specify how many random 3-tuples

% Randomly select without replacement
clauses = allPairs(randperm(size(allPairs, 1), numPairs), :);

% Step 2
s = zeros(1,n);

for i = 1:n
    s(i) = round(rand);
end

% Step 3
lit_clauses = zeros(K,3);

for k=1:K
    i1 = clauses(k,1);
    i2 = clauses(k,2);
    i3 = clauses(k,3);

    chooseBV = randi([1,2]);
    if (chooseBV == 1)
        i = i1;
    elseif (chooseBV == 2)
        i = i2;
    else
        i = i3;
    end

    if (s(i) == 0)
        lit_clauses(k,chooseBV) = 1;
    end
end

% Arbitrary truth assignment
x = round(rand(n,1));

isSatisfiable=0;
iters = 0;    
while(iters <= 2*m*(n^2))
    idx_satisfy = check_3SAT(x,clauses,lit_clauses);

    if sum(idx_satisfy) ~= K
        for k=1:K
           % a
           if idx_satisfy(k) == 0
              % b
              i = randi([1,3]);
              varToFlip = clauses(k,i);
              x(varToFlip) = not(x(varToFlip));
              break;
           end
        end
    else
        isSatisfiable = 1;
        iters = iters+1;
        break;
    end

    iters = iters+1;
end