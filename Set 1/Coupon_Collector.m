function [iterations] = Coupon_Collector(n)
    max_coupon_no = 100000000;
    iterations = 0;
    coupons_collected = zeros(1,n);

    % Now create n different coupons in the range [1,max_coupon_no]
    available_coupons = randi(max_coupon_no, 1, n);

    term_num = 0;
    while term_num ~= n
        idx = randi(n);
        if available_coupons(idx) ~= 0
            for i = 1:n
                if(coupons_collected(i) ~= available_coupons(idx) ...
                        && coupons_collected(i) ~= 0 )
                    continue;
                end
                coupons_collected(i) = available_coupons(idx);
                available_coupons(idx) = 0;
                break;                
            end
         end

        iterations = iterations+1;

        % Count the non-zero elements of the collected coupons array
        % If all coupons collected, n is returned by nnz(),
        % terminating the outter-most loop
        term_num = nnz(coupons_collected);
    end
end