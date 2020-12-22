
lines = readlines(joinpath(@__DIR__, "./input.txt"))

int_list = parse.(Int,lines)

sort!(int_list)

function part1(data)
    for int in int_list
        diff = 2020 - int
        index = searchsortedfirst(data,diff)
        if data[index]==diff
            return int*diff
        end
    end
end

function part2(data)
    len = length(data)
    for first_number in int_list
        min = 2020 - first_number - 1
        index = searchsortedfirst(data,min)
        for i in range(1,stop=index)
            second_number = data[i]
            third_number = 2020 - first_number - second_number
            find_third = searchsortedfirst(data,third_number)
            if data[find_third]==third_number
                return first_number*second_number*third_number
            end
        end
    end
end

part1(int_list)

part2(int_list)
