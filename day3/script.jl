
lines = readlines(joinpath(@__DIR__,"./input.txt"))

function count_trees(lines::Vector{String},slope=(3,1))
    pos_x=1
    pos_y=1
    height = length(lines)
    width = length(lines[1])
    slope_x,slope_y=slope
    trees_number = 0
    while pos_y <= height
        @show pos_x
        @show pos_y
        if lines[pos_y][pos_x]==='#'
            trees_number+=1
            println("tree")
        end
        pos_x += slope_x
        pos_y += slope_y
        if pos_x > width
            pos_x -= width
        end
    end
    return trees_number
end

function part2(lines::Vector{String},slopes=[(1,1),(3,1),(5,1),(7,1),(1,2)])
    product = 1
    for slope in slopes
        trees_number = count_trees(lines,slope)
        product *= trees_number
    end
    return product
end

count_trees(lines)

part2(lines)
