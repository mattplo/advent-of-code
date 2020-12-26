lines = readlines(joinpath(@__DIR__, "./input.txt"))

function apply_mask1(mask::String,number::Int)
    binary = bitstring(number)
    pos = length(binary)-length(mask)+1
    res = "";
    for char in mask
        if char == '0' || char == '1'
            res=res*char
        else
            res=res*binary[pos]
        end
        pos +=1
    end
    parse(Int,res,base=2)
end

function apply_mask2(mask::String,number::Int)
    binary = bitstring(number)
    pos = length(binary)-length(mask)+1
    addr = [""];
    for char in mask
        if char == '0'
            for i in 1:length(addr)
                addr[i]=addr[i]*binary[pos]
            end
        elseif char == '1'
            for i in 1:length(addr)
                addr[i]=addr[i]*'1'
            end
        else
            for i in 1:length(addr)
                push!(addr,addr[i]*'0')
                addr[i]=addr[i]*'1'
            end
        end
        pos +=1
    end
    parse.(Int,addr,base=2)
end

function part1(lines::Vector{String})
    mask = ""
    memory = Dict{Int,Int}()
    for line in lines
        if line[1:3]=="mem"
            res = match(r"^mem\[([0-9]*)\] = ([0-9]*)$", line)
            addr,val = parse(Int,res[1]),parse(Int,res[2])
            memory[addr]=apply_mask1(mask,val)
        else
            mask = line[8:length(line)]
        end
    end
    sum(collect(values(memory)))
end

function part2(lines::Vector{String})
    mask = ""
    memory = Dict{Int,Int}()
    for line in lines
        if line[1:3]=="mem"
            res = match(r"^mem\[([0-9]*)\] = ([0-9]*)$", line)
            addr,val = parse(Int,res[1]),parse(Int,res[2])
            addresses = apply_mask2(mask,addr)
            for a in addresses
                memory[a]=val
            end
        else
            mask = line[8:length(line)]
        end
    end
    sum(collect(values(memory)))
end

part1(lines)
part2(lines)
