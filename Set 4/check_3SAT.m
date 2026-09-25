function pos_sat_clause = check_3SAT(x, clauses, lit_clauses)

K = length(clauses);
pos_sat_clause = zeros(K,1);

value_of_lit1 = 0;
value_of_lit2 = 0;
value_of_lit3 = 1;

for k = 1:K
    if ( (lit_clauses(k,1)==1 & x(clauses(k,1))==0 ) | ( (lit_clauses(k,1)==0 & x(clauses(k,1))==1) ) )
        value_of_lit1 = 1;
    end

    if ( (lit_clauses(k,2)==1 & x(clauses(k,2))==0 ) | ( (lit_clauses(k,2)==0 & x(clauses(k,2))==1) ) )
        value_of_lit2 = 1;
    end

    if ( (lit_clauses(k,3)==1 & x(clauses(k,3))==0 ) | ( (lit_clauses(k,3)==0 & x(clauses(k,3))==1) ) )
        value_of_lit3 = 1;
    end

pos_sat_clause(k) = or(value_of_lit1,or(value_of_lit2,value_of_lit3));

value_of_lit1 = 0;
value_of_lit2 = 0;
value_of_lit3 = 0;

end


end