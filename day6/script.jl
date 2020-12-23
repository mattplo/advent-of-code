input = read(joinpath(@__DIR__,"./input.txt"),String)

function part1(input::String)
    sum = 0
    for group in split(input,"\n\n")
        lines = split(group,'\n',keepempty=false)
        common = union(Set.(lines)...)
        sum += length(common)
    end
    return sum
end

function part2(input::String)
    sum = 0
    for group in split(input,"\n\n")
        lines = split(group,'\n',keepempty=false)
        common = intersect(Set.(lines)...)
        sum += length(common)
    end
    return sum
end

part1(input)
part2(input)
