lines = parse.(Int,readlines(joinpath(@__DIR__,"./input.txt")))

function part1(input::Vector{Int})
    joltages = push!(copy(input),0)
    sort!(joltages)
    count_diff = [0,0,1]
    for i in 2:length(joltages)
        diff = joltages[i]-joltages[i-1]
        count_diff[diff]+=1
    end
    @show count_diff
    return count_diff[1]*count_diff[3]
end

function check_possibilities(input::Vector{Int})
    joltages = push!(copy(input),0)
    sort!(joltages)
    combinations_from_index = zeros(Int,length(joltages))
    combinations_from_index[length(joltages)]=1
    for index in length(joltages)-1:-1:1
        @show index
        for j in 1:3
            if index+j<=length(joltages) && joltages[index+j]-joltages[index]<=3
                @show j
                combinations_from_index[index] += combinations_from_index[index+j]
            end
        end
    end
    @show combinations_from_index
    return combinations_from_index[1]
end


part1(lines)
check_possibilities(lines)
