lines = readlines(joinpath(@__DIR__,"./input.txt"))

function process_line!(acc,processed_set,line_index,changed_index=0,new_cmd="")
    if line_index in processed_set
        return (false,acc)
    elseif line_index>length(lines)
        return (true,acc)
    else
        push!(processed_set,line_index)
        line = lines[line_index]
        cmd = line[1:3]
        if line_index==changed_index
            cmd=new_cmd
        end
        int = parse(Int,line[5:length(line)])
        if cmd=="nop"
            return process_line!(acc,processed_set,line_index+1,changed_index,new_cmd)
        elseif cmd=="jmp"
            return process_line!(acc,processed_set,line_index+int,changed_index,new_cmd)
        else
            acc += int
            return process_line!(acc,processed_set,line_index+1,changed_index,new_cmd)
        end
    end
end

function part1(lines::Vector{String})
    processed_set=Set{Int}()
    over,acc = process_line!(0,processed_set,1)
    return acc
end

function part2(lines::Vector{String})
    reached=Set{Int}()
    process_line!(0,reached,1)
    for i in reached
        processed_set=Set{Int}()
        line = lines[i]
        cmd = line[1:3]
        if cmd=="nop"
            over,acc = process_line!(0,processed_set,1,i,"jmp")
        elseif cmd=="jmp"
            over,acc = process_line!(0,processed_set,1,i,"nop")
        else
            continue
        end
        i+=1
        if over == true
            return acc
        end

    end
end

part1(lines)
part2(lines)
