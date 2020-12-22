
lines = readlines(joinpath(@__DIR__, "./input.txt"))


function part1(lines)
    nb_valid=0
    for line in lines
        hyphen_pos = findfirst('-',line)
        points_pos = findfirst(':',line)
        min = parse(Int,line[1:hyphen_pos-1])
        max= parse(Int,line[hyphen_pos+1:points_pos-2])
        char = line[points_pos-1]
        string=line[points_pos+2:length(line)]
        cnt = count(==(char),string)
        valid = (min <= cnt <= max)
        if valid===true
            nb_valid+=1
        end
    end
    return nb_valid
end

function part2(lines)
    nb_valid=0
    for line in lines
        hyphen_pos = findfirst('-',line)
        points_pos = findfirst(':',line)
        pos1 = parse(Int,line[1:hyphen_pos-1])
        pos2 = parse(Int,line[hyphen_pos+1:points_pos-2])
        char = line[points_pos-1]
        string=line[points_pos+2:length(line)]
        valid = xor(string[pos1]===char,string[pos2]===char)
        if valid===true
            nb_valid+=1
        end
    end
    return nb_valid
end

part1(lines)
part2(lines)
