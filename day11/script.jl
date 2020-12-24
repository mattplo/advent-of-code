lines = readlines(joinpath(@__DIR__, "./input.txt"))

grid = permutedims(reduce(hcat, collect.(lines)))

function neighbours_occupied(grid::Array{Char,2}, x::Int, y::Int)
    cnt = 0
    for x_shift = -1:1, y_shift = -1:1
        if x_shift != 0 || y_shift != 0
            if checkbounds(Bool, grid, x + x_shift, y + y_shift) &&
               grid[x+x_shift, y+y_shift] == '#'
                cnt += 1
            end
        end
    end
    return cnt
end

function neighbours_occupied2(grid::Array{Char,2}, x::Int, y::Int)
    cnt = 0
    for x_shift = -1:1, y_shift = -1:1
        if x_shift != 0 || y_shift != 0
            i, j = x + x_shift, y + y_shift
            while checkbounds(Bool, grid, i, j) && grid[i, j] == '.'
                i, j = i + x_shift, j + y_shift
            end
            if checkbounds(Bool, grid, i, j) && grid[i, j] == '#'
                cnt += 1
            end
        end
    end
    return cnt
end

function step_seats(grid::Array{Char,2}, tolerance::Int, count_neighbors::Function)
    new_grid = copy(grid)
    occupied_seats = 0
    changes = false
    for i = 1:size(grid, 1), j = 1:size(grid, 2)
        if grid[i, j] != '.'
            occ = count_neighbors(grid, i, j)
            if grid[i, j] == '#' && occ >= tolerance
                new_grid[i, j] = 'L'
                changes = true
            elseif grid[i, j] == 'L' && occ == 0
                new_grid[i, j] = '#'
                occupied_seats += 1
                changes = true
            elseif grid[i, j] == '#'
                occupied_seats += 1
            end
        end
    end
    return (new_grid, occupied_seats, changes)
end

function reach_equilibrium(grid::Array{Char,2}, tolerance::Int, count_neighbors::Function)
    new_grid = copy(grid)
    while true
        new_grid, occupied_seats, changes = step_seats(new_grid, tolerance, count_neighbors)
        # display("text/plain", new_grid)
        if !changes
            return occupied_seats
        end
    end
end

reach_equilibrium(grid, 4, neighbours_occupied)
reach_equilibrium(grid, 5, neighbours_occupied2)
