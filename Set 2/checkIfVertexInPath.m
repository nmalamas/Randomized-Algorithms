function [EXISTS,positionBehindHEAD] = checkIfVertexInPath(vertex,path)
HEAD = path(end);
EXISTS = false;

positionBehindHEAD = 0;
for i=length(path):-1:1
    if(path(i) == vertex)
        EXISTS = true;
        break;
    end
    positionBehindHEAD = positionBehindHEAD+1;
end

% if vertex NOT found in the path, return invalid position
if(positionBehindHEAD == length(path))
    positionBehindHEAD = -1;
end

end