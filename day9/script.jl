lines = parse.(Int,readlines(joinpath(@__DIR__,"./input.txt")))

function part1(numbers::Vector{Int},preambule_length)
    for i in preambule_length+1:length(numbers)
        is_sum = false
        for j in i-preambule_length:i-1, k in i-preambule_length:i-1
            if j!=k && numbers[j]+numbers[k]==numbers[i]
                is_sum = true
                break
            end
        end
        if !is_sum
            return numbers[i]
        end
    end
end

function part2(numbers::Vector{Int},result::Int)
    for i in 1:length(numbers)
        sum = numbers[i] + numbers[i+1]
        j=i+2
        while sum < result
            sum += numbers[j]
            j+=1
        end
        if sum==result
            return minimum(numbers[i:j-1])+maximum(numbers[i:j-1])
        end
    end
end

part1(lines,25)
part2(lines,part1(lines,25))
