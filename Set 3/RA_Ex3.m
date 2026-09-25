% Randomized Algorithms 2024-25 %
% --- EXERCISE 3 --- %
% Nikolaos Malamas (2020030180)

clear all; close all; clc;
%% Max-Cut
n = 100;
p = 0.01;

G = zeros(n,n);
edges = 0;
E = [];

for i=1:n
    for j=i+1:n
        G(i,j) = randsrc(1, 1, [1,0; p, 1-p]);
        if ( G(i,j) == 1 )
            edges = edges + 1;
            E = [E i j];
        end
    end
end

G = G + G';

% 1. 
% Create the Gn,p graph
iters = 1;
while (iters <= edges/2 + 1)
    [A,B] = iuar_assign_vertices(n);
    X = zeros(1,edges);
    for i=0:2:length(E)-2
        if existsIn(A,E(i+1)) & existsIn(B,E(i+2)) | existsIn(A,E(i+2)) & existsIn(B,E(i+1))
            X(ceil(i/2)+1) = 1;
        end
    end

    cut = sum(X);
    if cut >= edges/2
        fprintf('C(A,B)= %d\n',cut);
        fprintf('m = %d\n',edges);
        fprintf('m/2 + 1 = %4.2f\n',edges/2 + 1);
        fprintf('Samples(iterations) = %d\n',iters);
        fprintf('==============================\n');
        break;
    end

iters = iters + 1;
end

%%
% 2. Deterministic Large-Cut
% Create the Gn,p graph
A = [1];
B = [];
cur_vertex = 2;
cut = 0;
cur_v_neighbors = [];
a_neighbors = 0;
b_neighbors = 0;
alt = 1;

while (cur_vertex ~= n+1)
    cur_v_neighbors = findNeighbors(G,cur_vertex);
    
    for i=1:length(cur_v_neighbors)
        if existsIn(A,cur_v_neighbors(i))
            a_neighbors = a_neighbors + 1;
        elseif existsIn(B,cur_v_neighbors(i))
            b_neighbors = b_neighbors + 1;
        end
    end

    if a_neighbors >= b_neighbors
        B = [B cur_vertex];
    else
        A = [A cur_vertex];
    end

    a_neighbors = 0;
    b_neighbors = 0;
    cur_v_neighbors = [];
    cur_vertex = cur_vertex + 1;
end

for a = A(1:end)
    for b = B(1:end)
        if G(a,b) == 1
            cut = cut + 1;
        end
    end
end

%% m-Balls and n-Bins
m = 500;
n = 1000;
K = 10^4;

n_min = 0;
n_max = n-1;

empty_bins = zeros(1,K);
for k = 1:K
    empty_bins(k) = m_Balls_n_Bins(m,n);
end

stat_mean = n*(1-1/n)^m;
arithm_mean = sum(empty_bins)/K;

fprintf('Arithmetic mean = %4.4f\n',sum(empty_bins)/K);
fprintf('Statistical mean = %4.4f\n',stat_mean);
fprintf('==============================\n');

n = [n_min+1:n_max+1];

figure
histogram(empty_bins,n,'FaceColor','k');
grid on;
title('Histogram of empty bins in the interval [n_{min}:n_{max}]','FontSize',15);
xlabel('number of empty bins');
hold on;
mean_point = stat_mean;
y_point = 0;
line([mean_point mean_point], ylim, 'Color', 'r', 'LineWidth', 2, 'LineStyle', ':');
text(mean_point, max(ylim), 'Statistical Mean', 'FontSize', 15 ,'Color', 'r', ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'top');
ax = gca;
ax.FontSize = 14;

hold on;
epsilon = sqrt(m);
concetration_bound = 2*exp((-2*epsilon^2)/m);
line([mean_point-epsilon mean_point-epsilon], ylim, 'Color', '#D95319', 'LineWidth', 2, 'LineStyle', ':');
line([mean_point+epsilon mean_point+epsilon], ylim, 'Color', '#D95319', 'LineWidth', 2, 'LineStyle', ':');
hold off;

fprintf('epsilon = %4.4f\n',epsilon);