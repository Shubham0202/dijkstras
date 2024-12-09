function [distances, predecessors] = dijkstra(graph, source)
    n = size(graph, 1);
    distances = ones(1, n) * %inf;
    visited = zeros(1, n);
    predecessors = -ones(1, n);
    distances(source) = 0;
    for count = 1:n
        [minDist, u] = min(distances .* (1 - visited)); 
        if minDist == %inf then
            break;
        end
        visited(u) = 1;
        for v = 1:n
            if graph(u, v) > 0 & ~visited(v) then
                alt = distances(u) + graph(u, v);
                if alt < distances(v) then
                    distances(v) = alt;
                    predecessors(v) = u;
                end
            end
        end
    end
end

function printPath(predecessors, source, destination)
    if source == destination then
        disp(source);
    elseif predecessors(destination) == -1 then
        disp("No path exists.");
    else
        printPath(predecessors, source, predecessors(destination));
        disp(" -> " + string(destination));
    end
end

graph = [
    0  10  0   0   0  0;
    10  0  5   0   0  0;
    0   5  0   2   1  0;
    0   0  2   0   0  3;
    0   0  1   0   0  6;
    0   0  0   3   6  0
];

source = 1;
[distances, predecessors] = dijkstra(graph, source);

disp("Shortest distances from vertex " + string(source) + ":");
disp(distances);

disp("Paths from source:");
for i = 1:size(graph, 1)
    disp("Path to vertex " + string(i) + ": ");
    printPath(predecessors, source, i);
    disp("");
end