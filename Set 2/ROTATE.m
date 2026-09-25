function roated_path = ROTATE(path, rotating_edge, positionsBehindHEAD)

%if path(end-positionsBehindHEAD+1) ~= path(end-1)
if positionsBehindHEAD ~= 0 && positionsBehindHEAD ~= 1 
    endOfPath = flip(path(end-positionsBehindHEAD+1:end-1));
    roated_path = [path(1:end-positionsBehindHEAD) path(end) endOfPath];
else
    %endOfPath = path(end-1);
    roated_path = path;
end



end