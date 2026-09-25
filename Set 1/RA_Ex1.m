% Randomized Algorithms 2024-25 %
% --- EXERCISE 1 --- %
% Nikolaos Malamas (2020030180)

clc; close all; clear all;

%% Coupon Collector
K = 500;
n = 100;

%iter = Coupon_Collector(n)
selections = zeros(1,K);
for k = 1 : K
    selections(k) = Coupon_Collector(n);
end

E_X = (sum(selections)/K) .* ones(1,K);
k = [1:K];

figure
plot(k,selections);
hold on;
plot(E_X);
hold on;
xlabel('k','FontSize',13);
ylabel('#iterations','FontSize',13);
legend('#iterations','avg iterations');
axis tight;
grid on;
title('Iterations needed for all the n coupons to be collected');

figure
histogram(selections');
xlabel('#iterations','FontSize',13);
grid on;
title('Iterations needed for all the n coupons to be collected');

%% QuickSort
K = 500;
n = 2^10;
max_no = 1000000;
iterations = zeros(1,K);
sorted_list = zeros(1,n);

total_comparisons = size(1, K);
for k = 1:K
    cmpr = 0;
    list = randperm(max_no,n);
    [sorted_list,total_comparisons(k)] = Quick_Sort(list,cmpr);
end

avg_comparisons = (sum(total_comparisons)/K) .* ones(1,K);
k = [1:K];

figure
plot(k,total_comparisons);
hold on;
plot(avg_comparisons);
hold on;
xlabel('k','FontSize',13);
ylabel('#comparisons','FontSize',13);
legend('#comparisons','avg comparisons');
axis tight;
grid on;
title('Comparisons made between the pivots chosen and the elements of the sub-arrays');

figure
histogram(total_comparisons');
xlabel('#comparisons','FontSize',13);
grid on;
title('Comparisons made between the pivots chosen and the elements of the sub-arrays');

%% Randomized Median
cmpr = zeros(1,length(n));
rand_mean = zeros(1,length(n));
c = 1;

for n = 200 : 200 : 10000
    [rand_mean(c),cmpr(c)] = Randomized_Median(n);
    while (rand_mean == 0) 
        [rand_mean(c),cmpr(c)] = Randomized_Median(n);
    end
    c = c + 1;
end

n = [200 : 200 : 10000];

figure
plot(n,cmpr);
xlabel('n','FontSize',13);
ylabel('#comparisons','FontSize',13);
axis tight;
grid on;
title('Comparisons completed during the execution of the Randomized Median alg');

% Code for exporting the randomized medians to latex

% Open a text file to write LaTeX code
fid = fopen('matrixTable.tex', 'wt');

% Write the LaTeX table structure
fprintf(fid, '\\begin{tabular}{|c|c|c|}\n');
fprintf(fid, '\\hline\n');
for i = 1:size(rand_mean, 1)
    fprintf(fid, '%d & %d & %d \\\\\n', rand_mean(i, :));
    fprintf(fid, '\\hline\n');
end
fprintf(fid, '\\end{tabular}\n');

% Close the file
fclose(fid);
