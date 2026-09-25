function pos_sat_clause = check_2SAT(x, clauses, lit_clauses)

K = length(clauses);
pos_sat_clause = zeros(K,1);

value_of_lit1 = 0;
value_of_lit2 = 0;

for k = 1:K
    Lit1inNegation = lit_clauses(k,1);
    Lit2inNegation = lit_clauses(k,2);
    lit1 = clauses(k,1);
    lit2 = clauses(k,2);

    if ( (x(lit1)==0 & Lit1inNegation==1) | ( (x(lit1)==1 & Lit1inNegation==0) ) )
        value_of_lit1 = 1;
    end

    if ( (x(lit2)==0 & Lit2inNegation==1) | ( (x(lit2)==1 & Lit2inNegation==0) ) )
        value_of_lit2 = 1;
    end

pos_sat_clause(k) = or(value_of_lit1,value_of_lit2);

value_of_lit1 = 0;
value_of_lit2 = 0;

end


end